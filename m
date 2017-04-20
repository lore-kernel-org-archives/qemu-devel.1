Received: from eggs.gnu.org ([2001:4830:134:3::10]:45650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d165T-0003bb-6b
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d165O-0006tK-BX
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:01:07 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d165O-0006sB-3M
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:01:02 -0400
Received: by mail-wm0-x241.google.com with SMTP id u65so1175331wmu.3
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 00:01:01 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170418061551.196582-1-mithro@mithis.com>
	<20170418061551.196582-2-mithro@mithis.com>
	<20170418124711.GB2471@lianli.shorne-pla.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d0dd4958-e226-39de-a0bb-b96868193711@twiddle.net>
Date: Thu, 20 Apr 2017 00:00:54 -0700
MIME-Version: 1.0
In-Reply-To: <20170418124711.GB2471@lianli.shorne-pla.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] target/openrisc: Implement EVBAR
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>, Tim 'mithro' Ansell <mithro@mithis.com>
Cc: qemu-devel@nongnu.org, Jia Liu <proljc@gmail.com>

On 04/18/2017 05:47 AM, Stafford Horne wrote:
> On Tue, Apr 18, 2017 at 04:15:50PM +1000, Tim 'mithro' Ansell wrote:
>> Exception Vector Base Address Register (EVBAR) - This optional register
>> can be used to apply an offset to the exception vector addresses.
>>
>> The significant bits (31-12) of the vector offset address for each
>> exception depend on the setting of the Supervision Register (SR)'s EPH
>> bit and the Exception Vector Base Address Register (EVBAR).
>>
>> Its presence is indicated by the EVBARP bit in the CPU Configuration
>> Register (CPUCFGR).
>>
>> Signed-off-by: Tim 'mithro' Ansell <mithro@mithis.com>
>> ---
>>  target/openrisc/cpu.c        | 2 ++
>>  target/openrisc/cpu.h        | 7 +++++++
>>  target/openrisc/interrupt.c  | 6 +++++-
>>  target/openrisc/sys_helper.c | 7 +++++++
>>  4 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
>> index 7fd2b9a216..1524ed981a 100644
>> --- a/target/openrisc/cpu.c
>> +++ b/target/openrisc/cpu.c
>> @@ -134,6 +134,7 @@ static void or1200_initfn(Object *obj)
>>
>>      set_feature(cpu, OPENRISC_FEATURE_OB32S);
>>      set_feature(cpu, OPENRISC_FEATURE_OF32S);
>> +    set_feature(cpu, OPENRISC_FEATURE_EVBAR);
>>  }
>>
>>  static void openrisc_any_initfn(Object *obj)
>> @@ -141,6 +142,7 @@ static void openrisc_any_initfn(Object *obj)
>>      OpenRISCCPU *cpu = OPENRISC_CPU(obj);
>>
>>      set_feature(cpu, OPENRISC_FEATURE_OB32S);
>> +    set_feature(cpu, OPENRISC_FEATURE_EVBAR);
>>  }
>>
>>  typedef struct OpenRISCCPUInfo {
>> diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
>> index 418a0e6960..1958b72718 100644
>> --- a/target/openrisc/cpu.h
>> +++ b/target/openrisc/cpu.h
>> @@ -111,6 +111,11 @@ enum {
>>      CPUCFGR_OF32S = (1 << 7),
>>      CPUCFGR_OF64S = (1 << 8),
>>      CPUCFGR_OV64S = (1 << 9),
>> +    /* CPUCFGR_ND = (1 << 10), */
>> +    /* CPUCFGR_AVRP = (1 << 11), */
>> +    CPUCFGR_EVBARP = (1 << 12),
>> +    /* CPUCFGR_ISRP = (1 << 13), */
>> +    /* CPUCFGR_AECSRP = (1 << 14), */
>>  };
>>
>>  /* DMMU configure register */
>> @@ -200,6 +205,7 @@ enum {
>>      OPENRISC_FEATURE_OF32S = (1 << 7),
>>      OPENRISC_FEATURE_OF64S = (1 << 8),
>>      OPENRISC_FEATURE_OV64S = (1 << 9),
>> +    OPENRISC_FEATURE_EVBAR = (1 << 12),
>
> Does anyone know why we have to add both Features and CPUCFG bits?
>
> It seems like duplication to me.

It's probably a mistake.  I certainly see no reason for the FEATURE bits; just 
rely on the CPUCFGR definitions.

> If we add something to CPUOpenRISCState, we ideally need to also add it to
> machine.c vmstate definition.  However, I currently have a patch out to
> rework the vmstate serialization.  I can add this to that patch.

Sure.


r~
