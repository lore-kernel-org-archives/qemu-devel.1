Received: from eggs.gnu.org ([2001:4830:134:3::10]:60358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXweG-0005pd-9p
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 17:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXweB-0005Dw-Ak
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 17:36:48 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:37096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXweB-0005DN-4K
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 17:36:43 -0400
Received: by mail-qk0-x241.google.com with SMTP id q130so804252qka.4
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 14:36:41 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170719045722.25492-1-rth@twiddle.net>
	<CAFEAcA9Z_8kq_e+swQaZVEecmVmcNw9XJ4WRXatTLG26W=n0uQ@mail.gmail.com>
	<9bc19023-eca9-1ea6-02d7-4817fe6fd6fb@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e04d5021-f02a-7de5-6aba-52aca6774407@twiddle.net>
Date: Wed, 19 Jul 2017 11:36:29 -1000
MIME-Version: 1.0
In-Reply-To: <9bc19023-eca9-1ea6-02d7-4817fe6fd6fb@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 00/14] tcg-next patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 07/19/2017 10:33 AM, Philippe Mathieu-Daudé wrote:
> On 07/19/2017 04:45 PM, Peter Maydell wrote:
>> The sparc-linux-user test fails:
>>
>> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc-linux-user/qemu-sparc 
>>
>> -L ./gnemul/qemu-sparc sparc/ls -l dummyfile
>> Inconsistency detected by ld.so: rtld.c: 858: dl_main: Assertion
>> `_dl_rtld_map.l_prev->l_next == _dl_rtld_map.l_next' failed!
>> Makefile:6: recipe for target 'test' failed
>>
>> A valgrind run produces a lot of noise, but
>> this bit looks suspicious:
>>
>> ==14436==
>> ==14436== Conditional jump or move depends on uninitialised value(s)
>> ==14436==    at 0x60003F7C: tcg_out_qemu_st_direct (tcg-target.inc.c:1733)
>> ==14436==    by 0x60004295: tcg_out_qemu_st (tcg-target.inc.c:1856)
>> ==14436==    by 0x60004F0C: tcg_out_op (tcg-target.inc.c:2140)
>> ==14436==    by 0x6000B0FF: tcg_reg_alloc_op (tcg.c:2360)
>> ==14436==    by 0x6000BCED: tcg_gen_code (tcg.c:2679)
>> ==14436==    by 0x600387B7: tb_gen_code (translate-all.c:1311)
>> ==14436==    by 0x6003637B: tb_find (cpu-exec.c:367)
>> ==14436==    by 0x60036A7C: cpu_exec (cpu-exec.c:675)
>> ==14436==    by 0x60039DA1: cpu_loop (main.c:1088)
>> ==14436==    by 0x6003B7AF: main (main.c:4860)
>> ==14436==
>> ==14436== Invalid write of size 4
>> ==14436==    at 0x605114FA: ???
>> ==14436==    by 0x6011ADDF: ??? (in
>> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc-linux-user/qemu-sparc) 
>>
>> ==14436==    by 0x6253464F: ???
>> ==14436==    by 0x6022852F: ??? (in
>> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc-linux-user/qemu-sparc) 
>>
>> ==14436==    by 0x6022818C: ??? (in
>> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc-linux-user/qemu-sparc) 
>>
>> ==14436==    by 0x6022852F: ??? (in
>> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc-linux-user/qemu-sparc) 
>>
>> ==14436==    by 0x416FFFFFFFF: ???
>> ==14436==    by 0x60227F1F: ??? (in
>> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc-linux-user/qemu-sparc) 
>>
>> ==14436==  Address 0x59d1c7d0 is not stack'd, malloc'd or (recently) free'd
>> ==14436==
>>
>> Reverting "target/sparc: optimize gen_op_mulscc() using deposit op"
>> fixed this, so I think that's probably the culprit.
> 
> Thank you for taking time with valgrind, I'll verify sparc/tcg opcode used.

A simple typo, Phil,

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 56ef73c794..3bde47be83 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -633,7 +633,7 @@ static inline void gen_op_mulscc
      // b2 = T0 & 1;
      // env->y = (b2 << 31) | (env->y >> 1);
      tcg_gen_extract_tl(t0, cpu_y, 1, 31);
-    tcg_gen_deposit_tl(cpu_y, cpu_y, cpu_cc_src, 31, 1);
+    tcg_gen_deposit_tl(cpu_y, t0, cpu_cc_src, 31, 1);

      // b1 = N ^ V;
      gen_mov_reg_N(t0, cpu_psr);


I'll respin.


r~
