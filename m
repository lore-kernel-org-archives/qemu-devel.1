Received: from eggs.gnu.org ([2001:4830:134:3::10]:49633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eu0M4-00083t-As
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:33:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eu0M1-0005HW-7X
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:33:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56696 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eu0M1-0005HL-2f
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:33:25 -0500
From: Laszlo Ersek <lersek@redhat.com>
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
	<20180307155746.18526-7-marcandre.lureau@redhat.com>
	<c46d7d18-5f4c-fe76-6b4a-a7109749d4b4@redhat.com>
Message-ID: <4394ee6b-d3b3-4208-f052-4aead4638108@redhat.com>
Date: Thu, 8 Mar 2018 19:33:07 +0100
MIME-Version: 1.0
In-Reply-To: <c46d7d18-5f4c-fe76-6b4a-a7109749d4b4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH v2 6/8] ovmf: link with Tcg2Pei
 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: qemu-devel@nongnu.org, javierm@redhat.com, pjones@redhat.com, jiewen.yao@intel.com

On 03/08/18 19:20, Laszlo Ersek wrote:
> On 03/07/18 16:57, marcandre.lureau@redhat.com wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> This module will initialize TPM device, measure reported FVs and BIOS
>> version. We keep both SHA-1 and SHA-256 for the TCG 1.2 log format
>> compatibility, but the SHA-256 measurements and TCG 2 log format are
>> now recommended.
>>
>> Cc: Laszlo Ersek <lersek@redhat.com>
>> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> Contributed-under: TianoCore Contribution Agreement 1.0
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  OvmfPkg/OvmfPkgX64.dsc | 7 +++++++
>>  OvmfPkg/OvmfPkgX64.fdf | 1 +
>>  2 files changed, 8 insertions(+)
>=20
> (1) Please change the subject line to:
>=20
> OvmfPkg: include Tcg2Pei module
>=20
>>
>> diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
>> index 64bd6b6a9f08..3fa1a31f4c37 100644
>> --- a/OvmfPkg/OvmfPkgX64.dsc
>> +++ b/OvmfPkg/OvmfPkgX64.dsc
>> @@ -278,6 +278,8 @@ [LibraryClasses.common.PEIM]
>>    QemuFwCfgLib|OvmfPkg/Library/QemuFwCfgLib/QemuFwCfgPeiLib.inf
>> =20
>>  !if $(TPM2_ENABLE)
>> +  BaseCryptLib|CryptoPkg/Library/BaseCryptLib/PeiCryptLib.inf
>=20
> (2) Technically this makes sense, but given the fact that we resolve
> BaseCryptLib unconditionally for a bunch of other module types, I think
> we should do that for PEIMs as well.
>=20
>> +  HashLib|SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseCryp=
toRouterPei.inf

(3) Actually, can you please move this library resolution under
"Tcg2Pei.inf"? Every single PEIM that uses this library instance will
need us to spell out the individual hash plugins for it anyway. So I
think keeping the "hash router" lib instance together with those
NULL-class instances is cleaner.

Thanks
Laszlo

>>    Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2DeviceLibDT=
pm.inf
>>  !endif
>> =20
>> @@ -615,6 +617,11 @@ [Components]
>> =20
>>  !if $(TPM2_ENABLE) =3D=3D TRUE
>>    OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
>> +  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf {
>> +    <LibraryClasses>
>> +      NULL|SecurityPkg/Library/HashInstanceLibSha1/HashInstanceLibSha=
1.inf
>> +      NULL|SecurityPkg/Library/HashInstanceLibSha256/HashInstanceLibS=
ha256.inf
>> +  }
>>  !endif
>> =20
>>    #
>> diff --git a/OvmfPkg/OvmfPkgX64.fdf b/OvmfPkg/OvmfPkgX64.fdf
>> index dbafada5226b..c0173e7adf5f 100644
>> --- a/OvmfPkg/OvmfPkgX64.fdf
>> +++ b/OvmfPkg/OvmfPkgX64.fdf
>> @@ -167,6 +167,7 @@ [FV.PEIFV]
>> =20
>>  !if $(TPM2_ENABLE) =3D=3D TRUE
>>  INF  OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
>> +INF  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf
>>  !endif
>> =20
>>  #####################################################################=
###########
>>
>=20
> Looks good. (The final version should handle the other DSC / FDF files =
too.)
>=20
> Thanks!
> Laszlo
>=20
