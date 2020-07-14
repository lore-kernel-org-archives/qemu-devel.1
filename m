Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7317C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729472256B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drslve8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729472256B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvNTQ-0008Kz-Pg
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvNNk-0000KT-ND
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:02:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31224
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvNNh-00080i-02
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594742527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rPjUnyc8EaEsTj7zhe25TRTnVCrTgwFFmTpiNFmR+iQ=;
 b=drslve8yFvgfpvbdg8C3DeomreZ3dhJ8hfux6NLM/zar7iP+szQGZslIytvDFbhwuT/xAu
 Qz7I0C+vIxzJ/qot2HumMYvjDzF8CxSG/bAnrOmTkrSaQ+6yUpAW1IacOqjPHbGG105wZQ
 IajqHgtZWXet3bZaoylOuRM3M1+8350=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-xid3NIrhMbKEcK4AUy6uPQ-1; Tue, 14 Jul 2020 12:02:04 -0400
X-MC-Unique: xid3NIrhMbKEcK4AUy6uPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0972018C63C1;
 Tue, 14 Jul 2020 16:02:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8B2360E1C;
 Tue, 14 Jul 2020 16:02:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3779217741CC; Tue, 14 Jul 2020 18:02:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 4/5] qom: Document object_get_canonical_path() returns
 malloced string
Date: Tue, 14 Jul 2020 18:02:01 +0200
Message-Id: <20200714160202.3121879-5-armbru@redhat.com>
In-Reply-To: <20200714160202.3121879-1-armbru@redhat.com>
References: <20200714160202.3121879-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: lvivier@redhat.com, thuth@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qom/object.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 55d925d2c8..0f3a60617c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1467,8 +1467,9 @@ const char *object_get_canonical_path_component(const Object *obj);
 /**
  * object_get_canonical_path:
  *
- * Returns: The canonical path for a object.  This is the path within the
- * composition tree starting from the root.
+ * Returns: The canonical path for a object, newly allocated.  This is
+ * the path within the composition tree starting from the root.  Use
+ * g_free() to free it.
  */
 char *object_get_canonical_path(const Object *obj);
 
-- 
2.26.2


