Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA8CC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DE224655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbvRQWsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DE224655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuWke-0005R5-9T
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuWdW-0006AO-LE
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuWdV-0008EM-Ga
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29695
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuWdV-0008Dm-CI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579763441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eTnESgkc4Q1IE7eK3yhiRdRiKjKhsh/o/b9VSLnbvfo=;
 b=FbvRQWsjR2s0YC0HFxpmR4XsIEAog8l4rYeiAPPPLl66YgHMV2wUphJJQXTfw2gBhG1wxS
 XpxYq9MDtFGnvY3FhLK9sFSwP+ywtQwNc2X1KoHO3A8822VHeZblMxaMcCrFXPnYHCboen
 QH0akwJDxzecrClw70uei8zFFeZXyGc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-u1TTpu1tPHK1OuZW_TTEkg-1; Thu, 23 Jan 2020 02:10:39 -0500
Received: by mail-wm1-f69.google.com with SMTP id w205so603999wmb.5
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 23:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eAd3+nCoRQPzLOmjcY8CULrwvjv4VOu8uY/RSRtK8kQ=;
 b=LSOZCI1cl8bNe4WHEyzwbbihTXfeg1ni/FRV2bDcMchMQCDDGNELo4r7AmHw7/whKs
 dEJmf1aAQg0oyfEqtMFv2vq8PH+UFObo1BsiXPbg7l94inw0iPJZfAEnIVmfrxoe3wQd
 i2k8ezTItG5uEdS0Zh29oYZyvbAI6BvEtqk9trLZoW9YjPFIFwOWxRB05oc3ImahWdkv
 4jHu8GiJwm8OtkPM++FRplQ0EuWY+mFZQ0NPP4BrJtQ3Rm4REKDZRPaWexX1w3drE55n
 5ToBcrotjaHean1XBwA/f8TfdP9RwQDDccF/V6nRAfazQPVxD3/1qillrdcjkIWMSdlf
 63fw==
X-Gm-Message-State: APjAAAUKFuaKyrWxCB6pMXXVR5zH3mOm5FRx/EV0/3xKbuUswCrp/rwF
 T7dZT49uJgServ2xzq4faRxsxR3cX4DIgnWmG65ce2A7TYJ0LB7VBrjy/X6qgr1okh2sjUAnqk5
 X4l4yOnU6YRrOMT4=
X-Received: by 2002:a5d:4a8c:: with SMTP id o12mr15227755wrq.43.1579763437381; 
 Wed, 22 Jan 2020 23:10:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwzN3VAAz2iyEM6ziZRYkcooAJK6a5vGCwz2vG3AvnS7HPXkP9ZnZT+w598VRnZdw1IDosDQw==
X-Received: by 2002:a5d:4a8c:: with SMTP id o12mr15227726wrq.43.1579763437166; 
 Wed, 22 Jan 2020 23:10:37 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 f1sm1888607wru.6.2020.01.22.23.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 23:10:35 -0800 (PST)
Date: Thu, 23 Jan 2020 02:10:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 09/18] bios-tables-test: document expected file update
Message-ID: <20200123070913.626488-10-mst@redhat.com>
References: <20200123070913.626488-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123070913.626488-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: u1TTpu1tPHK1OuZW_TTEkg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Document the flow for the case where contributor
updates the expected files.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.=
c
index f1ac2d7e96..3ab4872bd7 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -16,7 +16,10 @@
  * 1. add empty files for new tables, if any, under tests/data/acpi
  * 2. list any changed files in tests/bios-tables-test-allowed-diff.h
  * 3. commit the above *before* making changes that affect the tables
- * Maintainer:
+ *
+ * Contributor or ACPI Maintainer (steps 4-7 need to be redone to resolve =
conflicts
+ * in binary commit created in step 6):
+ *
  * After 1-3 above tests will pass but ignore differences with the expecte=
d files.
  * You will also notice that tests/bios-tables-test-allowed-diff.h lists
  * a bunch of files. This is your hint that you need to do the below:
@@ -28,13 +31,23 @@
  * output. If not - disassemble them yourself in any way you like.
  * Look at the differences - make sure they make sense and match what the
  * changes you are merging are supposed to do.
+ * Save the changes, preferably in form of ASL diff for the commit log in
+ * step 6.
  *
  * 5. From build directory, run:
  *      $(SRC_PATH)/tests/data/acpi/rebuild-expected-aml.sh
- * 6. Now commit any changes.
- * 7. Before doing a pull request, make sure tests/bios-tables-test-allowe=
d-diff.h
- *    is empty - this will ensure following changes to ACPI tables will
- *    be noticed.
+ * 6. Now commit any changes to the expected binary, include diff from ste=
p 4
+ *    in commit log.
+ * 7. Before sending patches to the list (Contributor)
+ *    or before doing a pull request (Maintainer), make sure
+ *    tests/bios-tables-test-allowed-diff.h is empty - this will ensure
+ *    following changes to ACPI tables will be noticed.
+ *
+ * The resulting patchset/pull request then looks like this:
+ * - patch 1: list changed files in tests/bios-tables-test-allowed-diff.h.
+ * - patches 2 - n: real changes, may contain multiple patches.
+ * - patch n + 1: update golden master binaries and empty
+ *   tests/bios-tables-test-allowed-diff.h
  */
=20
 #include "qemu/osdep.h"
--=20
MST


