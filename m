Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0269C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAFAB2077C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR1WFic2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFAB2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46089 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDthK-0004tg-J9
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:34:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtWh-0004VT-DO
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hDtWg-0003RC-93
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hDtWg-0003Qi-2f
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:23:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id p10so21738025wrq.1
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=GhKLXN4x2Bh28KK1khKEa4UYDz15n5B2iNQEOKiXWDU=;
	b=hR1WFic2qsFaBAdo1S5anNkuo4o4ECzVnVkmxzxdv7FkwkP/NmWX6o1Sj6x42PVrcl
	3K0JktEwwbY17r562rBY0eKg1YzOCsWjBxvyj4+aJXpoUjl7FMVE9oONKWkvtZ7zbr6Q
	+yfwURJqT1mCNj+vA2Pm4iim8LOwS/kP15V/D1WaZ3wQYRomcNB8UVbUNQJvlN1Pn0cI
	q1UXLa22jwuAkMtRio9BjuVCfGO5DpE0nDUYdsoHybnsobtIlYWoYzDrefbAN6OEsrvu
	W7MD/NCxoCFNFdsT/VGI2w6Fj6zsXkNjirmriuQs3h7JZ1E8y8DTKf3mPQrdnHjpqmbr
	eHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=GhKLXN4x2Bh28KK1khKEa4UYDz15n5B2iNQEOKiXWDU=;
	b=KWK1ukmVHppMGWbojA7S5eJi+MP7CZCtBKHDYgp5sjOwsYXlNSjW/T55qYjksC00w1
	7EOv7NqNpYDlxBHFqq5iQD7iXgdH3mWRPFPMeB8xceBrKC1S7FKpg9Ie1712RjKrEvw+
	Fd6IPdZRoxbYqQs78pIyVbn8VeBg9GwcAmS7w8/zhlIyqpZOU50oojfeuPG8RU96npc2
	G3zFY0jyCZoqqMPJbz5Xo959hDxQs7RP4zc6IHMvVSPQ93y5EUI0yL+6OzgH6l+CSOUc
	lnONSAO0GU4Gq6iNGZQVzzGYLXcCwM3OWxbM673eOfZH2vnRH5X2gx2LQYzIO+VzDy0k
	mv8Q==
X-Gm-Message-State: APjAAAXHXHZyBK7FT1bHb0QOUhC/OhthUgvpHCyQkTjg+5+k9vvCneIm
	FU12VqjSdS0Cqxc83ph0C2dObhAr
X-Google-Smtp-Source: APXvYqwxP3Cj5q0ZZGOsRSCThvk9Z8391JuM6Loru9njh+P+J2c2V60FSZxoQHrT6DNMNKFMDw2ddw==
X-Received: by 2002:a05:6000:14a:: with SMTP id
	r10mr4028157wrx.107.1554826988811; 
	Tue, 09 Apr 2019 09:23:08 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	e1sm59579736wrw.66.2019.04.09.09.23.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 09:23:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 18:23:02 +0200
Message-Id: <1554826986-37164-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554826986-37164-1-git-send-email-pbonzini@redhat.com>
References: <1554826986-37164-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PULL 1/5] roms: Rename the EFIROM variable to avoid
 clashing with iPXE
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409162302.LAuCK9EM5m4AIz7CDRrEXBW8kDTe7CxSnrZqAqOGZIo@z>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The iPXE's 'veryclean' recipe removes $(EFIROM) even if the EFIROM
macro originates from elsewhere:

  $ git checkout f590a812c21~
  $ make -C roms clean EFIROM=$(type -P EfiRom)
  make: Entering directory '/source/qemu/roms'
  [...]
  make -C ipxe/src veryclean
  make[1]: Entering directory '/source/qemu/roms/ipxe/src'
  rm -f bin{,-*}/*.* bin{,-*}/.certificate.* bin{,-*}/.certificates.* bin{,-*}/.private_key.* bin{,-*}/errors bin{,-*}/NIC ./util/zbin ./util/elf2efi32 ./util/elf2efi64 /usr/bin/EfiRom ./util/efifatbin ./util/iccfix ./util/einfo TAGS bin{,-*}/symtab
  rm: cannot remove '/usr/bin/EfiRom': Permission denied
  make[1]: *** [Makefile.housekeeping:1564: clean] Error 1
  make[1]: Leaving directory '/source/qemu/roms/ipxe/src'
  make: *** [Makefile:152: clean] Error 2
  make: Leaving directory '/source/qemu/roms'

Before f590a812c21 this variable could be overridden or unset,
and the 'veryclean' Makefile rule would not complain.

Commit f590a812c21 enforces this variable to the Intel EfiRom
tool provided by the EDK2 project.

To avoid the name clash and make the difference between the
projects obvious, rename the variable used by the EDK2 project
as EDK2_EFIROM.

Fixes: f590a812c21074e82228de3e1dfb57b75fc02b62
Reported-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190409134536.15548-2-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 roms/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index 78d5dd1..d28252d 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -47,7 +47,7 @@ SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
 # We need that to combine multiple images (legacy bios,
 # efi ia32, efi x64) into a single rom binary.
 #
-EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
+EDK2_EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
 
 default:
 	@echo "nothing is build by default"
@@ -102,8 +102,8 @@ pxe-rom-%: build-pxe-roms
 
 efirom: $(patsubst %,efi-rom-%,$(pxerom_variants))
 
-efi-rom-%: build-pxe-roms build-efi-roms $(EFIROM)
-	$(EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
+efi-rom-%: build-pxe-roms build-efi-roms $(EDK2_EFIROM)
+	$(EDK2_EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
 		-b ipxe/src/bin/$(VID)$(DID).rom \
 		-ec ipxe/src/bin-i386-efi/$(VID)$(DID).efidrv \
 		-ec ipxe/src/bin-x86_64-efi/$(VID)$(DID).efidrv \
@@ -120,7 +120,7 @@ build-efi-roms: build-pxe-roms
 		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
 		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
 
-$(EFIROM):
+$(EDK2_EFIROM):
 	$(MAKE) -C edk2/BaseTools
 
 slof:
-- 
1.8.3.1



