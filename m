Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEDEC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECDD020820
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVjQdNQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDD020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4jc3-00043b-KP
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 06:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSi-0004dZ-HP
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i4jSh-0004G4-Bi
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:28 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:39493)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i4jSh-0004Fb-52
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:21:27 -0400
Received: by mail-wr1-x42d.google.com with SMTP id t16so13431945wra.6
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 03:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tNqvSEr8X3/3ZjLjpEcLT+HicpFHjS0C2AZqviXv1Lk=;
 b=aVjQdNQrXVYlEoYz4P78aj6Anzy5Ula3pl994TiKGCJnTUMhxVIJgGjRPtTUmPmmdD
 SXsLEP/uNefj9FbNxb6MrJCo0AsZvKyBp0SQoakyoNQcLpXjM/Tw9Kr6WQj3Z3cJsNFY
 upqy0tXsHqorwJsmOwLS818Me72lr9UugC2YhdQ6TkUapB5sAgDUxajPacWOuLtn/upl
 TX2Tdf68OdtDd3Ln00wZRLcqZ6LcR+7wpuSWxgLVlsIoewzmQRicN71mhRarA6KSdvzj
 JnH2V5uGXvcAb4pDf0GUwmFDm7OBKM+LJyIEd+YEsisDD+P0+d85eedoC9/h7gN40ZAP
 aNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tNqvSEr8X3/3ZjLjpEcLT+HicpFHjS0C2AZqviXv1Lk=;
 b=f2kxH3aICa6eseVvZGipxbcJ9KzxpwNS6/9qqSc/GSKE0a+u9cQRvaZAHPrBVzA0bU
 48v7GrH6aiz9EBT9oD7roZJQjneAbMA0i65fPj4QPZX+pHLjWO7wVi2HeRI4yMUBLbW8
 xWHpZzyLBAtbEw0HKABsyL/ymDB8HRq2GE6OJsltLBH3kJJGJKzfEq7e5sVhDR5+RgWm
 OD2Qy8xMdWjzRerNgssWk6nKsYbyCdoUJAK8ovZbRtTFjlQ7kF9GJ4iN0XKGZ4QlngAh
 oBGdKZ0bDQMRtkOx1U/GZROH6v6pdr8R4v1Ox9i/0RVQe+7JY7S5k53GNBpkheHA12Bt
 0ZzQ==
X-Gm-Message-State: APjAAAWApLRd9KngSIlS02gXWE7GccBLxPgAZ/Hhk3Q/zErNhrmosI+0
 tQZ3OH3DgZK5C2VGmXxoZR3SXA==
X-Google-Smtp-Source: APXvYqxPT9zEFefBvWaCs1oFlGUsEJ07PvXXX4jGlA2PTXlr17n3qf7zA+lXsAY4lTyempwmBAmbwA==
X-Received: by 2002:adf:9043:: with SMTP id h61mr34850359wrh.247.1567419686069; 
 Mon, 02 Sep 2019 03:21:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x15sm9011265wmc.16.2019.09.02.03.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 03:21:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 78AC31FF90;
 Mon,  2 Sep 2019 11:21:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon,  2 Sep 2019 11:21:13 +0100
Message-Id: <20190902102122.1128-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902102122.1128-1-alex.bennee@linaro.org>
References: <20190902102122.1128-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PULL 03/12] contrib/gitdm: filetype interface is not
 in order, fix
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

gitm prints the rather cryptic message "interface not found, appended
to the last order".  This is because filetypes.txt has filetype
interface, but neglects to mention it in order.  Fix that.

Fixes: 2f28271d807edfcdc47a280c06999dd866dcae10
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20190822122350.29852-2-armbru@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/contrib/gitdm/filetypes.txt b/contrib/gitdm/filetypes.txt
index 165b71b3f9a..2d5002fea0c 100644
--- a/contrib/gitdm/filetypes.txt
+++ b/contrib/gitdm/filetypes.txt
@@ -34,7 +34,7 @@
 #   If there is an filetype which is not in order but has values, it will
 #   be added at the end.
 #
-order build,tests,code,documentation,devel-doc,blobs
+order build,interface,tests,code,documentation,devel-doc,blobs
 
 #
 #
-- 
2.20.1


