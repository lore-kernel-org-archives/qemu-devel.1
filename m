Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80E1C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 08:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770BE20829
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 08:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGcrL+KS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770BE20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Qpx-0004cQ-NL
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 04:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k1Qoy-0003O3-1U
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 04:55:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56983
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k1Qow-0008Ag-Fc
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 04:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596185717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wu8Rc6eY4ey6WmkOwRjSnVil7pcllEVWfjJR7NyKsoM=;
 b=XGcrL+KSPc+Np9o67vaWNSWxD9DCthbGQVdtfppJA5zR5faDvJy7akWb614ZQt1ES/Z6eI
 e5zJLXSrMiP8xAwMtmNewX4He40qX48rNZmhhyxWgSMgYBc6jaQdY26ifYmNYbtxZrPEWb
 1u4mmdlMPy+aZwdchWDFH8UMoG5ZP9U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-3HMiOIe8PHam9N10d7Pycg-1; Fri, 31 Jul 2020 04:55:14 -0400
X-MC-Unique: 3HMiOIe8PHam9N10d7Pycg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E064418839C0;
 Fri, 31 Jul 2020 08:55:13 +0000 (UTC)
Received: from localhost (ovpn-113-36.ams2.redhat.com [10.36.113.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BB7F6179D;
 Fri, 31 Jul 2020 08:55:10 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/1] s390x/s390-virtio-ccw: fix off-by-one in loadparm getter
Date: Fri, 31 Jul 2020 10:55:03 +0200
Message-Id: <20200731085503.9008-2-cohuck@redhat.com>
In-Reply-To: <20200731085503.9008-1-cohuck@redhat.com>
References: <20200731085503.9008-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 02:46:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Halil Pasic <pasic@linux.ibm.com>

As pointed out by Peter, g_memdup(ms->loadparm, sizeof(ms->loadparm) + 1)
reads one past of the end of ms->loadparm, so g_memdup() can not be used
here.

Let's use g_strndup instead!

Fixes: d6645483285f ("s390x/s390-virtio-ccw: fix loadparm property getter")
Fixes: Coverity CID 1431058
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200730130156.35063-1-pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 403d30e13bca..e72c61d2eae0 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -701,12 +701,9 @@ bool hpage_1m_allowed(void)
 static char *machine_get_loadparm(Object *obj, Error **errp)
 {
     S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
-    char *loadparm_str;
 
     /* make a NUL-terminated string */
-    loadparm_str = g_memdup(ms->loadparm, sizeof(ms->loadparm) + 1);
-    loadparm_str[sizeof(ms->loadparm)] = 0;
-    return loadparm_str;
+    return g_strndup((char *) ms->loadparm, sizeof(ms->loadparm));
 }
 
 static void machine_set_loadparm(Object *obj, const char *val, Error **errp)
-- 
2.25.4


