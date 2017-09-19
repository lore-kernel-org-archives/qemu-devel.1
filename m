Received: from eggs.gnu.org ([2001:4830:134:3::10]:43977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duMLp-0004mK-Pt
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duMLm-0003vl-Sl
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:30:25 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:50797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duMLm-0003v5-OF
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:30:22 -0400
Received: by mail-qt0-x233.google.com with SMTP id f15so350734qtf.7
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 10:30:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170914183516.19537-1-richard.henderson@linaro.org>
	<53de205c-7c24-426c-129a-7cce7ca67210@amsat.org>
	<0a265b7a-c84f-fefc-41e6-0276dfc131b8@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <917e90c5-ddbc-bd55-d2ff-f780dab1063a@amsat.org>
Date: Tue, 19 Sep 2017 14:30:18 -0300
MIME-Version: 1.0
In-Reply-To: <0a265b7a-c84f-fefc-41e6-0276dfc131b8@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/10] Support the Capstone disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org

On 09/19/2017 01:13 PM, Richard Henderson wrote:
> [ Just saw this, so missed adding tags to the v2 patch set. ]
> 
> On 09/14/2017 11:53 PM, Philippe Mathieu-Daudé wrote:
>> At least this msg disappeared:
>>
>> "Disassembler disagrees with translator over instruction decoding"
> 
> It's back in v2.
> 
>> For i386, arm, mips32/64:
>> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Which patches?  Which mips versions?

full series, Malta board default cpu

> Can you, by any chance, test micro-mips?  I'm certain I've got that wrong in
> the v1 patch, and thus I dropped the mips patch from v2.  But in theory
> capstone supports umips too and should be trivially fixable.

$ mipsel-softmmu/qemu-system-mipsel -machine malta -cpu M14Kc -append 
"ttyS0 rw" -nographic -d in_asm -kernel vmlinux -initrd initrd.gz

  IN: kernel_entry
  0x801039e0:  syscall   0x3f004
  0x801039e4:  b 0x8011406c
-0x801039e8:  addu      t2,zero,ra
-0x801039ec:  c0        0x900028
-0x801039f0:  0x1f7108
-0x801039f4:  syscall   0xbf004
+0x801039e8:  addu         $t2, $zero, $ra

  IN: kernel_entry
-0x801039f8:  blezalc   zero,zero,0x801039fc
-0x801039fc:  lb        s0,16808(zero)
-0x80103a00:  xori      t1,s0,0x3108
+0x801039f8:  blez         $zero, 0x801039fc
+0x801039fc:  lb           $s0, 0x41a8($zero)
+0x80103a00:  xori         $t1, $s0, 0x3108
  0x80103a04:  jal       0x80011620

  IN: kernel_entry
-0x80103a08:  lb        t9,16808(at)
-0x80103a0c:  beqzalc   zero,zero,0x8010fe30
-0x80103a10:  0xf808
-0x80103a14:  lb        gp,16809(at)
-0x80103a18:  sdr       gp,12585(a1)
-0x80103a1c:  jialc     t0,19720
-0x80103a20:  sdr       t0,0(t1)
-0x80103a24:  jal       0x8003ffec
+0x80103a08:  lb           $t9, 0x41a8($at)
+0x80103a0c:  addi         $zero, $zero, 0x3108

  IN: kernel_entry
-0x80103a1c:  jialc     t0,19720
-0x80103a20:  sdr       t0,0(t1)
-0x80103a24:  jal       0x8003ffec
+0x80103a1c:  sdc2         $8, 0x4d08($zero)

  IN: kernel_entry
-0x80103a28:  lb        t9,16801(at)
-0x80103a2c:  sltiu     a0,t6,-1919
-0x80103a30:  lb        t9,16801(at)
-0x80103a34:  sltiu     t0,t6,-1887
-0x80103a38:  lb        t9,16801(at)
-0x80103a3c:  sltiu     t4,t6,-1855
-0x80103a40:  lb        t9,16801(at)
-0x80103a44:  sltiu     s0,t6,-1823
-0x80103a48:  sllv      zero,gp,s7
-0x80103a4c:  lb        s5,16828(at)
-0x80103a50:  sc        zero,13212(zero)
-0x80103a54:  bltuc     ra,zero,0x801108d8
-0x80103a58:  balc      0x855048d0
-0x80103a5c:  blezalc   zero,zero,0x80103a60
-0x80103a60:  lb        t9,16801(at)
-0x80103a64:  sltiu     t8,t6,-1119
-0x80103a68:  sd        s0,13245(ra)
-0x80103a6c:  lwl       s6,-11237(s2)
-0x80103a70:  jal       0x80003000
-Disassembler disagrees with translator over instruction decoding
-Please report this to qemu-devel@nongnu.org
+0x80103a28:  lb           $t9, 0x41a1($at)
+0x80103a2c:  sltiu        $a0, $t6, -0x77f
+0x80103a30:  lb           $t9, 0x41a1($at)
+0x80103a34:  sltiu        $t0, $t6, -0x75f
+0x80103a38:  lb           $t9, 0x41a1($at)
+0x80103a3c:  sltiu        $t4, $t6, -0x73f
+0x80103a40:  lb           $t9, 0x41a1($at)
+0x80103a44:  sltiu        $s0, $t6, -0x71f
+0x80103a48:  sllv         $zero, $gp, $s7
+0x80103a4c:  lb           $s5, 0x41bc($at)
+0x80103a50:  sc           $zero, 0x339c($zero)
+0x80103a54:  bgtz         $ra, 0x801108d8
+0x80103a58:  swc2         $16, 0x39d($t2)
+0x80103a5c:  blez         $zero, 0x80103a60
+0x80103a60:  lb           $t9, 0x41a1($at)
+0x80103a64:  sltiu        $t8, $t6, -0x45f

...

  IN: try_acquire_console_sem
-0x8011fb26:  bnezc     v1,0x819db12e
-0x8011fb2a:  0x41a2a3d4
-0x8011fb2e:  jialc     v0,-32710
-0x8011fb32:  jal       0x818291a0
-0x8011fb36:  bc1f      $fcc1,0x80122c46
-0x8011fb3a:  sdc1      $f9,18182(zero)
-Disassembler disagrees with translator over instruction decoding
-Please report this to qemu-devel@nongnu.org
+0x8011fb26:  sdc2         $2, -0x127f($v1)
