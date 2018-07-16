Received: from eggs.gnu.org ([2001:4830:134:3::10]:37837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1ff9pc-0000Aw-I1
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 16:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1ff9pa-0006nW-Jp
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 16:10:52 -0400
Received: from mail-yb0-x244.google.com ([2607:f8b0:4002:c09::244]:44482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1ff9pa-0006nN-Et
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 16:10:50 -0400
Received: by mail-yb0-x244.google.com with SMTP id b21-v6so1801812yba.11
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 13:10:50 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180624124540.6659-1-sameeh@daynix.com>
References: <20180624124540.6659-1-sameeh@daynix.com>
Message-ID: <153177183866.7766.1789433991037567183@sif>
Date: Mon, 16 Jul 2018 15:10:38 -0500
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
To: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>

Quoting Sameeh Jubran (2018-06-24 07:45:40)
> From: Sameeh Jubran <sjubran@redhat.com>
> =

> The defrag.exe tool which is used for executing the fstrim command
> on Windows doesn't support retrim for OSes lower than Win8. This
> commit handles this case and returns a suitable error.
> =

> Output of fstrim before this commit:
> {"execute":"guest-fstrim"}
> {"return": {"paths": [{"path": "C:\\", "error": "An invalid command line =
option
> was specified. (0x89000008)"}, {"path": "F:\\", "error": "An invalid comm=
and
> line option was specified. (0x89000008)"}, {"path": "S:\\", "error": "An
> invalid command line option was specified. (0x89000008)"}]}}
> =

> Reported on:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1594113
> =

> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> ---
>  qga/commands-win32.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> =

> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index d79974f212..0bdcd9dd38 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -30,6 +30,7 @@
>  #include <lm.h>
>  #include <wtsapi32.h>
>  #include <wininet.h>
> +#include <versionhelpers.h>

I have this queued locally but the mingw64 build environment I've been
using (fc20) doesn't support this header and I'm running into some odd
null pointer / 0xc0000005 / access violation issues with the binary
generated in newer tool chains. I'll send a pull for this next week when
I can get it tested.

What build envionment are you using?

> =

>  #include "qga/guest-agent-core.h"
>  #include "qga/vss-win32.h"
> @@ -852,6 +853,11 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, =
Error **errp)
>      HANDLE handle;
>      WCHAR guid[MAX_PATH] =3D L"";
> =

> +   if (!IsWindows8OrGreater()) {
> +        error_setg(errp, "fstrim is only supported for Win8+");
> +        return NULL;
> +   }
> +
>      handle =3D FindFirstVolumeW(guid, ARRAYSIZE(guid));
>      if (handle =3D=3D INVALID_HANDLE_VALUE) {
>          error_setg_win32(errp, GetLastError(), "failed to find any volum=
e");
> -- =

> 2.13.6
>=20
