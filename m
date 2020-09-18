Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C98C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03995221EC
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbBsngHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03995221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNTS-0000f5-4y
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJNIG-0002eA-8p
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:47:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJNI2-0006Hi-5e
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600462047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HviHr4FunOqEL8xT9/OsOQVp4aiu61kBo5y3Tq38Pn4=;
 b=DbBsngHvgmXj6Tr9dpHX7eblcSqgiOBbDdV39I4I42yy0eGMYY6po8GApgyMCoHMMPSncT
 4/UgmDe5NjBdxwFFHYr6KCdkew/geQwXHA2uqO2ClCR3qNe0X1joOFNT+wKMkAOvxRLfud
 suQn0OPoLvbQFEXSXdCnBmvxU03G9RM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-Sg7VU-CkN6KHCs2BL0TeMA-1; Fri, 18 Sep 2020 16:47:24 -0400
X-MC-Unique: Sg7VU-CkN6KHCs2BL0TeMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F372F800C78;
 Fri, 18 Sep 2020 20:47:22 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8ECE55778;
 Fri, 18 Sep 2020 20:47:22 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 07/17] qom: Correct error values in two contracts
Date: Fri, 18 Sep 2020 16:47:04 -0400
Message-Id: <20200918204714.27276-8-ehabkost@redhat.com>
In-Reply-To: <20200918204714.27276-1-ehabkost@redhat.com>
References: <20200918204714.27276-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

object_property_get_bool()'s contract claims it returns NULL on error.
Pasto; it returns false.

object_property_get_int()'s contract claims it returns "negative".  It
actually returns -1.  All the other object_property_get_FOO()
contracts specify the exact error value, so do the same here.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200917125540.597786-3-armbru@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 494827b4d1..32524d72cc 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1624,7 +1624,7 @@ bool object_property_set_bool(Object *obj, const char *name,
  * @name: the name of the property
  * @errp: returns an error if this function fails
  *
- * Returns: the value of the property, converted to a boolean, or NULL if
+ * Returns: the value of the property, converted to a boolean, or false if
  * an error occurs (including when the property value is not a bool).
  */
 bool object_property_get_bool(Object *obj, const char *name,
@@ -1649,7 +1649,7 @@ bool object_property_set_int(Object *obj, const char *name,
  * @name: the name of the property
  * @errp: returns an error if this function fails
  *
- * Returns: the value of the property, converted to an integer, or negative if
+ * Returns: the value of the property, converted to an integer, or -1 if
  * an error occurs (including when the property value is not an integer).
  */
 int64_t object_property_get_int(Object *obj, const char *name,
-- 
2.26.2


