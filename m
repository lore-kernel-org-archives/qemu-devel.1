Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E318FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0BE206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGfU3Zv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0BE206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFkr-0003AT-Vv
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhFeV-0008Pu-9m
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:57:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56313
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhFeT-0002uI-RG
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591376224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TQ4y6o8S8Tg0BfMwcpb9oDlHzXuxWL3yKaNDx3j2kfo=;
 b=aGfU3Zv9Ui5cjPayQl2qhhgApBHl+w50baxSC4P2LdUcO0CkET2Wjbxthl7wjHrP5O8Ity
 VUrmbSRARKOgHT5ZBtBKIwmzPRbjj5WF5S6zAN8dSjPkqVI9Z2WBBxVR/QCtEe9rsS+Qmp
 bqw1qhzT7xoMAb5foxR1npLQP+0vWYs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-zNkm5-HfO361CAz2J8GNzA-1; Fri, 05 Jun 2020 12:57:00 -0400
X-MC-Unique: zNkm5-HfO361CAz2J8GNzA-1
Received: by mail-wr1-f70.google.com with SMTP id p10so4013784wrn.19
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TQ4y6o8S8Tg0BfMwcpb9oDlHzXuxWL3yKaNDx3j2kfo=;
 b=DRsEhHvvOgLZz8eDBzeOzC605OU5Q/eWIh2voiFJw+pcGoEgG0WelmgQPsii8Disx5
 mE0vVV7PD+dVRQvHJTd+len2DKTRUIkn+pW86yhYBpw1SmDzReBIYqcUVWBWUWvXgW63
 lrlRa6QpABkK0EvdHSqDJ/II929sesZKZYwb0jmkOfGz/mpfAkF6Bm90XVvmrRjCA9Gb
 n2eZmG2Va0TRh7tmvmF/jZ384pxQWYApc8Gv1wHM7ADpKTz0f4uTYrbovSfSdNshLJW7
 Uh8XNGxyspMXOoa+4iXhQl0Gh1rmiRfmJv3OADa73cdPczFK52OAr8fi5Kc+J+yhu8q8
 PUJQ==
X-Gm-Message-State: AOAM532FC8SeFw4eaBp4plgGlZidDLxNZvcP1xDgdiBk6bvlLnX704Py
 26hIfAwXozmtaA+TlpvRvnX/It/N1S9atrR+353RcrNsrF0Si4jF+xrRGDkVTPU+UK3IoUd0g/L
 HjEnYRsmoLYgdlBk=
X-Received: by 2002:a1c:7206:: with SMTP id n6mr3768975wmc.4.1591376219400;
 Fri, 05 Jun 2020 09:56:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsVwuQU34RCokDzBEiso7XAemzTsuzS0XlvjCJrC2w7UJBkDShBEFfcjOPmng/avq1PkiT8g==
X-Received: by 2002:a1c:7206:: with SMTP id n6mr3768953wmc.4.1591376219177;
 Fri, 05 Jun 2020 09:56:59 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y80sm13136573wmc.34.2020.06.05.09.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:56:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: Add an entry to review Avocado based acceptance
 tests
Date: Fri,  5 Jun 2020 18:56:56 +0200
Message-Id: <20200605165656.17578-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an entry for to allow reviewers to be notified when acceptance /
integration tests are added or modified.
The designated reviewers are not maintainers, subsystem maintainers
are expected to merge their tests.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e7d9cb0a5..c2ae2bf390 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2923,6 +2923,14 @@ S: Maintained
 F: tests/tcg/Makefile
 F: tests/tcg/Makefile.include
 
+Acceptance (Integration) Testing with the Avocado framework
+W: https://trello.com/b/6Qi1pxVn/avocado-qemu
+R: Cleber Rosa <crosa@redhat.com>
+R: Philippe Mathieu-Daudé <philmd@redhat.com>
+R: Wainer dos Santos Moschetta <wainersm@redhat.com>
+S: Odd Fixes
+F: tests/acceptance/
+
 Documentation
 -------------
 Build system architecture
-- 
2.21.3


