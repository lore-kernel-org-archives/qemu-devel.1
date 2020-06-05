Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491BFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:38:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D8C2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEF2buCR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D8C2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFMp-00028v-D6
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhFLw-000124-HN
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:37:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38019
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhFLv-0007Rq-2K
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591375073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=98qgKBh5fH8KCi85m1CSGYKJMMXRY6XnMEUwXUwkDZ0=;
 b=WEF2buCRaP8cEp0GLSzjkly7lgwaQxIzUUonLvqsQWeJ9PjPpNAgVYHiecFyV5TFMMja+X
 VFkwPlFvPC1cOb42f30iyQtVuUNiar7YHX93tgwbeN6i3aYpjiXf03MnoQlWvcaLfulfT/
 Ep+FH1Y+j73M6iFahy1sDRU215dycVE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-mKYrs3EfNXCUlIVcr0H2IA-1; Fri, 05 Jun 2020 12:37:52 -0400
X-MC-Unique: mKYrs3EfNXCUlIVcr0H2IA-1
Received: by mail-wr1-f70.google.com with SMTP id d6so3984429wrn.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=98qgKBh5fH8KCi85m1CSGYKJMMXRY6XnMEUwXUwkDZ0=;
 b=C+UTJGlzFdYzN0MND6Pm+Ypy3tggasbgnwVdRMxERB8jMPxVFPjfqrPai0sPFncs8b
 tSBgBi7KGpccrWks64FgOikbDO10pJgn0Ey7MEeY0lO9zW/B1lkItxH12hOlE7scM7+8
 doHWhixG6V7N1TAuOO9bCFHgOQ67suOnY+FKqX766ayMuTdY38yBZUflUfUZ3jTIepiG
 v62cwzLthdCrbUgvK6xq++akiguqIF3dHyuk4v6H1r/mxw+6t5kXewOKtcMxVjZpJ5hW
 QrwwjQ6YVwIZsI/lsgAKLLY4mlLspVjpQ3ui7D55e2ixvQ5rcK+SsBnijuZyyOP1QSVt
 Op1g==
X-Gm-Message-State: AOAM533R3wStUEnvzTMWTXB8VaKvbi3IVNOxZ4nefia3MaTkmwvH3a0e
 noLLu7ldq+1F+s2pOTcP/Q6jwb7/KyC92OZUYFiySuTBgqPYEvAoZbNxkE/mqbrW8Ztr+VZUt9M
 zlyEGTojpzx6JJ88=
X-Received: by 2002:adf:dccc:: with SMTP id x12mr10235515wrm.72.1591375070781; 
 Fri, 05 Jun 2020 09:37:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVt/qITuRNR0feGAJAg9/RgrY4AX3krhPw+YgNYv8ISRguIx4xpEJDEuK+i0Gv009+AUWqZw==
X-Received: by 2002:adf:dccc:: with SMTP id x12mr10235496wrm.72.1591375070604; 
 Fri, 05 Jun 2020 09:37:50 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id s132sm12444779wmf.12.2020.06.05.09.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:37:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: Cover pip requirements.txt
Date: Fri,  5 Jun 2020 18:37:48 +0200
Message-Id: <20200605163748.15345-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an entry in 'Python scripts' to cover the requirements.txt
file added in commit 213137217a6 (this file contains a list of
Python packages used by our test suite).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e7d9cb0a5..fc4148fba3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2219,6 +2219,7 @@ S: Odd fixes
 F: python/qemu/*py
 F: scripts/*.py
 F: tests/*.py
+F: tests/requirements.txt
 
 Benchmark util
 M: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
-- 
2.21.3


