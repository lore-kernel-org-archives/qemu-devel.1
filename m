Received: from eggs.gnu.org ([2001:4830:134:3::10]:49270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ctzOt-0008Dl-DT
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ctzOr-0004CL-W5
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:27:47 -0400
Date: Fri, 31 Mar 2017 12:27:38 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170331162738.GB28870@localhost.localdomain>
References: <20170331152730.12514-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170331152730.12514-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] rbd: Fix regression in legacy
 key/values containing escaped :
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, Alexandru.Avadanii@enea.com, Josh Durgin <jdurgin@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Fri, Mar 31, 2017 at 10:27:30AM -0500, Eric Blake wrote:
> Commit c7cacb3 accidentally broke legacy key-value parsing through
> pseudo-filename parsing of -drive file=rbd://..., for any key that
> contains an escaped ':'.  Such a key is surprisingly common, thanks
> to mon_host specifying a 'host:port' string.  The break happens
> because passing things from QDict through QemuOpts back to another
> QDict requires that we pack our parsed key/value pairs into a string,
> and then reparse that string, but the intermediate string that we
> created ("key1=value1:key2=value2") lost the \: escaping that was
> present in the original, so that we could no longer see which : were
> used as separators vs. those used as part of the original input.
> 
> Fix it by collecting the key/value pairs through a QList, and
> sending that list on a round trip through a JSON QString (as in
> '["key1","value1","key2","value2"]') on its way through QemuOpts,
> rather than hand-rolling our own string.  Since the string is only
> handled internally, this was faster than creating a full-blown
> struct of '[{"key1":"value1"},{"key2":"value2"}]', and safer at
> guaranteeing order compared to '{"key1":"value1","key2":"value2"}'.
> 
> It would be nicer if we didn't have to round-trip through QemuOpts
> in the first place, but that's a much bigger task for later.
> 
> Reproducer:
> ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio \
> -drive 'file=rbd:volumes/volume-ea141b5c-cdb3-4765-910d-e7008b209a70'\
> ':id=compute:key=AQAVkvxXAAAAABAA9ZxWFYdRmV+DSwKr7BKKXg=='\
> ':auth_supported=cephx\;none:mon_host=192.168.1.2\:6789'\
> ',format=raw,if=none,id=drive-virtio-disk0,'\
> 'serial=ea141b5c-cdb3-4765-910d-e7008b209a70,cache=writeback'
> 
> Even without an RBD setup, this serves a test of whether we get
> the incorrect parser error of:
> qemu-system-x86_64: -drive file=rbd:...cache=writeback: conf option 6789 has no value
> or the correct behavior of hanging while trying to connect to
> the requested mon_host of 192.168.1.2:6789.
> 
> Reported-by: Alexandru Avadanii <Alexandru.Avadanii@enea.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/rbd.c | 83 +++++++++++++++++++++++++++++++------------------------------
>  1 file changed, 42 insertions(+), 41 deletions(-)
> 
> diff --git a/block/rbd.c b/block/rbd.c
> index 498322b..fbdb131 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -20,6 +20,7 @@
>  #include "crypto/secret.h"
>  #include "qemu/cutils.h"
>  #include "qapi/qmp/qstring.h"
> +#include "qapi/qmp/qjson.h"
> 
>  /*
>   * When specifying the image filename use:
> @@ -135,18 +136,16 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
>                                      Error **errp)
>  {
>      const char *start;
> -    char *p, *buf, *keypairs;
> +    char *p, *buf;
> +    QList *keypairs = NULL;
>      char *found_str;
> -    size_t max_keypair_size;
> 
>      if (!strstart(filename, "rbd:", &start)) {
>          error_setg(errp, "File name must start with 'rbd:'");
>          return;
>      }
> 
> -    max_keypair_size = strlen(start) + 1;
>      buf = g_strdup(start);
> -    keypairs = g_malloc0(max_keypair_size);
>      p = buf;
> 
>      found_str = qemu_rbd_next_tok(p, '/', &p);
> @@ -194,33 +193,30 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
>          } else if (!strcmp(name, "id")) {
>              qdict_put(options, "user" , qstring_from_str(value));
>          } else {
> -            /* FIXME: This is pretty ugly, and not the right way to do this.
> -             *        These should be contained in a structure, and then
> -             *        passed explicitly as individual key/value pairs to
> -             *        rados.  Consider this legacy code that needs to be
> -             *        updated. */
> -            char *tmp = g_malloc0(max_keypair_size);
> -            /* only use a delimiter if it is not the first keypair found */
> -            /* These are sets of unknown key/value pairs we'll pass along
> -             * to ceph */
> -            if (keypairs[0]) {
> -                snprintf(tmp, max_keypair_size, ":%s=%s", name, value);
> -                pstrcat(keypairs, max_keypair_size, tmp);
> -            } else {
> -                snprintf(keypairs, max_keypair_size, "%s=%s", name, value);
> +            /*
> +             * We pass these internally to qemu_rbd_set_keypairs(), so
> +             * we can get away with the simpler list of [ "key1",
> +             * "value1", "key2", "value2" ] rather than a raw dict
> +             * { "key1": "value1", "key2": "value2" } where we can't
> +             * guarantee order, or even a more correct but complex
> +             * [ { "key1": "value1" }, { "key2": "value2" } ]
> +             */
> +            if (!keypairs) {
> +                keypairs = qlist_new();
>              }
> -            g_free(tmp);
> +            qlist_append(keypairs, qstring_from_str(name));
> +            qlist_append(keypairs, qstring_from_str(value));
>          }
>      }
> 
> -    if (keypairs[0]) {
> -        qdict_put(options, "=keyvalue-pairs", qstring_from_str(keypairs));
> +    if (keypairs) {
> +        qdict_put(options, "=keyvalue-pairs",
> +                  qobject_to_json(QOBJECT(keypairs)));
>      }
> 
> -
>  done:
>      g_free(buf);
> -    g_free(keypairs);
> +    QDECREF(keypairs);
>      return;
>  }
> 
> @@ -244,36 +240,41 @@ static int qemu_rbd_set_auth(rados_t cluster, const char *secretid,
>      return 0;
>  }
> 
> -static int qemu_rbd_set_keypairs(rados_t cluster, const char *keypairs,
> +static int qemu_rbd_set_keypairs(rados_t cluster, const char *keypairs_json,
>                                   Error **errp)
>  {
> -    char *p, *buf;
> -    char *name;
> -    char *value;
> +    QList *keypairs;
> +    QString *name;
> +    QString *value;
> +    const char *key;
> +    size_t remaining;
>      int ret = 0;
> 
> -    buf = g_strdup(keypairs);
> -    p = buf;
> +    if (!keypairs_json) {
> +        return ret;
> +    }
> +    keypairs = qobject_to_qlist(qobject_from_json(keypairs_json,
> +                                                  &error_abort));
> +    remaining = qlist_size(keypairs) / 2;
> +    assert(remaining);
> 
> -    while (p) {
> -        name = qemu_rbd_next_tok(p, '=', &p);
> -        if (!p) {
> -            error_setg(errp, "conf option %s has no value", name);
> -            ret = -EINVAL;
> -            break;
> -        }
> +    while (remaining--) {
> +        name = qobject_to_qstring(qlist_pop(keypairs));
> +        value = qobject_to_qstring(qlist_pop(keypairs));
> +        assert(name && value);

We could just drop 'remaining' and break if !name && !value, and then
assert(!name || !value).  But this is fine too, of course.

Thanks for the fix:

Reviewed-by: Jeff Cody <jcody@redhat.com>

> +        key = qstring_get_str(name);
> 
> -        value = qemu_rbd_next_tok(p, ':', &p);
> -
> -        ret = rados_conf_set(cluster, name, value);
> +        ret = rados_conf_set(cluster, key, qstring_get_str(value));
> +        QDECREF(name);
> +        QDECREF(value);
>          if (ret < 0) {
> -            error_setg_errno(errp, -ret, "invalid conf option %s", name);
> +            error_setg_errno(errp, -ret, "invalid conf option %s", key);
>              ret = -EINVAL;
>              break;
>          }
>      }
> 
> -    g_free(buf);
> +    QDECREF(keypairs);
>      return ret;
>  }
> 
> -- 
> 2.9.3
> 
