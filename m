Received: from eggs.gnu.org ([2001:4830:134:3::10]:47382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciOL5-0003pv-Go
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:39:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciOL4-0001oN-3N
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:39:55 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1488180142.git.jcody@redhat.com>
	<cover.1488180142.git.jcody@redhat.com>
	<25ccaa9f42f7efdac608cb6f779b144a87529138.1488180142.git.jcody@redhat.com>
Date: Mon, 27 Feb 2017 17:39:45 +0100
In-Reply-To: <25ccaa9f42f7efdac608cb6f779b144a87529138.1488180142.git.jcody@redhat.com>
	(Jeff Cody's message of "Mon, 27 Feb 2017 02:30:38 -0500")
Message-ID: <87fuiza8q6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/4] block/rbd: don't copy strings in
 qemu_rbd_next_tok()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Jeff Cody <jcody@redhat.com> writes:

> This patch is prep work for parsing options for .bdrv_parse_filename,
> and using QDict options.
>
> The function qemu_rbd_next_tok() searched for various key/value pairs,
> and copied them into buffers.  This will soon be an unnecessary extra
> step, so we will now return found strings by reference only, and
> offload the responsibility for safely handling/coping these strings to
> the caller.
>
> This also cleans up error handling some, as the callers now rely on
> the Error object to determine if there is a parse error.
>
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/rbd.c | 99 +++++++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 64 insertions(+), 35 deletions(-)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index 22e8e69..3f1a9de 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -102,10 +102,10 @@ typedef struct BDRVRBDState {
>      char *snap;
>  } BDRVRBDState;
>  
> -static int qemu_rbd_next_tok(char *dst, int dst_len,
> -                             char *src, char delim,
> -                             const char *name,
> -                             char **p, Error **errp)
> +static char *qemu_rbd_next_tok(int max_len,
> +                               char *src, char delim,
> +                               const char *name,
> +                               char **p, Error **errp)
>  {
>      int l;
>      char *end;

       *p = NULL;

       if (delim != '\0') {
           for (end = src; *end; ++end) {
               if (*end == delim) {
                   break;
               }
               if (*end == '\\' && end[1] != '\0') {
                   end++;
               }
           }
           if (*end == delim) {
               *p = end + 1;
               *end = '\0';
>          }
>      }
>      l = strlen(src);

Not this patch's problem: this is a rather thoughtless way to say

       l = end - src;

> -    if (l >= dst_len) {
> +    if (l >= max_len) {
>          error_setg(errp, "%s too long", name);
> -        return -EINVAL;
> +        return NULL;
>      } else if (l == 0) {
>          error_setg(errp, "%s too short", name);
> -        return -EINVAL;
> +        return NULL;
>      }
>  
> -    pstrcpy(dst, dst_len, src);
> -
> -    return 0;
> +    return src;
>  }

Note for later:

1. This function always dereferences @src.
2. If @delim, it sets *@p to point behind @src plus the delimiter,
   else to NULL
3. It returns NULL exactly when it sets an error.
4. It returns NULL and sets an error when @src is empty.

Not this patch's problem, but I have to say it: whoever wrote this code
should either write simpler functions or get into the habit of writing
function contract comments.  Because having to document your
embarrassingly complicated shit is great motivation to simplify (pardon
my french).

>  
>  static void qemu_rbd_unescape(char *src)
> @@ -162,7 +160,9 @@ static int qemu_rbd_parsename(const char *filename,

This is a parser.  As so often, it is a parser without any hint on what
it's supposed to parse, let alone a grammar.  Experience tells that
these are wrong more often than not, and exposing me to yet another one
is a surefire way to make me grumpy.  Not your fault, of course.

>  {
>      const char *start;
>      char *p, *buf;
> -    int ret;
> +    int ret = 0;
> +    char *found_str;
> +    Error *local_err = NULL;
>  
>      if (!strstart(filename, "rbd:", &start)) {
>          error_setg(errp, "File name must start with 'rbd:'");
           return -EINVAL;
       }

       buf = g_strdup(start);
       p = buf;

This assignment to @p ...

>      *snap = '\0';
>      *conf = '\0';
>  
> -    ret = qemu_rbd_next_tok(pool, pool_len, p,
> -                            '/', "pool name", &p, errp);
> -    if (ret < 0 || !p) {
> +    found_str = qemu_rbd_next_tok(pool_len, p,
> +                                 '/', "pool name", &p, &local_err);

... is dead, because qemu_rbd_next_tok() assigns to it unconditionally.

The call extracts the part up to the first unescaped '/' or the end of
the string.

> +    if (local_err) {
> +        goto done;
> +    }
> +    if (!p) {

We extracted to end of string, i.e. we didn't find '/'.

>          ret = -EINVAL;
> +        error_setg(errp, "Pool name is required");
>          goto done;
>      }
> -    qemu_rbd_unescape(pool);
> +    qemu_rbd_unescape(found_str);
> +    g_strlcpy(pool, found_str, pool_len);

Before, we copy, then unescape the copy.

After, we unescape in place, then copy.

Unescaping can't lengthen the string.  Therefore, this is safe as long
as nothing else uses this part of @buf.

>  
>      if (strchr(p, '@')) {
> -        ret = qemu_rbd_next_tok(name, name_len, p,
> -                                '@', "object name", &p, errp);
> -        if (ret < 0) {
> +        found_str = qemu_rbd_next_tok(name_len, p,
> +                                     '@', "object name", &p, &local_err);

Extracts from first unescaped '/' to next unescaped '@' or end of string.

@p can't be null.

> +        if (local_err) {
>              goto done;
>          }
> -        ret = qemu_rbd_next_tok(snap, snap_len, p,
> -                                ':', "snap name", &p, errp);
> -        qemu_rbd_unescape(snap);
> +        qemu_rbd_unescape(found_str);
> +        g_strlcpy(name, found_str, name_len);
> +
> +        found_str = qemu_rbd_next_tok(snap_len, p,
> +                                      ':', "snap name", &p, &local_err);

>From that '@' to next ':' or end of string.

> +        if (local_err) {
> +            goto done;
> +        }
> +        qemu_rbd_unescape(found_str);
> +        g_strlcpy(snap, found_str, snap_len);

This confused me, but I figured it out: you're moving the @name unescape
from after the conditional into both its arms.  This is the first copy.

>      } else {
> -        ret = qemu_rbd_next_tok(name, name_len, p,
> -                                ':', "object name", &p, errp);
> +        found_str = qemu_rbd_next_tok(name_len, p,
> +                                     ':', "object name", &p, &local_err);

>From first '/' to next ':' or end of string.

Indentation off by one.

> +        if (local_err) {
> +            goto done;
> +        }
> +        qemu_rbd_unescape(found_str);

This is the second copy of the moved unescape.

> +        g_strlcpy(name, found_str, name_len);
>      }
> -    qemu_rbd_unescape(name);

This is where the copies come from.

> -    if (ret < 0 || !p) {
> +    if (!p) {

We didn't find ':'.

>          goto done;
>      }
>  
> -    ret = qemu_rbd_next_tok(conf, conf_len, p,
> -                            '\0', "configuration", &p, errp);
> +    found_str = qemu_rbd_next_tok(conf_len, p,
> +                                 '\0', "configuration", &p, &local_err);

>From that ':' to end of string.

> +    if (local_err) {
> +        goto done;
> +    }
> +    g_strlcpy(conf, found_str, conf_len);

No unescape?  Strange... but your patch doesn't change anything.

>  
>  done:
> +    if (local_err) {
> +        ret = -EINVAL;
> +        error_propagate(errp, local_err);
> +    }
>      g_free(buf);
>      return ret;
>  }

Okay, now someone tell me what it's supposed to parse, and I tell you
whether it works.

Unescaping in place looks safe.

> @@ -262,17 +286,18 @@ static int qemu_rbd_set_conf(rados_t cluster, const char *conf,

Great, another parser for an unknown language.  I'll pass.

>                               Error **errp)
>  {
>      char *p, *buf;
> -    char name[RBD_MAX_CONF_NAME_SIZE];
> -    char value[RBD_MAX_CONF_VAL_SIZE];
> +    char *name;
> +    char *value;
> +    Error *local_err = NULL;
>      int ret = 0;
>  
>      buf = g_strdup(conf);
>      p = buf;

Again, dead assignment to @p.

>  
>      while (p) {
> -        ret = qemu_rbd_next_tok(name, sizeof(name), p,
> -                                '=', "conf option name", &p, errp);
> -        if (ret < 0) {
> +        name = qemu_rbd_next_tok(RBD_MAX_CONF_NAME_SIZE, p,
> +                                 '=', "conf option name", &p, &local_err);
> +        if (local_err) {
>              break;
>          }
>          qemu_rbd_unescape(name);

Again, you change to unescape in place.

> @@ -283,9 +308,9 @@ static int qemu_rbd_set_conf(rados_t cluster, const char *conf,
>              break;
>          }
>  
> -        ret = qemu_rbd_next_tok(value, sizeof(value), p,
> -                                ':', "conf option value", &p, errp);
> -        if (ret < 0) {
> +        value = qemu_rbd_next_tok(RBD_MAX_CONF_VAL_SIZE, p,
> +                                  ':', "conf option value", &p, &local_err);
> +        if (local_err) {
>              break;
>          }
>          qemu_rbd_unescape(value);

Likewise.

> @@ -313,6 +338,10 @@ static int qemu_rbd_set_conf(rados_t cluster, const char *conf,
>          }
>      }
>  
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        ret = -EINVAL;
> +    }
>      g_free(buf);
>      return ret;
>  }

Again, unescaping in place looks safe.

Preferably with the two dead assignments dropped:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
