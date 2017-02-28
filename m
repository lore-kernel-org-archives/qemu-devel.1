Received: from eggs.gnu.org ([2001:4830:134:3::10]:57432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cijbL-0008Jy-Qi
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:22:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cijbF-00088M-Ho
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:22:07 -0500
Date: Tue, 28 Feb 2017 10:21:55 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170228152155.GC15696@localhost.localdomain>
References: <cover.1488254329.git.jcody@redhat.com>
	<cover.1488254329.git.jcody@redhat.com>
	<64a3308bbe51f78ccd2a53b30e8ba576e979ac4f.1488254329.git.jcody@redhat.com>
	<874lzexskd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874lzexskd.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] block/rbd: add support for
 'mon_host', 'auth_supported' via QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, qemu-block@nongnu.org

On Tue, Feb 28, 2017 at 04:07:14PM +0100, Markus Armbruster wrote:
> Jeff Cody <jcody@redhat.com> writes:
> 
> > This adds support for three additional options that may be specified
> > by QAPI in blockdev-add:
> >
> >     server: host, port
> >     auth method: either 'cephx' or 'none'
> >
> > The "server" and "auth-supported" QAPI parameters are arrays.  To conform
> > with the rados API, the array items are join as a single string with a ';'
> > character as a delimiter when setting the configuration values.
> >
> > Signed-off-by: Jeff Cody <jcody@redhat.com>
> > ---
> >  block/rbd.c          | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  qapi/block-core.json |  29 +++++++++++++
> >  2 files changed, 148 insertions(+)
> >
> > diff --git a/block/rbd.c b/block/rbd.c
> > index cc43f42..dfa52cc 100644
> > --- a/block/rbd.c
> > +++ b/block/rbd.c
> > @@ -405,6 +405,19 @@ static QemuOptsList runtime_opts = {
> >              .type = QEMU_OPT_STRING,
> >              .help = "Legacy rados key/value option parameters",
> >          },
> > +        {
> > +            .name = "host",
> > +            .type = QEMU_OPT_STRING,
> > +        },
> > +        {
> > +            .name = "port",
> > +            .type = QEMU_OPT_STRING,
> > +        },
> > +        {
> > +            .name = "auth",
> > +            .type = QEMU_OPT_STRING,
> > +            .help = "Supported authentication method, either cephx or none",
> > +        },
> >          { /* end of list */ }
> >      },
> >  };
> > @@ -565,14 +578,89 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
> >      qemu_aio_unref(acb);
> >  }
> >  
> > +#define RBD_MON_HOST          0
> > +#define RBD_AUTH_SUPPORTED    1
> 
> Blank line here, please.
>

OK

> > +static char *qemu_rbd_array_opts(QDict *options, const char *prefix, int type,
> > +                                 Error **errp)
> > +{
> > +    size_t num_entries;
> > +    QemuOpts *opts = NULL;
> > +    QDict *sub_options;
> > +    const char *host;
> > +    const char *port;
> > +    char *str;
> > +    char *rados_str = NULL;
> > +    Error *local_err = NULL;
> > +
> > +    assert(type == RBD_MON_HOST || type == RBD_AUTH_SUPPORTED);
> > +
> > +    num_entries = qdict_array_entries(options, prefix);
> 
> Can this fail?
> 

Yes, I should check for < 0 for error.

> > +
> > +    if (num_entries) {
> 
> Superfluous conditional: if !num_entries, the loop rejects.
> 

Will drop.

> > +        for (int i = 0; i < num_entries; i++) {
> > +            char *tmp = NULL;
> > +            const char *value;
> > +            char *rados_str_tmp;
> > +
> > +            str = g_strdup_printf("%s%d.", prefix, i);
> > +            qdict_extract_subqdict(options, &sub_options, str);
> > +            g_free(str);
> > +
> > +            opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
> > +            qemu_opts_absorb_qdict(opts, sub_options, &local_err);
> > +            QDECREF(sub_options);
> > +            if (local_err) {
> > +                error_propagate(errp, local_err);
> > +                goto exit;
> 
> Hmm.  Unless this is the first iteration, rados_str is already non-null,
> i.e. we fail and return a string the caller must free.  That's bad
> practice; it's better to return NULL on failre.
> 

OK

> > +            }
> > +
> > +            if (type == RBD_MON_HOST) {
> > +                host = qemu_opt_get(opts, "host");
> > +                port = qemu_opt_get(opts, "port");
> > +
> > +                value = host;
> > +                if (port) {
> > +                    tmp = g_strdup_printf("%s:%s", host, port);
> 
> Problematic when @host is numeric IPv6.  What syntax does ceph expect in
> that case?
> 

I think we will need to encapsulate that with a '[]' for ipv6.

> > +                    value = tmp;
> > +                }
> > +            } else {
> > +                value = qemu_opt_get(opts, "auth");
> > +            }
> > +
> > +
> > +            /* each iteration in the for loop will build upon the string,
> > +             * and if rados_str is NULL then it is our first pass */
> > +            if (rados_str) {
> > +                /* separate options with ';', as that  is what rados_conf_set()
> > +                 * requires */
> > +                rados_str_tmp = rados_str;
> > +                rados_str = g_strdup_printf("%s;%s", rados_str_tmp, value);
> > +                g_free(rados_str_tmp);
> 
> I'd make rados_str a GString.  But your code isn't wrong.
> 
> > +            } else {
> > +                rados_str = g_strdup(value);
> > +            }
> > +
> > +            g_free(tmp);
> 
> Aha, @tmp is just for getting the g_strdup_printf() freed.  Rename to
> strbuf?
> 

Sure

> > +            qemu_opts_del(opts);
> > +            opts = NULL;
> > +        }
> > +    }
> > +
> > +exit:
> > +    qemu_opts_del(opts);
> > +    return rados_str;
> > +}
> > +
> >  static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
> >                           Error **errp)
> >  {
> >      BDRVRBDState *s = bs->opaque;
> >      const char *pool, *snap, *conf, *clientname, *name, *keypairs;
> > +    const char *auth_supported;
> >      const char *secretid;
> >      QemuOpts *opts;
> >      Error *local_err = NULL;
> > +    char *mon_host = NULL;
> >      int r;
> >  
> >      opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
> > @@ -583,6 +671,22 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
> >          return -EINVAL;
> >      }
> >  
> > +   auth_supported = qemu_rbd_array_opts(options, "auth-supported.",
> 
> Indentation's off.
> 

OK, will fix

> > +                                         RBD_AUTH_SUPPORTED, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        r = -EINVAL;
> > +        goto failed_opts;
> > +    }
> > +
> > +    mon_host = qemu_rbd_array_opts(options, "server.",
> > +                                   RBD_MON_HOST, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        r = -EINVAL;
> > +        goto failed_opts;
> > +    }
> > +
> >      secretid = qemu_opt_get(opts, "password-secret");
> >  
> >      pool           = qemu_opt_get(opts, "pool");
> > @@ -615,6 +719,20 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
> >          goto failed_shutdown;
> >      }
> >  
> > +    if (mon_host) {
> > +        r = rados_conf_set(s->cluster, "mon_host", mon_host);
> > +        if (r < 0) {
> > +            goto failed_shutdown;
> > +        }
> > +    }
> > +
> > +    if (auth_supported) {
> > +        r = rados_conf_set(s->cluster, "auth_supported", auth_supported);
> > +        if (r < 0) {
> > +            goto failed_shutdown;
> > +        }
> > +    }
> > +
> >      if (qemu_rbd_set_auth(s->cluster, secretid, errp) < 0) {
> >          r = -EIO;
> >          goto failed_shutdown;
> > @@ -663,6 +781,7 @@ failed_shutdown:
> >      g_free(s->snap);
> >  failed_opts:
> >      qemu_opts_del(opts);
> > +    g_free(mon_host);
> 
> Need to free auth_supported.
>

Thanks

> >      return r;
> >  }
> >  
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index f152953..5f74f92 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -2666,6 +2666,28 @@
> >              '*header-digest': 'IscsiHeaderDigest',
> >              '*timeout': 'int' } }
> >  
> > +
> > +##
> > +# @RbdAuthSupport:
> > +#
> > +# An enumeration of RBD auth support
> > +#
> > +# Since: 2.9
> > +##
> > +{ 'enum': 'RbdAuthSupport',
> > +  'data': [ 'cephx', 'none' ] }
> > +
> > +
> > +##
> > +# @RbdAuthMethod:
> > +#
> > +# An enumeration of rados auth_supported types
> > +#
> > +# Since: 2.9
> > +##
> > +{ 'struct': 'RbdAuthMethod',
> > +  'data': { 'auth': 'RbdAuthSupport' } }
> > +
> >  ##
> >  # @BlockdevOptionsRbd:
> >  #
> > @@ -2681,6 +2703,11 @@
> >  #
> >  # @user:               #optional Ceph id name.
> >  #
> > +# @server:             #optional Monitor host address and port.  This maps
> > +#                      to the "mon_host" Ceph option.
> > +#
> > +# @auth-supported:     #optional Authentication supported.
> > +#
> >  # @password-secret:    #optional The ID of a QCryptoSecret object providing
> >  #                      the password for the login.
> >  #
> > @@ -2692,6 +2719,8 @@
> >              '*conf': 'str',
> >              '*snapshot': 'str',
> >              '*user': 'str',
> > +            '*server': ['InetSocketAddress'],
> > +            '*auth-supported': ['RbdAuthMethod'],
> >              '*password-secret': 'str' } }
> >  
> >  ##
