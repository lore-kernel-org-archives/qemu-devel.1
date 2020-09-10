Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABC6C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FDF20C09
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiwSQce8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FDF20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGOSd-0008K5-5X
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 11:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGOPT-0003f9-AF
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:22:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57320
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGOPQ-000816-QH
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599751368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aU61XF2iw8CsgjICtHQ/mc0+U4DSy1u0xwIZtbOf8Pc=;
 b=PiwSQce8SRZ237rvkGdbyMPU6Qatv9ZoYnXn0m3lD5QfHtkSjMvxg0M2gTSYWGDgO8G73t
 KgrS0CPILJT85ipmqnl/m6iXcZKgKwFwn7kD42PDpqNDBCnOATHOhJ2X2p9xkV1RPTfnAZ
 M3b3rTaCIvJ+nWB1DVVETD+6kRiQ7ww=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-G4QMHMumMEigxRJzlxUyVg-1; Thu, 10 Sep 2020 11:22:46 -0400
X-MC-Unique: G4QMHMumMEigxRJzlxUyVg-1
Received: by mail-wm1-f69.google.com with SMTP id l26so119769wmg.7
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 08:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aU61XF2iw8CsgjICtHQ/mc0+U4DSy1u0xwIZtbOf8Pc=;
 b=Qlj1lODHY9cgwMNcDDb4NDsYarCK0DJmyHWwGGnx8NRlAevsjuQcR5tFYXSsngkwN1
 Y0bfQ8QgEEU9YFhl0SGW+LBgqafQgZ0/LC9PCqfRUA5Wo7ViZmZxgn210g3MgzfV/CAb
 hY5Ch5/3wio1TAbPLI8F3HN0Q5HAaPxP9ublX06SLYdRGPSJTi4IAhGWKxY098r5H3uI
 UH///soI6tr3HX+lWkCoIAlAAOMTg/fwQ12W9a7/6P3UhiDsqHp7D2KKEQWvgC5F44F4
 +fxyK+IVq29hJGie0qMmVxiY7qN/ZG9/hYV2GMPqzP19+mnlJQJ4AgQVtFL0w+BKhIit
 cpHw==
X-Gm-Message-State: AOAM531sbCY4JvQGmOGGKTLpm8u6stfA/OkHPc+reb4dZXk/8S5xusEM
 561iCz9AlYVn93YCLu/pYhG1Kip90bXO0Zpcd1RviD3TrpyRz4RIrrMa9cH3IgYm3cbl/l2h8YB
 Ek1BNowcpffZx6EA=
X-Received: by 2002:a1c:96:: with SMTP id 144mr545156wma.84.1599751364563;
 Thu, 10 Sep 2020 08:22:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuSyW1m8MirtWlezIlKFdwxgvvcDVaVY2J/rTTHdvbnXc3LSStI3zetmtLsSn1F1o80NrVNg==
X-Received: by 2002:a1c:96:: with SMTP id 144mr545138wma.84.1599751364320;
 Thu, 10 Sep 2020 08:22:44 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id d13sm9286484wrp.44.2020.09.10.08.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 08:22:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/9] qapi: Correct balloon documentation
Date: Thu, 10 Sep 2020 17:22:19 +0200
Message-Id: <20200910152225.524322-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910152225.524322-1-philmd@redhat.com>
References: <20200910152225.524322-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:38:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The documentation incorrectly uses the "size of the balloon"
description when it should be "logical size of the VM". Fix it.

The relation between both values is:

  logical_vm_size = vm_ram_size - balloon_size

Reported-by: David Hildenbrand <david@redhat.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/misc.json | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index b21963a176d..a667fdf03e5 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -192,7 +192,8 @@
 #
 # Information about the guest balloon device.
 #
-# @actual: the number of bytes the balloon currently contains
+# @actual: the logical size of the VM in bytes
+#          Formula used: logical_vm_size = vm_ram_size - balloon_size
 #
 # Since: 0.14.0
 #
@@ -228,7 +229,8 @@
 # Emitted when the guest changes the actual BALLOON level. This value is
 # equivalent to the @actual field return by the 'query-balloon' command
 #
-# @actual: actual level of the guest memory balloon in bytes
+# @actual: the logical size of the VM in bytes
+#          Formula used: logical_vm_size = vm_ram_size - balloon_size
 #
 # Note: this event is rate-limited.
 #
@@ -759,7 +761,10 @@
 #
 # Request the balloon driver to change its balloon size.
 #
-# @value: the target size of the balloon in bytes
+# @value: the target logical size of the VM in bytes
+#         We can deduce the size of the balloon using this formula:
+#            logical_vm_size = vm_ram_size - balloon_size
+#         From it we have: balloon_size = vm_ram_size - @value
 #
 # Returns: - Nothing on success
 #          - If the balloon driver is enabled but not functional because the KVM
@@ -777,6 +782,8 @@
 # -> { "execute": "balloon", "arguments": { "value": 536870912 } }
 # <- { "return": {} }
 #
+# With a 2.5GiB guest this command inflated the balloon to 3GiB.
+#
 ##
 { 'command': 'balloon', 'data': {'value': 'int'} }
 
-- 
2.26.2


