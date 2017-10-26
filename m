Received: from eggs.gnu.org ([2001:4830:134:3::10]:53152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7nRi-0005q7-3r
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 15:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7nRe-0001yD-TZ
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 15:04:02 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:47972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e7nRe-0001xV-OT
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 15:03:58 -0400
Received: by mail-qk0-x241.google.com with SMTP id m189so5603734qke.4
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 12:03:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20171026135814.20773-1-richard.henderson@linaro.org>
	<20171026173758.GA2334@flamenco>
	<163ef388-2b1f-21f3-5434-286eb8f3078d@amsat.org>
Message-ID: <ffb0a910-c5e6-2aa3-4a4c-b9c0a25b1b9b@amsat.org>
Date: Thu, 26 Oct 2017 16:03:49 -0300
MIME-Version: 1.0
In-Reply-To: <163ef388-2b1f-21f3-5434-286eb8f3078d@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: Avoid setting tcg_initialize if
 !CONFIG_TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, ehabkost@redhat.com, Yang Zhong <yang.zhong@intel.com>

Oops sent a bit too fast.

On 10/26/2017 03:57 PM, Philippe Mathieu-Daudé wrote:
> On 10/26/2017 02:37 PM, Emilio G. Cota wrote:
>> AFAIK the only target that is so far supposed to work with
>> --disable-tcg is i386. The configure script however lets you try to
>> build without TCG if the host has an alternative accelerator (e.g. KVM),
>> but that build is likely to fail. [ just confirmed this with aarch64 ]
> 
> What about s390x?
> 
>   LINK    s390x-softmmu/qemu-system-s390x
> exec.o: In function `tlb_reset_dirty_range_all':
> exec.c:1118: undefined reference to `tlb_reset_dirty'
> exec.o: In function `tcg_commit':
> exec.c:2765: undefined reference to `cpu_reloading_memory_map'
> cpus.o: In function `tcg_cpu_exec':
> cpus.c:1270: undefined reference to `cpu_exec'
> cpus.o: In function `qemu_tcg_rr_cpu_thread_fn':
> cpus.c:1310: undefined reference to `tcg_register_thread'
> cpus.c:1375: undefined reference to `cpu_exec_step_atomic'
> cpus.o: In function `qemu_tcg_cpu_thread_fn':
> cpus.c:1458: undefined reference to `tcg_register_thread'
> cpus.c:1492: undefined reference to `cpu_exec_step_atomic'
> cpus.o: In function `qemu_tcg_init_vcpu':
> cpus.c:1679: undefined reference to `tcg_region_init'
> cpus.c:1689: undefined reference to `parallel_cpus'
> target/s390x/cpu.o: In function `s390_cpu_class_init':
> target/s390x/cpu.c:500: undefined reference to `s390x_translate_init'
> collect2: error: ld returned 1 exit status

bisected to:

b11ec7f2e44b285a3967d629b55d1a6970b06787 is the first bad commit
commit b11ec7f2e44b285a3967d629b55d1a6970b06787
Author: Yang Zhong <yang.zhong@intel.com>
Date:   Mon Jul 3 18:12:21 2017 +0800

    tcg: add CONFIG_TCG guards in headers

    Add CONFIG_TCG around TLB-related functions and structure declarations.
    Some of these functions are defined in ./accel/tcg/cputlb.c, which will
    not be linked in if TCG is disabled, and have no stubs; therefore, their
    callers will also be compiled out for --disable-tcg.

    Signed-off-by: Yang Zhong <yang.zhong@intel.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
