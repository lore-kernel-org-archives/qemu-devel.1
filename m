Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAF1C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A233206E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sytv4Y2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A233206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49742 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZIWb-00065Y-Jd
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 13:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53530)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZH0N-0003br-JY
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZGnD-0002lL-Um
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:28:38 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZGnD-0002es-Mj
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:28:35 -0400
Received: by mail-wr1-x441.google.com with SMTP id x17so2577122wrl.9
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 08:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qsUNXG+cCOY+wUP8RT0hl/MDxZboRG8ks+plyU9aNGg=;
 b=sytv4Y2Wb2olOOnZm9Z5JB9OTbeNO+4Pr7Elf9xtqNuvE9PcvK0AmCjp9so25bt0RA
 sTFLc3jWQBoEeQtBsarIPgiXcEZYLfkqkDAmCLYWRykjFEqo0LDZ/2WrZhof0+ZhjlrE
 IuRfK1Q1vkk8nCcC4N4djee5mOq6eH/5qt112doONvEVlhXcP/+s/4f2dQ927C5nGRBh
 m4TT3kZo+66AaXuaqFIvNSzdkq8ypkqjsz6exDkhDhKmHUQgrzPMPxEjiBeisVlYE3Dg
 RtPCcDbvaKDcSqvw3zP3O92CW9WB28lQ7kEriXx6Axaty+eijU3J2fePm12EC5TyPVaA
 NW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qsUNXG+cCOY+wUP8RT0hl/MDxZboRG8ks+plyU9aNGg=;
 b=Zm0hAe0zxh/T9SKCc4kc9tiL+DlqH88f1v6jAcVKVBB9Ca9LPLSH7nOa5228zjt9aB
 iIKgQ8i7/HgCpw/8oA6/P8psH/OTahTc0fnykg9K4zO4WlnyqaBHaUTTZXyp8r16jJf4
 sujoLI30Of5r72C61JArZ06sClJFHTaENfEfiostzWnup2xTneZK7VB1ucNLC8csUiOx
 MnypAAt0nLCp4yMdSAKGVNCHNQRoWZGHgbOW3lG2ND/1UHcHbYtmjEkC7Kf5TK9cQJLM
 Mf2aSK3gqVgLVqU6QLD/WghDpZFUXjFSh4qL9HTd5VfkafrOvLcZlivxynzhvrSfdE6T
 P2Fg==
X-Gm-Message-State: APjAAAUuIgmV4wyolXNApKBSydyI7Ezjxm1WJFXzHXwvYR+Fw1+7LmmA
 0ZxzY1a1KjmRYwbtP4IJrm37TMvn9IzwbQ==
X-Google-Smtp-Source: APXvYqw6ADDDsSeuaROpo4quriKrdTnrPW+k6q7XktNGhhajxsdI8Qtx79LjahrvxeqZwvRa8NNzTA==
X-Received: by 2002:adf:ead0:: with SMTP id o16mr22352491wrn.216.1559921311916; 
 Fri, 07 Jun 2019 08:28:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b7sm580224wrx.83.2019.06.07.08.28.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 08:28:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 16:28:27 +0100
Message-Id: <20190607152827.18003-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607152827.18003-1-peter.maydell@linaro.org>
References: <20190607152827.18003-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 2/2] qemu-tech.texi: Remove "QEMU compared to
 other emulators" section
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "QEMU compared to other emulators" section of our documentation
hasn't been updated since 2015 (and parts of the text are even older).
We're clearly not very well placed to track the evolution of a
dozen other emulation projects, and an inaccurate or out of date
comparison doesn't serve anybody, so we're best off just removing
the whole documentation section.

If anybody cares strongly about maintaining a comparison page,
it's probably better to do that on the project's wiki where
we can update it more dynamically.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qemu-tech.texi | 107 -------------------------------------------------
 1 file changed, 107 deletions(-)

diff --git a/qemu-tech.texi b/qemu-tech.texi
index eb430daacf2..3451cfaa5be 100644
--- a/qemu-tech.texi
+++ b/qemu-tech.texi
@@ -161,57 +161,6 @@ may be created from overlay with minimal amount of hand-written code.
 
 @end itemize
 
-@node QEMU compared to other emulators
-@section QEMU compared to other emulators
-
-Like bochs [1], QEMU emulates an x86 CPU. But QEMU is much faster than
-bochs as it uses dynamic compilation. Bochs is closely tied to x86 PC
-emulation while QEMU can emulate several processors.
-
-Like Valgrind [2], QEMU does user space emulation and dynamic
-translation. Valgrind is mainly a memory debugger while QEMU has no
-support for it (QEMU could be used to detect out of bound memory
-accesses as Valgrind, but it has no support to track uninitialised data
-as Valgrind does). The Valgrind dynamic translator generates better code
-than QEMU (in particular it does register allocation) but it is closely
-tied to an x86 host and target and has no support for precise exceptions
-and system emulation.
-
-EM86 [3] is the closest project to user space QEMU (and QEMU still uses
-some of its code, in particular the ELF file loader). EM86 was limited
-to an alpha host and used a proprietary and slow interpreter (the
-interpreter part of the FX!32 Digital Win32 code translator [4]).
-
-TWIN from Willows Software was a Windows API emulator like Wine. It is less
-accurate than Wine but includes a protected mode x86 interpreter to launch
-x86 Windows executables. Such an approach has greater potential because most
-of the Windows API is executed natively but it is far more difficult to
-develop because all the data structures and function parameters exchanged
-between the API and the x86 code must be converted.
-
-User mode Linux [5] was the only solution before QEMU to launch a
-Linux kernel as a process while not needing any host kernel
-patches. However, user mode Linux requires heavy kernel patches while
-QEMU accepts unpatched Linux kernels. The price to pay is that QEMU is
-slower.
-
-The Plex86 [6] PC virtualizer is done in the same spirit as the now
-obsolete qemu-fast system emulator. It requires a patched Linux kernel
-to work (you cannot launch the same kernel on your PC), but the
-patches are really small. As it is a PC virtualizer (no emulation is
-done except for some privileged instructions), it has the potential of
-being faster than QEMU. The downside is that a complicated (and
-potentially unsafe) host kernel patch is needed.
-
-The commercial PC Virtualizers (VMWare [7], VirtualPC [8]) are faster
-than QEMU (without virtualization), but they all need specific, proprietary
-and potentially unsafe host drivers. Moreover, they are unable to
-provide cycle exact simulation as an emulator can.
-
-VirtualBox [9], Xen [10] and KVM [11] are based on QEMU. QEMU-SystemC
-[12] uses QEMU to simulate a system where some hardware devices are
-developed in SystemC.
-
 @node Managed start up options
 @section Managed start up options
 
@@ -247,59 +196,3 @@ depend on an initialized machine, including but not limited to:
 @item query-status
 @item x-exit-preconfig
 @end table
-
-@node Bibliography
-@section Bibliography
-
-@table @asis
-
-@item [1]
-@url{http://bochs.sourceforge.net/}, the Bochs IA-32 Emulator Project,
-by Kevin Lawton et al.
-
-@item [2]
-@url{http://www.valgrind.org/}, Valgrind, an open-source memory debugger
-for GNU/Linux.
-
-@item [3]
-@url{http://ftp.dreamtime.org/pub/linux/Linux-Alpha/em86/v0.2/docs/em86.html},
-the EM86 x86 emulator on Alpha-Linux.
-
-@item [4]
-@url{http://www.usenix.org/publications/library/proceedings/usenix-nt97/@/full_papers/chernoff/chernoff.pdf},
-DIGITAL FX!32: Running 32-Bit x86 Applications on Alpha NT, by Anton
-Chernoff and Ray Hookway.
-
-@item [5]
-@url{http://user-mode-linux.sourceforge.net/},
-The User-mode Linux Kernel.
-
-@item [6]
-@url{http://www.plex86.org/},
-The new Plex86 project.
-
-@item [7]
-@url{http://www.vmware.com/},
-The VMWare PC virtualizer.
-
-@item [8]
-@url{https://www.microsoft.com/download/details.aspx?id=3702},
-The VirtualPC PC virtualizer.
-
-@item [9]
-@url{http://virtualbox.org/},
-The VirtualBox PC virtualizer.
-
-@item [10]
-@url{http://www.xen.org/},
-The Xen hypervisor.
-
-@item [11]
-@url{http://www.linux-kvm.org/},
-Kernel Based Virtual Machine (KVM).
-
-@item [12]
-@url{http://www.greensocs.com/projects/QEMUSystemC},
-QEMU-SystemC, a hardware co-simulator.
-
-@end table
-- 
2.20.1


