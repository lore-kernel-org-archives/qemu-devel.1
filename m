Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08160C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67FA206C0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hButAgq8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67FA206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZdP2-0003Wb-Ap
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 12:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdEf-000803-AG
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:30:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53323
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdEe-0001k6-Kv
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589560256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MlwAsFx7qZJhpUw9yV0U2104dkmNaPniQZ/O8ObnvZY=;
 b=hButAgq8OosvfIzmhX1tN+wlJu0IwiDsk3uJZWRmaTR7k1lnVIHVCfjyHAv5bBHurfwxC6
 1DKW85vZS7/QG6lAaMIK/UaG4cpW3ySWXqTuoWZwChk/37T3lkMET1ZzItJzWqICxR9dfw
 uZvbaZvkdC4wrTkQI9PslBa9683hWNU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-4IfYEPh_NsCiuNWKk5T8LQ-1; Fri, 15 May 2020 12:30:54 -0400
X-MC-Unique: 4IfYEPh_NsCiuNWKk5T8LQ-1
Received: by mail-wm1-f69.google.com with SMTP id t82so1128960wmf.4
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 09:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MlwAsFx7qZJhpUw9yV0U2104dkmNaPniQZ/O8ObnvZY=;
 b=lC2rkFLpPLYMKYN9X4pzP03XSiBs9t66yLTpf31O2prcq7jMd2Gxaoe/9bH6wO8Hfg
 NtallFNhpZV5r/x0HgNVs1qxKLe9L7lA9N0WOa6qA3Jj6xPstD0BBslMallSOHvjeAjH
 9s5voPJkD1KsgFNuMz8kjXui5nlFsQmXrVz13/pERS7XmbvEHkKZ6VhLPxVr5KPUceSQ
 lNoWy8KQ3sDBVw/vStljQL8hwI7HTFXi4QPa8U6qkev+HOrmSiM5D3HfB051/W6FMD0l
 3rCpkUG+ai9qVSCNY83D0dAg8KJdLFLp1kAsHUC0kv7s2XkVUk01nS0DaVRJyVM5BSye
 yMHA==
X-Gm-Message-State: AOAM533I87Wy4E1sGmG6lO5UQ7Oo3njwrslU0xpo0JWOIAH4Ouu/7j4i
 ZLcSIz65kp3hefJt4iC0wf2OtGymeoe0K0OT/o6PlC+AzTeWLqkfvO4HO/UJ7iR/Sa3JioDTkbz
 YRkITouSJcTSXn9Y=
X-Received: by 2002:a5d:604b:: with SMTP id j11mr5008234wrt.193.1589560252855; 
 Fri, 15 May 2020 09:30:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYN3QMXAM+RElvusEhgJ3ndtHjnofJqsedjH96rWZ8jlGt1feyThWdofPDVTtgstn8J1ZBHA==
X-Received: by 2002:a5d:604b:: with SMTP id j11mr5008217wrt.193.1589560252691; 
 Fri, 15 May 2020 09:30:52 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id j2sm4373178wrp.47.2020.05.15.09.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 09:30:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] cirrus-ci: Remove flex/bison packages
Date: Fri, 15 May 2020 18:30:28 +0200
Message-Id: <20200515163029.12917-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200515163029.12917-1-philmd@redhat.com>
References: <20200515163029.12917-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU does not use flex/bison packages.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .cirrus.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index de0727cb09..ce7850a320 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -7,7 +7,7 @@ freebsd_12_task:
     cpu: 8
     memory: 8G
   install_script: ASSUME_ALWAYS_YES=yes pkg bootstrap -f ; pkg install -y
-    bash bison curl cyrus-sasl git glib gmake gnutls gsed
+    bash curl cyrus-sasl git glib gmake gnutls gsed
     nettle perl5 pixman pkgconf png usbredir
   script:
     - mkdir build
-- 
2.21.3


