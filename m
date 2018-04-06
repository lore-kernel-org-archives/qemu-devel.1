Received: from eggs.gnu.org ([2001:4830:134:3::10]:45418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1f4VA1-0006ZV-L1
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1f4V9x-0002Si-KF
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:28:25 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196]:54216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1f4V9x-0002Jn-A5
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:28:21 -0400
References: <1521034084-17344-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<1521034084-17344-4-git-send-email-abdallah.bouassida@lauterbach.com>
	<87h8orcg3a.fsf@linaro.org>
From: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Message-ID: <7a39d3f5-af2b-e21d-fa10-798b67fe4f63@lauterbach.com>
Date: Fri, 6 Apr 2018 18:28:05 +0100
MIME-Version: 1.0
In-Reply-To: <87h8orcg3a.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 3/3] target/arm: Add the XML
 dynamic generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, khaled.jmal@lauterbach.com, qemu-arm@nongnu.org

Hi Alex,

First of all, thanks for the review!
>> +static int arm_gdb_get_sysreg(CPUARMState *env, uint8_t *buf, int reg)
>> +{
>> +    ARMCPU *cpu = arm_env_get_cpu(env);
>> +    const ARMCPRegInfo *ri;
>> +    uint32_t key;
>> +
>> +    key = cpu->dyn_xml.cpregs_keys[reg];
>> +    ri = get_arm_cp_reginfo(cpu->cp_regs, key);
>> +    if (ri) {
>> +        if (cpreg_field_is_64bit(ri)) {
>> +            return gdb_get_reg64(buf, (uint64_t)read_raw_cp_reg(env, ri));
>> +        } else {
>> +            return gdb_get_reg32(buf, (uint32_t)read_raw_cp_reg(env, ri));
>> +        }
>> +    }
>> +    return 0;
> There is something odd going on here because if I run a simple little
> features binary
> (https://github.com/stsquad/testcases/blob/master/aarch64/features.c) I
> get:
>
>   ID_AA64ISAR0_EL1    : 0x0000000000011120
>   ID_AA64ISAR1_EL1    : 0x0000000000000000
>   ID_AA64MMFR0_EL1    : 0x00000000ff000000
>   ID_AA64MMFR1_EL1    : 0x0000000000000000
>   ID_AA64PFR0_EL1     : 0x0000000000000011
>   ID_AA64PFR1_EL1     : 0x0000000000000000
>   ID_AA64DFR0_EL1     : 0x0000000000000006
>   ID_AA64DFR1_EL1     : 0x0000000000000000
>   MIDR_EL1            : 0x00000000411fd070
>   MPIDR_EL1           : 0x0000000080000000
>   REVIDR_EL1          : 0x0000000000000000
>
> However in the gdb output we see:
>
>   ID_AA64ISAR0_EL1           0x11120	69920
>   ID_AA64ISAR1_EL1           0x0	0
>   ID_AA64MMFR0_EL1           0x1124	4388  <-?
>   ID_AA64MMFR1_EL1           0x0	0
>   ID_PFR0                    0x131	305   <-name and value?
>   ID_AA64PFR1_EL1            0x0	0
>   ID_AA64DFR0_EL1            0x10305106	271601926 <-?
>   ID_AA64DFR1_EL1            0x0	0
>   REVIDR_EL1                 0x0	0
>
> So why the discrepancies?

>  ID_AA64MMFR0_EL1           0x1124	4388  <-?
>  ID_AA64DFR0_EL1            0x10305106	271601926 <-?
I get the same value in x1 (= 0x1124) and x2 (= 0x10305106) when I execute 
the following instructions on the guest:
  MRS x1, ID_AA64MMFR0_EL1
  MRS x2, ID_AA64DFR0_EL1
So, I think that there is no problem on how GDB is reading these registers!

>  ID_PFR0                    0x131	305   <-name and value?
This is not ID_AA64PFR0_EL1 - the ID_AA64PFR0_EL1 is not registered in our
dynamic XML as it has "ARM_CP_NO_RAW" type.
So should we add some modifications to handle this special case?

Best regards,
Abdallah
