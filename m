Received: from eggs.gnu.org ([2001:4830:134:3::10]:58098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <afish@apple.com>) id 1epJHl-0000iU-Vv
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <afish@apple.com>) id 1epJHi-0005Ys-RR
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:45:38 -0500
Received: from mail-out21.apple.com ([17.171.2.31]:62407
	helo=mail-in21.apple.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <afish@apple.com>) id 1epJHi-0005Vr-My
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 14:45:34 -0500
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: afish@apple.com
From: Andrew Fish <afish@apple.com>
In-reply-to: <20180223132311.26555-4-marcandre.lureau@redhat.com>
Date: Fri, 23 Feb 2018 11:45:28 -0800
Content-transfer-encoding: quoted-printable
Message-id: <91D51528-C2CA-41DF-921F-DBD5C2EC028C@apple.com>
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<20180223132311.26555-4-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [edk2] [PATCH 3/7] HACK: HobLib: workaround
 infinite loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com
Cc: edk2-devel@lists.01.org, qemu-devel@nongnu.org, javierm@redhat.com, pjones@redhat.com, jiewen.yao@intel.com, lersek@redhat.com



> On Feb 23, 2018, at 5:23 AM, marcandre.lureau@redhat.com wrote:
>=20
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
> MdePkg/Library/PeiHobLib/HobLib.c | 4 ++++
> 1 file changed, 4 insertions(+)
>=20
> diff --git a/MdePkg/Library/PeiHobLib/HobLib.c =
b/MdePkg/Library/PeiHobLib/HobLib.c
> index 5c0eeb992f..ed3c5fbd6d 100644
> --- a/MdePkg/Library/PeiHobLib/HobLib.c
> +++ b/MdePkg/Library/PeiHobLib/HobLib.c
> @@ -89,6 +89,10 @@ GetNextHob (
>     if (Hob.Header->HobType =3D=3D Type) {
>       return Hob.Raw;
>     }
> +    if (GET_HOB_LENGTH (HobStart) =3D=3D 0) {

As Laszlo points out this error condition is likely memory corruption. =
Thus it would be better to check for all know illegal values?=20

if (GET_HOB_LENGTH(HobStart) < sizeof (EFI_HOB_GENERIC_HEADER)

Thanks,

Andrew Fish

> +        DEBUG ((DEBUG_INFO, "FIXME: GetNextHob length =3D=3D 0"));
> +        return NULL;
> +    }
>     Hob.Raw =3D GET_NEXT_HOB (Hob);
>   }
>   return NULL;
> --=20
> 2.16.1.73.g5832b7e9f2
>=20
> _______________________________________________
> edk2-devel mailing list
> edk2-devel@lists.01.org
> https://lists.01.org/mailman/listinfo/edk2-devel
