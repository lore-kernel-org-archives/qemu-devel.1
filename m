Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFF8C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD5120714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NstzARYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD5120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Pn1-0005HB-NR
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 02:16:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1Plh-0004ek-Sd
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:15:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1Plf-0004jE-79
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:15:36 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56634
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1Ple-0004iN-Rd
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581405334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jLJ00CpqfK65Bt1WbWza5t6IencBm/NPpGwzHrzVtGI=;
 b=NstzARYYa5uNn7/ZK/Zh0uYhSubmn8SmhNMvIpnpFYZl2Fyt/H8T8A7V7j4YJkFu8a4LHD
 xWItywod3GVIBOgFkDJLDlfgahfamRdKw7Tq/Led5dhwDuqyzUorExA2pxuIOSfYqPr/2z
 t5RaMrP5dQKY+QlKUeeW/tsjuIahZSw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-Gquhl5xrNQaMMpAcNG3Vrw-1; Tue, 11 Feb 2020 02:15:29 -0500
Received: by mail-wm1-f72.google.com with SMTP id b133so685605wmb.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 23:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jLJ00CpqfK65Bt1WbWza5t6IencBm/NPpGwzHrzVtGI=;
 b=epAQq1KZ6DZex3XLH56KLXcFo9EYOcrMouIyW3o5Lk5nlMcMc2PBfxH2NiV1sN1BQF
 4UK8/RLHOWDOCdYbdiC05ztoLkaGCvQlZG0fNzVbzKOn9KzY/fMMnIOIxEGGTwbRVmp+
 rh4wBqP2IuMSmqnzEIn3Qb5RxqCy4rrOL5erhKmzgiHg1xNuObhZeNIB12vXnFFp2mbP
 +Ye2YVzvxzGc63TENHLODx3AEd5+4nXrP/4KbuclF8D99Zr4LBwCOUNTog9NUwM1EbMf
 L8RAOfWNbQDta1KsUQxFYjyqX8vmcfSDt1rQRROhejyTBAc/KmTLkXmvI0QCzZClQvfQ
 kp7A==
X-Gm-Message-State: APjAAAXtBtl2ejprg5TFKJnV7GfofsfqNV7G9uA9818RhuwxviJaTHMH
 rq7oVnf7kYfIovNURQ0JZULWsmOyL3sxAp17H7Dm4y6emmPgK5lj+4OKIHrTgMOc5cFihRBMrq7
 HqtK9BpIZoqy0eTQ=
X-Received: by 2002:a1c:a515:: with SMTP id o21mr3857334wme.85.1581405328693; 
 Mon, 10 Feb 2020 23:15:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqzN+xQZzJWRKNBwxkIlmVLMP4docAC89LdMXFCY4lUHjQA95+CFHATKycfbIIvDGbegLO9OaQ==
X-Received: by 2002:a1c:a515:: with SMTP id o21mr3857296wme.85.1581405328277; 
 Mon, 10 Feb 2020 23:15:28 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id l17sm3824960wro.77.2020.02.10.23.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 23:15:27 -0800 (PST)
Subject: Re: [RFC PATCH 52/66] Hexagon build infrastructure
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-53-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b697b2ec-97e6-b198-ff16-8e235f4b1e1b@redhat.com>
Date: Tue, 11 Feb 2020 08:15:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581381644-13678-53-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-MC-Unique: Gquhl5xrNQaMMpAcNG3Vrw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On 2/11/20 1:40 AM, Taylor Simpson wrote:
> Add file to default-configs
> Change configure
> Add target/hexagon/Makefile.objs
> Change scripts/qemu-binfmt-conf.sh
> Modify tests/tcg/configure.sh
> Add reference files to tests/tcg/hexagon
> 
> At this point in the patch series, you can build a hexagon-linux-user target
> and run programs on the Hexagon scalar core.  With hexagon-linux-clang
> installed, "make check-tcg TIMEOUT=60" will pass.
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>   configure                              |   9 +
>   default-configs/hexagon-linux-user.mak |   1 +
>   scripts/qemu-binfmt-conf.sh            |   6 +-
>   target/hexagon/Makefile.objs           | 103 +++++
>   tests/tcg/configure.sh                 |   4 +-
>   tests/tcg/hexagon/float_convs.ref      | 748 ++++++++++++++++++++++++++++++++
>   tests/tcg/hexagon/float_madds.ref      | 768 +++++++++++++++++++++++++++++++++
>   7 files changed, 1637 insertions(+), 2 deletions(-)
>   create mode 100644 default-configs/hexagon-linux-user.mak
>   create mode 100644 target/hexagon/Makefile.objs
>   create mode 100644 tests/tcg/hexagon/float_convs.ref
>   create mode 100644 tests/tcg/hexagon/float_madds.ref
> 
> diff --git a/configure b/configure
> index 115dc38..84841be 100755
> --- a/configure
> +++ b/configure
> @@ -7774,6 +7774,12 @@ case "$target_name" in
>       bflt="yes"
>       mttcg="yes"
>     ;;
> +  hexagon)
> +    TARGET_BASE_ARCH=hexagon
> +    TARGET_ABI_DIR=hexagon
> +    mttcg=yes
> +    target_compiler=$cross_cc_hexagon
> +  ;;
>     *)
>       error_exit "Unsupported target CPU"
>     ;;
> @@ -7937,6 +7943,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
>     xtensa*)
>       disas_config "XTENSA"
>     ;;
> +  hexagon)
> +    disas_config "HEXAGON"
> +  ;;
>     esac
>   done
>   if test "$tcg_interpreter" = "yes" ; then
> diff --git a/default-configs/hexagon-linux-user.mak b/default-configs/hexagon-linux-user.mak
> new file mode 100644
> index 0000000..ad55af0
> --- /dev/null
> +++ b/default-configs/hexagon-linux-user.mak
> @@ -0,0 +1 @@
> +# Default configuration for hexagon-linux-user
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index 9f1580a..7b5d54b 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -4,7 +4,7 @@
>   qemu_target_list="i386 i486 alpha arm armeb sparc sparc32plus sparc64 \
>   ppc ppc64 ppc64le m68k mips mipsel mipsn32 mipsn32el mips64 mips64el \
>   sh4 sh4eb s390x aarch64 aarch64_be hppa riscv32 riscv64 xtensa xtensaeb \
> -microblaze microblazeel or1k x86_64"
> +microblaze microblazeel or1k x86_64 hexagon"
>   
>   i386_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x03\x00'
>   i386_mask='\xff\xff\xff\xff\xff\xfe\xfe\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
> @@ -136,6 +136,10 @@ or1k_magic='\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\
>   or1k_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff'
>   or1k_family=or1k
>   
> +hexagon_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\xa4\x00'
> +hexagon_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
> +hexagon_family=hexagon
> +
>   qemu_get_family() {
>       cpu=${HOST_ARCH:-$(uname -m)}
>       case "$cpu" in
> diff --git a/target/hexagon/Makefile.objs b/target/hexagon/Makefile.objs
> new file mode 100644
> index 0000000..efcf510
> --- /dev/null
> +++ b/target/hexagon/Makefile.objs
> @@ -0,0 +1,103 @@
> +obj-y += \
> +    cpu.o \
> +    translate.o \
> +    op_helper.o \
> +    gdbstub.o \
> +    genptr.o \
> +    reg_fields.o \
> +    decode.o \
> +    iclass.o \
> +    opcodes.o \
> +    printinsn.o \
> +    arch.o \
> +    fma_emu.o \
> +    conv_emu.o
> +
> +#
> +#  Step 1
> +#  We use a C program to create semantics_generated.pyinc
> +#
> +GEN_SEMANTICS = gen_semantics
> +GEN_SEMANTICS_SRC = $(SRC_PATH)/target/hexagon/gen_semantics.c
> +
> +IDEF_FILES = \
> +    $(SRC_PATH)/target/hexagon/imported/alu.idef \
> +    $(SRC_PATH)/target/hexagon/imported/branch.idef \
> +    $(SRC_PATH)/target/hexagon/imported/compare.idef \
> +    $(SRC_PATH)/target/hexagon/imported/float.idef \
> +    $(SRC_PATH)/target/hexagon/imported/ldst.idef \
> +    $(SRC_PATH)/target/hexagon/imported/mpy.idef \
> +    $(SRC_PATH)/target/hexagon/imported/shift.idef \
> +    $(SRC_PATH)/target/hexagon/imported/subinsns.idef \
> +    $(SRC_PATH)/target/hexagon/imported/system.idef
> +DEF_FILES = \
> +    $(SRC_PATH)/target/hexagon/imported/allidefs.def \
> +    $(SRC_PATH)/target/hexagon/imported/macros.def
> +
> +$(GEN_SEMANTICS): $(GEN_SEMANTICS_SRC) $(IDEF_FILES) $(DEF_FILES)
> +	$(CC) $(CFLAGS) $(GEN_SEMANTICS_SRC) -o $(GEN_SEMANTICS)
> +
> +SEMANTICS=semantics_generated.pyinc
> +$(SEMANTICS): $(GEN_SEMANTICS)
> +	$(call quiet-command, \
> +	    $(GEN_SEMANTICS) $(SEMANTICS), \
> +	    "GEN", $(SEMANTICS))
> +
> +#
> +# Step 2
> +# We use the do_qemu.py script to generate the following files
> +#
> +QEMU_DEF_H = $(BUILD_DIR)/hexagon-linux-user/qemu_def_generated.h
> +QEMU_WRAP_H = $(BUILD_DIR)/hexagon-linux-user/qemu_wrap_generated.h
> +OPCODES_DEF_H = $(BUILD_DIR)/hexagon-linux-user/opcodes_def_generated.h
> +OP_ATTRIBS_H = $(BUILD_DIR)/hexagon-linux-user/op_attribs_generated.h
> +OP_REGS_H = $(BUILD_DIR)/hexagon-linux-user/op_regs_generated.h
> +PRINTINSN_H = $(BUILD_DIR)/hexagon-linux-user/printinsn_generated.h
> +
> +GENERATED_HEXAGON_FILES = \
> +    $(QEMU_DEF_H) \
> +    $(QEMU_WRAP_H) \
> +    $(OPCODES_DEF_H) \
> +    $(OP_ATTRIBS_H) \
> +    $(OP_REGS_H) \
> +    $(PRINTINSN_H)
> +
> +$(GENERATED_HEXAGON_FILES): \
> +    $(SRC_PATH)/target/hexagon/do_qemu.py \
> +    $(SEMANTICS) \
> +    $(SRC_PATH)/target/hexagon/attribs_def.h
> +	$(call quiet-command, \
> +	    $(SRC_PATH)/target/hexagon/do_qemu.py \
> +                $(SEMANTICS) \
> +                $(SRC_PATH)/target/hexagon/attribs_def.h, \
> +	    "GEN", "Hexagon generated files")
> +
> +#
> +# Step 3
> +# We use a C program to create iset.py which is imported into dectree.py
> +# to create the decode tree
> +#
> +GEN_DECTREE_IMPORT=gen_dectree_import
> +GEN_DECTREE_IMPORT_SRC = $(SRC_PATH)/target/hexagon/gen_dectree_import.c
> +
> +$(GEN_DECTREE_IMPORT): $(GEN_DECTREE_IMPORT_SRC) $(GENERATED_HEXAGON_FILES)
> +	$(CC) $(CFLAGS) -I$(BUILD_DIR)/hexagon-linux-user $(GEN_DECTREE_IMPORT_SRC) -o $(GEN_DECTREE_IMPORT)
> +
> +DECTREE_IMPORT=iset.py
> +$(DECTREE_IMPORT): $(GEN_DECTREE_IMPORT)
> +	$(call quiet-command, \
> +	    $(GEN_DECTREE_IMPORT) $(DECTREE_IMPORT), \
> +	    "GEN", $(DECTREE_IMPORT))
> +
> +#
> +# Step 4
> +# We use the dectree.py script to generate the decode tree header file
> +#
> +DECTREE_HEADER=dectree_generated.h
> +$(DECTREE_HEADER): $(SRC_PATH)/target/hexagon/dectree.py $(DECTREE_IMPORT)
> +	$(call quiet-command, \
> +	    $(SRC_PATH)/target/hexagon/dectree.py \
> +                $(BUILD_DIR)/hexagon-linux-user, \
> +	    "GEN", "Hexagon decode tree")
> +
> +generated-files-y += $(GENERATED_HEXAGON_FILES) $(DECTREE_HEADER)

I had to make this change to get it work (I only build out-of-tree):

-- >8 --
--- a/target/hexagon/Makefile.objs
+++ b/target/hexagon/Makefile.objs
@@ -46,7 +46,7 @@ $(GEN_SEMANTICS): $(GEN_SEMANTICS_SRC) $(IDEF_FILES) 
$(DEF_FILES)
  SEMANTICS=semantics_generated.pyinc
  $(SEMANTICS): $(GEN_SEMANTICS)
         $(call quiet-command, \
-           $(GEN_SEMANTICS) $(SEMANTICS), \
+           $(BUILD_DIR)/hexagon-linux-user/$(GEN_SEMANTICS) $(SEMANTICS), \
             "GEN", $(SEMANTICS))

  #
@@ -92,7 +92,7 @@ $(GEN_DECTREE_IMPORT): $(GEN_DECTREE_IMPORT_SRC) 
$(GENERATED_HEXAGON_FILES)
  DECTREE_IMPORT=iset.py
  $(DECTREE_IMPORT): $(GEN_DECTREE_IMPORT)
         $(call quiet-command, \
-           $(GEN_DECTREE_IMPORT) $(DECTREE_IMPORT), \
+           $(BUILD_DIR)/hexagon-linux-user/$(GEN_DECTREE_IMPORT) 
$(DECTREE_IMPORT), \
             "GEN", $(DECTREE_IMPORT))

---

(You might declare BUILD_USER_DIR=$(BUILD_DIR)/hexagon-linux-user to 
make it shorter).


