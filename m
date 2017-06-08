Received: from eggs.gnu.org ([2001:4830:134:3::10]:47202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ2VM-0005cJ-1z
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ2VI-0001Fg-GT
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:50:00 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1dJ2VI-0001FE-6w
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:49:56 -0400
Received: by mail-wm0-x243.google.com with SMTP id x3so8673878wme.0
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 11:49:54 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu,  8 Jun 2017 21:49:35 +0300
Message-Id: <20170608184944.19406-1-mrolnik@gmail.com>
Subject: [Qemu-devel] [PATCH RFC v19 00/13] QEMU AVR 8 bit cores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anichang@protonmail.ch, Michael Rolnik <mrolnik@gmail.com>

This series of patches adds 8bit AVR cores to QEMU.
All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not fully tested yet.
However I was able to execute simple code with functions. e.g fibonacci calculation.
This series of patches include a non real, sample board.
No fuses support yet. PC is set to 0 at reset.

the patches include the following
1. just a basic 8bit AVR CPU, without instruction decoding or translation
2. CPU features which allow define the following 8bit AVR cores
     avr1
     avr2 avr25
     avr3 avr31 avr35
     avr4
     avr5 avr51
     avr6
     xmega2 xmega4 xmega5 xmega6 xmega7
3. a definition of sample machine with SRAM, FLASH and CPU which allows to execute simple code
4. encoding for all AVR instructions
5. interrupt handling
6. helpers for IN, OUT, SLEEP, WBR & unsupported instructions
7. a decoder which given an opcode decides what istruction it is
8. translation of AVR instruction into TCG
9. all features together

changes since v3
1. rampD/X/Y/Z registers are encoded as 0x00ff0000 (instead of 0x000000ff) for faster address manipulaton
2. ffs changed to ctz32
3. duplicate code removed at avr_cpu_do_interrupt
4. using andc instead of not + and
5. fixing V flag calculation in varios instructions
6. freeing local variables in PUSH
7. tcg_const_local_i32 -> tcg_const_i32
8. using sextract32 instead of my implementation
9. fixing BLD instruction
10.xor(r) instead of 0xff - r at COM
11.fixing MULS/MULSU not to modify inputs' content
12.using SUB for NEG
13.fixing tcg_gen_qemu_ld/st call in XCH

changes since v4
1. target is now defined as big endian in order to optimize push_ret/pop_ret
2. all style warnings are fixed
3. adding cpu_set/get_sreg functions
4. simplifying gen_goto_tb as there is no real paging
5. env->pc -> env->pc_w
6. making flag dump more compact
7. more spacing
8. renaming CODE/DATA_INDEX -> MMU_CODE/DATA_IDX
9. removing avr_set_feature
10. SPL/SPH set bug fix
11. switching stb_phys to cpu_stb_data
12. cleaning up avr_decode
13. saving sreg, rampD/X/Y/Z, eind in HW format (savevm)
14. saving CPU features (savevm)

changes since v5
1. BLD bug fix
2. decoder generator is added

chages since v6
1. using cpu_get_sreg/cpu_set_sreg in avr_cpu_gdb_read_register/avr_cpu_gdb_write_register
2. configure the target as little endian because otherwise GDB does not work
3. fixing and testing gen_push_ret/gen_pop_ret

changes since v7
1. folding back v6 
2. logging at helper_outb and helper_inb are done for non supported yet registers only
3. MAINTAINERS updated

changes since v8
1. removing hw/avr from hw/Makefile.obj as it should not be built for all
2. making linux compilable
3. testing on
    a. Mac, Apple LLVM version 7.0.0
    b. Ubuntu 12.04, gcc 4.9.2
    c. Fedora 23, gcc 5.3.1
4. folding back some patches
5. translation bug fixes for ORI, CPI, XOR instructions
6. propper handling of cpu register writes though memory

changes since v9
1. removing forward declarations of static functions
2. disabling debug prints
3. switching to case range instead of if else if ...
4. LD/ST IN/OUT accessing CPU maintainder registers are not routed to any device
5. commenst about sample board and sample IO device added
6. sample board description is more descriptive now
7. memory_region_allocate_system_memory is used to create RAM
8. now there are helper_fullrd & helper_fullwr when LD/ST try to access registers

changes since v10
1. movig back fullwr & fullrd into the commit where outb and inb were introduced
2. changing tlb_fill function signature
3. adding empty line between functions
4. adding newline on the last line of the file
5. using tb->flags to generae full access ST/LD instructions
6. fixing SBRC bug
7. folding back 10th commit
8. whenever a new file is introduced it's added to Makefile.objs

changes since v11
1. updating to v2.7.0-rc
2. removing assignment to env->fullacc from gen_intermediate_code

changes since v12
1. fixing spacing
2. fixing get/put_segment functions
3. removing target-avr/machine.h file
4. VMSTATE_SINGLE_TEST -> VMSTATE_SINGLE
5. comment spelling
6. removing hw/avr/sample_io.c
7. char const* -> const char*
8. proper ram allocation
9. fixing breakpoint functionality.
10.env1 -> env
11.fixing avr_cpu_gdb_write_register & avr_cpu_gdb_read_register functions
12.any cpu is removed
12.feature bits are not saved into vm state

changes since v13
1. rebasing to v2.7.0-rc1

changes since v14
1. I made self review with git gui tool. (I did not know such a thing exists)
2. removing all double/tripple spaces
3. removing comment reference to SampleIO
4. folding back some changes, so there is not deleted lines in my code
5. moving avr configuration, within configure file, before chris

changes since v15
1. removing IO registers cache from CPU
2. implementing CBI/SBI as read(helper_inb), modify, write(helper_outb)
3. implementing CBIC/SBIC as read(helper_inb), check, branch
4. adding missing tcg_temp_free_i32 for tcg_const_i32

changes since v16
1. removing EXT IO registers knoledge from CPU. These registers are accessible 
   by LD/ST only. CPU has no interest in them

changes since v17 (by Richard Henderson)
This is Michael's v17, with some adjustments of my own:

1. Fix the whitespace errors reported by "git am",
2. Replace the utf-8 characters with normal ascii,
3. Ditch the separate compilation of translate.c.

I retained the two separate files that could be regenerated
from the included cpugen program, but merged in translate-insn.c.
Not that it matters, but the code generated is about 3k smaller.

changes since v18
1.  moving target-avr into target/avr
2.  do not call cpu_exec_initfn function from avr_cpu_initfn
3.  call cpu_exec_realizefn avr_cpu_realizefn
4.  do not fail sample machine creation if no rom is suplied
5.  add tcg_gen_exit_tb(0) for BS_BRANCH in gen_intermediate_code
6.  fix a register getters/setters in machine.c
7.  changing QEMU_ARCH_AVR from 1<<17 to 1<<18
8.  thanks to Ani Chang <anichang@protonmail.ch> for helping me with this release


Michael Rolnik (9):
  target-avr: AVR cores support is added.
  target-avr: adding AVR CPU features/flavors
  target-avr: adding a sample AVR board
  target-avr: adding instructions encodings
  target-avr: adding AVR interrupt handling
  target-avr: adding helpers for IN, OUT, SLEEP, WBR & unsupported
    instructions
  target-avr: adding instruction translation
  target-avr: instruction decoder generator
  target-avr: adding instruction decoder

Richard Henderson (4):
  target-avr: Put env pointer in DisasContext
  target-avr: Put all translation code into one compilation unit
  target-avr: Respect .inc.c convention
  target-avr: Merge translate-inst.inc.c into translate.c

 MAINTAINERS                                |    6 +
 arch_init.c                                |    2 +
 configure                                  |    5 +
 default-configs/avr-softmmu.mak            |   21 +
 hw/avr/Makefile.objs                       |   21 +
 hw/avr/sample.c                            |  108 ++
 include/disas/bfd.h                        |    6 +
 include/sysemu/arch_init.h                 |    1 +
 target/avr/Makefile.objs                   |   23 +
 target/avr/cpu-qom.h                       |   84 +
 target/avr/cpu.c                           |  599 ++++++
 target/avr/cpu.h                           |  237 +++
 target/avr/cpugen/CMakeLists.txt           |   38 +
 target/avr/cpugen/README.md                |   17 +
 target/avr/cpugen/cpu/avr.yaml             |  213 ++
 target/avr/cpugen/src/CMakeLists.txt       |   62 +
 target/avr/cpugen/src/cpugen.cpp           |  457 +++++
 target/avr/cpugen/src/utils.cpp            |   26 +
 target/avr/cpugen/src/utils.h              |   78 +
 target/avr/cpugen/xsl/decode.c.xsl         |  103 +
 target/avr/cpugen/xsl/translate-inst.h.xsl |  118 ++
 target/avr/cpugen/xsl/utils.xsl            |  108 ++
 target/avr/decode.inc.c                    |  689 +++++++
 target/avr/gdbstub.c                       |   85 +
 target/avr/helper.c                        |  355 ++++
 target/avr/helper.h                        |   28 +
 target/avr/machine.c                       |  120 ++
 target/avr/translate-inst.h                |  691 +++++++
 target/avr/translate.c                     | 2910 ++++++++++++++++++++++++++++
 29 files changed, 7211 insertions(+)
 create mode 100644 default-configs/avr-softmmu.mak
 create mode 100644 hw/avr/Makefile.objs
 create mode 100644 hw/avr/sample.c
 create mode 100644 target/avr/Makefile.objs
 create mode 100644 target/avr/cpu-qom.h
 create mode 100644 target/avr/cpu.c
 create mode 100644 target/avr/cpu.h
 create mode 100644 target/avr/cpugen/CMakeLists.txt
 create mode 100644 target/avr/cpugen/README.md
 create mode 100644 target/avr/cpugen/cpu/avr.yaml
 create mode 100644 target/avr/cpugen/src/CMakeLists.txt
 create mode 100644 target/avr/cpugen/src/cpugen.cpp
 create mode 100644 target/avr/cpugen/src/utils.cpp
 create mode 100644 target/avr/cpugen/src/utils.h
 create mode 100644 target/avr/cpugen/xsl/decode.c.xsl
 create mode 100644 target/avr/cpugen/xsl/translate-inst.h.xsl
 create mode 100644 target/avr/cpugen/xsl/utils.xsl
 create mode 100644 target/avr/decode.inc.c
 create mode 100644 target/avr/gdbstub.c
 create mode 100644 target/avr/helper.c
 create mode 100644 target/avr/helper.h
 create mode 100644 target/avr/machine.c
 create mode 100644 target/avr/translate-inst.h
 create mode 100644 target/avr/translate.c

-- 
2.11.0 (Apple Git-81)
