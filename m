Received: from eggs.gnu.org ([2001:4830:134:3::10]:56801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1crKXk-0000jD-AG
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 04:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1crKXh-0008Ke-4z
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 04:25:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1crKXg-0008KP-Sz
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 04:25:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC2216A6DB
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 08:25:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-4-git-send-email-armbru@redhat.com>
	<20170323203819.GH5344@noname.redhat.com>
	<87lgrvyy6l.fsf@dusky.pond.sub.org>
Date: Fri, 24 Mar 2017 09:25:49 +0100
In-Reply-To: <87lgrvyy6l.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 24 Mar 2017 07:40:50 +0100")
Message-ID: <87lgrvw06q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: jdurgin@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, jcody@redhat.com

Markus Armbruster <armbru@redhat.com> writes:

> Kevin Wolf <kwolf@redhat.com> writes:
>
>> Am 23.03.2017 um 11:55 hat Markus Armbruster geschrieben:
>>> We have two list-values options:
>>> 
>>> * "server" is a list of InetSocketAddress.  We use members "host" and
>>>   "port", and silently ignore the rest.
>>> 
>>> * "auth-supported" is a list of RbdAuthMethod.  We use its only member
>>>   "auth".
>>> 
>>> Since qemu_rbd_open() takes options as a flattened QDict, options has
>>> keys of the form server.%d.host, server.%d.port and
>>> auth-supported.%d.auth, where %d counts up from zero.
>>> 
>>> qemu_rbd_array_opts() extracts these values as follows.  First, it
>>> calls qdict_array_entries() to find the list's length.  For each list
>>> element, it first formats the list's key prefix (e.g. "server.0."),
>>> then creates a new QDict holding the options with that key prefix,
>>> then converts that to a QemuOpts, so it can finally get the member
>>> values from there.
>>> 
>>> If there's one surefire way to make code using QDict more awkward,
>>> it's creating more of them and mixing in QemuOpts for good measure.
>>> 
>>> The conversion to QemuOpts abuses runtime_opts, as described in the
>>> commit before previous.
>>> 
>>> Rewrite to simply get the values straight from the options QDict.
>>> This removes the abuse of runtime_opts, so clean it up.
>>> 
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>>> @@ -577,91 +557,59 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
>>>      qemu_aio_unref(acb);
>>>  }
>>>  
>>> -#define RBD_MON_HOST          0
>>> -#define RBD_AUTH_SUPPORTED    1
>>> -
>>> -static char *qemu_rbd_array_opts(QDict *options, const char *prefix, int type,
>>> -                                 Error **errp)
>>> +static char *rbd_auth(QDict *options)
>>>  {
>>> -    int num_entries;
>>> -    QemuOpts *opts = NULL;
>>> -    QDict *sub_options;
>>> -    const char *host;
>>> -    const char *port;
>>> -    char *str;
>>> -    char *rados_str = NULL;
>>> -    Error *local_err = NULL;
>>> +    const char **vals = g_new(const char *, qdict_size(options));
>>> +    char keybuf[32];
>>> +    QObject *val;
>>> +    char *rados_str;
>>>      int i;
>>>  
>>> -    assert(type == RBD_MON_HOST || type == RBD_AUTH_SUPPORTED);
>>> -
>>> -    num_entries = qdict_array_entries(options, prefix);
>>> +    for (i = 0;; i++) {
>>> +        sprintf(keybuf, "auth-supported.%d.auth", i);
>>> +        val = qdict_get(options, keybuf);
>>> +        if (!val) {
>>> +            break;
>>> +        }
>>>  
>>> -    if (num_entries < 0) {
>>> -        error_setg(errp, "Parse error on RBD QDict array");
>>> -        return NULL;
>>> +        vals[i] = qstring_get_str(qobject_to_qstring(val));
>>>      }
>>> +    vals[i] = NULL;
>>
>> In case of doubt, i is one more than vals can hold. (It segfaulted for
>> me when options was empty because I passed only options that are removed
>> before this function is called.)
>
> Yes, the g_new() above needs one extra slot.
>
>> You also want to remove the options from the QDict, otherwise
>> bdrv_open_inherit() will complain that the options are unknown.
>
> Okay.
>
>>>  
>>> -    for (i = 0; i < num_entries; i++) {
>>> -        char *strbuf = NULL;
>>> -        const char *value;
>>> -        char *rados_str_tmp;
>>> -
>>> -        str = g_strdup_printf("%s%d.", prefix, i);
>>> -        qdict_extract_subqdict(options, &sub_options, str);
>>> -        g_free(str);
>>> -
>>> -        opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
>>> -        qemu_opts_absorb_qdict(opts, sub_options, &local_err);
>>> -        QDECREF(sub_options);
>>> -        if (local_err) {
>>> -            error_propagate(errp, local_err);
>>> -            g_free(rados_str);
>>> -            rados_str = NULL;
>>> -            goto exit;
>>> -        }
>>> +    rados_str = g_strjoinv(";", (char **)vals);
>>> +    g_free(vals);
>>> +    return rados_str;
>>> +}
>>>  
>>> -        if (type == RBD_MON_HOST) {
>>> -            host = qemu_opt_get(opts, "host");
>>> -            port = qemu_opt_get(opts, "port");
>>> +static char *rbd_mon_host(QDict *options)
>>> +{
>>> +    const char **vals = g_new(const char *, qdict_size(options));
>>> +    char keybuf[32];
>>> +    QObject *val;
>>> +    const char *host, *port;
>>> +    char *rados_str;
>>> +    int i;
>>>  
>>> -            value = host;
>>> -            if (port) {
>>> -                /* check for ipv6 */
>>> -                if (strchr(host, ':')) {
>>> -                    strbuf = g_strdup_printf("[%s]:%s", host, port);
>>> -                } else {
>>> -                    strbuf = g_strdup_printf("%s:%s", host, port);
>>> -                }
>>> -                value = strbuf;
>>> -            } else if (strchr(host, ':')) {
>>> -                strbuf = g_strdup_printf("[%s]", host);
>>> -                value = strbuf;
>>> -            }
>>> -        } else {
>>> -            value = qemu_opt_get(opts, "auth");
>>> +    for (i = 0;; i++) {
>>> +        sprintf(keybuf, "server.%d.host", i);
>>> +        val = qdict_get(options, keybuf);
>>> +        if (!val) {
>>> +            break;
>>>          }
>>> +        host = qstring_get_str(qobject_to_qstring(val));
>>> +        sprintf(keybuf, "server.%d.port", i);
>>> +        port = qdict_get_str(options, keybuf);
>>
>> This segfaults if the port option isn't given.
>
> @port is mandatory in BlockdevOptionsRbd.  If it's not there here, the
> options must have bypassed QAPI.  That would be bad news.  Can you
> explain how it can happen?

Answering myself, please correct mistakes.

There are two ways to create @options:

1. -blockdev and blockdev-add

   These create @options with a QAPI visitor from the command line
   option argument or QMP arguments, respectively.  This checks them
   against the QAPI schema.  Missing @port is rejected.

2. -drive and drive_add

   These appear to create @options manually, without checking against
   the QAPI schema.

   Crash reproducer: -drive driver=rbd,server.0.host=s0

In other words, we have *two* specifications for @options: the QAPI
schema, and the union of all the QemuOptsList that apply.  In case 1, we
check against both (I think).  In case 2, we only check against the
latter.

I understand how we got into this state, but it's not a good state to be
in.  We need to have our options defined in one way and one way only.

For 2.9, we cope with missing @port.

Post 2.9, we should either finish the QAPIfication of block
configuration we started with blockdev-add, or back it out, i.e. make
the QAPI schema accept anything, and rely on the QemuOpts-based
checking.

I want us to finish QAPIfication.

>>> -
>>> -        /* each iteration in the for loop will build upon the string, and if
>>> -         * rados_str is NULL then it is our first pass */
>>> -        if (rados_str) {
>>> -            /* separate options with ';', as that  is what rados_conf_set()
>>> -             * requires */
>>> -            rados_str_tmp = rados_str;
>>> -            rados_str = g_strdup_printf("%s;%s", rados_str_tmp, value);
>>> -            g_free(rados_str_tmp);
>>> +        if (strchr(host, ':')) {
>>> +            vals[i] = g_strdup_printf("[%s]:%s", host, port);
>>>          } else {
>>> -            rados_str = g_strdup(value);
>>> +            vals[i] = g_strdup_printf("%s:%s", host, port);
>>>          }
>>> -
>>> -        g_free(strbuf);
>>> -        qemu_opts_del(opts);
>>> -        opts = NULL;
>>>      }
>>> +    vals[i] = NULL;
>>
>> Probably the same buffer overflow as above (but I didn't test that this
>> one really segfaults).
>
> Yes, same off-by-one.
>
>>> -exit:
>>> -    qemu_opts_del(opts);
>>> +    rados_str = g_strjoinv(";", (char **)vals);
>>> +    g_strfreev((char **)vals);
>>>      return rados_str;
>>>  }
>>>  
>>> @@ -685,24 +633,9 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>>>          return -EINVAL;
>>>      }
>>>  
>>> -    auth_supported = qemu_rbd_array_opts(options, "auth-supported.",
>>> -                                         RBD_AUTH_SUPPORTED, &local_err);
>>> -    if (local_err) {
>>> -        error_propagate(errp, local_err);
>>> -        r = -EINVAL;
>>> -        goto failed_opts;
>>> -    }
>>> -
>>> -    mon_host = qemu_rbd_array_opts(options, "server.",
>>> -                                   RBD_MON_HOST, &local_err);
>>> -    if (local_err) {
>>> -        error_propagate(errp, local_err);
>>> -        r = -EINVAL;
>>> -        goto failed_opts;
>>> -    }
>>> -
>>> +    auth_supported = rbd_auth(options);
>>> +    mon_host = rbd_mon_host(options);
>>>      secretid = qemu_opt_get(opts, "password-secret");
>>
>> Of course, this also changes the behaviour so that additional options in
>> server.* and auth-supported.* aren't silently ignored any more, but we
>> complain that they are unknown. I consider this a bonus bug fix, but it
>> should probably be spelt out in the commit message.
>
> Good point.

Note to self: this applies to -drive / drive_add, but not to -blockdev /
blockdev_add, because the QAPI schema kicks in there.  Example:
-drive driver=rbd,server.0.host=s0,server.0.port=p0,server.0.foo=bar
