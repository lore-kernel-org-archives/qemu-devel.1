Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B29C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1BED206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9BZ+iie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BED206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTTIi-0004FB-37
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTFQ-00070B-MU
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTBz-0000vB-JO
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32544
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTTBz-0000uj-4l
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588091682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nzP+uw+2XuwrGiqU22XaFcepv5QrViywKvtT5n9Opwo=;
 b=W9BZ+iieodkVnXwEghI577iEpsKSeyTJ40W5gjw70wQ1JWOoHVaSSHkFRSgbs3JqN93aJY
 7tLwW2eRpdVTHcImBlJdoyg1bMx2eNl+LB7ZmEhclYwzbwtdN0mb0Wih6dsf60iZOBHTEC
 VbcI7Z7AFOHBzIIbWjWf7Vk1LaxWwnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-wpsAwwXYNcmcjr10Xs1pog-1; Tue, 28 Apr 2020 12:34:40 -0400
X-MC-Unique: wpsAwwXYNcmcjr10Xs1pog-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60C2E18A0738;
 Tue, 28 Apr 2020 16:34:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D3375DA66;
 Tue, 28 Apr 2020 16:34:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 188E611358C4; Tue, 28 Apr 2020 18:34:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/17] s390x/cpumodel: Fix UI to CPU features pcc-cmac-{aes,
 eaes}-256
Date: Tue, 28 Apr 2020 18:34:10 +0200
Message-Id: <20200428163419.4483-9-armbru@redhat.com>
In-Reply-To: <20200428163419.4483-1-armbru@redhat.com>
References: <20200428163419.4483-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
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

* s390_realize_cpu_model() misidentifies it in check_consistency()
  warnings.

* s390_cpu_list() likewise.  Affects -cpu help.

* s390_cpu_model_register_props() creates CPU property
  "pcc-cmac-eaes-256" twice.  The second one fails, but the error is
  ignored (a later commit will change that).  Results in a single
  property "pcc-cmac-eaes-256" with the description for
  S390_FEAT_PCC_CMAC_AES_256, and no property for
  S390_FEAT_PCC_CMAC_EAES_256.  CPU properties are visible in CLI -cpu
  and -device, QMP & HMP device_add, QMP device-list-properties, and
  QOM introspection.

Fix by deleting the wayward 'e'.

Fixes: 782417446279717aa85320191a519b51f6d5dd31
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/s390x/cpu_features_def.inc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_feature=
s_def.inc.h
index 31dff0d84e..a8d562d688 100644
--- a/target/s390x/cpu_features_def.inc.h
+++ b/target/s390x/cpu_features_def.inc.h
@@ -310,7 +310,7 @@ DEF_FEAT(PCC_CMAC_ETDEA_192, "pcc-cmac-etdea-128", PCC,=
 10, "PCC Compute-Last-Bl
 DEF_FEAT(PCC_CMAC_TDEA, "pcc-cmac-etdea-192", PCC, 11, "PCC Compute-Last-B=
lock-CMAC-Using-EncryptedTDEA-192")
 DEF_FEAT(PCC_CMAC_AES_128, "pcc-cmac-aes-128", PCC, 18, "PCC Compute-Last-=
Block-CMAC-Using-AES-128")
 DEF_FEAT(PCC_CMAC_AES_192, "pcc-cmac-aes-192", PCC, 19, "PCC Compute-Last-=
Block-CMAC-Using-AES-192")
-DEF_FEAT(PCC_CMAC_AES_256, "pcc-cmac-eaes-256", PCC, 20, "PCC Compute-Last=
-Block-CMAC-Using-AES-256")
+DEF_FEAT(PCC_CMAC_AES_256, "pcc-cmac-aes-256", PCC, 20, "PCC Compute-Last-=
Block-CMAC-Using-AES-256")
 DEF_FEAT(PCC_CMAC_EAES_128, "pcc-cmac-eaes-128", PCC, 26, "PCC Compute-Las=
t-Block-CMAC-Using-Encrypted-AES-128")
 DEF_FEAT(PCC_CMAC_EAES_192, "pcc-cmac-eaes-192", PCC, 27, "PCC Compute-Las=
t-Block-CMAC-Using-Encrypted-AES-192")
 DEF_FEAT(PCC_CMAC_EAES_256, "pcc-cmac-eaes-256", PCC, 28, "PCC Compute-Las=
t-Block-CMAC-Using-Encrypted-AES-256")
--=20
2.21.1


