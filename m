Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDD1C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:30:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37550206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QItvuMl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37550206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHiwG-0008MZ-B0
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHil7-0001Ou-Ck
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:18:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59349
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHil5-0002B6-Di
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600067918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sV+NlrfPirEi8SZ5UJtI4I6RSRCs1z27ZLnxNRxfG2k=;
 b=QItvuMl7uMtZLNXsMX3zmrHTyihIK7K6Y2yq7Ob965867t67l2TcPkVKJ8/RgHkWDRQLFP
 g23RDDhjmPKdLJFb3WUrQmkqYr4Dhv82bDgclejn34YvNcO/J9aXJWPMSMW3FOsAR4c4np
 ceWaRC+XuxJR9pBnQrVzFyioCGgGyYY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-P6xVU77XMXqQcOGc9w4PwA-1; Mon, 14 Sep 2020 03:18:35 -0400
X-MC-Unique: P6xVU77XMXqQcOGc9w4PwA-1
Received: by mail-wr1-f70.google.com with SMTP id n15so6493730wrv.23
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 00:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sV+NlrfPirEi8SZ5UJtI4I6RSRCs1z27ZLnxNRxfG2k=;
 b=mfCaFhUQ7TfZQeMZRRhjHPftXuDW7senq2ooPcUbjtiGpockqnlBdRYqs4YylHlMYE
 WIcRZdBqnR35MK35ZZn3+nuN9hXB5oeF8r7EpSNEO8BDdS2mzsv+KjM+IVYXPQKggaDf
 0zu2gTbINPgejLA0V0vK9584dzfWnrRYQZ1Sq2R95bwGFZ6tEX6s2WA2cFmMZh0vaQdh
 Va67PRD+ocPo+kgnLSiZR5z8Zd7/rXqtyIe6DS+9cGJ9umZ2JwNnUVVlmRQL4biluxV0
 WuWH94/9XuHAMgnXKnnSgPJv2xAq+Imwx02rt3p2fJxRb8+iHgMc6ZCXaaZ4sP2MrXt6
 OSfw==
X-Gm-Message-State: AOAM533a5j6pk32mYkLmavHyKHJbl9Pj/s/fd5D+Mwkncf78lpt/Dk79
 8NN+cp2KZZZjjxccLHZhjN846L76X5bwd6UmgJGHHse74NYyo6ftUP+nTFHRX3Lcienl/nnUtDD
 pgplHOIPLLVyi/mk=
X-Received: by 2002:a5d:610d:: with SMTP id v13mr13783982wrt.23.1600067914341; 
 Mon, 14 Sep 2020 00:18:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx75Ulaehtv2eJWdGy22XO+Z6EsWwT5MXhRU+P4LW0uPEZjCIQH2FZaoHk+OPBcBIRF2FEq1Q==
X-Received: by 2002:a5d:610d:: with SMTP id v13mr13783966wrt.23.1600067914193; 
 Mon, 14 Sep 2020 00:18:34 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t15sm13208295wrp.20.2020.09.14.00.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 00:18:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/10] pc-bios: update the README file with edk2-stable202008
 information
Date: Mon, 14 Sep 2020 09:17:19 +0200
Message-Id: <20200914071720.1099898-10-philmd@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:33:07
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

Refresh the "pc-bios/README" file with edk2 and OpenSSL release info,
matching the edk2-stable202008 firmware images added in the previous
patch.

Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Ref: https://bugs.launchpad.net/qemu/+bug/1852196
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <e967b4d5-bcc2-3846-0ad6-9e8f4d2f9115@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 pc-bios/README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pc-bios/README b/pc-bios/README
index fa8b58b7972..2e49be607e0 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -52,8 +52,8 @@
   variable store templates built from the TianoCore community's EFI Development
   Kit II project
   <https://github.com/tianocore/tianocore.github.io/wiki/EDK-II>. The images
-  were built at git tag "edk2-stable201905". The firmware binaries bundle parts
-  of the OpenSSL project, at git tag "OpenSSL_1_1_1b" (the OpenSSL tag is a
+  were built at git tag "edk2-stable202008". The firmware binaries bundle parts
+  of the OpenSSL project, at git tag "OpenSSL_1_1_1g" (the OpenSSL tag is a
   function of the edk2 tag). Parts of the Berkeley SoftFloat library are
   bundled as well, at Release 3e plus a subsequent typo fix (commit
   b64af41c3276f97f0e181920400ee056b9c88037), as an OpenSSL dependency on 32-bit
-- 
2.26.2


