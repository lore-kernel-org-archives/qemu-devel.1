Received: from eggs.gnu.org ([2001:4830:134:3::10]:37526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQvIt-0006rE-NT
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQvIs-0002x6-3X
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:50:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34746 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fQvIr-0002wR-TS
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:50:14 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180529174821.19964-1-f4bug@amsat.org>
	<20180529174821.19964-5-f4bug@amsat.org>
Date: Thu, 07 Jun 2018 15:50:12 +0200
In-Reply-To: <20180529174821.19964-5-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue,
	29 May 2018 14:48:21 -0300")
Message-ID: <87h8mevh7v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] device_tree: Replace
 error_setg(&error_fatal) by error_report() + exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Use error_report() + exit() instead of error_setg(&error_fatal),
> as suggested by the "qapi/error.h" documentation:
>
>    Please don't error_setg(&error_fatal, ...), use error_report() and
>    exit(), because that's more obvious.
>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  device_tree.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/device_tree.c b/device_tree.c
> index 52c3358a55..3553819257 100644
> --- a/device_tree.c
> +++ b/device_tree.c
> @@ -140,15 +140,16 @@ static void read_fstree(void *fdt, const char *dirn=
ame)
>      const char *parent_node;
>=20=20
>      if (strstr(dirname, root_dir) !=3D dirname) {
> -        error_setg(&error_fatal, "%s: %s must be searched within %s",
> -                   __func__, dirname, root_dir);
> +        error_report("%s: %s must be searched within %s",
> +                     __func__, dirname, root_dir);
> +        exit(1);

Preexisting code smell: __func__ in an error message.  Not this patch's
problem.

>      }
>      parent_node =3D &dirname[strlen(SYSFS_DT_BASEDIR)];
>=20=20
>      d =3D opendir(dirname);
>      if (!d) {
> -        error_setg(&error_fatal, "%s cannot open %s", __func__, dirname);
> -        return;
> +        error_report("%s cannot open %s", __func__, dirname);
> +        exit(1);
>      }
>=20=20
>      while ((de =3D readdir(d)) !=3D NULL) {
> @@ -162,7 +163,8 @@ static void read_fstree(void *fdt, const char *dirnam=
e)
>          tmpnam =3D g_strdup_printf("%s/%s", dirname, de->d_name);
>=20=20
>          if (lstat(tmpnam, &st) < 0) {
> -            error_setg(&error_fatal, "%s cannot lstat %s", __func__, tmp=
nam);
> +            error_report("%s cannot lstat %s", __func__, tmpnam);
> +            exit(1);
>          }
>=20=20
>          if (S_ISREG(st.st_mode)) {
> @@ -170,8 +172,9 @@ static void read_fstree(void *fdt, const char *dirnam=
e)
>              gsize len;
>=20=20
>              if (!g_file_get_contents(tmpnam, &val, &len, NULL)) {
> -                error_setg(&error_fatal, "%s not able to extract info fr=
om %s",
> -                           __func__, tmpnam);
> +                error_report("%s not able to extract info from %s",
> +                             __func__, tmpnam);
> +                exit(1);
>              }
>=20=20
>              if (strlen(parent_node) > 0) {
> @@ -206,9 +209,9 @@ void *load_device_tree_from_sysfs(void)
>      host_fdt =3D create_device_tree(&host_fdt_size);
>      read_fstree(host_fdt, SYSFS_DT_BASEDIR);
>      if (fdt_check_header(host_fdt)) {
> -        error_setg(&error_fatal,
> -                   "%s host device tree extracted into memory is invalid=
",
> -                   __func__);
> +        error_report("%s host device tree extracted into memory is inval=
id",
> +                     __func__);
> +        exit(1);
>      }
>      return host_fdt;
>  }

Reviewed-by: Markus Armbruster <armbru@redhat.com>
