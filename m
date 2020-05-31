Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED216C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78E32074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2J8uC6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78E32074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfR6H-00043a-Qs
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0N-0002rX-47
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59100
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0L-0006u1-UP
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pSwnlYyy2B0PZW1yLAYRpAT/9w1HRsIxeqH6YbUmUyo=;
 b=e2J8uC6hmCkS989QZ1O8PZOGzdB4OAOw1MmSoZCXBo1hXOV4Z0S/P4QWIxndTJnEG9kfER
 hfZzn2vIYhZLA5twxSMDlYDG0SimTbSusKHBhG/sEDd8jLk+Cxy113hzRJNws01Qk8P2xZ
 yLgCS67AU9NS4CYctNo5Uh6Mds5ZDCk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-LPJBWbpIP1G3Nc2O5b__9A-1; Sun, 31 May 2020 12:40:07 -0400
X-MC-Unique: LPJBWbpIP1G3Nc2O5b__9A-1
Received: by mail-wr1-f70.google.com with SMTP id m14so1789763wrj.12
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pSwnlYyy2B0PZW1yLAYRpAT/9w1HRsIxeqH6YbUmUyo=;
 b=DumkzGPEF8DeK1tDEj129DM4ryF2l3i2A1gBjNJaDmDSM3fZ8StC236g/EPkMoi+Nm
 Qt70JWFTD4lWWo3FJ9Pc+RgTa1cz9g2CBQpyJlAJqPQBwJTdL/K0WIxuqt3bE01VpmRJ
 eh0pr/cGd+bBsohyMmrMW6Pfet+id++pqiRVXi5KcTh5wcf0w0VbNZIaGeS4LBk0npnZ
 +D8ru1GahvI3xxCitX6w9+7XeHiXPsykb8+R3WZ/IYK7A2lMxtCPmGlMGzuntbfK2FsW
 mEElNP2iheScERN4K8ppyl13lpHlLs+nufY9dlEDdgKubhTPW9u4/TfYn7a5X4V6mEFU
 Pl6w==
X-Gm-Message-State: AOAM533XGpcW2aKikZf8dZGN4xlUse1pn18G/0DRQ2SyOPHWeU6owWG/
 l8vEbXDfU/KrwhW1mOtBIPYXnjcPhU81x2XPKqfb+ov6kLEAzktMiCenr+ANViS9HBO48p3aHGF
 Ovg/nByXM5beFvLA=
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr6191171wmf.129.1590943206333; 
 Sun, 31 May 2020 09:40:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzK6EJL9ukNUJVtb0DzQQtMY6apR9VUSafpsaZhu2G7jdYEUit4j1V2cYWBkGwNjw7QAftH3A==
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr6191153wmf.129.1590943206180; 
 Sun, 31 May 2020 09:40:06 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id k16sm16048090wrp.66.2020.05.31.09.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:40:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/25] python/qemu/qmp: use True/False for non/blocking modes
Date: Sun, 31 May 2020 18:38:36 +0200
Message-Id: <20200531163846.25363-16-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:39:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

The type system doesn't want integers.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200514055403.18902-15-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/qmp.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index b91c9d5c1c..a634c4e26c 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -120,14 +120,14 @@ def __get_events(self, wait=False):
         """
 
         # Check for new events regardless and pull them into the cache:
-        self.__sock.setblocking(0)
+        self.__sock.setblocking(False)
         try:
             self.__json_read()
         except OSError as err:
             if err.errno == errno.EAGAIN:
                 # No data available
                 pass
-        self.__sock.setblocking(1)
+        self.__sock.setblocking(True)
 
         # Wait for new events, if needed.
         # if wait is 0.0, this means "no wait" and is also implicitly false.
-- 
2.21.3


