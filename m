Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4BECA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D717A20684
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S3we3iXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D717A20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO5qN-0007k7-0G
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 16:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Oi-0008Gh-L0
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Oh-000390-7g
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:20 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:35940)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO5Oh-00038O-1h
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:19 -0400
Received: by mail-wr1-x436.google.com with SMTP id w18so3637535wrt.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 12:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BF2w3G1qTttMb2TzTmyAT9qanEryxWW0AdGjytWG0ac=;
 b=S3we3iXEvXGjY7UQ2vzBpi6lzsfQtVVLBqu0YoxJSw0Rm/7gWScGfv3y4tU0WyeMk5
 Dc8loBesq7s486yihn0ZiN9z3cFPyhO9DV+TLMbMUfpdbbSpp1u0/ekZqEOg1kqmY6Ks
 DvSjPqHQp2O/A20Q02djYsG0GNrl90TStviNT0uviRPG8fRl2ueqdR6WypKMvo60AYG1
 GfYqfqSUYehSlC+XFFOxGI+cjhFi1FofTAe0f3qw6NsA0tBKPAmINRk9gPExumnViOY+
 KYukJHFHgGG7rBmRJwIs2yr7J00HaFyr/jiU55vb8Y2EXkHJW2Gg7UvHKijrl0gl/Jjo
 ZZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BF2w3G1qTttMb2TzTmyAT9qanEryxWW0AdGjytWG0ac=;
 b=hfjLTkFBwfD2gDJHHg3t3wkdrGHbXYBjZkR0v917kKRLccS4ZYujOMPs9sITLqNYYK
 eAi+eKj7HEwsrxmdgmvpmSa13tfS9nRqpA3UcPX2eBqnwZDPYRUpx4Xcx6OBqZjwB7ZD
 luQ1P8CPArJ8IhAnWOz6hCcFg8qVuFrSs99rJz3jitjMB/tLoed79ppXgZZdP7hUpOA/
 bgfgUIlpZ9rcN1p4yP28odztPIVf4vgL8VsrVHNkruDV4wkdeThAk1lbLpDI5KIVix8/
 pNRRm7k5B4ROU+YhUUBG7lUTW7baZyxM4Yae+clESknuC5P5XBIEgY/F8ryrOx3YLDnF
 +pew==
X-Gm-Message-State: APjAAAVebODqXKMTqKVYdUw+rEtcGkweUJIa52rTxHqc8sLHOhroiTgl
 V58ZfxIzhxZT2Nu7bHWc8h5LjA==
X-Google-Smtp-Source: APXvYqyXSv+3ltD8hADaoBtl5YFFWouQVv+Kl0vB9fybbrmrzLHn2eh/otGFofND6NFyFu2oNDTsbQ==
X-Received: by 2002:a5d:5388:: with SMTP id d8mr4575284wrv.92.1572032237897;
 Fri, 25 Oct 2019 12:37:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v81sm4043940wmg.4.2019.10.25.12.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 12:37:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 541C41FF9A;
 Fri, 25 Oct 2019 20:37:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v3 10/15] tests/vm/netbsd: Disable IPv6
Date: Fri, 25 Oct 2019 20:37:04 +0100
Message-Id: <20191025193709.28783-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025193709.28783-1-alex.bennee@linaro.org>
References: <20191025193709.28783-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

Workaround for issues when the host has no IPv6 connectivity.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191018181705.17957-4-ehabkost@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index ee9eaeab504..18aa56ae826 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -28,6 +28,13 @@ class NetBSDVM(basevm.BaseVM):
         gmake --output-sync -j{jobs} {target} {verbose};
     """
 
+    # Workaround for NetBSD + IPv6 + slirp issues.
+    # NetBSD seems to ignore the ICMPv6 Destination Unreachable
+    # messages generated by slirp.  When the host has no IPv6
+    # connectivity, this causes every connection to ftp.NetBSD.org
+    # take more than a minute to be established.
+    ipv6 = False
+
     def build_image(self, img):
         cimg = self._download_with_cache("http://download.patchew.org/netbsd-7.1-amd64.img.xz",
                                          sha256sum='b633d565b0eac3d02015cd0c81440bd8a7a8df8512615ac1ee05d318be015732')
-- 
2.20.1


