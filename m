Received: from eggs.gnu.org ([2001:4830:134:3::10]:48516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cyGY2-0003In-H4
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 07:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cyGXz-0006kN-CE
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 07:34:54 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:36002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1cyGXz-0006ii-2E
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 07:34:51 -0400
Received: by mail-wr0-f180.google.com with SMTP id c55so15474906wrc.3
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 04:34:50 -0700 (PDT)
From: Vinzenz Feenstra <vfeenstr@redhat.com>
Message-Id: <8552B978-C0A0-4ED9-91D6-EA334EE9B1FA@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Wed, 12 Apr 2017 13:34:46 +0200
In-Reply-To: <CAJ+F1CLukvP9EcdJXBGcBuNhfYAs3EBe_4cLbcdJx2N-xxQdfg@mail.gmail.com>
References: <1491995456-6411-1-git-send-email-huang.yong@zte.com.cn>
	<CAJ+F1CLukvP9EcdJXBGcBuNhfYAs3EBe_4cLbcdJx2N-xxQdfg@mail.gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] QEMU Guest Agent: Add an interface to
 determine guest os type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Huang Yong <huang.yong@zte.com.cn>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org


> On Apr 12, 2017, at 1:28 PM, Marc-Andr=C3=A9 Lureau =
<marcandre.lureau@gmail.com> wrote:
>=20
> Hi
>=20
> On Wed, Apr 12, 2017 at 1:12 PM Huang Yong <huang.yong@zte.com.cn =
<mailto:huang.yong@zte.com.cn>> wrote:
> vm management tools (e.g.libvirt) may tell if guest os is linux or =
windows,
> so they can design a customized application accordingly, we suggest to =
add
> an interface (guest-ostype) in QEMU.
>=20
> This proposal is probably redundant with "qemu-ga: add =
guest-get-osrelease command" =
http://patchew.org/QEMU/20170331101947.2046-2-vfeenstr@redhat.com =
<http://patchew.org/QEMU/20170331101947.2046-2-vfeenstr@redhat.com>

Indeed, that=E2=80=99s going the same direction just that we=E2=80=99re =
trying to report a bit more extensive information.

>=20
>=20
>=20
> Signed-off-by: Huang Yong <huang.yong@zte.com.cn =
<mailto:huang.yong@zte.com.cn>>
> ---
>  qga/commands-posix.c | 10 ++++++++++
>  qga/commands-win32.c | 10 ++++++++++
>  qga/qapi-schema.json | 12 ++++++++++++
>  3 files changed, 32 insertions(+)
>=20
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 915df9e..24ec2b6 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -49,6 +49,11 @@ extern char **environ;
>  #endif
>  #endif
>=20
> +typedef enum GuestArch {
> +    ARCH_WINDOWS =3D 0,
> +    ARCH_LINUX =3D 1,
> +} GuestArch;
> +
>  static void ga_wait_child(pid_t pid, int *status, Error **errp)
>  {
>      pid_t rpid;
> @@ -2470,6 +2475,11 @@ qmp_guest_fstrim(bool has_minimum, int64_t =
minimum, Error **errp)
>  }
>  #endif
>=20
> +int64_t qmp_guest_ostype(Error **errp)
> +{
> +    return ARCH_LINUX;
> +}
> +
>  /* add unsupported commands to the blacklist */
>  GList *ga_command_blacklist_init(GList *blacklist)
>  {
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 19d72b2..a6639dd 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -58,6 +58,11 @@ static struct {
>      .filehandles =3D =
QTAILQ_HEAD_INITIALIZER(guest_file_state.filehandles),
>  };
>=20
> +typedef enum GuestArch {
> +    ARCH_WINDOWS =3D 0,
> +    ARCH_LINUX =3D 1,
> +} GuestArch;
> +
>  #define FILE_GENERIC_APPEND (FILE_GENERIC_WRITE & ~FILE_WRITE_DATA)
>=20
>  typedef struct OpenFlags {
> @@ -214,6 +219,11 @@ void qmp_guest_file_close(int64_t handle, Error =
**errp)
>      g_free(gfh);
>  }
>=20
> +int64_t qmp_guest_ostype(Error **errp)
> +{
> +    return ARCH_WINDOWS;
> +}
> +
>  static void acquire_privilege(const char *name, Error **errp)
>  {
>      HANDLE token =3D NULL;
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index a02dbf2..496ae55 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -26,6 +26,7 @@
>          'guest-get-time',
>          'guest-set-vcpus',
>          'guest-sync',
> +        'guest-ostype',
>          'guest-sync-delimited' ] } }
>=20
>  ##
> @@ -1042,3 +1043,14 @@
>    'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
>                 '*input-data': 'str', '*capture-output': 'bool' },
>    'returns': 'GuestExec' }
> +
> +##
> +# @guest-ostype:
> +#
> +# Get guest os type info
> +# Returns: os type, Linux/Windows
> +#
> +# Since: 2.5.0
> +##
> +{ 'command': 'guest-ostype',
> +  'returns': 'int' }
> --
> 1.8.3.1
>=20
>=20
>=20
> --=20
> Marc-Andr=C3=A9 Lureau

--
Vinzenz Feenstra
Senior Software Developer
Red Hat Czech
