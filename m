Received: from eggs.gnu.org ([2001:4830:134:3::10]:57447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eCo2F-0005d5-6U
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:42:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eCo2C-0002nw-2y
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:42:27 -0500
Received: from bran.ispras.ru ([83.149.199.196]:54253 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1eCo2B-0002lj-MW
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:42:24 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Thu,  9 Nov 2017 17:41:52 +0300
Message-Id: <20171109144155.17076-1-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH RFC 0/3] TCG: do copy propagation through
 memory locations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kirill Batuzov <batuzovk@ispras.ru>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

This patch series is based on native-vector-registers-3:
  git://github.com/rth7680/qemu.git native-vector-registers-3

Particular goal of this change was to retain values of guest vector registers
on host vector registers between different guest instructions.

Relation between memory locations and variables is many-to-many.
Variables can be copies of each other; multiple variables can have the same
value as the one stored in memory location. Any variable can be stored to
multiple memory locations as well. To represent all this a data structure that
can handle the following operations is needed.

 (0) Allocate and deallocate memory locations. Exact number of possible memory
     locations is unknown, but there should not be too many of them known to
     algorithm simultaneously.
 (1) Find a memory location with specified offset, size and type among all
     memory locations. Needed to replace LOADs.
 (2) For a memory location find a variable containing the same value. Also
     needed to replace LOADs.
 (3) Remove memory locations overlapping with specified range of addresses.
     Needed to remove memory locations affected by STOREs.
 (4) For a variable find all memory locations containing the same value.
     In case the value of the variable has changed, these memory locations
     should not reference this variable any more.

In proposed implementation all these cases are handled by multiple lists
containing memory locations.
 - List of unused memory location descriptors.
 - List of all known memory locations.
 - List of memory locations containing the same value for every variable.

Change was tested on x264 video encoder compiled for ARM32 and run using
qemu-linux-user on x86_64 host. Some loads were replaced by MOVs, but no
change in performance was observed.

x264 video encoder compiled for ARM64 crashed under qemu-linux-user
unfortunately.

On the artificial test case nearly 3x speedup was observed (8s vs 22s).

IN:
<snip>
0x00000000004005c0:  4ea18400      add v0.4s, v0.4s, v1.4s
0x00000000004005c4:  4ea18400      add v0.4s, v0.4s, v1.4s
0x00000000004005c8:  4ea18400      add v0.4s, v0.4s, v1.4s
0x00000000004005cc:  4ea18400      add v0.4s, v0.4s, v1.4s
<snip>

OP:
<snip>
 ---- 00000000004005c0 0000000000000000 0000000000000000
 ld_vec tmp7,env,$0x8a0,$0x1
 ld_vec tmp8,env,$0x8b0,$0x1
 add32_vec tmp9,tmp7,tmp8,$0x1
 st_vec tmp9,env,$0x8a0,$0x1

 ---- 00000000004005c4 0000000000000000 0000000000000000
 ld_vec tmp7,env,$0x8a0,$0x1
 ld_vec tmp8,env,$0x8b0,$0x1
 add32_vec tmp9,tmp7,tmp8,$0x1
 st_vec tmp9,env,$0x8a0,$0x1

 ---- 00000000004005c8 0000000000000000 0000000000000000
 ld_vec tmp7,env,$0x8a0,$0x1
 ld_vec tmp8,env,$0x8b0,$0x1
 add32_vec tmp9,tmp7,tmp8,$0x1
 st_vec tmp9,env,$0x8a0,$0x1

 ---- 00000000004005cc 0000000000000000 0000000000000000
 ld_vec tmp7,env,$0x8a0,$0x1
 ld_vec tmp8,env,$0x8b0,$0x1
 add32_vec tmp9,tmp7,tmp8,$0x1
 st_vec tmp9,env,$0x8a0,$0x1
<snip>

OP after optimization and liveness analysis:
<snip>
 ---- 00000000004005c0 0000000000000000 0000000000000000
 ld_vec tmp7,env,$0x8a0,$0x1
 ld_vec tmp8,env,$0x8b0,$0x1
 add32_vec tmp9,tmp7,tmp8,$0x1                    dead: 1
 st_vec tmp9,env,$0x8a0,$0x1

 ---- 00000000004005c4 0000000000000000 0000000000000000
 mov_vec tmp7,tmp9,$0x1                           dead: 1
 add32_vec tmp9,tmp7,tmp8,$0x1                    dead: 1
 st_vec tmp9,env,$0x8a0,$0x1

 ---- 00000000004005c8 0000000000000000 0000000000000000
 mov_vec tmp7,tmp9,$0x1                           dead: 1
 add32_vec tmp9,tmp7,tmp8,$0x1                    dead: 1
 st_vec tmp9,env,$0x8a0,$0x1

 ---- 00000000004005cc 0000000000000000 0000000000000000
 mov_vec tmp7,tmp9,$0x1                           dead: 1
 add32_vec tmp9,tmp7,tmp8,$0x1                    dead: 1 2
 st_vec tmp9,env,$0x8a0,$0x1                      dead: 0 1
<snip>

I'm not particularly happy about the current implementation.
 - Data structure seems to be a bit too complicated for the task at hand. May
   be I'm doing something wrong?
 - Current data structure is tightly related to struct tcg_temp_info and is a
   part of optimizations. Very similar data structure will be needed in
   liveness analysis to eliminate redundant STOREs.

Having SSA (or at least single assignment per basic block) will help a lot.
It will remove use case (4) completely, and with it the need for the lists of
memory locations for each variable, leaving only one list. Another result will
be that operation on TCGMemLocation will no longer need to do any
modifications of TCGTemp or tcg_temp_info structures thus making TCGMemLocation
reusable in liveness or register allocation.

But we do not have SSA (yet?).

Any thoughts or comments?

Kirill Batuzov (3):
  tcg: support MOV_VEC and MOVI_VEC opcodes in register allocator
  tcg/optimize: do copy propagation for memory locations
  tcg/optimize: handle vector loads and stores during copy propagation

 tcg/optimize.c | 288 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg.c      |   2 +
 2 files changed, 290 insertions(+)

-- 
2.11.0
