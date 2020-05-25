Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37789C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36732073B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb6Ju+8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36732073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdEj8-0007JO-7M
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEh2-0005XE-EZ
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:07:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36768
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEh1-0006hf-KN
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590419227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MQWYf2QYcqkNIHTPoPqPd3tJF9br/Kx677vEgu609W8=;
 b=eb6Ju+8FLKlOXVpCihRdXAqRVO6tACGqR82FB7+ITVc2hUoLnioRgUCerKQ1I6Z5UFYYV6
 DslNpGPg5Rz67X563eTTq6U+pF1G97huTRBGEwXfhEczjC5hhZlzcKsLwQOc1KlJIt5C1e
 r9xRzTnHUH+SRQNB0wcnffXC5XpssuY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-jh9kXP0HOzG1G2IJbjJbgQ-1; Mon, 25 May 2020 11:07:03 -0400
X-MC-Unique: jh9kXP0HOzG1G2IJbjJbgQ-1
Received: by mail-ej1-f72.google.com with SMTP id s13so6379623ejc.18
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 08:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MQWYf2QYcqkNIHTPoPqPd3tJF9br/Kx677vEgu609W8=;
 b=CZNJj1MEIeGHeZBcI6QdNLJB8lpGnmDp7rpzoyaABlB8lGQMr2/ASIBigaD2uIAtJL
 CZxYltUHMBpG+v95B7C6ru3s+KUUbrOhtJNvCl89a6xLaq1oaVMjjxnUXn6qjm0h7saX
 iY7ZJWW4sal1FKJlYx/e7/0+MxdvMWm72gGsJ14aIrNHg7QWQbiRwcyo7bMo/cK1orRt
 OFMHvsby2GWcrEaWLKSMyu6iy06nCGRG4KoP/d496rDe9q0rYw1M/hKoy3apLbV0+hgd
 4QtsUhzmr0wn3Z78VFAUcy9hi8A/sRlxo+l1fWSm4w7Cj7R6dNrVha5irSpWghsV4X/i
 ozrA==
X-Gm-Message-State: AOAM533Ov4UdaMvyJiZnWnopoFhYJeAtQxdkQ6fe3OEqUIzKhYf0dvC1
 mve4WWBubn615Uqlq0UBRrGPvBY9jaY+qOwx7vgWf9+ToFdXfD+qbZp2xP+moFHxrwyObhAichh
 FpOZRhxByrr/T0RA=
X-Received: by 2002:a17:906:d86:: with SMTP id
 m6mr20137740eji.434.1590419222213; 
 Mon, 25 May 2020 08:07:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiLti9ujl8zPGB3BoWaIdOxK2Mxmt4QWp+2GEsLKO7ZN/1WHhN/x7yMWjaYTOPSjCoeELqnQ==
X-Received: by 2002:a17:906:d86:: with SMTP id
 m6mr20137701eji.434.1590419221912; 
 Mon, 25 May 2020 08:07:01 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id y13sm15544110ejm.107.2020.05.25.08.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 08:07:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/9] qapi/misc.json: Correct balloon documentation
Date: Mon, 25 May 2020 17:06:34 +0200
Message-Id: <20200525150640.30879-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200525150640.30879-1-philmd@redhat.com>
References: <20200525150640.30879-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 08:28:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ben Warren <ben@skyportsystems.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The documentation incorrectly uses the "size of the balloon"
description when it should be "logical size of the VM". Fix it.

The relation between both values is:

  logical_vm_size = vm_ram_size - balloon_size

Reported-by: David Hildenbrand <david@redhat.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/misc.json | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 2c48ffaa62..446fc8ff83 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -191,7 +191,8 @@
 #
 # Information about the guest balloon device.
 #
-# @actual: the number of bytes the balloon currently contains
+# @actual: the logical size of the VM in bytes
+#          Formula used: logical_vm_size = vm_ram_size - balloon_size
 #
 # Since: 0.14.0
 #
@@ -227,7 +228,8 @@
 # Emitted when the guest changes the actual BALLOON level. This value is
 # equivalent to the @actual field return by the 'query-balloon' command
 #
-# @actual: actual level of the guest memory balloon in bytes
+# @actual: the logical size of the VM in bytes
+#          Formula used: logical_vm_size = vm_ram_size - balloon_size
 #
 # Note: this event is rate-limited.
 #
@@ -756,7 +758,10 @@
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
@@ -774,6 +779,8 @@
 # -> { "execute": "balloon", "arguments": { "value": 536870912 } }
 # <- { "return": {} }
 #
+# With a 2.5GiB guest this command inflated the ballon to 3GiB.
+#
 ##
 { 'command': 'balloon', 'data': {'value': 'int'} }
 
-- 
2.21.3


