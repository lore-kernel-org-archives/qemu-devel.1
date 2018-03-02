Received: from eggs.gnu.org ([2001:4830:134:3::10]:40013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eriHz-0005fx-0D
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eriHv-0005nV-Rw
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:51:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54090 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eriHv-0005n7-MI
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:51:43 -0500
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<20180223132311.26555-5-marcandre.lureau@redhat.com>
	<ed77e9f5-a6a7-b922-55a9-9c3013efce08@redhat.com>
	<CAJ+F1CJ=aNXj+-0RrvRoqharUJHnqVc2ZtXusP=6i3A=y7zmtA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <abbc9cb6-6333-a23d-3a22-738fae4c6d00@redhat.com>
Date: Fri, 2 Mar 2018 11:51:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJ=aNXj+-0RrvRoqharUJHnqVc2ZtXusP=6i3A=y7zmtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: edk2-devel@lists.01.org, Peter Jones <pjones@redhat.com>, Jiewen Yao <jiewen.yao@intel.com>, QEMU <qemu-devel@nongnu.org>, Javier Martinez Canillas <javierm@redhat.com>

On 03/01/18 16:08, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Feb 26, 2018 at 10:38 AM, Laszlo Ersek <lersek@redhat.com> wrot=
e:
>> On 02/23/18 14:23, marcandre.lureau@redhat.com wrote:
>>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>
>>> This module will initialize TPM device, measure reported FVs and BIOS
>>> version.
>>>
>>> CC: Laszlo Ersek <lersek@redhat.com>
>>> CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>> Contributed-under: TianoCore Contribution Agreement 1.0
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  OvmfPkg/OvmfPkgX64.dsc | 7 +++++++
>>>  OvmfPkg/OvmfPkgX64.fdf | 1 +
>>>  2 files changed, 8 insertions(+)
>>>
>>> diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
>>> index b5cbe8430f..34a7c2778e 100644
>>> --- a/OvmfPkg/OvmfPkgX64.dsc
>>> +++ b/OvmfPkg/OvmfPkgX64.dsc
>>> @@ -279,6 +279,8 @@
>>>    PcdLib|MdePkg/Library/PeiPcdLib/PeiPcdLib.inf
>>>    QemuFwCfgLib|OvmfPkg/Library/QemuFwCfgLib/QemuFwCfgPeiLib.inf
>>>  !if $(TPM2_ENABLE)
>>> +  BaseCryptLib|CryptoPkg/Library/BaseCryptLib/PeiCryptLib.inf
>>> +  HashLib|SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseCry=
ptoRouterPei.inf
>>>    Tpm12DeviceLib|SecurityPkg/Library/Tpm12DeviceLibDTpm/Tpm12DeviceL=
ibDTpm.inf
>>>    Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2DeviceLibD=
Tpm.inf
>>>  !endif
>>> @@ -647,6 +649,11 @@
>>>
>>>  !if $(TPM2_ENABLE) =3D=3D TRUE
>>>    SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
>>> +  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf {
>>> +    <LibraryClasses>
>>> +      NULL|SecurityPkg/Library/HashInstanceLibSha1/HashInstanceLibSh=
a1.inf
>>> +      NULL|SecurityPkg/Library/HashInstanceLibSha256/HashInstanceLib=
Sha256.inf
>>> +  }
>>>  !endif
>>>
>>>  !if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
>>> diff --git a/OvmfPkg/OvmfPkgX64.fdf b/OvmfPkg/OvmfPkgX64.fdf
>>> index dc35d0a1f7..9558142a42 100644
>>> --- a/OvmfPkg/OvmfPkgX64.fdf
>>> +++ b/OvmfPkg/OvmfPkgX64.fdf
>>> @@ -170,6 +170,7 @@ INF  MdeModulePkg/Universal/Variable/Pei/Variable=
Pei.inf
>>>  !endif
>>>  !if $(TPM2_ENABLE) =3D=3D TRUE
>>>  INF  SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
>>> +INF  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf
>>>  !endif
>>>
>>>  ####################################################################=
############
>>>
>>
>> Would it be possible to drop SHA1 (include SHA256 only) by setting
>> PcdTpm2HashMask to value 2? Or SHA1 required for some other reason? (I=
f
>> so please mention it in the commit message.)
>>
>=20
> afaik, it's not strictly required, and apparently the support is being
> dropped. I'll remove it.
>=20
> btw, now I understand your comment about read-only variable not being
> used by PEI module. I'll add a preliminary patch dropping it from
> depex ;)

OK, thanks :)

Laszlo
