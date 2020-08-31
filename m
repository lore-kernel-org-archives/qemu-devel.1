Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5BDC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 13:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6294120719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 13:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjXIi9xj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6294120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCkFu-00079F-Kf
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 09:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mrezanin@redhat.com>)
 id 1kCkFG-0006jD-P7
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 09:53:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43676
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mrezanin@redhat.com>)
 id 1kCkFE-0004BG-Qx
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 09:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598881983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iVrx2ruTrE0lQFLtjHlpio0CNO4Cgn0iCz4eGHn+f4A=;
 b=bjXIi9xjn9SxxnevxOxneRYakxMjT2EUPjlQMOMl2rXLK1+JtzQv/335SQGH1AHF3D/Cyc
 enKu0NFzARVWgcYIBqbv05QvkDnjLWy4kxjjCwyqw+bN/P5+XpET9iKjHY4yFJg+Ri3SyG
 HBkVy601PlgWNt6oWTatb1Kg554ae8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-u1SVZqxNP8209eOwvlEy_Q-1; Mon, 31 Aug 2020 09:50:44 -0400
X-MC-Unique: u1SVZqxNP8209eOwvlEy_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6BC264099
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 13:50:43 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C03FC60C15
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 13:50:43 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id A020018A0B64;
 Mon, 31 Aug 2020 13:50:43 +0000 (UTC)
Date: Mon, 31 Aug 2020 09:50:43 -0400 (EDT)
From: Miroslav Rezanina <mrezanin@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1852476053.10659890.1598881843372.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200831125645.29331-1-pbonzini@redhat.com>
References: <20200831125645.29331-1-pbonzini@redhat.com>
Subject: Re: [PATCH] build: fix recurse-all target
MIME-Version: 1.0
X-Originating-IP: [10.40.192.14, 10.4.195.20]
Thread-Topic: build: fix recurse-all target
Thread-Index: orlGt6KlrqzmiibXZTJDuDQDCEbj8g==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mrezanin@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mrezanin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 02:13:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

----- Original Message -----
> From: "Paolo Bonzini" <pbonzini@redhat.com>
> To: qemu-devel@nongnu.org
> Cc: thuth@redhat.com, "Miroslav Rezanina" <mrezanin@redhat.com>
> Sent: Monday, August 31, 2020 2:56:45 PM
> Subject: [PATCH] build: fix recurse-all target
> 
> The missing "/all" suffix prevents the pc-bios/ parts of the build
> from running.
> 
> In the meanwhile, -Wall has moved from QEMU_CFLAGS to CFLAGS.  Simplify
> everything by not passing down CFLAGS, and add -Wall in the recursive
> Makefiles.
> 
> Reported-by: Miroslav Rezanina <mrezanin@redhat.com>
> Fixes: 5e6d1573b4 ("remove Makefile.target", 2020-08-21)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile                   | 4 ++--
>  pc-bios/optionrom/Makefile | 8 ++------
>  pc-bios/s390-ccw/Makefile  | 3 ++-
>  3 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 27bf8156ec..7230f0f1f3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -186,10 +186,10 @@ ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix
> /$(t), $(ROM_DIRS)))
>  # Only keep -O and -g cflags
>  .PHONY: $(ROM_DIRS_RULES)
>  $(ROM_DIRS_RULES):
> -	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)"
> TARGET_DIR="$(dir $@)" CFLAGS="$(filter -O% -g%,$(CFLAGS))" $(notdir $@),)
> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)"
> TARGET_DIR="$(dir $@)" $(notdir $@),)
>  
>  .PHONY: recurse-all recurse-clean
> -recurse-all: $(ROM_DIRS)
> +recurse-all: $(addsuffix /all, $(ROM_DIRS))
>  recurse-clean: $(addsuffix /clean, $(ROM_DIRS))
>  
>  ######################################################################
> diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
> index 51cb6ca9d8..6495802d9f 100644
> --- a/pc-bios/optionrom/Makefile
> +++ b/pc-bios/optionrom/Makefile
> @@ -8,15 +8,12 @@ all: multiboot.bin linuxboot.bin linuxboot_dma.bin
> kvmvapic.bin pvh.bin
>  	@true
>  
>  include ../../config-host.mak
> +CFLAGS = -O2 -g
>  
>  quiet-command = $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && $1,
>  @$1))
>  cc-option = $(if $(shell $(CC) $1 -S -o /dev/null -xc /dev/null >/dev/null
>  2>&1 && echo OK), $1, $2)
>  
> -# Compiling with no optimization creates ROMs that are too large
> -ifeq ($(lastword $(filter -O%, -O0 $(CFLAGS))),-O0)
> -override CFLAGS += -O2
> -endif
> -override CFLAGS += -march=i486
> +override CFLAGS += -march=i486 -Wall
>  
>  # Flags for dependency generation
>  override CPPFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d
> @@ -42,7 +39,6 @@ Wa = -Wa,
>  override ASFLAGS += -32
>  override CFLAGS += $(call cc-option, $(Wa)-32)
>  
> -
>  LD_I386_EMULATION ?= elf_i386
>  override LDFLAGS = -m $(LD_I386_EMULATION) -T $(SRC_DIR)/flat.lds
>  override LDFLAGS += $(LDFLAGS_NOPIE)
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index cc0f77baa6..3eb785048a 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -3,6 +3,7 @@ all: build-all
>  	@true
>  
>  include ../../config-host.mak
> +CFLAGS = -O2 -g
>  
>  quiet-command = $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && $1,
>  @$1))
>  cc-option = $(if $(shell $(CC) $1 -S -o /dev/null -xc /dev/null > /dev/null
>  \
> @@ -28,7 +29,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
>  OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o \
>  	  virtio.o virtio-scsi.o virtio-blkdev.o libc.o cio.o dasd-ipl.o
>  
> -QEMU_CFLAGS := $(filter -W%, $(QEMU_CFLAGS))
> +QEMU_CFLAGS := -Wall $(filter -W%, $(QEMU_CFLAGS))
>  QEMU_CFLAGS += -ffreestanding -fno-delete-null-pointer-checks -msoft-float
>  QEMU_CFLAGS += -march=z900 -fPIE -fno-strict-aliasing
>  QEMU_CFLAGS += -fno-asynchronous-unwind-tables
> --
> 2.26.2
> 
>

Missing roms built with the fix.

Reviewed-by: Miroslav Rezanina <mrezanin@redhat.com> 

-- 
Miroslav Rezanina
Software Engineer - Virtualization Team Maintainer


