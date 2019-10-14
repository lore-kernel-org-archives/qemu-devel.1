Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEBAECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A646A2083B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AMYR9Fyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A646A2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK0ys-0007vq-Mx
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK0sS-0002VC-SP
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK0sR-0007DG-Gd
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:59:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:53871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK0sQ-0007CO-LD
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:59:11 -0400
Received: by mail-wm1-x331.google.com with SMTP id i16so17399842wmd.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=icjvsArQ5uSm1FFRj06yMQLbvVSX7IwkWiqu73IFnUA=;
 b=AMYR9FyrmR0/J7pxe30AJaY0ShyrIj+gGbMc0e3yoEyjcM8wyxDHzRn24iD2fyb8a8
 awNN7wJ3BwtDTSQ0v235CIhyoq1pn8CtldScmssF9cUYJ6JpMKNXS7PXwsYSAkU70/Z9
 tuVrnGwnHcFXzpH0wXPLDFFrtVt9PyWR9ZYYK0hoYm+ypjjwht3xopFAtkVPXYG/EmOI
 r4n6gR0H3GFsrCgaoq0iLvR6t24NNZxRsrQijTOP9pooWeTN0fjmMuIcGCILYmuUzwHA
 j6CCl0S2es9QTcLRCrGuAUzoHtuE1mSLtxyHHuBWX6pga5E43B6Q+mW32pl0Um9dBHg1
 yFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=icjvsArQ5uSm1FFRj06yMQLbvVSX7IwkWiqu73IFnUA=;
 b=rV75zZveSCQt4IkpZMD083T78TRFjQdasB7Mo+3jP/AIbb2gxa1XFK4ecCi0ApjeI2
 28AGtzsZODWvPY2TaRj3pj7YRlWk9YX7tnw+3EDGNOfefQ7vDhq3Co9qcuWUG8MLf8Ra
 rUW11w2RcvouBw3gz4TR+EREdUDSKO74XxMYKTMXjDO5vDpesb6biGG3yQyVaRXNxlg4
 megaUl6lr+2T57M8KKLJADRkdV7X57xVNXs011Rqw1xBTfqGzQlra1zhCw+ZG5XE4n7c
 I7hzNdtnXgDnB/Mc8PB7q73Dozq8MpsQQg5SPUlSSxjbZY3xWIIBRPyVbb7ABoSQ4UM4
 kILw==
X-Gm-Message-State: APjAAAXvwCDo4gDvdOESpjVB9K5HDWNmdVtoCzowUHqLAdf4pONaMCfK
 D9PcqT7nZV2+J9gSSHpkP9SfQw==
X-Google-Smtp-Source: APXvYqzSu8HfBceH3rI+Q7iEN8BzsjZFuupkkTh5FnlMtprK55tdyGJJbAD58mTACOLTJg8AEKLwTQ==
X-Received: by 2002:a1c:2681:: with SMTP id m123mr15998285wmm.92.1571061549529; 
 Mon, 14 Oct 2019 06:59:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t123sm31595527wma.40.2019.10.14.06.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 06:59:07 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8BD491FF91;
 Mon, 14 Oct 2019 14:59:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 4/5] contrib/gitdm: add Bin Meng to the individual group
Date: Mon, 14 Oct 2019 14:59:04 +0100
Message-Id: <20191014135905.24364-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014135905.24364-1-alex.bennee@linaro.org>
References: <20191014135905.24364-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 dirty.ice.hu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Please confirm this is the correct section for you.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 contrib/gitdm/group-map-individuals | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index 624e27fc83..eb23c0beee 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -19,3 +19,4 @@ dirty.ice.hu@gmail.com
 liq3ea@163.com
 liq3ea@gmail.com
 andrew.smirnov@gmail.com
+bmeng.cn@gmail.com
-- 
2.20.1


