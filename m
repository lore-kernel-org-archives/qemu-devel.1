Received: from eggs.gnu.org ([2001:4830:134:3::10]:60148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhkrD-0002VL-AT
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 20:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhkrB-0005Dg-Tb
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 20:07:15 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:41238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1fhkrB-0005DU-EG
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 20:07:13 -0400
Received: by mail-oi0-x244.google.com with SMTP id k12-v6so4379106oiw.8
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 17:07:13 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAKPgXcF64Bq+xfFRojYwHS-s3HjNS8s=1Lix4C9Z16Y5Ez3yCg@mail.gmail.com>
References: <20180624124540.6659-1-sameeh@daynix.com>
	<153177183866.7766.1789433991037567183@sif>
	<CAKPgXcF64Bq+xfFRojYwHS-s3HjNS8s=1Lix4C9Z16Y5Ez3yCg@mail.gmail.com>
Message-ID: <153239080148.10934.6338565197365381926@sif>
Date: Mon, 23 Jul 2018 19:06:41 -0500
Subject: Re: [Qemu-devel] [PATCH] qga-win: Handle fstrim for OSes lower than
 Win8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>

Quoting Sameeh Jubran (2018-07-17 00:46:27)
> I'v successfully compiled the previous patch on Fedora 27, but it seems t=
o be
> failing on RHEL, You can apply this patch instead which avoids using the
> versionhelpers header:

Thanks, applied to qga tree:
  https://github.com/mdroth/qemu/commits/qga

I went ahead with the GetVersionEx() version since it's also used
elsewhere in qga code. I needed to fix up the version check to be
(major > 6) || (major =3D=3D 6 && minor >=3D 2) since that seems to align
with what's documented here:

https://docs.microsoft.com/en-us/windows/desktop/api/winnt/ns-winnt-_osvers=
ioninfoa

> ---
> =C2=A0qga/commands-win32.c | 11 +++++++++++
> =C2=A01 file changed, 11 insertions(+)
> =

> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index fb91f5d..e688e71 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -846,6 +846,17 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, =
Error
> **errp)
> =C2=A0 =C2=A0 =C2=A0GuestFilesystemTrimResponse *resp;
> =C2=A0 =C2=A0 =C2=A0HANDLE handle;
> =C2=A0 =C2=A0 =C2=A0WCHAR guid[MAX_PATH] =3D L"";
> +=C2=A0 =C2=A0 OSVERSIONINFO osvi;
> +=C2=A0 =C2=A0 BOOL bIsWindows8orLater;
> +
> +=C2=A0 =C2=A0 ZeroMemory(&osvi, sizeof(OSVERSIONINFO));
> +=C2=A0 =C2=A0 osvi.dwOSVersionInfoSize =3D sizeof(OSVERSIONINFO);
> +=C2=A0 =C2=A0 GetVersionEx(&osvi);
> +=C2=A0 =C2=A0 bIsWindows8orLater =3D ((osvi.dwMajorVersion =3D=3D 6) && =
(osvi.dwMinorVersion >
> =3D 2));
> +=C2=A0 =C2=A0 if (!bIsWindows8orLater) {
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, "fstrim is only suppo=
rted for Win8+");
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;
> +=C2=A0 =C2=A0 }
> =

> =C2=A0 =C2=A0 =C2=A0handle =3D FindFirstVolumeW(guid, ARRAYSIZE(guid));
> =C2=A0 =C2=A0 =C2=A0if (handle =3D=3D INVALID_HANDLE_VALUE) {
> --
> 2.8.1.185.gdc0db2c
> =

> =

> On Mon, Jul 16, 2018 at 11:10 PM, Michael Roth <mdroth@linux.vnet.ibm.com>
> wrote:
> =

>     Quoting Sameeh Jubran (2018-06-24 07:45:40)
>     > From: Sameeh Jubran <sjubran@redhat.com>
>     >
>     > The defrag.exe tool which is used for executing the fstrim command
>     > on Windows doesn't support retrim for OSes lower than Win8. This
>     > commit handles this case and returns a suitable error.
>     >
>     > Output of fstrim before this commit:
>     > {"execute":"guest-fstrim"}
>     > {"return": {"paths": [{"path": "C:\\", "error": "An invalid command=
 line
>     option
>     > was specified. (0x89000008)"}, {"path": "F:\\", "error": "An invalid
>     command
>     > line option was specified. (0x89000008)"}, {"path": "S:\\", "error"=
: "An
>     > invalid command line option was specified. (0x89000008)"}]}}
>     >
>     > Reported on:
>     > https://bugzilla.redhat.com/show_bug.cgi?id=3D1594113
>     >
>     > Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
>     > ---
>     >=C2=A0 qga/commands-win32.c | 6 ++++++
>     >=C2=A0 1 file changed, 6 insertions(+)
>     >
>     > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>     > index d79974f212..0bdcd9dd38 100644
>     > --- a/qga/commands-win32.c
>     > +++ b/qga/commands-win32.c
>     > @@ -30,6 +30,7 @@
>     >=C2=A0 #include <lm.h>
>     >=C2=A0 #include <wtsapi32.h>
>     >=C2=A0 #include <wininet.h>
>     > +#include <versionhelpers.h>
> =

>     I have this queued locally but the mingw64 build environment I've been
>     using (fc20) doesn't support this header and I'm running into some odd
>     null pointer / 0xc0000005 / access violation issues with the binary
>     generated in newer tool chains. I'll send a pull for this next week w=
hen
>     I can get it tested.
> =

>     What build envionment are you using?
> =

>     >
>     >=C2=A0 #include "qga/guest-agent-core.h"
>     >=C2=A0 #include "qga/vss-win32.h"
>     > @@ -852,6 +853,11 @@ qmp_guest_fstrim(bool has_minimum, int64_t min=
imum,
>     Error **errp)
>     >=C2=A0 =C2=A0 =C2=A0 HANDLE handle;
>     >=C2=A0 =C2=A0 =C2=A0 WCHAR guid[MAX_PATH] =3D L"";
>     >
>     > +=C2=A0 =C2=A0if (!IsWindows8OrGreater()) {
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, "fstrim is only suppo=
rted for Win8+");
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>     > +=C2=A0 =C2=A0}
>     > +
>     >=C2=A0 =C2=A0 =C2=A0 handle =3D FindFirstVolumeW(guid, ARRAYSIZE(gui=
d));
>     >=C2=A0 =C2=A0 =C2=A0 if (handle =3D=3D INVALID_HANDLE_VALUE) {
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastErr=
or(), "failed to find any
>     volume");
>     > --
>     > 2.13.6
>     >
> =

> =

> =

> =

> --
> Respectfully,
> Sameeh Jubran
> Linkedin
> Software Engineer @ Daynix.
