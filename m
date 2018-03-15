Received: from eggs.gnu.org ([2001:4830:134:3::10]:33325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Cowgill@mips.com>) id 1ewQVH-00027L-8Q
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 06:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Cowgill@mips.com>) id 1ewQUm-0007vB-QA
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 06:52:58 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:40419)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <James.Cowgill@mips.com>)
	id 1ewQUm-0007fi-8K
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 06:52:28 -0400
References: <20180314153121.23838-1-james.cowgill@mips.com>
	<46dbae6e-4ff6-5003-e8e6-175bf0fbd51f@vivier.eu>
From: James Cowgill <james.cowgill@mips.com>
Message-ID: <20e6165d-70b2-d1ec-1c46-7ede39a8d816@mips.com>
Date: Thu, 15 Mar 2018 10:52:11 +0000
MIME-Version: 1.0
In-Reply-To: <46dbae6e-4ff6-5003-e8e6-175bf0fbd51f@vivier.eu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: implement HWCAP bits on MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Hi,

On 14/03/18 16:13, Laurent Vivier wrote:
> Le 14/03/2018 =C3=A0 16:31, James Cowgill a =C3=A9crit=C2=A0:
>> Add support for the two currently defined HWCAP bits on MIPS - R6 and
>> MSA.
>>
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1754372
>> Signed-off-by: James Cowgill <james.cowgill@mips.com>
>> ---
>> This was resent because I think I messed up my email config. Apologies i=
f you
>> receive this twice.
>>
>>  linux-user/elfload.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index 5fc130cc20..747b0ed10b 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -950,6 +950,30 @@ static void elf_core_copy_regs(target_elf_gregset_t=
 *regs, const CPUMIPSState *e
>>  #define USE_ELF_CORE_DUMP
>>  #define ELF_EXEC_PAGESIZE        4096
>> =20
>> +/* See arch/mips/include/uapi/hwcap.h.  */
>=20
> in fact arch/mips/include/uapi/asm/hwcap.h

Woops.

>> +enum {
>> +    HWCAP_MIPS_R6           =3D (1 << 0),
>> +    HWCAP_MIPS_MSA          =3D (1 << 1),
>> +};
>=20
> We have this for ARM only in elfload.c since:
>=20
>     afce2927aa Arm AT_HWCAP AUXV entry (Paul Brook) [2005]
>=20
> but they have been added in include/elf.h since:
>=20
>     41d9ea80ac tcg-arm: Use qemu_getauxval [Richard Henderson, 2013]
>=20
> and I think we should remove them (they are prefixed by ARM_)
>=20
> So the MIPS ones should be in include/elf.h (with the #define form).

I can do that, although I think it's a bit unusual. The HWCAP bits are
specific to the Linux kernel and not to "the MIPS ELF format" so it
doesn't make sense to me to put them in elf.h.

James
