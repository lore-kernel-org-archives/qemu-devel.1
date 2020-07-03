Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6BDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3CCF20720
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwrBsrgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CCF20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrIlY-0005lR-1e
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jrIbo-0004VK-3G
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:07:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43876
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jrIbh-0005pC-TY
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593770865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QD0N/uKfSfOkfoCWH5z+rUHr3iQlE/62wTPwUfJqJ1w=;
 b=IwrBsrgvQvQwoaQmOnvVPkVGuO9ChnwQ46YaV3TLdKBrPJPmFYRkO64ILeHu+v8JfkNSzR
 q4ajrjNb5dpK4j60mNA0WIaUJvnouun7vA3g6q67M2yNfDrlSMe+8lKH/rz1Pn5kNxXBld
 Be2KruRvV8uGO80zvAlVjaH89B3ijb0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-QMGwU6U2NzSK-iXjSBaRjg-1; Fri, 03 Jul 2020 06:07:40 -0400
X-MC-Unique: QMGwU6U2NzSK-iXjSBaRjg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A4071883619;
 Fri,  3 Jul 2020 10:07:39 +0000 (UTC)
Received: from localhost (ovpn-113-54.ams2.redhat.com [10.36.113.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3641673FEF;
 Fri,  3 Jul 2020 10:07:36 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/14] target/s390x: Fix SQXBR
Date: Fri,  3 Jul 2020 12:06:48 +0200
Message-Id: <20200703100650.621212-13-cohuck@redhat.com>
In-Reply-To: <20200703100650.621212-1-cohuck@redhat.com>
References: <20200703100650.621212-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The output is 128-bit, and thus requires a pair of 64-bit temps.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Buglink: https://bugs.launchpad.net/bugs/1883984
Message-Id: <20200620042140.42070-1-richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/insn-data.def | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 91ddaedd8475..d79ae9e3f114 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -798,7 +798,7 @@
 /* SQUARE ROOT */
     F(0xb314, SQEBR,   RRE,   Z,   0, e2, new, e1, sqeb, 0, IF_BFP)
     F(0xb315, SQDBR,   RRE,   Z,   0, f2, new, f1, sqdb, 0, IF_BFP)
-    F(0xb316, SQXBR,   RRE,   Z,   x2h, x2l, new, x1, sqxb, 0, IF_BFP)
+    F(0xb316, SQXBR,   RRE,   Z,   x2h, x2l, new_P, x1, sqxb, 0, IF_BFP)
     F(0xed14, SQEB,    RXE,   Z,   0, m2_32u, new, e1, sqeb, 0, IF_BFP)
     F(0xed15, SQDB,    RXE,   Z,   0, m2_64, new, f1, sqdb, 0, IF_BFP)
 
-- 
2.25.4


