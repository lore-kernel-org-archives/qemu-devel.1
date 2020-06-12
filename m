Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EE2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9376B206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdOH7hVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9376B206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlTO-0008Bo-RQ
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl4O-00031E-SF
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:54:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39361
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl4L-0001qM-Bw
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kAMCwY6Ii66tK0+En6xfr/Bb9/oeXHnOnpsD9bdoRBE=;
 b=WdOH7hVHgOMP3BZKyoW2QxkNbfsnn3pS8zpY9w1gGMKTIOLzfXXTKEJtebPmOf2bgbh+PA
 t2Ume63wxjvehOJzVQt43zRNtW6JDgHk1V5gnBy2pjNwu3UECEHR4NfpBK12G0nH+vvaQV
 Rlo/whCfuUwYPSAje8Qpf6S/dq3R4qY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-Mq-_R6AQOmuj616quP0hUQ-1; Fri, 12 Jun 2020 10:51:08 -0400
X-MC-Unique: Mq-_R6AQOmuj616quP0hUQ-1
Received: by mail-wm1-f69.google.com with SMTP id 14so2514374wmi.8
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kAMCwY6Ii66tK0+En6xfr/Bb9/oeXHnOnpsD9bdoRBE=;
 b=RS31XClJksoXok4zWF04mG7M+/uBliU6+IXV8cSMSDghHCWmfBxJOXitRP3ggOj7o1
 JxhV9MYboT0snw7qX3gMDzaTlaMNWre1lSfnOXsJIO9xYRkpHPXGAveGjAJbYLVR6cJW
 Q5XFD/1M+RIy0kqClIGJF9fEaHQFDQ7wuorA5OAWh9MurGWpgMCDjU1Ml8uN69WB/M1S
 sS42GN/J+eSdfzgF6rtjWWDQsPeSzM4ORoF4oX/YdwaO/ceXB/NujJEcMgoAJvtiyovR
 wMxvrr0HvLtpDotFjuyUZF9hslDDn81UIosJxGzy1Z0t532s9E3ulsXN9/yUmWrc4ogC
 a4AA==
X-Gm-Message-State: AOAM531oWTURTO8eqb2gsbo8T+tNTB6EdNVtlZJPG7SVA9cZIFEEUZbs
 2a0CEbHXe9C3KOkHeCNNuNs2KgPCjkzTzhNqYHMCiTyGNMGYtqLmLRTrmofFMvsxFArfTtk6XAI
 zsOiQXU8XeiZwBqU=
X-Received: by 2002:a7b:cd06:: with SMTP id f6mr13653110wmj.8.1591973466926;
 Fri, 12 Jun 2020 07:51:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPXfXfB2hD4f9KCExUVh69jj9NTS6oEjhg0FSx7DpxEgZeRUv4OhDvqW4bHksYZYUVgLjrQw==
X-Received: by 2002:a7b:cd06:: with SMTP id f6mr13653092wmj.8.1591973466723;
 Fri, 12 Jun 2020 07:51:06 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id o10sm10407217wrq.40.2020.06.12.07.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:06 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 02/58] diffs-allowed: add the SRAT AML to diffs-allowed
Message-ID: <20200612141917.9446-3-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 09:30:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Vishal Verma <vishal.l.verma@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vishal Verma <vishal.l.verma@intel.com>

In anticipation of a change to the SRAT generation in qemu, add the AML
file to diffs-allowed.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Message-Id: <20200606000911.9896-2-vishal.l.verma@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..e8f2766a63 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,4 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/SRAT.dimmpxm",
+"tests/data/acpi/q35/SRAT.dimmpxm",
+"tests/data/acpi/virt/SRAT.memhp",
-- 
MST


