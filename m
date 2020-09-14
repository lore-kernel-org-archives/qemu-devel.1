Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EC1C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5375521548
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lt5a1RxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5375521548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHimY-0003q5-BB
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHik6-0007eE-QH
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:17:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46601
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHik4-000221-Vv
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600067855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B/QyHAI8rfw4hh8DA8H1ZDJBxt01mZA0EnhuZgHcDoo=;
 b=Lt5a1RxGNceuSFaAbx8bOZMo7Iu4sta2atLC9dX0otrgMADiSPTdfUo442Buk73aOXoTGW
 zsGw2+Yd0bCdqPddkgX2Rg76+TwIS6rFz6PcEgzZqhnPSrppkuZ1IKneqiFZabxd3Uc7hT
 uTSsXfn2noF7YNxRhSjvbXFmPyXmfUM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-nIT8ZvA3MA2v2fU2dzi17A-1; Mon, 14 Sep 2020 03:17:34 -0400
X-MC-Unique: nIT8ZvA3MA2v2fU2dzi17A-1
Received: by mail-wm1-f69.google.com with SMTP id w3so2137969wmg.4
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 00:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B/QyHAI8rfw4hh8DA8H1ZDJBxt01mZA0EnhuZgHcDoo=;
 b=rNfb+wkZtuA8XEVsk4Vh9Mo6Gh+Y/qLGHYUgqATA3xGciNa3WGqSP27VqF3To1u4xI
 PG+mQu+lOhQ/xKUnDlZO9VEL6QYh/5qgZlLXSdbwXjAKFvow5/5AkxnYX4wLS4wzRKOC
 KckXKgaOzHlJH0CPsOHvYJPrQd67A3e9MEE6NgErUo7kTsaMaTi0UbRNswwJ6+L3dmQM
 MFRPtrJ7LpMRPmQU8ngBRI8YFkSCsCld/hcVumDokcCRENU4bH3t22k+G5YkRFqneJxK
 MPEsWwX9bFqUTHmBwlSKux3M5Am9QZ9jRj04vbPLi4R/zKUkogE1DiRYZTow640X+8rt
 SIDQ==
X-Gm-Message-State: AOAM5302MIg1K8tipNxIsKDgIjLfAfb5yPRYR13rEHV3tjpCMQQoUmXk
 Dl3s3iu/+5mb0rGhr185jr5PpnXCKKyNTqOuYNPhWljgwpuppQKCSvQlFeTFp79s7qfFNNQIV4w
 j09F/xLJNP7E4KVo=
X-Received: by 2002:adf:f0c7:: with SMTP id x7mr14081892wro.315.1600067852550; 
 Mon, 14 Sep 2020 00:17:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoAWonbrOLyUuFVi2T+w0FQ+hL9rYcc0ihU3LBs7//8Rouu4PqLJzr17VT5kTPNLtqKfZcRQ==
X-Received: by 2002:adf:f0c7:: with SMTP id x7mr14081878wro.315.1600067852397; 
 Mon, 14 Sep 2020 00:17:32 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id p16sm19225829wro.71.2020.09.14.00.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 00:17:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/10] roms/efirom,
 tests/uefi-test-tools: update edk2's own submodules first
Date: Mon, 14 Sep 2020 09:17:12 +0200
Message-Id: <20200914071720.1099898-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914071720.1099898-1-philmd@redhat.com>
References: <20200914071720.1099898-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 00:11:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laszlo Ersek <lersek@redhat.com>

In edk2 commit 06033f5abad3 ("BaseTools: Make brotli a submodule",
2020-04-16), part of edk2-stable202005, the Brotli compressor /
decompressor source code that edk2 had flattened into BaseTools was
replaced with a git submodule.

This means we have to initialize edk2's own submodules before building
BaseTools not just in "roms/Makefile.edk2", but in "roms/Makefile" (for
the sake of the "efirom" target) and "tests/uefi-test-tools/Makefile" as
well.

Right now this patch is effectively a no-op; it will become meaningful
after we move the edk2 submodule to edk2-stable202008.

Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Ref: https://bugs.launchpad.net/qemu/+bug/1852196
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200908072939.30178-3-lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 roms/Makefile                  | 1 +
 tests/uefi-test-tools/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/roms/Makefile b/roms/Makefile
index 8cafced348e..d3a32283591 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -138,6 +138,7 @@ build-efi-roms: build-pxe-roms
 #    efirom
 #
 edk2-basetools:
+	cd edk2/BaseTools && git submodule update --init --force
 	$(MAKE) -C edk2/BaseTools \
 		PYTHON_COMMAND=$${EDK2_PYTHON_COMMAND:-python3} \
 		EXTRA_OPTFLAGS='$(EDK2_BASETOOLS_OPTFLAGS)' \
diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Makefile
index 1dcddcdbbab..471f0de9810 100644
--- a/tests/uefi-test-tools/Makefile
+++ b/tests/uefi-test-tools/Makefile
@@ -99,6 +99,7 @@ Build/bios-tables-test.%.efi: build-edk2-tools
 	+./build.sh $(edk2_dir) BiosTablesTest $* $@
 
 build-edk2-tools:
+	cd $(edk2_dir)/BaseTools && git submodule update --init --force
 	$(MAKE) -C $(edk2_dir)/BaseTools \
 		PYTHON_COMMAND=$${EDK2_PYTHON_COMMAND:-python3} \
 		EXTRA_OPTFLAGS='$(EDK2_BASETOOLS_OPTFLAGS)' \
-- 
2.26.2


