Received: from eggs.gnu.org ([2001:4830:134:3::10]:50480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1esqkR-0004p2-2n
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 09:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1esqkL-00016a-Cp
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 09:05:51 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:40916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1esqkL-00014r-63
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 09:05:45 -0500
Received: by mail-wr0-x244.google.com with SMTP id o76so17388816wrb.7
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 06:05:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <91D51528-C2CA-41DF-921F-DBD5C2EC028C@apple.com>
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<20180223132311.26555-4-marcandre.lureau@redhat.com>
	<91D51528-C2CA-41DF-921F-DBD5C2EC028C@apple.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 5 Mar 2018 15:05:43 +0100
Message-ID: <CAJ+F1C+sTmv7M8QU2vqfPWE2Zej_DxJQF8aVSH5pZC8pqo8OZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Andrew Fish <afish@apple.com>
Cc: edk2-devel@lists.01.org, QEMU <qemu-devel@nongnu.org>, Javier Martinez Canillas <javierm@redhat.com>, Peter Jones <pjones@redhat.com>, Jiewen Yao <jiewen.yao@intel.com>, Laszlo Ersek <lersek@redhat.com>

Hi

On Fri, Feb 23, 2018 at 8:45 PM, Andrew Fish <afish@apple.com> wrote:
>
>
>> On Feb 23, 2018, at 5:23 AM, marcandre.lureau@redhat.com wrote:
>>
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Without this hack, GetNextHob() loops infinitely with the next patch.
>> I don't understand the reason.
>>
>> The loop is triggered by the GetFirstGuidHob (&gTpmErrorHobGuid) call.
>>
>> CC: Laszlo Ersek <lersek@redhat.com>
>> CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> Contributed-under: TianoCore Contribution Agreement 1.0
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>> MdePkg/Library/PeiHobLib/HobLib.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>
>> diff --git a/MdePkg/Library/PeiHobLib/HobLib.c b/MdePkg/Library/PeiHobLi=
b/HobLib.c
>> index 5c0eeb992f..ed3c5fbd6d 100644
>> --- a/MdePkg/Library/PeiHobLib/HobLib.c
>> +++ b/MdePkg/Library/PeiHobLib/HobLib.c
>> @@ -89,6 +89,10 @@ GetNextHob (
>>     if (Hob.Header->HobType =3D=3D Type) {
>>       return Hob.Raw;
>>     }
>> +    if (GET_HOB_LENGTH (HobStart) =3D=3D 0) {
>
> As Laszlo points out this error condition is likely memory corruption. Th=
us it would be better to check for all know illegal values?
>
> if (GET_HOB_LENGTH(HobStart) < sizeof (EFI_HOB_GENERIC_HEADER)
>

Thanks, I have adjusted the check.

With manual calls and printf (I don't know  a better way to debug ovmf
;), I try to locate the issue. It's somehow related to
RegisterForShadow(). The "corruption" seems to happen during the
second call. After the
PeiLoadImage(...,PEIM_STATE_REGISTER_FOR_SHADOW,..), right before
calling PeimEntryPoint(), a GetFirstGuidHob() succeed, but inside the
function, it fails (with the same arguments). Right after it succeeds
again... The PeimEntryPoint() is not the Tcg2Pei:PeimEntryMA(), I
suppose there is some kind of wrapping code, but I fail to find where.
Any idea?

thanks for your help

--=20
Marc-Andr=C3=A9 Lureau
