Received: from eggs.gnu.org ([2001:4830:134:3::10]:40831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cQyMM-00063B-Tn
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 10:29:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cQyMJ-0003pD-RJ
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 10:29:14 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cQyMJ-0003p9-Jm
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 10:29:11 -0500
Received: by mail-wm0-x236.google.com with SMTP id c85so131275486wmi.1
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 07:29:11 -0800 (PST)
References: <20161124161033.11456-1-alex.bennee@linaro.org>
	<20161124161033.11456-5-alex.bennee@linaro.org>
	<87r34b2b3a.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87r34b2b3a.fsf@linaro.org>
Date: Tue, 10 Jan 2017 15:29:08 +0000
Message-ID: <87pojv2at7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v7 04/11] libcflat: add
 PRI(dux)32 format types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, christoffer.dall@linaro.org, marc.zyngier@arm.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, claudio.fontana@huawei.com


Alex Bennée <alex.bennee@linaro.org> writes:

> Alex Bennée <alex.bennee@linaro.org> writes:
>
>> So we can have portable formatting of uint32_t types.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  lib/libcflat.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/lib/libcflat.h b/lib/libcflat.h
>> index bdcc561..6dab5be 100644
>> --- a/lib/libcflat.h
>> +++ b/lib/libcflat.h
>> @@ -55,12 +55,17 @@ typedef _Bool		bool;
>>  #define true  1
>>
>>  #if __SIZEOF_LONG__ == 8
>> +#  define __PRI32_PREFIX
>>  #  define __PRI64_PREFIX	"l"
>>  #  define __PRIPTR_PREFIX	"l"
>>  #else
>> +#  define __PRI32_PREFIX        "l"
>
> OK this is bogus, but the failure is because of where we get uint32_t
> from (hint using arm32 compiler on a arm64 system) so I got:
>
>   lib/pci.c:71:9: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'uint32_t {aka long unsigned int}' [-Werro\
> r=format=]
>
> Which makes me think we should be more careful about including system
> headers in kvm-unit-tests (done in 75e777a0).

Hmm it turns out my compiler is d.r.t as far as it is concerned:

  # 34 "/usr/lib/gcc/arm-none-eabi/5.4.1/include/stdint-gcc.h" 3 4
  typedef signed char int8_t;


  typedef short int int16_t;


  typedef long int int32_t;


  typedef long long int int64_t;


  typedef unsigned char uint8_t;


  typedef short unsigned int uint16_t;


  typedef long unsigned int uint32_t;


--
Alex Bennée
