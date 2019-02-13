Received: from eggs.gnu.org ([209.51.188.92]:60974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gtvDO-0006hQ-1n
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gtv9I-0004G7-5q
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:04:29 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:44120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1gtv9G-0004AV-0F
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 09:04:27 -0500
Received: by mail-wr1-f41.google.com with SMTP id v16so2593850wrn.11
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 06:04:22 -0800 (PST)
Date: Wed, 13 Feb 2019 15:04:18 +0100
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20190213150418.70acfbdf@fiorina>
In-Reply-To: <1545208851-6906-2-git-send-email-bishara@daynix.com>
References: <1545208851-6906-1-git-send-email-bishara@daynix.com>
	<1545208851-6906-2-git-send-email-bishara@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qga-win: Adding support for Windows Server
 2019 get-osinfo command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bishara AbuHattoum <bishara@daynix.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Yan Vugenfirer <yan@daynix.com>, Samee Jubran <sameeh@daynix.com>

On Wed, 19 Dec 2018 10:40:51 +0200
Bishara AbuHattoum <bishara@daynix.com> wrote:

> Since Windows Server 2016, Microsoft stopped upgrading the major and minor
> versions of their new Windows Server product, so, the current functionali=
ty
> of checking major and minor version numbers to determine the Windows Serv=
er
> version wont work as expected.
> The implemented solution here is to use the build number in addition to t=
he
> major and minor version numbers of the product to determine the Windows
> Server product version.
> The final build number of Windows Server 2016 is 14939, and
> the final build number of Windows Server 2019 is 17764, so any Windows
> Server product that has the major version of 10 and minor version of 0
> with a build number lower or equal to 14939 will resemble 2016 and if the
> build number is lower or equal to 17763 will resemble 2019.
>=20
> Reference:
> https://techcommunity.microsoft.com/t5/Windows-Server-Insiders/Windows-Se=
rver-2019-version-info/m-p/293112/highlight/true#M859
>=20
> Signed-off-by: Bishara AbuHattoum <bishara@daynix.com>
> ---
>  qga/commands-win32.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>=20
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 62e1b51..3985b40 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -2009,12 +2009,24 @@ static ga_matrix_lookup_t const WIN_VERSION_MATRI=
X[2][8] =3D {
>          { 6, 1, "Microsoft Windows Server 2008 R2",     "2008r2"},
>          { 6, 2, "Microsoft Windows Server 2012",        "2012"},
>          { 6, 3, "Microsoft Windows Server 2012 R2",     "2012r2"},
> -        {10, 0, "Microsoft Windows Server 2016",        "2016"},
> +        { 0, 0, 0},
>          { 0, 0, 0},
>          { 0, 0, 0}
>      }
>  };
> =20
> +typedef struct _ga_win_10_0_server_t {
> +    int final_build;
> +    char const *version;
> +    char const *version_id;
> +} ga_win_10_0_server_t;
> +
> +static ga_win_10_0_server_t const WIN_10_0_SERVER_VERSION_MATRIX[3] =3D {
> +    {14393, "Microsoft Windows Server 2016",    "2016"},
> +    {17763, "Microsoft Windows Server 2019",    "2019"},
> +    {0, 0}
> +};
> +
>  static void ga_get_win_version(RTL_OSVERSIONINFOEXW *info, Error **errp)
>  {
>      typedef NTSTATUS(WINAPI * rtl_get_version_t)(
> @@ -2039,10 +2051,23 @@ static char *ga_get_win_name(OSVERSIONINFOEXW con=
st *os_version, bool id)
>  {
>      DWORD major =3D os_version->dwMajorVersion;
>      DWORD minor =3D os_version->dwMinorVersion;
> +    DWORD build =3D os_version->dwBuildNumber;
>      int tbl_idx =3D (os_version->wProductType !=3D VER_NT_WORKSTATION);
>      ga_matrix_lookup_t const *table =3D WIN_VERSION_MATRIX[tbl_idx];
> +    ga_win_10_0_server_t const *win_10_0_table =3D WIN_10_0_SERVER_VERSI=
ON_MATRIX;
>      while (table->version !=3D NULL) {
> -        if (major =3D=3D table->major && minor =3D=3D table->minor) {
> +        if (major =3D=3D 10 && minor =3D=3D 0 && tbl_idx) {
> +            while (win_10_0_table->version !=3D NULL) {
> +                if (build <=3D win_10_0_table->final_build) {

You should reverse the order of entries in you table for this to work,
or break after first match. Otherwise you will always match the last
entry.

    Tomas

> +                    if (id) {
> +                        return g_strdup(win_10_0_table->version_id);
> +                    } else {
> +                        return g_strdup(win_10_0_table->version);
> +                    }
> +                }
> +                win_10_0_table++;
> +            }
> +        } else if (major =3D=3D table->major && minor =3D=3D table->mino=
r) {
>              if (id) {
>                  return g_strdup(table->version_id);
>              } else {
> --=20
> 1.8.3.1
>=20
>=20


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
