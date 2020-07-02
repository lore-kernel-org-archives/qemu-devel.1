Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78457C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B36206BE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsAADgQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B36206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1op-00051Z-H6
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jr1U3-0000mG-KS
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:50:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22279
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jr1Tf-0004rZ-TH
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593705011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ZbcF4CKKmOMd9yVAiIYK+v6LOZA1ZMgccQRpRxx6tE=;
 b=IsAADgQm2DqvAGhDXi+JWBkTASa/VU118gkREmg9zHLK/q4GGlTaoodq2WRBY6sL8DOXpz
 3+/hwfvcG28KYq44pX0hvGAGysL2Se0l4Jcmx8R0eiO0tD2W0p69pw3+WZWn1HclIa6FZJ
 XUwhpcwUcsjDkiY2b5W6CNj98OVkkoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-hyprgMJuO8u8g97fMRaOog-1; Thu, 02 Jul 2020 11:50:07 -0400
X-MC-Unique: hyprgMJuO8u8g97fMRaOog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 374618015FA;
 Thu,  2 Jul 2020 15:50:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0279177899;
 Thu,  2 Jul 2020 15:50:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DB97911358DE; Thu,  2 Jul 2020 17:50:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 21/44] qom: Use error_reportf_err() instead of g_printerr()
 in examples
Date: Thu,  2 Jul 2020 17:49:37 +0200
Message-Id: <20200702155000.3455325-22-armbru@redhat.com>
In-Reply-To: <20200702155000.3455325-1-armbru@redhat.com>
References: <20200702155000.3455325-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:00:43
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qom/object.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 94a61ccc3f..b70edd8cd9 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -671,8 +671,7 @@ Object *object_new(const char *typename);
  *                               NULL);
  *
  *   if (!obj) {
- *     g_printerr("Cannot create memory backend: %s\n",
- *                error_get_pretty(err));
+ *     error_reportf_err(err, "Cannot create memory backend: ");
  *   }
  *   </programlisting>
  * </example>
@@ -739,8 +738,7 @@ void object_apply_compat_props(Object *obj);
  *                          NULL);
  *
  *   if (!obj) {
- *     g_printerr("Cannot set properties: %s\n",
- *                error_get_pretty(err));
+ *     error_reportf_err(err, "Cannot set properties: ");
  *   }
  *   </programlisting>
  * </example>
-- 
2.26.2


