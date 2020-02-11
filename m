Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D10C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 039F7206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMzpdVxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039F7206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1QN2-0005ox-RD
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 02:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1QMG-0004jQ-L8
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:53:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1QMD-0001gC-SB
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:53:24 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42486
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1QMD-0001fv-Mc
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581407601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EuhbZtJXe9ROODWKiL/xeNGvljVTEJEHgJqOABdGHtQ=;
 b=gMzpdVxZMe692Mrfy2zXnyCMRpWRh5A9oI5o7LJvdZmN+1tW84lzhis7AD/1oEifK8/xdS
 n0DefBIImgUQw9n6DWD8AWv4jKtkjiEb3cWXvzHbxg8pcioJU8RrnWaSbbyNCXeJtly9Pp
 2iHGsVsxKJMAgjco49qg5d3DAEg+byU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-wKhuxcexNnuABbuR_MpoxA-1; Tue, 11 Feb 2020 02:53:09 -0500
Received: by mail-wr1-f72.google.com with SMTP id r1so2425485wrc.15
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 23:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EuhbZtJXe9ROODWKiL/xeNGvljVTEJEHgJqOABdGHtQ=;
 b=oqI7wOXjS0vQAPkjZwNPKG4j3VR3wVan5bgPnjVkpwY+7gB7GKHb+JR8Pg/bdEc/0S
 p2sZxhd/IUuEno0Uu3TxMR3L82mtJlDVrfGU/dcRzRhdMw17QYlUk17mDKr7IM8/nb+S
 Vl/RY6L1ngsBcghKo87Vbel5DRellDCl7F1HuaGfDbgGdJ33ria2klp5ez87CDShTCqR
 XEX36LPJtSAFnhKgZ2K/bj47ntg+47PSETUgw6h/df0id0qGhsMKxpQf4NA8OIa2IL8v
 nvr7M+s4K1uXrgYx4yyB2S2MWOee1MRcm91FO3mvIjCUD8Bo8upMQbjD0Yk3+bGUEgHc
 0AYA==
X-Gm-Message-State: APjAAAUu+U3xOtdTU1O1Q9XnH71TMviXHIDy79L9nvjYJgiq94f4Hm4Z
 Dznyw9pAhQ74t9V6Pfajx06lu15/6oJTE5RisHrmeSXVU53QE8u2Tah+s7Scld58yQMoLwhKg+H
 dWJDiVbYKKdSLdkk=
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr7357421wrn.124.1581407588570; 
 Mon, 10 Feb 2020 23:53:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqxaDHPEfKDk17ZQX1OUfWHezNfuLCHBWvqW8BgIU1wCEy3v+wtXtACzHmXPXpm+2b343/z1ow==
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr7357362wrn.124.1581407588072; 
 Mon, 10 Feb 2020 23:53:08 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id f11sm2609579wml.3.2020.02.10.23.53.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 23:53:07 -0800 (PST)
Subject: Re: [RFC PATCH 00/66] Hexagon patch series
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ca723746-9e9a-c6e0-3836-221170874567@redhat.com>
Date: Tue, 11 Feb 2020 08:53:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-MC-Unique: wKhuxcexNnuABbuR_MpoxA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 1:39 AM, Taylor Simpson wrote:
> This series adds support for the Hexagon processor with Linux user support
> 
> Hexagon is Qualcomm's very long instruction word (VLIW) digital signal
> processor(DSP).  We also support Hexagon Vector eXtensions (HVX).  HVX
> is a wide vector coprocessor designed for high performance computer vision,
> image processing, machine learning, and other workloads.
> 
> This series of patches supports the following versions of the Hexagon core
>      Scalar core: v67
>      https://developer.qualcomm.com/downloads/qualcomm-hexagon-v67-programmer-s-reference-manual
>      HVX extension: v66
>      https://developer.qualcomm.com/downloads/qualcomm-hexagon-v66-hvx-programmer-s-reference-manual
> 
> We presented an overview of the project at the 2019 KVM Forum.
>      https://kvmforum2019.sched.com/event/Tmwc/qemu-hexagon-automatic-translation-of-the-isa-manual-pseudcode-to-tiny-code-instructions-of-a-vliw-architecture-niccolo-izzo-revng-taylor-simpson-qualcomm-innovation-center
> 
> The patches up to and including "Hexagon build infractructure" implement the
> base Hexagon core and the remainder add HVX.  Once the build infrastructure
> patch is applied, you can build and qemu will execute non-HVX Hexagon programs.
> 
> We have a parallel effort to make the Hexagon Linux toolchain publically
> available.
> 
> 
> *** Required patches ***
> 
> In order to build, we need this patch
>      https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg01203.html
> 
> In order to run pthread_cancel, we need this patch series
>      https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg00834.html
>      https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg00832.html
>      https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg00833.html
>      https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg00835.html
>      https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg00836.html
> 
> 
> *** Testing ***
> 
> The port passes the following tests
>      Directed unit tests
>      MUSL libc test suite (good coverage of Linux system calls)
>      Compiler intrinsics test suite (good coverage of instructions)
>      Hexagon machine learning library unit tests

Link/references please?

>      make check-tcg TIMEOUT=60
> 
> *** Known checkpatch issues ***
> 
> The following are known checkpatch errors in the series
>      include/disas/dis-asm.h             space prohibited
>          (Follow convention of other targets on prior lines)
>      target/hexagon/reg_fields.h         Complex macro
>      target/hexagon/attribs.h            Complex macro
>      target/hexagon/decode.c             Complex macro
>      target/hexagon/q6v_decode.c         Macro needs do - while
>      target/hexagon/printinsn.c          Macro needs do - while
>      target/hexagon/gen_semantics.c      Suspicious ; after while (0)
>      target/hexagon/gen_dectree_import.c Complex macro
>      target/hexagon/gen_dectree_import.c Suspicious ; after while (0)
>      target/hexagon/opcodes.c            Complex macro
>      target/hexagon/iclass.h             Complex macro
>      scripts/qemu-binfmt-conf.sh         Line over 90 characters
>      target/hexagon/mmvec/macros.h       Suspicious ; after while (0)
> 
> The following are known checkpatch warnings in the series
>      target/hexagon/fma_emu.c            Comments inside macro definition
>      scripts/qemu-binfmt-conf.sh         Line over 80 characters
> 
> 
> *** Tour of the code ***
> 
> The qemu-hexagon implementation is a combination of qemu and the Hexagon
> architecture library (aka archlib).  The three primary directories with
> Hexagon-specific code are
> 
>      qemu/target/hexagon
>          This has all the instruction and packet semantics
>      qemu/target/hexagon/imported
>          These files are imported with very little modification from archlib
>          *.idef                  Instruction semantics definition
>          macros.def              Mapping of macros to instruction attributes
>          encode*.def             Encoding patterns for each instruction
>          iclass.def              Instruction class definitions used to determine
>                                  legal VLIW slots for each instruction
>      qemu/linux-user/hexagon
>          Helpers for loading the ELF file and making Linux system calls,
>          signals, etc
> 
> We start with a script that generates qemu helper for each instruction.  This
> is a two step process.  The first step is to use the C preprocessor to expand
> macros inside the architecture definition files.  This is done in
> target/hexagon/semantics.c.  This step produces
>      <BUILD_DIR>/hexagon-linux-user/semantics_generated.pyinc.
> That file is consumed by the do_qemu.py script.  This script generates
> several files.  All of the generated files end in "_generated.*".  The
> primary file produced is
>      <BUILD_DIR>/hexagon-linux-user/qemu_def_generated.h
> 
> Qemu helper functions have 3 parts
>      DEF_HELPER declaration indicates the signature of the helper
>      gen_helper_<NAME> will generate a TCG call to the helper function
>      The helper implementation
> 
> In the qemu_def_generated.h file, there is a DEF_QEMU macro for each user-space
> instruction.  The file is included several times with DEF_QEMU defined
> differently, depending on the context.  The macro has four arguments
>      The instruction tag
>      The semantics_short code
>      DEF_HELPER declaration
>      Call to the helper
>      Helper implementation
> 
> Here's an example of the A2_add instruction.
>      Instruction tag        A2_add
>      Assembly syntax        "Rd32=add(Rs32,Rt32)"
>      Instruction semantics  "{ RdV=RsV+RtV;}"
> 
> By convention, the operands are identified by letter
>      RdV is the destination register
>      RsV, RtV are source registers
> 
> The generator uses the operand naming conventions (see large comment in
> do_qemu.py) to determine the signature of the helper function.  Here is the
> result for A2_add from qemu_def_generated.h
> 
> DEF_QEMU(A2_add,{ RdV=RsV+RtV;},
> #ifndef fWRAP_A2_add
> DEF_HELPER_3(A2_add, s32, env, s32, s32)
> #endif
> ,
> {
> /* A2_add */
> DECL_RREG_d(RdV, RdN, 0, 0);
> DECL_RREG_s(RsV, RsN, 1, 0);
> DECL_RREG_t(RtV, RtN, 2, 0);
> READ_RREG_s(RsV, RsN);
> READ_RREG_t(RtV, RtN);
> fWRAP_A2_add(
> do {
> gen_helper_A2_add(RdV, cpu_env, RsV, RtV);
> } while (0),
> { RdV=RsV+RtV;});
> WRITE_RREG_d(RdN, RdV);
> FREE_RREG_d(RdV);
> FREE_RREG_s(RsV);
> FREE_RREG_t(RtV);
> /* A2_add */
> },
> #ifndef fWRAP_A2_add
> int32_t HELPER(A2_add)(CPUHexagonState *env, int32_t RsV, int32_t RtV)
> {
> uint32_t slot = 4; slot = slot;
> int32_t RdV = 0;
> { RdV=RsV+RtV;}
> COUNT_HELPER(A2_add);
> return RdV;
> }
> #endif
> )
> 
> For each operand, there are macros for DECL, FREE, READ, WRITE.  These are
> defined in macros.h.  Note that we append the operand type to the macro name,
> which allows us to specialize the TCG code tenerated.  For read-only operands,
> DECL simply declares the TCGv variable (no need for tcg_temp_local_new()),
> and READ will assign from the TCGv corresponding to the GPR, and FREE doesn't
> have to do anything.  Also, note that the WRITE macros update the disassembly
> context to be processed when the packet commits (see "Packet Semantics" below).
> 
> Note the fWRAP_A2_add macro around the gen_helper call.  Each instruction has a fWRAP_<tag> macro that takes 2 arguments
>      gen_helper call
>      C semantics (aka short code)
> 
> This allows the code generator to override the auto-generated code.  In some
> cases this is necessary for correct execution.  We can also override for
> faster emulation.  For example, calling a helper for add is more expensive
> than generating a TCG add operation.
> 
> The qemu_wrap_generated.h file contains a default fWRAP_<tag> for each
> instruction.  The default is to invoke the gen_helper code.
>      #ifndef fWRAP_A2_add
>      #define fWRAP_A2_add(GENHLPR, SHORTCODE) GENHLPR
>      #endif
> 
> The helper_overrides.h file has any overrides. For example,
>      #define fWRAP_A2_add(GENHLPR, SHORTCODE) \
>          tcg_gen_add_tl(RdV, RsV, RtV)
> 
> This file is included twice
> 1) In genptr.c, it overrides the semantics of the desired instructions
> 2) In helper.h, it prevents the generation of helpers for overridden
>     instructions.  Notice the #ifndef fWRAP_A2_add above.
> 
> The instruction semantics C code heavily on macros.  In cases where the C
> semantics are specified only with macros, we can override the default with
> the short semantics option and #define the macros to generate TCG code.  One
> example is Y2_dczeroa (dc == data cache, zero == zero out the cache line,
> a == address: zero out the data cache line at the given address):
>      Instruction tag        Y2_dczeroa
>      Assembly syntax        "dczeroa(Rs32)"
>      Instruction semantics  "{fEA_REG(RsV); fDCZEROA(EA);}"
> 
> In helper_overrides.h, we use the shortcode
> #define fWRAP_Y2_dczeroa(GENHLPR, SHORTCODE) SHORTCODE
> 
> In other cases, just a little bit of wrapper code needs to be written.
>      #define fWRAP_tmp(SHORTCODE) \
>      { \
>          TCGv tmp = tcg_temp_new(); \
>          SHORTCODE; \
>          tcg_temp_free(tmp); \
>      }
> 
> For example, some load instructions use a temporary for address computation.
> The SL2_loadrd_sp instruction needs a temporary to hold the value of the stack
> pointer (r29)
>      Instruction tag        SL2_loadrd_sp
>      Assembly syntax        "Rdd8=memd(r29+#u5:3)"
>      Instruction semantics  "{fEA_RI(fREAD_SP(),uiV); fLOAD(1,8,u,EA,RddV);}"
> 
> In helper_overrides.h you'll see
>      #define fWRAP_SL2_loadrd_sp(GENHLPR, SHORTCODE)      fWRAP_tmp(SHORTCODE)
> 
> There are also cases where we brute force the TCG code generation.  The
> allocframe and deallocframe instructions are examples.  Other examples are
> instructions with multiple definitions.  These require special handling
> because qemu helpers can only return a single value.
> 
> In addition to instruction semantics, we use a generator to create the decode
> tree.  This generation is also a two step process.  The first step is to run
> target/hexagon/gen_dectree_import.c to produce
>      <BUILD_DIR>/hexagon-linux-user/iset.py
> This file is imported by target/hexagon/dectree.py to produce
>      <BUILD_DIR>/hexagon-linux-user/dectree_generated.h
> 
> *** Key Files ***
> 
> cpu.h
> 
> This file contains the definition of the CPUHexagonState struct.  It is the
> runtime information for each thread and contains stuff like the GPR and
> predicate registers.
> 
> macros.h
> mmvec/macros.h
> 
> The Hexagon arch lib relies heavily on macros for the instruction semantics.
> This is a great advantage for qemu because we can override them for different
> purposes.  You will also notice there are sometimes two definitions of a macro.
> The QEMU_GENERATE variable determines whether we want the macro to generate TCG
> code.  If QEMU_GENERATE is not defined, we want the macro to generate vanilla
> C code that will work in the helper implementation.
> 
> translate.c
> 
> The functions in this file generate TCG code for a translation block.  Some
> important functions in this file are
> 
>      gen_start_packet - initialize the data structures for packet semantics
>      gen_commit_packet - commit the register writes, stores, etc for a packet
>      decode_packet - disassemble a packet and generate code
> 
> genptr.c
> genptr_helpers.h
> helper_overrides.h
> 
> These file create a function for each instruction.  It is mostly composed of
> fWRAP_<tag> definitions followed by including qemu_def_generated.h.  The
> genptr_helpers.h file contains helper functions that are invoked by the macros
> in helper_overrides.h and macros.h
> 
> op_helper.c
> 
> This file contains the implementations of all the helpers.  There are a few
> general purpose helpers, but most of them are generated by including
> qemu_def_generated.h.  There are also several helpers used for debugging.
> 
> 
> *** Packet Semantics ***
> 
> VLIW packet semantics differ from serial semantics in that all input operands
> are read, then the operations are performed, then all the results are written.
> For exmaple, this packet performs a swap of registers r0 and r1
>      { r0 = r1; r1 = r0 }
> Note that the result is different if the instructions are executed serially.
> 
> Packet semantics dictate that we defer any changes of state until the entire
> packet is committed.  We record the results of each instruction in a side data
> structure, and update the visible processor state when we commit the packet.
> 
> The data structures are divided between the runtime state and the translation
> context.
> 
> During the TCG generation (see translate.[ch]), we use the DisasContext to
> track what needs to be done during packet commit.  Here are the relevant
> fields
> 
>      ctx_reg_log            list of registers written
>      ctx_reg_log_idx        index into ctx_reg_log
>      ctx_pred_log           list of predicates written
>      ctx_pred_log_idx       index into ctx_pred_log
>      ctx_store_width        width of stores (indexed by slot)
> 
> During runtime, the following fields in CPUHexagonState (see cpu.h) are used
> 
>      new_value             new value of a given register
>      reg_written           boolean indicating if register was written
>      new_pred_value        new value of a predicate register
>      new_pred_written      boolean indicating if predicate was written
>      mem_log_stores        record of the stores (indexed by slot)
> 
> For Hexagon Vector eXtensions (HVX), the following fields are used
> 
>      future_VRegs
>      tmp_VRegs
>      future_ZRegs
>      ZRegs_updated
>      VRegs_updated_tmp
>      VRegs_updated
>      VRegs_select
> 
> *** Debugging ***
> 
> You can turn on a lot of debugging by changing the HEX_DEBUG macro to 1 in
> internal.h.  This will stream a lot of information as it generates TCG and
> executes the code.
> 
> To track down nasty issues with Hexagon->TCG generation, we compare the
> execution results with actual hardware running on a Hexagon Linux target.
> Run qemu with the "-d cpu" option.  Then, we can diff the results and figure
> out where qemu and hardware behave differently.
> 
> The stacks are located at different locations.  We handle this by changing
> env->stack_adjust in translate.c.  First, set this to zero and run qemu.
> Then, change env->stack_adjust to the difference between the two stack
> locations.  Then rebuild qemu and run again. That will produce a very
> clean diff.
> 
> Here are some handy places to set breakpoints
> 
>      At the call to gen_start_packet for a given PC (note that the line number
>          might change in the future)
>          br translate.c:602 if ctx->base.pc_next == 0xdeadbeef
>      The helper function for each instruction is named helper_<TAG>, so here's
>          an example that will set a breakpoint at the start
>          br helper_V6_vgathermh
>      If you have the HEX_DEBUG macro set, the following will be useful
>          At the start of execution of a packet for a given PC
>              br helper_debug_start_packet if env->gpr[41] == 0xdeadbeef
>          At the end of execution of a packet for a given PC
>              br helper_debug_commit_end if env->this_PC == 0xdeadbeef

Most of this cover should go into a document in the repository, which 
might be the first patch of your series.

> 
> Taylor Simpson (66):
>    Hexagon Maintainers
>    Hexagon ELF Machine Definition
>    Hexagon CPU Scalar Core Definition
>    Hexagon register names
>    Hexagon Disassembler
>    Hexagon CPU Scalar Core Helpers
>    Hexagon GDB Stub
>    Hexagon instruction and packet types
>    Hexagon architecture types
>    Hexagon register fields
>    Hexagon instruction attributes
>    Hexagon register map
>    Hexagon instruction/packet decode
>    Hexagon instruction printing
>    Hexagon arch import - instruction semantics definitions
>    Hexagon arch import - macro definitions
>    Hexagon arch import - instruction encoding
>    Hexagon instruction class definitions
>    Hexagon instruction utility functions
>    Hexagon generator phase 1 - C preprocessor for semantics
>    Hexagon generator phase 2 - qemu_def_generated.h
>    Hexagon generator phase 2 - qemu_wrap_generated.h
>    Hexagon generator phase 2 - opcodes_def_generated.h
>    Hexagon generator phase 2 - op_attribs_generated.h
>    Hexagon generator phase 2 - op_regs_generated.h
>    Hexagon generator phase 2 - printinsn-generated.h
>    Hexagon generator phase 3 - C preprocessor for decode tree
>    Hexagon generater phase 4 - Decode tree
>    Hexagon opcode data structures
>    Hexagon macros to interface with the generator
>    Hexagon macros referenced in instruction semantics
>    Hexagon instruction classes
>    Hexagon TCG generation helpers - step 1
>    Hexagon TCG generation helpers - step 2
>    Hexagon TCG generation helpers - step 3
>    Hexagon TCG generation helpers - step 4
>    Hexagon TCG generation helpers - step 5
>    Hexagon TCG generation - step 01
>    Hexagon TCG generation - step 02
>    Hexagon TCG generation - step 03
>    Hexagon TCG generation - step 04
>    Hexagon TCG generation - step 05
>    Hexagon TCG generation - step 06
>    Hexagon TCG generation - step 07
>    Hexagon TCG generation - step 08
>    Hexagon TCG generation - step 09
>    Hexagon TCG generation - step 10
>    Hexagon TCG generation - step 11
>    Hexagon TCG generation - step 12

While the TCG patch subjects are not verbose, I appreciate how you split 
them into digestable patches.

>    Hexagon translation
>    Hexagon Linux user emulation
>    Hexagon build infrastructure
>    Hexagon - Add Hexagon Vector eXtensions (HVX) to core definition
>    Hexagon HVX support in gdbstub
>    Hexagon HVX import instruction encodings
>    Hexagon HVX import semantics
>    Hexagon HVX import macro definitions
>    Hexagon HVX semantics generator
>    Hexagon HVX instruction decoding
>    Hexagon HVX instruction utility functions
>    Hexagon HVX macros to interface with the generator
>    Hexagon HVX macros referenced in instruction semantics
>    Hexagon HVX helper to commit vector stores (masked and scatter/gather)
>    Hexagon HVX TCG generation
>    Hexagon HVX translation
>    Hexagon HVX build infrastructure


