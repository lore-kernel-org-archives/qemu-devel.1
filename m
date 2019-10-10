Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9D5C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4267206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3tNANVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4267206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIZBH-0006TP-VV
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 10:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iIZAa-00064Y-5O
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iIZAX-0001oa-V0
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:11:56 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:34438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iIZAX-0001oJ-Q6
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:11:53 -0400
Received: by mail-qk1-x743.google.com with SMTP id q203so5743252qke.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RkwTFAB9fNWaMzngxYP+Gno0qOFcWwqt3vBHN0x2epU=;
 b=A3tNANVPaD/+Kp/j0iONAULrdd642+TvSVHb74KHRAEIn3ezBMdhf2njob4h7vp5w6
 Eih8P6OgNRxO6QFyQka3/WrxNTPQE+vTaEuiWtIYtSTtJh05nPzg5TyM0Q3zUJXVhLqm
 Vhvd1+9CGCjapIqxQAt4nkGk5KB3H/yLFvuLVvRpKQ5qY8psn/87aSfb6nc2RAOPT1dl
 K8iu5+C7G2B7ilfIxEryHLTk6hRejJFDELqp0CljmaFbFe2/WpHpuYLNyXR1f41PtLi+
 /QnPYDnVo6mADtW4TblrUtfh1c4rjz1maH2dxNGDF+CoPlVjydyntX9c0M6aExbfEonW
 cpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RkwTFAB9fNWaMzngxYP+Gno0qOFcWwqt3vBHN0x2epU=;
 b=df5fu4WwhKrVAPBnJI3F/O+a3sm9/oyWYaAQoQWOT8mP1DMi4FnL/LDDwfB73EQMpl
 XeMAIaJ8SagO4mqL90fgPJoKjM/akIWty7GGS7qKD9ubWmc9MXFoVW0w2uz7+R9wrd1u
 UBnMlaDq3Gt1tEaaeeedtCGUuHGtFdSWZsIH8oHiG8o/korK5M4uHMxAdgxLWYlq2KfY
 hhkrRFylWm+3knWQSWKxYaYxXsxf2yd4dNmrmqe1nJ16nAb44lkkodqIEq5j4acJCz91
 3YZ8rLCCDn0F9q4v1wTlB9A8BEIFySfVgG+dS4yJ3b12CKGE4lGwcEE6kN6l7cYz2YNE
 ww3g==
X-Gm-Message-State: APjAAAU/sfkG/WumJOGo89vzsjg8zYzortxpCNIQ4Zagx+rZq/Erp/QC
 CN4HF5DNKpOuaJK6gVZkhkketucOGPHJtsGNTUY=
X-Google-Smtp-Source: APXvYqxhhynwT1ZogX97Xs1J8upCajWI8Xr6sU4IKaju/UPfg0ghpVl40tZbhm9ZRRx798d+y3F0X9XhenqGhUJ3HNI=
X-Received: by 2002:a05:620a:140d:: with SMTP id
 d13mr9841569qkj.460.1570716712623; 
 Thu, 10 Oct 2019 07:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190915122015.45852-1-mrolnik@gmail.com>
 <CAK4993hWEgHnphTu4_Y8F9VSOTgQkdDMN2D2m2bm3fxG5EQG-A@mail.gmail.com>
 <CAL1e-=gzAj558+fHkJjawX=YZAKHy=JuXWEBhMyKMu7sk73Wnw@mail.gmail.com>
 <CAK4993j4pp65WbK4DCgcxdpZtAaCNuoyNY5XWd7hpZV2fbQVXA@mail.gmail.com>
 <CAL1e-=jMjoRAgkheozWRuc6fGo5XVcgO3LwRCaqkg4KbLFdgWQ@mail.gmail.com>
In-Reply-To: <CAL1e-=jMjoRAgkheozWRuc6fGo5XVcgO3LwRCaqkg4KbLFdgWQ@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu, 10 Oct 2019 17:11:04 +0300
Message-ID: <CAK4993gKGuwOUS0pZxTBxDPVFa0HWm5rwHpQuzE4K9vSU4mYVA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v31 0/8] QEMU AVR 8 bit cores
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar.

This is the document I used
http://ww1.microchip.com/downloads/en/devicedoc/atmel-0856-avr-instruction-=
set-manual.pdf

Thanks.
Michael Rolnik


On Thu, Oct 10, 2019 at 2:38 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
>
>
> On Wednesday, October 9, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>>
>> Hello Aleksandar.
>>
>>
>> https://ww1.microchip.com/downloads/en/devicedoc/atmel-2549-8-bit-avr-mi=
crocontroller-atmega640-1280-1281-2560-2561_datasheet.pdf
>>
>>>
>
> Thanks, Michael!
>
> Could you please provide also a link to AVR instruction set reference doc=
umentation that you used while creating this series, one that this series s=
hould support?
>
> Aleksandar
>
>
>>
>> On Wed, Oct 9, 2019 at 11:38 PM Aleksandar Markovic <aleksandar.m.mail@g=
mail.com> wrote:
>>>
>>>
>>> 23.09.2019. 15.29, "Michael Rolnik" <mrolnik@gmail.com> =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>> >
>>> > Hi all,
>>> >
>>> > is there any hope this will be ever pulled?
>>> >
>>> > regards,
>>> > Michael
>>> >
>>>
>>> Hello, Michael.
>>>
>>> I am practically new to your series, even though it is v31. Could you p=
erhaps include links to any documentation that you think it can be pertinen=
t to your solution (I apologize if you already did it somewhere else)?
>>>
>>> I do admire your persistence.
>>>
>>> Yours, Aleksandar
>>>
>>> > On Sun, Sep 15, 2019 at 3:20 PM Michael Rolnik <mrolnik@gmail.com> wr=
ote:
>>> >>
>>> >> This series of patches adds 8bit AVR cores to QEMU.
>>> >> All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not ful=
ly tested yet.
>>> >> However I was able to execute simple code with functions. e.g fibona=
cci calculation.
>>> >> This series of patches include a non real, sample board.
>>> >> No fuses support yet. PC is set to 0 at reset.
>>> >>
>>> >> the patches include the following
>>> >> 1. just a basic 8bit AVR CPU, without instruction decoding or transl=
ation
>>> >> 2. CPU features which allow define the following 8bit AVR cores
>>> >>      avr1
>>> >>      avr2 avr25
>>> >>      avr3 avr31 avr35
>>> >>      avr4
>>> >>      avr5 avr51
>>> >>      avr6
>>> >>      xmega2 xmega4 xmega5 xmega6 xmega7
>>> >> 3. a definition of sample machine with SRAM, FLASH and CPU which all=
ows to execute simple code
>>> >> 4. encoding for all AVR instructions
>>> >> 5. interrupt handling
>>> >> 6. helpers for IN, OUT, SLEEP, WBR & unsupported instructions
>>> >> 7. a decoder which given an opcode decides what istruction it is
>>> >> 8. translation of AVR instruction into TCG
>>> >> 9. all features together
>>> >>
>>> >> changes since v3
>>> >> 1. rampD/X/Y/Z registers are encoded as 0x00ff0000 (instead of 0x000=
000ff) for faster address manipulaton
>>> >> 2. ffs changed to ctz32
>>> >> 3. duplicate code removed at avr_cpu_do_interrupt
>>> >> 4. using andc instead of not + and
>>> >> 5. fixing V flag calculation in varios instructions
>>> >> 6. freeing local variables in PUSH
>>> >> 7. tcg_const_local_i32 -> tcg_const_i32
>>> >> 8. using sextract32 instead of my implementation
>>> >> 9. fixing BLD instruction
>>> >> 10.xor(r) instead of 0xff - r at COM
>>> >> 11.fixing MULS/MULSU not to modify inputs' content
>>> >> 12.using SUB for NEG
>>> >> 13.fixing tcg_gen_qemu_ld/st call in XCH
>>> >>
>>> >> changes since v4
>>> >> 1. target is now defined as big endian in order to optimize push_ret=
/pop_ret
>>> >> 2. all style warnings are fixed
>>> >> 3. adding cpu_set/get_sreg functions
>>> >> 4. simplifying gen_goto_tb as there is no real paging
>>> >> 5. env->pc -> env->pc_w
>>> >> 6. making flag dump more compact
>>> >> 7. more spacing
>>> >> 8. renaming CODE/DATA_INDEX -> MMU_CODE/DATA_IDX
>>> >> 9. removing avr_set_feature
>>> >> 10. SPL/SPH set bug fix
>>> >> 11. switching stb_phys to cpu_stb_data
>>> >> 12. cleaning up avr_decode
>>> >> 13. saving sreg, rampD/X/Y/Z, eind in HW format (savevm)
>>> >> 14. saving CPU features (savevm)
>>> >>
>>> >> changes since v5
>>> >> 1. BLD bug fix
>>> >> 2. decoder generator is added
>>> >>
>>> >> chages since v6
>>> >> 1. using cpu_get_sreg/cpu_set_sreg in avr_cpu_gdb_read_register/avr_=
cpu_gdb_write_register
>>> >> 2. configure the target as little endian because otherwise GDB does =
not work
>>> >> 3. fixing and testing gen_push_ret/gen_pop_ret
>>> >>
>>> >> changes since v7
>>> >> 1. folding back v6
>>> >> 2. logging at helper_outb and helper_inb are done for non supported =
yet registers only
>>> >> 3. MAINTAINERS updated
>>> >>
>>> >> changes since v8
>>> >> 1. removing hw/avr from hw/Makefile.obj as it should not be built fo=
r all
>>> >> 2. making linux compilable
>>> >> 3. testing on
>>> >>     a. Mac, Apple LLVM version 7.0.0
>>> >>     b. Ubuntu 12.04, gcc 4.9.2
>>> >>     c. Fedora 23, gcc 5.3.1
>>> >> 4. folding back some patches
>>> >> 5. translation bug fixes for ORI, CPI, XOR instructions
>>> >> 6. propper handling of cpu register writes though memory
>>> >>
>>> >> changes since v9
>>> >> 1. removing forward declarations of static functions
>>> >> 2. disabling debug prints
>>> >> 3. switching to case range instead of if else if ...
>>> >> 4. LD/ST IN/OUT accessing CPU maintainder registers are not routed t=
o any device
>>> >> 5. commenst about sample board and sample IO device added
>>> >> 6. sample board description is more descriptive now
>>> >> 7. memory_region_allocate_system_memory is used to create RAM
>>> >> 8. now there are helper_fullrd & helper_fullwr when LD/ST try to acc=
ess registers
>>> >>
>>> >> changes since v10
>>> >> 1. movig back fullwr & fullrd into the commit where outb and inb wer=
e introduced
>>> >> 2. changing tlb_fill function signature
>>> >> 3. adding empty line between functions
>>> >> 4. adding newline on the last line of the file
>>> >> 5. using tb->flags to generae full access ST/LD instructions
>>> >> 6. fixing SBRC bug
>>> >> 7. folding back 10th commit
>>> >> 8. whenever a new file is introduced it's added to Makefile.objs
>>> >>
>>> >> changes since v11
>>> >> 1. updating to v2.7.0-rc
>>> >> 2. removing assignment to env->fullacc from gen_intermediate_code
>>> >>
>>> >> changes since v12
>>> >> 1. fixing spacing
>>> >> 2. fixing get/put_segment functions
>>> >> 3. removing target-avr/machine.h file
>>> >> 4. VMSTATE_SINGLE_TEST -> VMSTATE_SINGLE
>>> >> 5. comment spelling
>>> >> 6. removing hw/avr/sample_io.c
>>> >> 7. char const* -> const char*
>>> >> 8. proper ram allocation
>>> >> 9. fixing breakpoint functionality.
>>> >> 10.env1 -> env
>>> >> 11.fixing avr_cpu_gdb_write_register & avr_cpu_gdb_read_register fun=
ctions
>>> >> 12.any cpu is removed
>>> >> 12.feature bits are not saved into vm state
>>> >>
>>> >> changes since v13
>>> >> 1. rebasing to v2.7.0-rc1
>>> >>
>>> >> changes since v14
>>> >> 1. I made self review with git gui tool. (I did not know such a thin=
g exists)
>>> >> 2. removing all double/tripple spaces
>>> >> 3. removing comment reference to SampleIO
>>> >> 4. folding back some changes, so there is not deleted lines in my co=
de
>>> >> 5. moving avr configuration, within configure file, before chris
>>> >>
>>> >> changes since v15
>>> >> 1. removing IO registers cache from CPU
>>> >> 2. implementing CBI/SBI as read(helper_inb), modify, write(helper_ou=
tb)
>>> >> 3. implementing CBIC/SBIC as read(helper_inb), check, branch
>>> >> 4. adding missing tcg_temp_free_i32 for tcg_const_i32
>>> >>
>>> >> changes since v16
>>> >> 1. removing EXT IO registers knoledge from CPU. These registers are =
accessible
>>> >>    by LD/ST only. CPU has no interest in them
>>> >>
>>> >> changes since v17 (by Richard Henderson)
>>> >> This is Michael's v17, with some adjustments of my own:
>>> >>
>>> >> 1. Fix the whitespace errors reported by "git am",
>>> >> 2. Replace the utf-8 characters with normal ascii,
>>> >> 3. Ditch the separate compilation of translate.c.
>>> >>
>>> >> I retained the two separate files that could be regenerated
>>> >> from the included cpugen program, but merged in translate-insn.c.
>>> >> Not that it matters, but the code generated is about 3k smaller.
>>> >>
>>> >> changes since v18
>>> >> 1.  moving target-avr into target/avr
>>> >> 2.  do not call cpu_exec_initfn function from avr_cpu_initfn
>>> >> 3.  call cpu_exec_realizefn avr_cpu_realizefn
>>> >> 4.  do not fail sample machine creation if no rom is suplied
>>> >> 5.  add tcg_gen_exit_tb(0) for BS_BRANCH in gen_intermediate_code
>>> >> 6.  fix a register getters/setters in machine.c
>>> >> 7.  changing QEMU_ARCH_AVR from 1<<17 to 1<<18
>>> >>
>>> >> changes since v19
>>> >> 1.  use decodetree.py tool to decode instructions
>>> >> 2.  adding USART
>>> >> 3.  adding 16 bit timer peripherals
>>> >> 4.  changing QEMU_ARCH_AVR from 1<<18 to 1<<20
>>> >> 5.  renaming tlb_fill to avr_cpu_tlb_fill
>>> >>
>>> >> changes since v20
>>> >> 1.  use one CPU naming convention
>>> >> 2.  merging insn16.decode & insn32.decode files
>>> >> 3.  modifying skip next instruction mechanizm
>>> >> 4.  translate BREAK as NOP for now
>>> >>
>>> >> changes since v21
>>> >> 1.  Reorganize bstate.
>>> >>     This will make transition to <exec/translator.h> easier, and fix=
es a couple of bugs wrt single stepping
>>> >>     by richard.henderson@linaro.org
>>> >> 2.  Drop cpc and fix page cross condition.
>>> >>     by richard.henderson@linaro.org
>>> >> 3.  Refactor checking supported/unsupported instructions
>>> >> 4.  Add gdb-xml/avr-cpu.xml
>>> >>
>>> >> changes since v22
>>> >> 1.  Rebase
>>> >> 2.  Split long comment
>>> >>
>>> >> changes since v23
>>> >> 1.  remove avr_cpu_list_compare function
>>> >> 2.  modify avr_cpu_class_by_name function
>>> >> 3.  modify avr_cpu_list_entry function
>>> >> 4.  modify avr_cpu_list function
>>> >>
>>> >> changes since v24
>>> >> 1.  remove AVR_CPU_TYPE_NAME macro
>>> >>
>>> >> changes since v25
>>> >> 1.  fix patches. every file belong to one patch only
>>> >> 2.  change copyright year from 2016 to 2019
>>> >> 3.  create mask device to emulate prr0/prr1
>>> >>
>>> >> changes since v26
>>> >> 1.  add avocado acceptence test
>>> >> 2.  add boot serial test
>>> >>
>>> >> changes since v27
>>> >> 1.  list atmel2560 devices as unimplemented
>>> >> 2.  fix sram base/size
>>> >>
>>> >> changes since v28
>>> >> 1.  rebase
>>> >> 2.  fix includes & build
>>> >>
>>> >> changes since v29
>>> >> 1.  fixing ownership
>>> >> 2.  using 'since' instread of 'added in'
>>> >>
>>> >> changes since v30
>>> >> 1.  rebase
>>> >>
>>> >> Michael Rolnik (7):
>>> >>   target/avr: Add outward facing interfaces and core CPU logic
>>> >>   target/avr: Add instruction helpers
>>> >>   target/avr: Add instruction decoding
>>> >>   target/avr: Add instruction translation
>>> >>   target/avr: Add example board configuration
>>> >>   target/avr: Register AVR support with the rest of QEMU, the build
>>> >>     system, and the MAINTAINERS file
>>> >>   target/avr: Add tests
>>> >>
>>> >> Sarah Harris (1):
>>> >>   target/avr: Add limited support for USART and 16 bit timer periphe=
rals
>>> >>
>>> >>  MAINTAINERS                      |    6 +
>>> >>  arch_init.c                      |    2 +
>>> >>  configure                        |   89 +-
>>> >>  default-configs/avr-softmmu.mak  |    5 +
>>> >>  gdb-xml/avr-cpu.xml              |   49 +
>>> >>  hw/Kconfig                       |    1 +
>>> >>  hw/avr/Kconfig                   |    6 +
>>> >>  hw/avr/Makefile.objs             |    1 +
>>> >>  hw/avr/sample.c                  |  282 +++
>>> >>  hw/char/Kconfig                  |    3 +
>>> >>  hw/char/Makefile.objs            |    1 +
>>> >>  hw/char/avr_usart.c              |  324 ++++
>>> >>  hw/misc/Kconfig                  |    3 +
>>> >>  hw/misc/Makefile.objs            |    2 +
>>> >>  hw/misc/avr_mask.c               |  112 ++
>>> >>  hw/timer/Kconfig                 |    3 +
>>> >>  hw/timer/Makefile.objs           |    1 +
>>> >>  hw/timer/avr_timer16.c           |  605 +++++++
>>> >>  include/disas/dis-asm.h          |    6 +
>>> >>  include/hw/char/avr_usart.h      |   97 +
>>> >>  include/hw/misc/avr_mask.h       |   47 +
>>> >>  include/hw/timer/avr_timer16.h   |   97 +
>>> >>  include/sysemu/arch_init.h       |    1 +
>>> >>  qapi/machine.json                |    3 +-
>>> >>  target/avr/Makefile.objs         |   33 +
>>> >>  target/avr/cpu-param.h           |   37 +
>>> >>  target/avr/cpu-qom.h             |   54 +
>>> >>  target/avr/cpu.c                 |  576 ++++++
>>> >>  target/avr/cpu.h                 |  254 +++
>>> >>  target/avr/gdbstub.c             |   85 +
>>> >>  target/avr/helper.c              |  354 ++++
>>> >>  target/avr/helper.h              |   29 +
>>> >>  target/avr/insn.decode           |  175 ++
>>> >>  target/avr/machine.c             |  121 ++
>>> >>  target/avr/translate.c           | 2888 +++++++++++++++++++++++++++=
+++
>>> >>  tests/Makefile.include           |    2 +
>>> >>  tests/acceptance/machine_avr6.py |   36 +
>>> >>  tests/boot-serial-test.c         |   10 +
>>> >>  tests/machine-none-test.c        |    1 +
>>> >>  39 files changed, 6359 insertions(+), 42 deletions(-)
>>> >>  create mode 100644 default-configs/avr-softmmu.mak
>>> >>  create mode 100644 gdb-xml/avr-cpu.xml
>>> >>  create mode 100644 hw/avr/Kconfig
>>> >>  create mode 100644 hw/avr/Makefile.objs
>>> >>  create mode 100644 hw/avr/sample.c
>>> >>  create mode 100644 hw/char/avr_usart.c
>>> >>  create mode 100644 hw/misc/avr_mask.c
>>> >>  create mode 100644 hw/timer/avr_timer16.c
>>> >>  create mode 100644 include/hw/char/avr_usart.h
>>> >>  create mode 100644 include/hw/misc/avr_mask.h
>>> >>  create mode 100644 include/hw/timer/avr_timer16.h
>>> >>  create mode 100644 target/avr/Makefile.objs
>>> >>  create mode 100644 target/avr/cpu-param.h
>>> >>  create mode 100644 target/avr/cpu-qom.h
>>> >>  create mode 100644 target/avr/cpu.c
>>> >>  create mode 100644 target/avr/cpu.h
>>> >>  create mode 100644 target/avr/gdbstub.c
>>> >>  create mode 100644 target/avr/helper.c
>>> >>  create mode 100644 target/avr/helper.h
>>> >>  create mode 100644 target/avr/insn.decode
>>> >>  create mode 100644 target/avr/machine.c
>>> >>  create mode 100644 target/avr/translate.c
>>> >>  create mode 100644 tests/acceptance/machine_avr6.py
>>> >>
>>> >> --
>>> >> 2.17.2 (Apple Git-113)
>>> >>
>>> >
>>> >
>>> > --
>>> > Best Regards,
>>> > Michael Rolnik
>>
>>
>>
>> --
>> Best Regards,
>> Michael Rolnik



--=20
Best Regards,
Michael Rolnik

