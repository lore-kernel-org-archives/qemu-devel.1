Received: from eggs.gnu.org ([2001:4830:134:3::10]:39667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9fuG-0000iC-RV
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9fuD-0001sv-QX
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:53:00 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
	<1493122030-32191-9-git-send-email-peter.maydell@linaro.org>
	<CAKmqyKPTXPZUkWsTzTV7rZ02QNAC2j9h_1eWqNs67KHM1Jkgrw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cd57310d-a047-00b7-c8fb-76faa4ba5f8f@amsat.org>
Date: Sat, 13 May 2017 19:52:52 -0300
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPTXPZUkWsTzTV7rZ02QNAC2j9h_1eWqNs67KHM1Jkgrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 08/13] armv7m: Improve "-d mmu"
 tracing for PMSAv7 MPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>

On 05/03/2017 06:30 PM, Alistair Francis wrote:
> On Tue, Apr 25, 2017 at 5:07 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> From: Michael Davidsaver <mdavidsaver@gmail.com>
>>
>> Improve the "-d mmu" tracing for the PMSAv7 MPU translation
>> process as an aid in debugging guest MPU configurations:
>>  * fix a missing newline for a guest-error log
>>  * report the region number with guest-error or unimp
>>    logs of bad region register values
>>  * add a log message for the overall result of the lookup
>>  * print "0x" prefix for hex values
>>
>> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
>> [PMM: a little tidyup, report region number in all messages
>>  rather than just one]
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Thanks,
>
> Alistair
>
>> ---
>>  target/arm/helper.c | 39 +++++++++++++++++++++++++++------------
>>  1 file changed, 27 insertions(+), 12 deletions(-)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 5c044d0..9e1ed1c 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -8169,16 +8169,18 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
>>              }
>>
>>              if (!rsize) {
>> -                qemu_log_mask(LOG_GUEST_ERROR, "DRSR.Rsize field can not be 0");
>> +                qemu_log_mask(LOG_GUEST_ERROR,
>> +                              "DRSR[%d]: Rsize field cannot be 0\n", n);
>>                  continue;
>>              }
>>              rsize++;
>>              rmask = (1ull << rsize) - 1;
>>
>>              if (base & rmask) {
>> -                qemu_log_mask(LOG_GUEST_ERROR, "DRBAR %" PRIx32 " misaligned "
>> -                              "to DRSR region size, mask = %" PRIx32,
>> -                              base, rmask);
>> +                qemu_log_mask(LOG_GUEST_ERROR,
>> +                              "DRBAR[%d]: 0x%" PRIx32 " misaligned "
>> +                              "to DRSR region size, mask = 0x%" PRIx32 "\n",
>> +                              n, base, rmask);
>>                  continue;
>>              }
>>
>> @@ -8215,9 +8217,10 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
>>                  }
>>              }
>>              if (rsize < TARGET_PAGE_BITS) {
>> -                qemu_log_mask(LOG_UNIMP, "No support for MPU (sub)region"
>> +                qemu_log_mask(LOG_UNIMP,
>> +                              "DRSR[%d]: No support for MPU (sub)region "
>>                                "alignment of %" PRIu32 " bits. Minimum is %d\n",
>> -                              rsize, TARGET_PAGE_BITS);
>> +                              n, rsize, TARGET_PAGE_BITS);
>>                  continue;
>>              }
>>              if (srdis) {
>> @@ -8251,8 +8254,8 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
>>                      break;
>>                  default:
>>                      qemu_log_mask(LOG_GUEST_ERROR,
>> -                                  "Bad value for AP bits in DRACR %"
>> -                                  PRIx32 "\n", ap);
>> +                                  "DRACR[%d]: Bad value for AP bits: 0x%"
>> +                                  PRIx32 "\n", n, ap);
>>                  }
>>              } else { /* Priv. mode AP bits decoding */
>>                  switch (ap) {
>> @@ -8269,8 +8272,8 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
>>                      break;
>>                  default:
>>                      qemu_log_mask(LOG_GUEST_ERROR,
>> -                                  "Bad value for AP bits in DRACR %"
>> -                                  PRIx32 "\n", ap);
>> +                                  "DRACR[%d]: Bad value for AP bits: 0x%"
>> +                                  PRIx32 "\n", n, ap);
>>                  }
>>              }
>>
>> @@ -8448,9 +8451,21 @@ static bool get_phys_addr(CPUARMState *env, target_ulong address,
>>       */
>>      if (arm_feature(env, ARM_FEATURE_PMSA) &&
>>          arm_feature(env, ARM_FEATURE_V7)) {
>> +        bool ret;
>>          *page_size = TARGET_PAGE_SIZE;
>> -        return get_phys_addr_pmsav7(env, address, access_type, mmu_idx,
>> -                                    phys_ptr, prot, fsr);
>> +        ret = get_phys_addr_pmsav7(env, address, access_type, mmu_idx,
>> +                                   phys_ptr, prot, fsr);
>> +        qemu_log_mask(CPU_LOG_MMU, "PMSAv7 MPU lookup for %s at 0x%08" PRIx32
>> +                      " mmu_idx %u -> %s (prot %c%c%c)\n",
>> +                      access_type == 1 ? "reading" :
>> +                      (access_type == 2 ? "writing" : "execute"),
>> +                      (uint32_t)address, mmu_idx,
>> +                      ret ? "Miss" : "Hit",
>> +                      *prot & PAGE_READ ? 'r' : '-',
>> +                      *prot & PAGE_WRITE ? 'w' : '-',
>> +                      *prot & PAGE_EXEC ? 'x' : '-');
>> +
>> +        return ret;
>>      }
>>
>>      if (regime_translation_disabled(env, mmu_idx)) {
>> --
>> 2.7.4
>>
>>
>
