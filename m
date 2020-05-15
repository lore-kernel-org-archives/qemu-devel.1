Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53356C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF1C206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hidp0Bek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF1C206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZTeq-0006Wf-8Y
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 02:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTSX-0003Bs-Ld
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:04:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46741
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTSU-0004S9-0e
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589522673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EDutmp6QRXUlvxzC29vVl5P4mh9q50bv87FKPAKQfvM=;
 b=hidp0BekzXPu2flCi9QOZtijzDT0bB3VPp1Re6r2FgMR1A9ouhwS9dcituzYqzLKYjil+X
 OwYZAZMW5gfm0lTbrBZ93S39jGr80d50g/vr2It9MpLQ3HdHYeN7Tvk8R1Y4gy/0pB007v
 s6XhXZ9fuUhnt3Jn/0qe/zIthiUJbEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-7mBFkkkvPyenjYcbqsF04A-1; Fri, 15 May 2020 02:04:31 -0400
X-MC-Unique: 7mBFkkkvPyenjYcbqsF04A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C2AABFD8;
 Fri, 15 May 2020 06:04:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 372926E719;
 Fri, 15 May 2020 06:04:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 459AC11358C5; Fri, 15 May 2020 08:04:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/21] s390x/cpumodel: Fix UI to CPU features pcc-cmac-{aes,
 eaes}-256
Date: Fri, 15 May 2020 08:04:12 +0200
Message-Id: <20200515060424.18993-10-armbru@redhat.com>
In-Reply-To: <20200515060424.18993-1-armbru@redhat.com>
References: <20200515060424.18993-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both s390_features[S390_FEAT_PCC_CMAC_AES_256].name and
s390_features[S390_FEAT_PCC_CMAC_EAES_256].name is
"pcc-cmac-eaes-256".  The former is obviously a pasto.

Impact:

* s390_feat_bitmap_to_ascii() misidentifies S390_FEAT_PCC_CMAC_AES_256
  as "pcc-cmac-eaes-256".  Affects QMP commands query-cpu-definitions,
  query-cpu-model-expansion, query-cpu-model-baseline,
  query-cpu-model-comparison, and the error message when
  s390_realize_cpu_model() fails in check_compatibility().

* s390_cpu_list() also misidentifies it.  Affects -cpu help.

* s390_cpu_model_register_props() creates CPU property
  "pcc-cmac-eaes-256" twice.  The second one fails, but the error is
  ignored (a later commit will change that).  Results in a single
  property "pcc-cmac-eaes-256" with the description for
  S390_FEAT_PCC_CMAC_AES_256, and no property for
  S390_FEAT_PCC_CMAC_EAES_256.  CPU properties are visible in CLI -cpu
  and -device, QMP & HMP device_add, QMP device-list-properties, and
  QOM introspection.

The two features are almost always used via their group msa4.  Such
use is not affected by this bug.

Fix by deleting the wayward 'e'.

Fixes: 782417446279 ("s390x/cpumodel: introduce CPU features")
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20200505152926.18877-10-armbru@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[Lost paragraph in commit message restored, Fixes: tweaked]
---
 target/s390x/cpu_features_def.inc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_features_def.inc.h
index 60db28351d..5942f81f16 100644
--- a/target/s390x/cpu_features_def.inc.h
+++ b/target/s390x/cpu_features_def.inc.h
@@ -311,7 +311,7 @@ DEF_FEAT(PCC_CMAC_ETDEA_192, "pcc-cmac-etdea-128", PCC, 10, "PCC Compute-Last-Bl
 DEF_FEAT(PCC_CMAC_TDEA, "pcc-cmac-etdea-192", PCC, 11, "PCC Compute-Last-Block-CMAC-Using-EncryptedTDEA-192")
 DEF_FEAT(PCC_CMAC_AES_128, "pcc-cmac-aes-128", PCC, 18, "PCC Compute-Last-Block-CMAC-Using-AES-128")
 DEF_FEAT(PCC_CMAC_AES_192, "pcc-cmac-aes-192", PCC, 19, "PCC Compute-Last-Block-CMAC-Using-AES-192")
-DEF_FEAT(PCC_CMAC_AES_256, "pcc-cmac-eaes-256", PCC, 20, "PCC Compute-Last-Block-CMAC-Using-AES-256")
+DEF_FEAT(PCC_CMAC_AES_256, "pcc-cmac-aes-256", PCC, 20, "PCC Compute-Last-Block-CMAC-Using-AES-256")
 DEF_FEAT(PCC_CMAC_EAES_128, "pcc-cmac-eaes-128", PCC, 26, "PCC Compute-Last-Block-CMAC-Using-Encrypted-AES-128")
 DEF_FEAT(PCC_CMAC_EAES_192, "pcc-cmac-eaes-192", PCC, 27, "PCC Compute-Last-Block-CMAC-Using-Encrypted-AES-192")
 DEF_FEAT(PCC_CMAC_EAES_256, "pcc-cmac-eaes-256", PCC, 28, "PCC Compute-Last-Block-CMAC-Using-Encrypted-AES-256")
-- 
2.21.1


