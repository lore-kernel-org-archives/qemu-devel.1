Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3287CC388F9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDE12080A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPXY+JN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDE12080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7wK-0007KT-KF
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX7qX-0002RP-NG
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:07:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX7qV-0006rh-I1
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603739274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwT4moo83BHvNKvdSJN7HO0ctYsohM97736gAr9OGRw=;
 b=GPXY+JN3tybvWrvl0rRwEm+6hVyQbXN8HUGngyWcAgfE+1iuJpiz+b0Two0RAw+qeoDBNU
 cTrMzQZpXEA11GXkTZiwZg7k7SKAy2bFtI0SILwFA8zNuDWDJc/YHoivYjWi4a8JHbH2xP
 I1K62jR1jbF/e8+V/N0QPd3Cm+oTGiU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-DzbVV4x2PLu78VMnlzJyEQ-1; Mon, 26 Oct 2020 15:07:51 -0400
X-MC-Unique: DzbVV4x2PLu78VMnlzJyEQ-1
Received: by mail-ej1-f72.google.com with SMTP id z25so5885817ejd.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 12:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pwT4moo83BHvNKvdSJN7HO0ctYsohM97736gAr9OGRw=;
 b=jnXD+6jM0ok3Wb0smBpCvPuDGQR6EQ8G8LXCsZNwk9KrBVlg92ozZNf99eGsrlK9US
 LXEJcyeobA48CvUZNRbQODuuSyEEcb/WVLx/4GmPcU1SZr+O4MFkYu/yarBsNjrk71o2
 u+HstK0OsOKl1PO7Ir3aKly51DQYZGA7JzkxQbw6cHmNfPl/VUtu6i6s78RK04yhFyhS
 vH+fTiyjqEtUcrQDef3WyBMlvOXrdMZ3si87wSdrpRv1+vJDwf9PN0ZyWZBVtq09/4ko
 oDtWkRIrUgDxVoGmLPWqV4d696lvpIA6sU9WeebcN9JSkMhHIQRz9B8gQuEXOIPnGa49
 q7/g==
X-Gm-Message-State: AOAM532n/WtZaesUJ7ybsqVbDuwFFxQGv+GhZiX0+l/Lf4AN1ByW76f5
 wxKnPcyu3Q5vl+S3zkK5hJL5/IVCx7N8hEJj0rGtH1BpPEKi6Pi3KGt33b80sL8uQcOJbqT13Ep
 WyFv9wewNP6Y/YSk=
X-Received: by 2002:aa7:d7ca:: with SMTP id e10mr17057869eds.269.1603739270138; 
 Mon, 26 Oct 2020 12:07:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/JgiqEbPPvQcO3+q+o0DOJwGqSkY8f/3/bRJ0Cxbh7gO45z7dybiWrS6hXpXuUli5S2dvTw==
X-Received: by 2002:aa7:d7ca:: with SMTP id e10mr17057743eds.269.1603739268834; 
 Mon, 26 Oct 2020 12:07:48 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id gy6sm6349930ejb.7.2020.10.26.12.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 12:07:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] docs/devel/testing.rst: Update outdated Avocado URLs
Date: Mon, 26 Oct 2020 20:07:26 +0100
Message-Id: <20201026190726.19515-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026190726.19515-1-philmd@redhat.com>
References: <20201026190726.19515-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avocado documentation referred returns 404 error.
Update the broken links.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20201010080741.2932406-1-philmd@redhat.com>
---
 docs/devel/testing.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 0c3e79d31cd..0aa7a13bbad 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -654,7 +654,7 @@ To manually install Avocado and its dependencies, run:
 
 Alternatively, follow the instructions on this link:
 
-  http://avocado-framework.readthedocs.io/en/latest/GetStartedGuide.html#installing-avocado
+  https://avocado-framework.readthedocs.io/en/latest/guides/user/chapters/installing.html
 
 Overview
 --------
@@ -837,7 +837,7 @@ Parameter reference
 To understand how Avocado parameters are accessed by tests, and how
 they can be passed to tests, please refer to::
 
-  http://avocado-framework.readthedocs.io/en/latest/WritingTests.html#accessing-test-parameters
+  https://avocado-framework.readthedocs.io/en/latest/guides/writer/chapters/writing.html#accessing-test-parameters
 
 Parameter values can be easily seen in the log files, and will look
 like the following:
-- 
2.26.2


