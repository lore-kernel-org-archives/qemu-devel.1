Received: from eggs.gnu.org ([2001:4830:134:3::10]:46730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1epInX-0006Gf-AN
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:14:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1epInS-0004q9-Be
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:14:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42046 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1epInS-0004oy-7f
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:14:18 -0500
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<20180223132311.26555-4-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <53540b2d-e52e-af98-6008-cab3a1688388@redhat.com>
Date: Fri, 23 Feb 2018 20:14:00 +0100
MIME-Version: 1.0
In-Reply-To: <20180223132311.26555-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/7] HACK: HobLib: workaround infinite loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, stefanb@linux.vnet.ibm.com, qemu-devel@nongnu.org, javierm@redhat.com

On 02/23/18 14:23, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Without this hack, GetNextHob() loops infinitely with the next patch.
> I don't understand the reason.
>=20
> The loop is triggered by the GetFirstGuidHob (&gTpmErrorHobGuid) call.
>=20
> CC: Laszlo Ersek <lersek@redhat.com>
> CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Contributed-under: TianoCore Contribution Agreement 1.0
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  MdePkg/Library/PeiHobLib/HobLib.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/MdePkg/Library/PeiHobLib/HobLib.c b/MdePkg/Library/PeiHobL=
ib/HobLib.c
> index 5c0eeb992f..ed3c5fbd6d 100644
> --- a/MdePkg/Library/PeiHobLib/HobLib.c
> +++ b/MdePkg/Library/PeiHobLib/HobLib.c
> @@ -89,6 +89,10 @@ GetNextHob (
>      if (Hob.Header->HobType =3D=3D Type) {
>        return Hob.Raw;
>      }
> +    if (GET_HOB_LENGTH (HobStart) =3D=3D 0) {
> +        DEBUG ((DEBUG_INFO, "FIXME: GetNextHob length =3D=3D 0"));
> +        return NULL;
> +    }
>      Hob.Raw =3D GET_NEXT_HOB (Hob);
>    }
>    return NULL;
>=20

Strange. The HobLength field is supposed to include the size of the HOB h=
eader, so it should never be zero.

Furthermore, the PEI core initializes the HOB list; it should be terminat=
ed with an End-of-HOB-List HOB:

PeiCore()                             [MdeModulePkg/Core/Pei/PeiMain/PeiM=
ain.c]
  InitializeMemoryServices()          [MdeModulePkg/Core/Pei/Memory/Memor=
yServices.c]
    PeiCoreBuildHobHandoffInfoTable() [MdeModulePkg/Core/Pei/Hob/Hob.c]

I tried to reproduce this issue by:
- applying patches 1, 2, and 4
- in function PeimEntryMA(), file "SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.c", mo=
ving the GetFirstGuidHob (&gTpmErrorHobGuid) call to the top of the funct=
ion.

It didn't hang for me.

Laszlo
