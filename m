Received: from eggs.gnu.org ([2001:4830:134:3::10]:43533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1erPov-0006Rq-KR
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1erPou-0005Fw-MF
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:08:33 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:50682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1erPou-0005Fg-FC
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:08:32 -0500
Received: by mail-wm0-x241.google.com with SMTP id w128so12662992wmw.0
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 07:08:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ed77e9f5-a6a7-b922-55a9-9c3013efce08@redhat.com>
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<20180223132311.26555-5-marcandre.lureau@redhat.com>
	<ed77e9f5-a6a7-b922-55a9-9c3013efce08@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 1 Mar 2018 16:08:30 +0100
Message-ID: <CAJ+F1CJ=aNXj+-0RrvRoqharUJHnqVc2ZtXusP=6i3A=y7zmtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 4/7] ovmf: link with Tcg2Pei module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: edk2-devel@lists.01.org, Peter Jones <pjones@redhat.com>, Jiewen Yao <jiewen.yao@intel.com>, QEMU <qemu-devel@nongnu.org>, Javier Martinez Canillas <javierm@redhat.com>

Hi

On Mon, Feb 26, 2018 at 10:38 AM, Laszlo Ersek <lersek@redhat.com> wrote:
> On 02/23/18 14:23, marcandre.lureau@redhat.com wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> This module will initialize TPM device, measure reported FVs and BIOS
>> version.
>>
>> CC: Laszlo Ersek <lersek@redhat.com>
>> CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> Contributed-under: TianoCore Contribution Agreement 1.0
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  OvmfPkg/OvmfPkgX64.dsc | 7 +++++++
>>  OvmfPkg/OvmfPkgX64.fdf | 1 +
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
>> index b5cbe8430f..34a7c2778e 100644
>> --- a/OvmfPkg/OvmfPkgX64.dsc
>> +++ b/OvmfPkg/OvmfPkgX64.dsc
>> @@ -279,6 +279,8 @@
>>    PcdLib|MdePkg/Library/PeiPcdLib/PeiPcdLib.inf
>>    QemuFwCfgLib|OvmfPkg/Library/QemuFwCfgLib/QemuFwCfgPeiLib.inf
>>  !if $(TPM2_ENABLE)
>> +  BaseCryptLib|CryptoPkg/Library/BaseCryptLib/PeiCryptLib.inf
>> +  HashLib|SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseCrypto=
RouterPei.inf
>>    Tpm12DeviceLib|SecurityPkg/Library/Tpm12DeviceLibDTpm/Tpm12DeviceLibD=
Tpm.inf
>>    Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2DeviceLibDTpm=
.inf
>>  !endif
>> @@ -647,6 +649,11 @@
>>
>>  !if $(TPM2_ENABLE) =3D=3D TRUE
>>    SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
>> +  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf {
>> +    <LibraryClasses>
>> +      NULL|SecurityPkg/Library/HashInstanceLibSha1/HashInstanceLibSha1.=
inf
>> +      NULL|SecurityPkg/Library/HashInstanceLibSha256/HashInstanceLibSha=
256.inf
>> +  }
>>  !endif
>>
>>  !if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
>> diff --git a/OvmfPkg/OvmfPkgX64.fdf b/OvmfPkg/OvmfPkgX64.fdf
>> index dc35d0a1f7..9558142a42 100644
>> --- a/OvmfPkg/OvmfPkgX64.fdf
>> +++ b/OvmfPkg/OvmfPkgX64.fdf
>> @@ -170,6 +170,7 @@ INF  MdeModulePkg/Universal/Variable/Pei/VariablePei=
.inf
>>  !endif
>>  !if $(TPM2_ENABLE) =3D=3D TRUE
>>  INF  SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
>> +INF  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf
>>  !endif
>>
>>  #######################################################################=
#########
>>
>
> Would it be possible to drop SHA1 (include SHA256 only) by setting
> PcdTpm2HashMask to value 2? Or SHA1 required for some other reason? (If
> so please mention it in the commit message.)
>

afaik, it's not strictly required, and apparently the support is being
dropped. I'll remove it.

btw, now I understand your comment about read-only variable not being
used by PEI module. I'll add a preliminary patch dropping it from
depex ;)

thanks

--=20
Marc-Andr=C3=A9 Lureau
