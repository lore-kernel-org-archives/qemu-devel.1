Received: from eggs.gnu.org ([2001:4830:134:3::10]:38898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8ofo-0005fb-Rw
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 11:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8ofl-0002KO-Hm
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 11:07:04 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180405170619.20480-1-kwolf@redhat.com>
Date: Wed, 18 Apr 2018 17:06:43 +0200
In-Reply-To: <20180405170619.20480-1-kwolf@redhat.com> (Kevin Wolf's message
	of "Thu, 5 Apr 2018 19:06:19 +0200")
Message-ID: <87d0ywv9j0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC][BROKEN] rbd: Allow configuration of
 authentication scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jdurgin@redhat.com, qemu-devel@nongnu.org, jcody@redhat.com, mreitz@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> The legacy command line syntax supports a "password-secret" option that
> allows to pass an authentication key to Ceph. This was not supported in
> QMP so far.

We tried during development of v2.9.0 (commit 0a55679b4a5), but reverted
before the release:

commit 464444fcc161284ac0e743b99251debc297d5236
Author: Markus Armbruster <armbru@redhat.com>
Date:   Tue Mar 28 10:56:06 2017 +0200

    rbd: Revert -blockdev and -drive parameter auth-supported
    
    This reverts half of commit 0a55679.  We're having second thoughts on
    the QAPI schema (and thus the external interface), and haven't reached
    consensus, yet.  Issues include:
    
    * The implementation uses deprecated rados_conf_set() key
      "auth_supported".  No biggie.
    
    * The implementation makes -drive silently ignore invalid parameters
      "auth" and "auth-supported.*.X" where X isn't "auth".  Fixable (in
      fact I'm going to fix similar bugs around parameter server), so
      again no biggie.
    
    * BlockdevOptionsRbd member @password-secret applies only to
      authentication method cephx.  Should it be a variant member of
      RbdAuthMethod?
    
    * BlockdevOptionsRbd member @user could apply to both methods cephx
      and none, but I'm not sure it's actually used with none.  If it
      isn't, should it be a variant member of RbdAuthMethod?
    
    * The client offers a *set* of authentication methods, not a list.
      Should the methods be optional members of BlockdevOptionsRbd instead
      of members of list @auth-supported?  The latter begs the question
      what multiple entries for the same method mean.  Trivial question
      now that RbdAuthMethod contains nothing but @type, but less so when
      RbdAuthMethod acquires other members, such the ones discussed above.
    
    * How BlockdevOptionsRbd member @auth-supported interacts with
      settings from a configuration file specified with @conf is
      undocumented.  I suspect it's untested, too.
    
    Let's avoid painting ourselves into a corner now, and revert the
    feature for 2.9.
    
    Note that users can still configure authentication methods with a
    configuration file.  They probably do that anyway if they use Ceph
    outside QEMU as well.
    
    Further note that this doesn't affect use of key "auth-supported" in
    -drive file=rbd:...:key=value.
    
    qemu_rbd_array_opts()'s parameter @type now must be RBD_MON_HOST,
    which is silly.  This will be cleaned up shortly.
    
    Signed-off-by: Markus Armbruster <armbru@redhat.com>
    Reviewed-by: Max Reitz <mreitz@redhat.com>
    Reviewed-by: Eric Blake <eblake@redhat.com>
    Reviewed-by: Jeff Cody <jcody@redhat.com>
    Message-id: 1490691368-32099-9-git-send-email-armbru@redhat.com
    Signed-off-by: Jeff Cody <jcody@redhat.com>

> This patch introduces authentication options in the QAPI schema, makes
> them do the corresponding rados_conf_set() calls and adds compatibility
> code that translates the old "password-secret" option both for opening

Suggest 'the old "password-secret" command line option parameter'.

> and creating images to the new set of options.
>
> Note that the old option didn't allow to explicitly specify the set of

Likewise, 'the old option parameter'.

> allowed authentication schemes. The compatibility code assumes that if
> "password-secret" is given, only the cephx scheme is allowed. If it's
> missing, both none and cephx are allowed because the configuration file
> could still provide a key.

This is a bit terse for readers who aren't familiar with the way things
work now (or have since forgotten pretty much everything about it, like
me).

Perhaps spelling out how the compatibility code translates the old
option parameter to BlockdevOptionsRbd would help.

> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>
> This doesn't actually work correctly yet because the way that options
> are passed through the block layer (QAPI -> QemuOpts -> QDict). Before
> we fix or hack around this, let's make sure this is the schema that we
> want.

Makes sense.

> The two known problems are:
>
> 1. QDict *options in qemu_rbd_open() may contain options either in their
>    proper QObject types (if passed from blockdev-add) or as strings
>    (-drive). Both forms can be mixed in the same options QDict.

Remind me, how can such a mix happen?

>    rbd uses the keyval visitor to convert the options into a QAPI
>    object. This means that it requires all options to be strings. This
>    patch, however, introduces a bool property, so the visitor breaks
>    when it gets its input from blockdev-add.
>
>    Options to hack around the problem:
>
>    a. Do an extra conversion step or two and go through QemuOpts like
>       some other block drivers. When I offered something like this to
>       Markus a while ago in a similar case, he rejected the idea.

Going through QemuOpts just to get rid of strings is a bit like going
down Niagara Falls in a barrel just to get rid of sleepiness: it'll do
that, sure, but it's probably not all it'll do.

>    b. Introduce a qdict_stringify_entries() that just does what its name
>       says. It would be called before the running keyval visitor so that
>       only strings will be present in the QDict.

Precedence: a bunch of other QDict operations that are used only by the
block layer.  One more won't make a difference, I guess.

Aside: I'm tempted to move them out of qdict.h to reduce the temptation
to use them outside the block layer.

>    c. Do a local one-off hack that checks if the entry with the key
>       "auth-none" is a QBool, and if so, overwrite it with a string. The
>       problem will reappear with the next non-string option.

Defensible only if we're fairly confident such options will remain rare.

>    (d. Get rid of the QDict detour and work only with QAPI objects
>        everywhere. Support rbd authentication only in QEMU 4.0.)

This is of course the proper solution, but it's a big project that will
take time.  The occasional stop gaps are unavoidable.  We just need to
take care not to spend all of our cycles on stop gaps, and none on
actual progress.

     e. Make the keyval visitor accept scalars other than strings.

More efficient than b., doubt it matters.  Complicates the visitor.
Harder to back out than b. when we no longer need it.

I'm leaning towards b.

> 2. The proposed schema allows 'auth-cephx': {} as a valid option with
>    the meaning that the cephx authentication scheme is enabled, but no
>    key is given (e.g. it is taken from the config file).

Apropos config file: we need to be careful to maintain the QAPI schema's
promise that "Values in the configuration file will be overridden by
options specified via QAPI."

>    However, an empty dict cannot currently be represented by flattened
>    QDicts.

Flattening a QDict moves nested scalars to the root (with dotted keys),
and drops nested non-scalars, i.e. QDict, QList.  A nested empty QDict
(or QList) vanishes without trace.

>            We need to find a way to enable this. I think this will be
>    externally visible because it directly translates into the dotted
>    syntax of -blockdev, so we may want to be careful.

Quote keyval.c:

 * Design flaw: there is no way to denote an empty array or non-root
 * object.  While interpreting "key absent" as empty seems natural
 * (removing a key-val from the input string removes the member when
 * there are more, so why not when it's the last), it doesn't work:
 * "key absent" already means "optional object/array absent", which
 * isn't the same as "empty object/array present".

Getting that syntax right was hairy (you'll probably remember the
lengthy e-mail discussions).  I'm reluctant to revisit it.  We concluded
back then that dotted key syntax capable of expressing arbitrary JSON
wasn't in the cards, but that the cases it can't do are so exotic that
users should just fall back to JSON.  And that would be my advice here.

Can we design a schema that avoids this case?  Let's see below.

> Any thoughts on the proposed QAPI schema or the two implementation
> problems are welcome.
>
>  qapi/block-core.json |  22 +++++++++++
>  block/rbd.c          | 102 ++++++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 99 insertions(+), 25 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index c50517bff3..d5ce588add 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3170,6 +3170,19 @@
>  
>  
>  ##
> +# @RbdAuthCephx:
> +#
> +# @key-secret:         ID of a QCryptoSecret object providing a key for cephx
> +#                      authentication. If not specified, a key from the
> +#                      specified configuration file, or the system default
> +#                      configuration is used, if present.
> +#
> +# Since: 2.13
> +##
> +{ 'struct': 'RbdAuthCephx',
> +  'data': { '*key-secret': 'str' } }
> +
> +##
>  # @BlockdevOptionsRbd:
>  #
>  # @pool:               Ceph pool name.
> @@ -3184,6 +3197,13 @@
>  #
>  # @user:               Ceph id name.
>  #
> +# @auth-none:          true if connecting to a server without authentication
> +#                      should be allowed (default: false; since 2.13)
> +#
> +# @auth-cephx:         Configuration for cephx authentication if specified. If
> +#                      not specified, cephx authentication is not allowed.
> +#                      (since 2.13)
> +#
>  # @server:             Monitor host address and port.  This maps
>  #                      to the "mon_host" Ceph option.
>  #
> @@ -3195,6 +3215,8 @@
>              '*conf': 'str',
>              '*snapshot': 'str',
>              '*user': 'str',
> +            '*auth-none': 'bool',
> +            '*auth-cephx': 'RbdAuthCephx',
>              '*server': ['InetSocketAddressBase'] } }
>  
>  ##

Two new optional members @auth-none, @auth-cephx.

For backwards compatibility, behavior needs to remain unchanged when
both are absent.  What is the behavior we need to preserve?  Config
file, then default?

The schema permits four cases, which get translated to an auth client
required setting by qemu_rbd_set_auth(), visible below:

(1) just auth-none: we set auth_client_required to "none"

(2) just auth-cephx: we set auth_client_required to "cephx"

(3) both: we set auth_client_required to "none;cephx", which I can't
    find in the documentation right now, but according to my notes means
    "either method"

(4) neither: rejected with "No authentication scheme allowed"
    Uh, why isn't this a compatibility break?  Or am I confused?

When auth-cephx is present, we get subcases

(2a) and (3a) key-secret present: key is in the QCryptoSecret named, and
we set

(2b) and (3b) key-secret absent: key must be provided some other way,
     say in a configuration file, default keyring, whatever, or else
     we'll fail somehow, I guess

Related: existing BlockdevOptionsRbd member @user.  As far as I know,
it's meaningless with auth-none.

Ways to avoid the troublesome auth-cephx: {}:

(A) Make auth-cephx a bool, rely on the other ways to provide the key

(B) Make auth-cephx a bool and add the @key-secret member next to it

    Like @user, the member is meaningless with auth-none.

(C) Make auth-cephx.key-secret a mandatory StrOrNull

    Should take care of "vanishes on flattening" problem, but dotted key
    syntax is still screwed: since any value is a valid string, there's
    none left for null.  My take would be that if you want to say
    auth-cephx.key-secret: {}, you get to say it in JSON.

    Aside: check_alternate() tries to catch such alternates, but we
    failed to update it when we added first class null.  *sigh*

Which one do you hate least?

> diff --git a/block/rbd.c b/block/rbd.c
> index 5b64849dc6..c2a9a92dd5 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -105,8 +105,7 @@ typedef struct BDRVRBDState {
>  
>  static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
>                              BlockdevOptionsRbd *opts, bool cache,
> -                            const char *keypairs, const char *secretid,
> -                            Error **errp);
> +                            const char *keypairs, Error **errp);
>  
>  static char *qemu_rbd_next_tok(char *src, char delim, char **p)
>  {
> @@ -231,21 +230,40 @@ done:
>  }
>  
>  
> -static int qemu_rbd_set_auth(rados_t cluster, const char *secretid,
> +static int qemu_rbd_set_auth(rados_t cluster, BlockdevOptionsRbd *opts,
>                               Error **errp)
>  {
> -    if (secretid == 0) {
> -        return 0;
> -    }
> +    int r;
>  
> -    gchar *secret = qcrypto_secret_lookup_as_base64(secretid,
> -                                                    errp);
> -    if (!secret) {
> -        return -1;
> +    if (opts->auth_none && opts->has_auth_cephx) {
> +        r = rados_conf_set(cluster, "auth_client_required", "none;cephx");
> +    } else if (opts->auth_none) {
> +        r = rados_conf_set(cluster, "auth_client_required", "none");
> +    } else if (opts->has_auth_cephx) {
> +        r = rados_conf_set(cluster, "auth_client_required", "cephx");
> +    } else {
> +        error_setg(errp, "No authentication scheme allowed");
> +        return -EINVAL;
> +    }
> +    if (r < 0) {
> +        error_setg_errno(errp, -r, "Could not set 'auth_client_required'");
> +        return r;
>      }
>  
> -    rados_conf_set(cluster, "key", secret);
> -    g_free(secret);
> +    if (opts->has_auth_cephx && opts->auth_cephx->has_key_secret) {
> +        gchar *secret =
> +            qcrypto_secret_lookup_as_base64(opts->auth_cephx->key_secret, errp);
> +        if (!secret) {
> +            return -EIO;
> +        }
> +
> +        r = rados_conf_set(cluster, "key", secret);
> +        g_free(secret);
> +        if (r < 0) {
> +            error_setg_errno(errp, -r, "Could not set 'key'");
> +            return r;
> +        }
> +    }
>  
>      return 0;
>  }

After the patch: cases (1), (2a), (2b), (3a), (3b), (4) described above.
Note that we now set "auth_client_required" in addition to "key".

Before the patch: If @secretid is null, do nothing, else set "key" to
the QCryptoSecret named by it.  "auth_client_required" could be set in
the configuration file, or default to "cephx".

How does backward compatibility work?

> @@ -337,12 +355,9 @@ static QemuOptsList runtime_opts = {
>      },
>  };
>  
> -/* FIXME Deprecate and remove keypairs or make it available in QMP.
> - * password_secret should eventually be configurable in opts->location. Support
> - * for it in .bdrv_open will make it work here as well. */
> +/* FIXME Deprecate and remove keypairs or make it available in QMP. */
>  static int qemu_rbd_do_create(BlockdevCreateOptions *options,
> -                              const char *keypairs, const char *password_secret,
> -                              Error **errp)
> +                              const char *keypairs, Error **errp)
>  {
>      BlockdevCreateOptionsRbd *opts = &options->u.rbd;
>      rados_t cluster;
> @@ -370,7 +385,7 @@ static int qemu_rbd_do_create(BlockdevCreateOptions *options,
>      }
>  
>      ret = qemu_rbd_connect(&cluster, &io_ctx, opts->location, false, keypairs,
> -                           password_secret, errp);
> +                           errp);
>      if (ret < 0) {
>          return ret;
>      }
> @@ -390,7 +405,7 @@ out:
>  
>  static int qemu_rbd_co_create(BlockdevCreateOptions *options, Error **errp)
>  {
> -    return qemu_rbd_do_create(options, NULL, NULL, errp);
> +    return qemu_rbd_do_create(options, NULL, errp);
>  }
>  
>  static int coroutine_fn qemu_rbd_co_create_opts(const char *filename,
> @@ -443,7 +458,21 @@ static int coroutine_fn qemu_rbd_co_create_opts(const char *filename,

This is the code mapping QemuOpts to QAPI for "qemu-img create" and such.

>      loc->image    = g_strdup(qdict_get_try_str(options, "image"));
>      keypairs      = qdict_get_try_str(options, "=keyvalue-pairs");
>  
> -    ret = qemu_rbd_do_create(create_options, keypairs, password_secret, errp);
> +    /* Always allow the cephx authentication scheme, even if no password-secret
> +     * is given; the key might come from the config file. Without password-secret,

It could also come from a default keyring, couldn't it?

> +     * also allow none. */
> +    loc->has_auth_cephx = true;
> +    loc->auth_cephx = g_new0(RbdAuthCephx, 1);
> +
> +    if (password_secret) {
> +        loc->auth_cephx->has_key_secret = true;
> +        loc->auth_cephx->key_secret = g_strdup(password_secret);
> +    } else {
> +        loc->has_auth_none = true;
> +        loc->auth_none = true;
> +    }
> +
> +    ret = qemu_rbd_do_create(create_options, keypairs, errp);
>      if (ret < 0) {
>          goto exit;
>      }
> @@ -538,8 +567,7 @@ static char *qemu_rbd_mon_host(BlockdevOptionsRbd *opts, Error **errp)
>  
>  static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
>                              BlockdevOptionsRbd *opts, bool cache,
> -                            const char *keypairs, const char *secretid,
> -                            Error **errp)
> +                            const char *keypairs, Error **errp)
>  {
>      char *mon_host = NULL;
>      Error *local_err = NULL;
> @@ -577,8 +605,8 @@ static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
>          }
>      }
>  
> -    if (qemu_rbd_set_auth(*cluster, secretid, errp) < 0) {
> -        r = -EIO;
> +    r = qemu_rbd_set_auth(*cluster, opts, errp);
> +    if (r < 0) {
>          goto failed_shutdown;
>      }
>  
> @@ -671,8 +699,32 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,

This is the code mapping QemuOpts to QAPI for -drive and such.

>          goto out;
>      }
>  
> +    /* Always allow the cephx authentication scheme, even if no password-secret
> +     * is given; the key might come from the config file. Without password-secret,
> +     * also allow none. If the new QAPI-style options are given, don't override
> +     * them, though. */
> +    if (opts->auth_cephx == NULL) {
> +        opts->has_auth_cephx = true;
> +        opts->auth_cephx = g_new0(RbdAuthCephx, 1);
> +    }

@auth_cephx defaults to {}.

> +
> +    if (secretid) {
> +        if (opts->auth_cephx->has_key_secret) {
> +            error_setg(errp, "'auth-ceph.key-secret' and its alias "
> +                             "'password-secret' can't be used at the "
> +                             "same time");
> +            r = -EINVAL;
> +            goto out;

Legacy @password-secret clashes with @auth_cephx.key-secret.  Okay.

> +        }
> +        opts->auth_cephx->has_key_secret = true;
> +        opts->auth_cephx->key_secret = g_strdup(secretid);

@auth_cephx.key_secret defaults to legacy @password-secret.  Okay.

> +    } else if (!opts->has_auth_none) {
> +        opts->has_auth_none = true;
> +        opts->auth_none = true;

@auth_none defaults to true.

The QAPI schema documents default false.  I'll be hanged if I know what
the actual default is for each of -drive, -blockdev, blockdev-add.

How does backward compatibility work?

> +    }
> +
>      r = qemu_rbd_connect(&s->cluster, &s->io_ctx, opts,
> -                         !(flags & BDRV_O_NOCACHE), keypairs, secretid, errp);
> +                         !(flags & BDRV_O_NOCACHE), keypairs, errp);
>      if (r < 0) {
>          goto out;
>      }

Did I mention I've forgotten pretty much everything about this stuff?
I'm afraid it shows in my review.
