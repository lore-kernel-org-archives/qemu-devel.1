Received: from eggs.gnu.org ([2001:4830:134:3::10]:54777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ckhXc-0000bv-MO
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 20:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ckhXb-0006Ne-Tn
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 20:34:24 -0500
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:34390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ckhXb-0006NR-Om
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 20:34:23 -0500
Received: by mail-pg0-x22c.google.com with SMTP id 77so16027378pgc.1
	for <qemu-devel@nongnu.org>; Sun, 05 Mar 2017 17:34:22 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <49fcb3c4-df9d-ec64-2927-71c02fc2524b@genode-labs.com>
	<87r32bif49.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <09728335-6fd7-b332-0d86-91c0ded71d90@twiddle.net>
Date: Mon, 6 Mar 2017 12:34:13 +1100
MIME-Version: 1.0
In-Reply-To: <87r32bif49.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Qemu deadlocks in tb_lock when using SVM+SoftMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Alexander Boettcher <alexander.boettcher@genode-labs.com>
Cc: qemu-devel@nongnu.org, fred.konrad@greensocs.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com

On 03/06/2017 08:32 AM, Alex Bennée wrote:
>> #5  0x000000000046ea2e in tlb_flush (cpu=0x164a360) at qemu.git/cputlb.c:121
>> #6  0x0000000000538987 in cpu_x86_update_cr4 (env=0x16525f0, new_cr4=1784)
>>     at qemu.git/target/i386/helper.c:660
>> #7  0x000000000055e318 in cpu_vmexit (env=0x16525f0, exit_code=78,
>> exit_info_1=4, retaddr=0)
>>     at qemu.git/target/i386/svm_helper.c:689
>> #8  0x000000000055d9b7 in cpu_svm_check_intercept_param (env=0x16525f0,
>> type=78, param=4, retaddr=0)
>>     at qemu.git/target/i386/svm_helper.c:511
>> #9  0x0000000000541acf in raise_interrupt2 (env=0x16525f0, intno=14,
>> is_int=0, error_code=4, next_eip_addend=0, retaddr=0)
>>     at qemu.git/target/i386/excp_helper.c:96
>> #10 0x0000000000541c0d in raise_exception_err_ra (env=0x16525f0,
>> exception_index=14, error_code=4, retaddr=0)
>>     at qemu.git/target/i386/excp_helper.c:127
>> #11 0x00000000005621a9 in tlb_fill (cs=0x164a360, addr=1245184,
>> access_type=MMU_INST_FETCH, mmu_idx=1, retaddr=0)
>>     at qemu.git/target/i386/mem_helper.c:212
> Richard,
>
> So this looks like another path through the SoftMMU code during
> code-generation (which is why tb_lock() is held in the first place). I'm
> not sure if the correct thing to do is bug out earlier or to defer the
> exception raising part to async work and exit the loop.

My guess is that everything from cpu_svm_check_intercept_param on should be 
done from do_interrupt instead of during raise_interrupt.


r~
