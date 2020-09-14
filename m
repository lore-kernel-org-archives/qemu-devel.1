Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED05C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:18:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 583CC21548
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 07:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HR4guqP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583CC21548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHil4-0000j6-94
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 03:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHik1-0007Xx-D2
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:17:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHijz-00021W-LN
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 03:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600067851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EgwrzFklfMso8GiwV7PkcDWToLClRIWXp85qXWnix6Q=;
 b=HR4guqP6Xov4MXT9UjwcQnMyBFPWMDoT5sjsJg0AUsLZpe3Zce18F5OzJccDCpqRHoG4H2
 ukrIAzpXINs9lvPrEIEjzbVm6q7aUm+rag+159NAurtvHfc54OZCdeJsMOJzrJFvSZChkG
 iuU+BdNMNhl0eyCfKoq8qWtnk77JqDU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-IgS1POIUN8CYxFwqZE3zcQ-1; Mon, 14 Sep 2020 03:17:29 -0400
X-MC-Unique: IgS1POIUN8CYxFwqZE3zcQ-1
Received: by mail-wm1-f69.google.com with SMTP id a7so2142567wmc.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 00:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EgwrzFklfMso8GiwV7PkcDWToLClRIWXp85qXWnix6Q=;
 b=gct42v8QH2SOR4+W8axqSRs0/+VBlA9LpDj0KoNf6jomUcCwpVXn+tpOFuxL9Z736G
 qUMTLqmHDpR3hcLFQNZ7v8HzQJklKbK7AHIeMcRROezFkc2RR187LkD4XOJMsGzWXLJK
 ybvdVoXCYjhf2Z/UjiLjdnxValetFZh/9AIkm0BRBQ4i/0Kdd1iut455z98ZC3PP99HU
 /UJzywnjX3XuVPsVEAhMcpMxUsJJKXtiAUz6F+xXaxuD5RoZcFeoyA8aTKHMGcXRuVGX
 8N0tFfHeheyGTrByVZrFSyZqbscs0QKMUg0eN52vSDik0UGprpAsVXaztbwp4K78z8c3
 2XUw==
X-Gm-Message-State: AOAM533aAe4Kd3Efrkp5QwLj1KxRN6JjXf9I26h32pp6z2zIm7647Ipm
 rELXEUNU49Pom/9Ay1eOqeYDF3W4PEvkwQCmYz8uyeZz9FSJnNQ0Hpw/AHcWofGc1FoKc9sLJEk
 FsLC3XSJPsEK+u/M=
X-Received: by 2002:a1c:7716:: with SMTP id t22mr12890359wmi.64.1600067847630; 
 Mon, 14 Sep 2020 00:17:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzd6Lb8nddHp5N/1In+XgC7uxByr70NyaCE5mGEkkvns9gAZUdOhmQyPrOZy4XWxqAvH1ZZ+w==
X-Received: by 2002:a1c:7716:: with SMTP id t22mr12890335wmi.64.1600067847370; 
 Mon, 14 Sep 2020 00:17:27 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id q192sm19652914wme.13.2020.09.14.00.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 00:17:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/10] Makefile: remove obsolete edk2 exception from "clean"
 rule
Date: Mon, 14 Sep 2020 09:17:11 +0200
Message-Id: <20200914071720.1099898-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914071720.1099898-1-philmd@redhat.com>
References: <20200914071720.1099898-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:10:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The file "BaseTools/Source/Python/UPT/Dll/sqlite3.dll" was removed in edk2
commit 26e2b295ec7a ("BaseTools:Remove unused
BaseTools\Source\Python\UPT\Dll", 2019-05-08), part of edk2-stable201905,
so skipping it in the outermost in-tree "clean" rule is unnecessary.

Remove the obsolete pathname reference.

Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Ref: https://bugs.launchpad.net/qemu/+bug/1852196
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200908072939.30178-2-lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 57f72f56c6c..7c60b9dcb83 100644
--- a/Makefile
+++ b/Makefile
@@ -200,7 +200,6 @@ clean: recurse-clean ninja-clean clean-ctlist
 	find . \( -name '*.so' -o -name '*.dll' -o -name '*.[oda]' \) -type f \
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-aarch64.a \
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
-		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
 		-exec rm {} +
 	rm -f TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
-- 
2.26.2


