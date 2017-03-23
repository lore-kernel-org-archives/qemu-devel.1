Received: from eggs.gnu.org ([2001:4830:134:3::10]:42911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cr9V6-0005Sa-0j
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cr9V2-00067D-SG
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:38:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cr9V2-00066w-Jc
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:38:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44D4E80495
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:38:24 +0000 (UTC)
Date: Thu, 23 Mar 2017 21:38:19 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170323203819.GH5344@noname.redhat.com>
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-4-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490266548-22500-4-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 3/5] rbd: Rewrite the code to
 extract list-valued options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, jdurgin@redhat.com, jcody@redhat.com, mreitz@redhat.com, eblake@redhat.com

Am 23.03.2017 um 11:55 hat Markus Armbruster geschrieben:
> We have two list-values options:
> 
> * "server" is a list of InetSocketAddress.  We use members "host" and
>   "port", and silently ignore the rest.
> 
> * "auth-supported" is a list of RbdAuthMethod.  We use its only member
>   "auth".
> 
> Since qemu_rbd_open() takes options as a flattened QDict, options has
> keys of the form server.%d.host, server.%d.port and
> auth-supported.%d.auth, where %d counts up from zero.
> 
> qemu_rbd_array_opts() extracts these values as follows.  First, it
> calls qdict_array_entries() to find the list's length.  For each list
> element, it first formats the list's key prefix (e.g. "server.0."),
> then creates a new QDict holding the options with that key prefix,
> then converts that to a QemuOpts, so it can finally get the member
> values from there.
> 
> If there's one surefire way to make code using QDict more awkward,
> it's creating more of them and mixing in QemuOpts for good measure.
> 
> The conversion to QemuOpts abuses runtime_opts, as described in the
> commit before previous.
> 
> Rewrite to simply get the values straight from the options QDict.
> This removes the abuse of runtime_opts, so clean it up.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

> @@ -577,91 +557,59 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
>      qemu_aio_unref(acb);
>  }
>  
> -#define RBD_MON_HOST          0
> -#define RBD_AUTH_SUPPORTED    1
> -
> -static char *qemu_rbd_array_opts(QDict *options, const char *prefix, int type,
> -                                 Error **errp)
> +static char *rbd_auth(QDict *options)
>  {
> -    int num_entries;
> -    QemuOpts *opts = NULL;
> -    QDict *sub_options;
> -    const char *host;
> -    const char *port;
> -    char *str;
> -    char *rados_str = NULL;
> -    Error *local_err = NULL;
> +    const char **vals = g_new(const char *, qdict_size(options));
> +    char keybuf[32];
> +    QObject *val;
> +    char *rados_str;
>      int i;
>  
> -    assert(type == RBD_MON_HOST || type == RBD_AUTH_SUPPORTED);
> -
> -    num_entries = qdict_array_entries(options, prefix);
> +    for (i = 0;; i++) {
> +        sprintf(keybuf, "auth-supported.%d.auth", i);
> +        val = qdict_get(options, keybuf);
> +        if (!val) {
> +            break;
> +        }
>  
> -    if (num_entries < 0) {
> -        error_setg(errp, "Parse error on RBD QDict array");
> -        return NULL;
> +        vals[i] = qstring_get_str(qobject_to_qstring(val));
>      }
> +    vals[i] = NULL;

In case of doubt, i is one more than vals can hold. (It segfaulted for
me when options was empty because I passed only options that are removed
before this function is called.)

You also want to remove the options from the QDict, otherwise
bdrv_open_inherit() will complain that the options are unknown.

>  
> -    for (i = 0; i < num_entries; i++) {
> -        char *strbuf = NULL;
> -        const char *value;
> -        char *rados_str_tmp;
> -
> -        str = g_strdup_printf("%s%d.", prefix, i);
> -        qdict_extract_subqdict(options, &sub_options, str);
> -        g_free(str);
> -
> -        opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
> -        qemu_opts_absorb_qdict(opts, sub_options, &local_err);
> -        QDECREF(sub_options);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            g_free(rados_str);
> -            rados_str = NULL;
> -            goto exit;
> -        }
> +    rados_str = g_strjoinv(";", (char **)vals);
> +    g_free(vals);
> +    return rados_str;
> +}
>  
> -        if (type == RBD_MON_HOST) {
> -            host = qemu_opt_get(opts, "host");
> -            port = qemu_opt_get(opts, "port");
> +static char *rbd_mon_host(QDict *options)
> +{
> +    const char **vals = g_new(const char *, qdict_size(options));
> +    char keybuf[32];
> +    QObject *val;
> +    const char *host, *port;
> +    char *rados_str;
> +    int i;
>  
> -            value = host;
> -            if (port) {
> -                /* check for ipv6 */
> -                if (strchr(host, ':')) {
> -                    strbuf = g_strdup_printf("[%s]:%s", host, port);
> -                } else {
> -                    strbuf = g_strdup_printf("%s:%s", host, port);
> -                }
> -                value = strbuf;
> -            } else if (strchr(host, ':')) {
> -                strbuf = g_strdup_printf("[%s]", host);
> -                value = strbuf;
> -            }
> -        } else {
> -            value = qemu_opt_get(opts, "auth");
> +    for (i = 0;; i++) {
> +        sprintf(keybuf, "server.%d.host", i);
> +        val = qdict_get(options, keybuf);
> +        if (!val) {
> +            break;
>          }
> +        host = qstring_get_str(qobject_to_qstring(val));
> +        sprintf(keybuf, "server.%d.port", i);
> +        port = qdict_get_str(options, keybuf);

This segfaults if the port option isn't given.

> -
> -        /* each iteration in the for loop will build upon the string, and if
> -         * rados_str is NULL then it is our first pass */
> -        if (rados_str) {
> -            /* separate options with ';', as that  is what rados_conf_set()
> -             * requires */
> -            rados_str_tmp = rados_str;
> -            rados_str = g_strdup_printf("%s;%s", rados_str_tmp, value);
> -            g_free(rados_str_tmp);
> +        if (strchr(host, ':')) {
> +            vals[i] = g_strdup_printf("[%s]:%s", host, port);
>          } else {
> -            rados_str = g_strdup(value);
> +            vals[i] = g_strdup_printf("%s:%s", host, port);
>          }
> -
> -        g_free(strbuf);
> -        qemu_opts_del(opts);
> -        opts = NULL;
>      }
> +    vals[i] = NULL;

Probably the same buffer overflow as above (but I didn't test that this
one really segfaults).

> -exit:
> -    qemu_opts_del(opts);
> +    rados_str = g_strjoinv(";", (char **)vals);
> +    g_strfreev((char **)vals);
>      return rados_str;
>  }
>  
> @@ -685,24 +633,9 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>          return -EINVAL;
>      }
>  
> -    auth_supported = qemu_rbd_array_opts(options, "auth-supported.",
> -                                         RBD_AUTH_SUPPORTED, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        r = -EINVAL;
> -        goto failed_opts;
> -    }
> -
> -    mon_host = qemu_rbd_array_opts(options, "server.",
> -                                   RBD_MON_HOST, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        r = -EINVAL;
> -        goto failed_opts;
> -    }
> -
> +    auth_supported = rbd_auth(options);
> +    mon_host = rbd_mon_host(options);
>      secretid = qemu_opt_get(opts, "password-secret");

Of course, this also changes the behaviour so that additional options in
server.* and auth-supported.* aren't silently ignored any more, but we
complain that they are unknown. I consider this a bonus bug fix, but it
should probably be spelt out in the commit message.

Kevin
