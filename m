Received: from eggs.gnu.org ([2001:4830:134:3::10]:42234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fT82f-0004qH-9C
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fT82a-0007io-Rc
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:50:37 -0400
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:54969)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fT82a-0007fA-FY
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:50:32 -0400
Received: from player690.ha.ovh.net (unknown [10.109.122.7])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 944C81C0DAA
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 17:50:30 +0200 (CEST)
Date: Wed, 13 Jun 2018 17:50:24 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180613175024.62b7f203@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <1528861711-23200-1-git-send-email-keno@juliacomputing.com>
References: <1528861711-23200-1-git-send-email-keno@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5] cutils: Provide strchrnul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keno Fischer <keno@juliacomputing.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue, 12 Jun 2018 23:48:31 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> strchrnul is a GNU extension and thus unavailable on a number of targets.
> In the review for a commit removing strchrnul from 9p, I was asked to
> create a qemu_strchrnul helper to factor out this functionality.
> Do so, and use it in a number of other places in the code base that inlined
> the replacement pattern in a place where strchrnul could be used.
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> Acked-by: Greg Kurz <groug@kaod.org>
> ---
> 

Applied to 9p-next. You can rebase your patches against:

https://github.com/gkurz/qemu/commits/9p-next

Thanks!

> Changes since v4:
>  - `CONFIG_STRCHRNUL` -> `HAVE_STRCHRNUL` name change
>  - In the strchrnul configure check
>    - Return the value of strchrnul to avoid it being optimized away
>    - Use `&main` (i.e. the assembly of the generated function as
>      the haystack) to avoid concerns about constant folding. `main`
>      seemed like the simplest symbol guaranteed to exist, but with
>      non-foldable content.
> 
>  configure             | 18 ++++++++++++++++++
>  hmp.c                 |  8 ++++----
>  hw/9pfs/9p-local.c    |  2 +-
>  include/qemu/cutils.h |  8 ++++++++
>  monitor.c             |  8 ++------
>  util/cutils.c         | 15 +++++++++++++++
>  util/qemu-option.c    |  6 +-----
>  util/uri.c            |  6 ++----
>  8 files changed, 51 insertions(+), 20 deletions(-)
> 
> diff --git a/configure b/configure
> index 14b1113..8a75745 100755
> --- a/configure
> +++ b/configure
> @@ -4747,6 +4747,21 @@ if compile_prog "" "" ; then
>  fi
>  
>  ##########################################
> +# check if we have strchrnul
> +
> +strchrnul=no
> +cat > $TMPC << EOF
> +#include <string.h>
> +int main(void);
> +// Use a haystack that the compiler shouldn't be able to constant fold
> +char *haystack = (char*)&main;
> +int main(void) { return strchrnul(haystack, 'x') != &haystack[6]; }
> +EOF
> +if compile_prog "" "" ; then
> +    strchrnul=yes
> +fi
> +
> +##########################################
>  # check if trace backend exists
>  
>  $python "$source_path/scripts/tracetool.py" "--backends=$trace_backends" --check-backends  > /dev/null 2> /dev/null
> @@ -6229,6 +6244,9 @@ fi
>  if test "$sem_timedwait" = "yes" ; then
>    echo "CONFIG_SEM_TIMEDWAIT=y" >> $config_host_mak
>  fi
> +if test "$strchrnul" = "yes" ; then
> +  echo "HAVE_STRCHRNUL=y" >> $config_host_mak
> +fi
>  if test "$byteswap_h" = "yes" ; then
>    echo "CONFIG_BYTESWAP_H=y" >> $config_host_mak
>  fi
> diff --git a/hmp.c b/hmp.c
> index ef93f48..416d4c9 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2123,12 +2123,12 @@ void hmp_sendkey(Monitor *mon, const QDict *qdict)
>      int has_hold_time = qdict_haskey(qdict, "hold-time");
>      int hold_time = qdict_get_try_int(qdict, "hold-time", -1);
>      Error *err = NULL;
> -    char *separator;
> +    const char *separator;
>      int keyname_len;
>  
>      while (1) {
> -        separator = strchr(keys, '-');
> -        keyname_len = separator ? separator - keys : strlen(keys);
> +        separator = qemu_strchrnul(keys, '-');
> +        keyname_len = separator - keys;
>  
>          /* Be compatible with old interface, convert user inputted "<" */
>          if (keys[0] == '<' && keyname_len == 1) {
> @@ -2165,7 +2165,7 @@ void hmp_sendkey(Monitor *mon, const QDict *qdict)
>              keylist->value->u.qcode.data = idx;
>          }
>  
> -        if (!separator) {
> +        if (!*separator) {
>              break;
>          }
>          keys = separator + 1;
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 5721eff..828e8d6 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -65,7 +65,7 @@ int local_open_nofollow(FsContext *fs_ctx, const char *path, int flags,
>          assert(*path != '/');
>  
>          head = g_strdup(path);
> -        c = strchrnul(path, '/');
> +        c = qemu_strchrnul(path, '/');
>          if (*c) {
>              /* Intermediate path element */
>              head[c - path] = 0;
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index a663340..274d419 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -122,6 +122,14 @@ int qemu_strnlen(const char *s, int max_len);
>   * Returns: the pointer originally in @input.
>   */
>  char *qemu_strsep(char **input, const char *delim);
> +#ifdef HAVE_STRCHRNUL
> +static inline const char *qemu_strchrnul(const char *s, int c)
> +{
> +    return strchrnul(s, c);
> +}
> +#else
> +const char *qemu_strchrnul(const char *s, int c);
> +#endif
>  time_t mktimegm(struct tm *tm);
>  int qemu_fdatasync(int fd);
>  int fcntl_setfl(int fd, int flag);
> diff --git a/monitor.c b/monitor.c
> index 6d0cec5..4484d74 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -797,9 +797,7 @@ static int compare_cmd(const char *name, const char *list)
>      p = list;
>      for(;;) {
>          pstart = p;
> -        p = strchr(p, '|');
> -        if (!p)
> -            p = pstart + strlen(pstart);
> +        p = qemu_strchrnul(p, '|');
>          if ((p - pstart) == len && !memcmp(pstart, name, len))
>              return 1;
>          if (*p == '\0')
> @@ -3400,9 +3398,7 @@ static void cmd_completion(Monitor *mon, const char *name, const char *list)
>      p = list;
>      for(;;) {
>          pstart = p;
> -        p = strchr(p, '|');
> -        if (!p)
> -            p = pstart + strlen(pstart);
> +        p = qemu_strchrnul(p, '|');
>          len = p - pstart;
>          if (len > sizeof(cmd) - 2)
>              len = sizeof(cmd) - 2;
> diff --git a/util/cutils.c b/util/cutils.c
> index 0de69e6..9205e09 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -545,6 +545,21 @@ int qemu_strtou64(const char *nptr, const char **endptr, int base,
>  }
>  
>  /**
> + * Searches for the first occurrence of 'c' in 's', and returns a pointer
> + * to the trailing null byte if none was found.
> + */
> +#ifndef HAVE_STRCHRNUL
> +const char *qemu_strchrnul(const char *s, int c)
> +{
> +    const char *e = strchr(s, c);
> +    if (!e) {
> +        e = s + strlen(s);
> +    }
> +    return e;
> +}
> +#endif
> +
> +/**
>   * parse_uint:
>   *
>   * @s: String to parse
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 58d1c23..54eca12 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -77,11 +77,7 @@ const char *get_opt_value(const char *p, char **value)
>  
>      *value = NULL;
>      while (1) {
> -        offset = strchr(p, ',');
> -        if (!offset) {
> -            offset = p + strlen(p);
> -        }
> -
> +        offset = qemu_strchrnul(p, ',');
>          length = offset - p;
>          if (*offset != '\0' && *(offset + 1) == ',') {
>              length++;
> diff --git a/util/uri.c b/util/uri.c
> index 8624a7a..8bdef84 100644
> --- a/util/uri.c
> +++ b/util/uri.c
> @@ -52,6 +52,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  
>  #include "qemu/uri.h"
>  
> @@ -2266,10 +2267,7 @@ struct QueryParams *query_params_parse(const char *query)
>          /* Find the next separator, or end of the string. */
>          end = strchr(query, '&');
>          if (!end) {
> -            end = strchr(query, ';');
> -        }
> -        if (!end) {
> -            end = query + strlen(query);
> +            end = qemu_strchrnul(query, ';');
>          }
>  
>          /* Find the first '=' character between here and end. */
