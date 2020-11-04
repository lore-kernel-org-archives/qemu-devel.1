Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C8FC388F9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360A120759
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PE+8dTVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360A120759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaMaI-0005v0-7C
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaMXE-0000z5-Vr
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:25:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaMXB-0008Ba-UW
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604510720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bD8WHQ5vkPZgFU67Ydv6CRTwa7bMPjoclBtYbd6jK3c=;
 b=PE+8dTVc7ryyWQIzjWLiFTiAwjyeR1fzbRgipif/WPj69ofteLzRUfmVs2D2DIKNXv4T7m
 GKLf2dBssIBWpy9jMIC0x4iQJ0fMLGd8c0UrnAxQTu5/IFUPk8h5Up1PHR4ttu91CNDPCy
 4VY7pqpz9rymvFErD3luDMHk5npfBFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-eRHrlGKkOvqVzrcUNlO-EA-1; Wed, 04 Nov 2020 12:25:18 -0500
X-MC-Unique: eRHrlGKkOvqVzrcUNlO-EA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BBC11028D51
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 17:25:17 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E20660BFA;
 Wed,  4 Nov 2020 17:25:17 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] qom: Save size of struct field in Property struct
Date: Wed,  4 Nov 2020 12:25:07 -0500
Message-Id: <20201104172512.2381656-3-ehabkost@redhat.com>
In-Reply-To: <20201104172512.2381656-1-ehabkost@redhat.com>
References: <20201104172512.2381656-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will let the code that reads/writes the field ensure it will
never go out of bounds.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/qom/field-property.h | 3 +++
 include/qom/property-types.h | 1 +
 qom/property-types.c         | 1 +
 3 files changed, 5 insertions(+)

diff --git a/include/qom/field-property.h b/include/qom/field-property.h
index bc866e1c93..e64a2b3c07 100644
--- a/include/qom/field-property.h
+++ b/include/qom/field-property.h
@@ -27,7 +27,10 @@ struct Property {
      */
     const char   *qdev_prop_name;
     const PropertyInfo *info;
+    /** @offset: offset of field in object instance struct */
     ptrdiff_t    offset;
+    /** @size: size of field in object instance struct */
+    size_t       size;
     uint8_t      bitnr;
     /**
      * @set_default: true if the default value should be set from @defval,
diff --git a/include/qom/property-types.h b/include/qom/property-types.h
index 3a36e1fec5..17bf007234 100644
--- a/include/qom/property-types.h
+++ b/include/qom/property-types.h
@@ -28,6 +28,7 @@ extern const PropertyInfo prop_info_link;
         .info      = &(_prop),                                   \
         .offset    = offsetof(_state, _field)                    \
             + type_check(_type, typeof_field(_state, _field)),   \
+        .size      = sizeof(typeof_field(_state, _field)),       \
         __VA_ARGS__                                              \
         }
 
diff --git a/qom/property-types.c b/qom/property-types.c
index f566c05ec2..856b5ae76d 100644
--- a/qom/property-types.c
+++ b/qom/property-types.c
@@ -485,6 +485,7 @@ static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
          * being inside the device struct.
          */
         arrayprop->offset = eltptr - (void *)obj;
+        arrayprop->size = prop->arrayfieldsize;
         assert(object_field_prop_ptr(obj, arrayprop) == eltptr);
         object_property_add_field(obj, propname, arrayprop, op->allow_set);
     }
-- 
2.28.0


