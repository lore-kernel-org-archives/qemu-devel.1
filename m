Received: from eggs.gnu.org ([2001:4830:134:3::10]:52427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQBoh-0005sB-BP
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fQBoZ-0004An-3C
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:16:03 -0400
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:49855)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fQBoY-00049n-P4
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:15:55 -0400
Received: from player793.ha.ovh.net (unknown [10.109.120.5])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id D2BC6E2396
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 15:15:52 +0200 (CEST)
Date: Tue, 5 Jun 2018 15:15:46 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180605151525.71ecf518@bahia.lan>
In-Reply-To: <20180605134802.4672d12c@bahia.lan>
References: <cover.1527973524.git.keno@juliacomputing.com>
	<51be4c123dbf92a45184e386bd7a62614430ba29.1527973524.git.keno@juliacomputing.com>
	<20180605134802.4672d12c@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/5] cutils: Provide strchrnul
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

On Tue, 5 Jun 2018 13:48:02 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Sat,  2 Jun 2018 17:29:35 -0400
> Keno Fischer <keno@juliacomputing.com> wrote:
>=20
> > strchrnul is a GNU extension and thus unavailable on a number of target=
s.
> > In the review for a commit removing strchrnul from 9p, I was asked to
> > create a qemu_strchrnul helper to factor out this functionality.
> > Do so, and use it in a number of other places in the code base that inl=
ined
> > the replacement pattern in a place where strchrnul could be used.
> >=20
> > Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> > Acked-by: Greg Kurz <groug@kaod.org>
> > ---
> >=20
> > Changes since v2:
> >  * Add configure check as suggested by Greg Kurz <groug@kaod.org>,
> >    and requested by Eric Blake <eblake@redhat.com>
> >  * Use qemu_strchrnul in hmp_sendkey as suggested by
> >    Dr. David Alan Gilbert <dgilbert@redhat.com>
> >  =20
>=20
> My Acked-by stands with the new changes.
>=20

But this doesn't build on CentOS 7.5.1804 (gcc 4.8.5 20150623 (Red Hat 4.8.=
5-28))

ERROR: configure test passed without -Werror but failed with -Werror.
       This is probably a bug in the configure script. The failing command
       will be at the bottom of config.log.
       You can run configure with --disable-werror to bypass this check.

More below...

> If everyone is okay, maybe better for this to go through my tree
> since it is required for the "9p: Add support for Darwin" series.
>=20
> >  configure             | 15 +++++++++++++++
> >  hmp.c                 |  8 ++++----
> >  hw/9pfs/9p-local.c    |  2 +-
> >  include/qemu/cutils.h |  8 ++++++++
> >  monitor.c             |  8 ++------
> >  util/cutils.c         | 15 +++++++++++++++
> >  util/qemu-option.c    |  6 +-----
> >  util/uri.c            |  6 ++----
> >  8 files changed, 48 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/configure b/configure
> > index a6a4616..1b3ca4e 100755
> > --- a/configure
> > +++ b/configure
> > @@ -4754,6 +4754,18 @@ if compile_prog "" "" ; then
> >  fi
> > =20
> >  ##########################################
> > +# check if we have strchrnul
> > +
> > +strchrnul=3Dno
> > +cat > $TMPC << EOF
> > +#include <string.h>
> > +int main(void) { (void)strchrnul("Hello World", 'W'); }

config-temp/qemu-conf.c: In function =E2=80=98main=E2=80=99:
config-temp/qemu-conf.c:2:1: error: control reaches end of non-void
 function [-Werror=3Dreturn-type]
 int main(void) { (void)strchrnul("Hello World", 'W'); }
 ^
cc1: all warnings being treated as errors

Adding 'return 0;' like for syslog a few lines above is enough.

> > +EOF
> > +if compile_prog "" "" ; then
> > +    strchrnul=3Dyes
> > +fi
> > +
> > +##########################################
> >  # check if trace backend exists
> > =20
> >  $python "$source_path/scripts/tracetool.py" "--backends=3D$trace_backe=
nds" --check-backends  > /dev/null 2> /dev/null
> > @@ -6210,6 +6222,9 @@ fi
> >  if test "$sem_timedwait" =3D "yes" ; then
> >    echo "CONFIG_SEM_TIMEDWAIT=3Dy" >> $config_host_mak
> >  fi
> > +if test "$strchrnul" =3D "yes" ; then
> > +  echo "CONFIG_STRCHRNUL=3Dy" >> $config_host_mak
> > +fi
> >  if test "$byteswap_h" =3D "yes" ; then
> >    echo "CONFIG_BYTESWAP_H=3Dy" >> $config_host_mak
> >  fi
> > diff --git a/hmp.c b/hmp.c
> > index ef93f48..416d4c9 100644
> > --- a/hmp.c
> > +++ b/hmp.c
> > @@ -2123,12 +2123,12 @@ void hmp_sendkey(Monitor *mon, const QDict *qdi=
ct)
> >      int has_hold_time =3D qdict_haskey(qdict, "hold-time");
> >      int hold_time =3D qdict_get_try_int(qdict, "hold-time", -1);
> >      Error *err =3D NULL;
> > -    char *separator;
> > +    const char *separator;
> >      int keyname_len;
> > =20
> >      while (1) {
> > -        separator =3D strchr(keys, '-');
> > -        keyname_len =3D separator ? separator - keys : strlen(keys);
> > +        separator =3D qemu_strchrnul(keys, '-');
> > +        keyname_len =3D separator - keys;
> > =20
> >          /* Be compatible with old interface, convert user inputted "<"=
 */
> >          if (keys[0] =3D=3D '<' && keyname_len =3D=3D 1) {
> > @@ -2165,7 +2165,7 @@ void hmp_sendkey(Monitor *mon, const QDict *qdict)
> >              keylist->value->u.qcode.data =3D idx;
> >          }
> > =20
> > -        if (!separator) {
> > +        if (!*separator) {
> >              break;
> >          }
> >          keys =3D separator + 1;
> > diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> > index 7758c38..304ef72 100644
> > --- a/hw/9pfs/9p-local.c
> > +++ b/hw/9pfs/9p-local.c
> > @@ -65,7 +65,7 @@ int local_open_nofollow(FsContext *fs_ctx, const char=
 *path, int flags,
> >          assert(*path !=3D '/');
> > =20
> >          head =3D g_strdup(path);
> > -        c =3D strchrnul(path, '/');
> > +        c =3D qemu_strchrnul(path, '/');
> >          if (*c) {
> >              /* Intermediate path element */
> >              head[c - path] =3D 0;
> > diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> > index a663340..809090c 100644
> > --- a/include/qemu/cutils.h
> > +++ b/include/qemu/cutils.h
> > @@ -122,6 +122,14 @@ int qemu_strnlen(const char *s, int max_len);
> >   * Returns: the pointer originally in @input.
> >   */
> >  char *qemu_strsep(char **input, const char *delim);
> > +#ifdef CONFIG_STRCHRNUL
> > +static inline const char *qemu_strchrnul(const char *s, int c)
> > +{
> > +    return strchrnul(s, c);
> > +}
> > +#else
> > +const char *qemu_strchrnul(const char *s, int c);
> > +#endif
> >  time_t mktimegm(struct tm *tm);
> >  int qemu_fdatasync(int fd);
> >  int fcntl_setfl(int fd, int flag);
> > diff --git a/monitor.c b/monitor.c
> > index 922cfc0..e1f01c4 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -798,9 +798,7 @@ static int compare_cmd(const char *name, const char=
 *list)
> >      p =3D list;
> >      for(;;) {
> >          pstart =3D p;
> > -        p =3D strchr(p, '|');
> > -        if (!p)
> > -            p =3D pstart + strlen(pstart);
> > +        p =3D qemu_strchrnul(p, '|');
> >          if ((p - pstart) =3D=3D len && !memcmp(pstart, name, len))
> >              return 1;
> >          if (*p =3D=3D '\0')
> > @@ -3401,9 +3399,7 @@ static void cmd_completion(Monitor *mon, const ch=
ar *name, const char *list)
> >      p =3D list;
> >      for(;;) {
> >          pstart =3D p;
> > -        p =3D strchr(p, '|');
> > -        if (!p)
> > -            p =3D pstart + strlen(pstart);
> > +        p =3D qemu_strchrnul(p, '|');
> >          len =3D p - pstart;
> >          if (len > sizeof(cmd) - 2)
> >              len =3D sizeof(cmd) - 2;
> > diff --git a/util/cutils.c b/util/cutils.c
> > index 0de69e6..c365ddb 100644
> > --- a/util/cutils.c
> > +++ b/util/cutils.c
> > @@ -545,6 +545,21 @@ int qemu_strtou64(const char *nptr, const char **e=
ndptr, int base,
> >  }
> > =20
> >  /**
> > + * Searches for the first occurrence of 'c' in 's', and returns a poin=
ter
> > + * to the trailing null byte if none was found.
> > + */
> > +#ifndef CONFIG_STRCHRNUL
> > +const char *qemu_strchrnul(const char *s, int c)
> > +{
> > +    const char *e =3D strchr(s, c);
> > +    if (!e) {
> > +        e =3D s + strlen(s);
> > +    }
> > +    return e;
> > +}
> > +#endif
> > +
> > +/**
> >   * parse_uint:
> >   *
> >   * @s: String to parse
> > diff --git a/util/qemu-option.c b/util/qemu-option.c
> > index 58d1c23..54eca12 100644
> > --- a/util/qemu-option.c
> > +++ b/util/qemu-option.c
> > @@ -77,11 +77,7 @@ const char *get_opt_value(const char *p, char **valu=
e)
> > =20
> >      *value =3D NULL;
> >      while (1) {
> > -        offset =3D strchr(p, ',');
> > -        if (!offset) {
> > -            offset =3D p + strlen(p);
> > -        }
> > -
> > +        offset =3D qemu_strchrnul(p, ',');
> >          length =3D offset - p;
> >          if (*offset !=3D '\0' && *(offset + 1) =3D=3D ',') {
> >              length++;
> > diff --git a/util/uri.c b/util/uri.c
> > index 8624a7a..8bdef84 100644
> > --- a/util/uri.c
> > +++ b/util/uri.c
> > @@ -52,6 +52,7 @@
> >   */
> > =20
> >  #include "qemu/osdep.h"
> > +#include "qemu/cutils.h"
> > =20
> >  #include "qemu/uri.h"
> > =20
> > @@ -2266,10 +2267,7 @@ struct QueryParams *query_params_parse(const cha=
r *query)
> >          /* Find the next separator, or end of the string. */
> >          end =3D strchr(query, '&');
> >          if (!end) {
> > -            end =3D strchr(query, ';');
> > -        }
> > -        if (!end) {
> > -            end =3D query + strlen(query);
> > +            end =3D qemu_strchrnul(query, ';');
> >          }
> > =20
> >          /* Find the first '=3D' character between here and end. */ =20
>=20
