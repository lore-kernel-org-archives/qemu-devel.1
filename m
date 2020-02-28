Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C078C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84FC2469D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YOWE1T6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84FC2469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7hoa-0007ax-1E
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 10:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hhH-0001Nl-FI
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hhF-000558-K1
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:03 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42797)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7hhF-00054Y-DI
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:01 -0500
Received: by mail-wr1-x443.google.com with SMTP id p18so3401705wre.9
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 07:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ow1LDJV1/Ida3kt2aML/vDnb6kPmSSMSoBYAW/XYLhk=;
 b=YOWE1T6WYcKlI8wwNebDzG0o/s319ScxVhH1B45CPA2smElhbANeba1k1JHLVJeuJd
 c94UrgprEH5G0ezQFCDM2o0ObjQdYbSHQxacxvIZcU8/B1polX5xPEYzxH1qwpMT+Lpg
 IY4SWhao45AFYMkpQyxfeJ1WqhX7rSFQRPhWWSFLENNctMQHIRWcTzEHUMivlEMsa7U1
 X9/0I1DoLMHjgXNGuzGaxT6wbGaxuQ+gm7nKR5XRoX4hf5Rv+VLPE+o2/1PlBVlGfYZu
 Ae2RazVbCVBtWE8L9556Bz5Yh1gS5QtO1+oQgaDMKyWNWPMk4Zin3z75zPpjRn7T9KBS
 8rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ow1LDJV1/Ida3kt2aML/vDnb6kPmSSMSoBYAW/XYLhk=;
 b=uVxWuXh8u8iOlNOTRlhhFwYP90Vj5S1ksf3sgxGwQ56xtKqiDnZcEibRyptlU6Q5oo
 4mZ5cwHdjM7vFI1sfUIUWhFN6QfkUsVrTM80QnR8Yw/Kyve0VEeWyrwYQtxKCAlAkBAg
 a8W2mEHkonzzwlh7OI/lBpJflietIaTqmw4BdSmshvyKAvT2JNzcVWBbanfwGR6d+D1a
 eDIl3jgBIyweb/7UMP5ne3yfo9v7GwKL4O+C7WcEerCggsBl1P6mpyMyPBNBhY5IpKgU
 gdrnRYWEVPah2RfMaQoBusVR8hfkwIyDCCRyNhzJHtCRMPn8rNaq72HktmjYQNyTlIz0
 Deqw==
X-Gm-Message-State: APjAAAWjvj+K7RkXHkHNH+rv10ER2XjfWkzlb8YEag6+i4NSTNjVPEQh
 F4pishTLM5DY8jDp20xt1y2vqtPX5BvygQ==
X-Google-Smtp-Source: APXvYqzkJumH8L12BD+KgfXZ7WWngsJQAo508wuzln0vFmXyDiEcRdnoDkp1zVVQGdXoxFUFw+fRmw==
X-Received: by 2002:a05:6000:192:: with SMTP id
 p18mr5263338wrx.218.1582904219818; 
 Fri, 28 Feb 2020 07:36:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u23sm2659452wmu.14.2020.02.28.07.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 07:36:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 24/33] docs: Roll -prom-env and -g target-specific info
 into qemu-options.hx
Date: Fri, 28 Feb 2020 15:36:10 +0000
Message-Id: <20200228153619.9906-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228153619.9906-1-peter.maydell@linaro.org>
References: <20200228153619.9906-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SPARC and PPC targets currently have a fragment of target-specific
information about the -g and -prom options which would be better placed
as part of the general documentation of those options in qemu-options.hx.
Move the relevant information to those locations.

SPARC also has a bit of text about the -M option which is out of
date and provides no useful information over the generic documentation
of that option, so just delete it.

The motivation here is again to avoid having to awkwardly include
this text into the rST version of the qemu.1 manpage.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/target-ppc.rst      | 14 --------------
 docs/system/target-ppc.texi     | 25 -------------------------
 docs/system/target-sparc.rst    | 19 -------------------
 docs/system/target-sparc.texi   | 27 ---------------------------
 docs/system/target-sparc64.rst  | 12 ------------
 docs/system/target-sparc64.texi | 22 ----------------------
 qemu-options.hx                 | 19 +++++++++++++++++++
 7 files changed, 19 insertions(+), 119 deletions(-)

diff --git a/docs/system/target-ppc.rst b/docs/system/target-ppc.rst
index 43fadf3c00b..a2f04c533c2 100644
--- a/docs/system/target-ppc.rst
+++ b/docs/system/target-ppc.rst
@@ -43,19 +43,5 @@ the g3beige and mac99 PowerMac and the 40p machines. OpenBIOS is a free
 (GPL v2) portable firmware implementation. The goal is to implement a
 100% IEEE 1275-1994 (referred to as Open Firmware) compliant firmware.
 
-The following options are specific to the PowerPC emulation:
-
-``-g WxH[xDEPTH]``
-   Set the initial VGA graphic mode. The default is 800x600x32.
-
-``-prom-env string``
-   Set OpenBIOS variables in NVRAM, for example:
-
-   ::
-
-      qemu-system-ppc -prom-env 'auto-boot?=false' \
-       -prom-env 'boot-device=hd:2,\yaboot' \
-       -prom-env 'boot-args=conf=hd:2,\yaboot.conf'
-
 More information is available at
 http://perso.magic.fr/l_indien/qemu-ppc/.
diff --git a/docs/system/target-ppc.texi b/docs/system/target-ppc.texi
index 55f98f65b12..5c83d4f68e7 100644
--- a/docs/system/target-ppc.texi
+++ b/docs/system/target-ppc.texi
@@ -47,31 +47,6 @@ for the g3beige and mac99 PowerMac and the 40p machines. OpenBIOS is a free
 (GPL v2) portable firmware implementation. The goal is to implement a 100%
 IEEE 1275-1994 (referred to as Open Firmware) compliant firmware.
 
-@c man begin OPTIONS
-
-The following options are specific to the PowerPC emulation:
-
-@table @option
-
-@item -g @var{W}x@var{H}[x@var{DEPTH}]
-
-Set the initial VGA graphic mode. The default is 800x600x32.
-
-@item -prom-env @var{string}
-
-Set OpenBIOS variables in NVRAM, for example:
-
-@example
-qemu-system-ppc -prom-env 'auto-boot?=false' \
- -prom-env 'boot-device=hd:2,\yaboot' \
- -prom-env 'boot-args=conf=hd:2,\yaboot.conf'
-@end example
-
-@end table
-
-@c man end
-
-
 More information is available at
 @url{http://perso.magic.fr/l_indien/qemu-ppc/}.
 
diff --git a/docs/system/target-sparc.rst b/docs/system/target-sparc.rst
index 589c88d1756..b55f8d09e9c 100644
--- a/docs/system/target-sparc.rst
+++ b/docs/system/target-sparc.rst
@@ -60,22 +60,3 @@ QEMU web site. There are still issues with NetBSD and OpenBSD, but most
 kernel versions work. Please note that currently older Solaris kernels
 don't work probably due to interface issues between OpenBIOS and
 Solaris.
-
-The following options are specific to the Sparc32 emulation:
-
-``-g WxHx[xDEPTH]``
-   Set the initial graphics mode. For TCX, the default is 1024x768x8
-   with the option of 1024x768x24. For cgthree, the default is
-   1024x768x8 with the option of 1152x900x8 for people who wish to use
-   OBP.
-
-``-prom-env string``
-   Set OpenBIOS variables in NVRAM, for example:
-
-   ::
-
-      qemu-system-sparc -prom-env 'auto-boot?=false' \
-       -prom-env 'boot-device=sd(0,2,0):d' -prom-env 'boot-args=linux single'
-
-``-M [SS-4|SS-5|SS-10|SS-20|SS-600MP|LX|Voyager|SPARCClassic] [|SPARCbook]``
-   Set the emulated machine type. Default is SS-5.
diff --git a/docs/system/target-sparc.texi b/docs/system/target-sparc.texi
index 7748001f734..99fbf820b42 100644
--- a/docs/system/target-sparc.texi
+++ b/docs/system/target-sparc.texi
@@ -64,32 +64,5 @@ most kernel versions work. Please note that currently older Solaris kernels
 don't work probably due to interface issues between OpenBIOS and
 Solaris.
 
-@c man begin OPTIONS
-
-The following options are specific to the Sparc32 emulation:
-
-@table @option
-
-@item -g @var{W}x@var{H}x[x@var{DEPTH}]
-
-Set the initial graphics mode. For TCX, the default is 1024x768x8 with the
-option of 1024x768x24. For cgthree, the default is 1024x768x8 with the option
-of 1152x900x8 for people who wish to use OBP.
-
-@item -prom-env @var{string}
-
-Set OpenBIOS variables in NVRAM, for example:
-
-@example
-qemu-system-sparc -prom-env 'auto-boot?=false' \
- -prom-env 'boot-device=sd(0,2,0):d' -prom-env 'boot-args=linux single'
-@end example
-
-@item -M [SS-4|SS-5|SS-10|SS-20|SS-600MP|LX|Voyager|SPARCClassic] [|SPARCbook]
-
-Set the emulated machine type. Default is SS-5.
-
-@end table
-
 @c man end
 
diff --git a/docs/system/target-sparc64.rst b/docs/system/target-sparc64.rst
index ca76ba9c488..97e334b9308 100644
--- a/docs/system/target-sparc64.rst
+++ b/docs/system/target-sparc64.rst
@@ -35,15 +35,3 @@ QEMU emulates the following peripherals:
 -  2 PCI IDE interfaces with hard disk and CD-ROM support
 
 -  Floppy disk
-
-The following options are specific to the Sparc64 emulation:
-
-``-prom-env string``
-   Set OpenBIOS variables in NVRAM, for example:
-
-   ::
-
-      qemu-system-sparc64 -prom-env 'auto-boot?=false'
-
-``-M [sun4u|sun4v|niagara]``
-   Set the emulated machine type. The default is sun4u.
diff --git a/docs/system/target-sparc64.texi b/docs/system/target-sparc64.texi
index 4db4ca3842b..d381d3af719 100644
--- a/docs/system/target-sparc64.texi
+++ b/docs/system/target-sparc64.texi
@@ -36,25 +36,3 @@ PC-compatible serial ports
 Floppy disk
 @end itemize
 
-@c man begin OPTIONS
-
-The following options are specific to the Sparc64 emulation:
-
-@table @option
-
-@item -prom-env @var{string}
-
-Set OpenBIOS variables in NVRAM, for example:
-
-@example
-qemu-system-sparc64 -prom-env 'auto-boot?=false'
-@end example
-
-@item -M [sun4u|sun4v|niagara]
-
-Set the emulated machine type. The default is sun4u.
-
-@end table
-
-@c man end
-
diff --git a/qemu-options.hx b/qemu-options.hx
index 4bc8048f60b..3b230a17164 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1962,6 +1962,13 @@ STEXI
 @item -g @var{width}x@var{height}[x@var{depth}]
 @findex -g
 Set the initial graphical resolution and depth (PPC, SPARC only).
+
+For PPC the default is 800x600x32.
+
+For SPARC with the TCX graphics device, the default is 1024x768x8 with the
+option of 1024x768x24. For cgthree, the default is 1024x768x8 with the option
+of 1152x900x8 for people who wish to use OBP.
+
 ETEXI
 
 DEF("vnc", HAS_ARG, QEMU_OPTION_vnc ,
@@ -4107,6 +4114,18 @@ STEXI
 @item -prom-env @var{variable}=@var{value}
 @findex -prom-env
 Set OpenBIOS nvram @var{variable} to given @var{value} (PPC, SPARC only).
+
+@example
+qemu-system-sparc -prom-env 'auto-boot?=false' \
+ -prom-env 'boot-device=sd(0,2,0):d' -prom-env 'boot-args=linux single'
+@end example
+
+@example
+qemu-system-ppc -prom-env 'auto-boot?=false' \
+ -prom-env 'boot-device=hd:2,\yaboot' \
+ -prom-env 'boot-args=conf=hd:2,\yaboot.conf'
+@end example
+
 ETEXI
 DEF("semihosting", 0, QEMU_OPTION_semihosting,
     "-semihosting    semihosting mode\n",
-- 
2.20.1


