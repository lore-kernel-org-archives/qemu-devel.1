Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C12FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C07320809
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqxO73FV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C07320809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJNy-0002Gk-Om
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mgamal@redhat.com>) id 1jmJMT-000066-Pv
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:55:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56923
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mgamal@redhat.com>) id 1jmJMQ-00080u-QE
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592582122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pVIj3XToIh5tz8Pv5AGHQXu5eJDH366pzw6sKsocPMQ=;
 b=OqxO73FVV9vj/O+mT2DIgM6oxPOnmn0/ZHbYoLH9LZPefDFl5tSvru3i/CsRgO156YjlzT
 t9fN6YkO+xYsBQNNDaLl9sZfosdjtkjGiKnTf9j7KpJvKWISrHnP9jMe3D4z2fzhyJoUMJ
 Ikv1omIVodaplEiSoqLMkf04UdPaYoU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-r3sINLJfNJWXNnUfvXQW3g-1; Fri, 19 Jun 2020 11:54:00 -0400
X-MC-Unique: r3sINLJfNJWXNnUfvXQW3g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDB828730B3;
 Fri, 19 Jun 2020 15:53:57 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-254.ams2.redhat.com
 [10.36.112.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8CF15BAD3;
 Fri, 19 Jun 2020 15:53:54 +0000 (UTC)
From: Mohammed Gamal <mgamal@redhat.com>
To: qemu-devel@nongnu.org,
	pbonzini@redhat.com
Subject: [PATCH 2/2] x86/cpu: Handle GUEST_MAXPHYADDR < HOST_MAXPHYADDR for
 hosts that don't support it
Date: Fri, 19 Jun 2020 17:53:44 +0200
Message-Id: <20200619155344.79579-3-mgamal@redhat.com>
In-Reply-To: <20200619155344.79579-1-mgamal@redhat.com>
References: <20200619155344.79579-1-mgamal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mgamal@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 05:19:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: mtosatti@redhat.com, Mohammed Gamal <mgamal@redhat.com>,
 ehabkost@redhat.com, kvm@vger.kernel.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the CPU doesn't support GUEST_MAXPHYADDR < HOST_MAXPHYADDR we
let QEMU choose to use the host MAXPHYADDR and print a warning to the
user.

Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
 target/i386/cpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b1b311baa2..91c57117ce 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6589,6 +6589,17 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             uint32_t host_phys_bits = x86_host_phys_bits();
             static bool warned;
 
+	    /*
+	     * If host doesn't support setting physical bits on the guest,
+	     * report it and return
+	     */
+	    if (cpu->phys_bits < host_phys_bits &&
+		!kvm_has_smaller_maxphyaddr()) {
+		warn_report("Host doesn't support setting smaller phys-bits."
+			    " Using host phys-bits\n");
+		cpu->phys_bits = host_phys_bits;
+	    }
+
             /* Print a warning if the user set it to a value that's not the
              * host value.
              */
-- 
2.26.2


