Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB2CC56201
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:17:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2940C2227F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTHxONn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2940C2227F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV8Mn-0002pb-0V
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 03:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kV8LM-0001pt-8F
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kV8LJ-0005gf-8t
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603264528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dDHWT3LVZt4bET4GFbrv3i92S8wPITXJGhA56WhlS1Q=;
 b=DTHxONn6H73NdtS3uVJLN1lOXzfIt1gIWpPEGkjQfnOtF5Dr6uYDb26Z8/bP8C3ZWlMxaM
 yUBJoLqMBpUmRmEHDJrxy7N+RHeh6t9qg26iqOjDvxZz1YA4zIm2gJz/zuX48vI2Zgp9Dp
 yk2rCsJYrd7WXjJpdimkKIb+zaZRp9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523--PXdfOa1On2vTRTXIJykPw-1; Wed, 21 Oct 2020 03:15:25 -0400
X-MC-Unique: -PXdfOa1On2vTRTXIJykPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5315879535;
 Wed, 21 Oct 2020 07:15:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF6406EF66;
 Wed, 21 Oct 2020 07:15:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 28E7A11275C2; Wed, 21 Oct 2020 09:15:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] qga: Flatten simple union GuestDeviceId
Date: Wed, 21 Oct 2020 09:15:20 +0200
Message-Id: <20201021071520.2168877-5-armbru@redhat.com>
In-Reply-To: <20201021071520.2168877-1-armbru@redhat.com>
References: <20201021071520.2168877-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: marcandre.lureau@redhat.com, tgolembi@redhat.com, philmd@redhat.com,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simple unions are simpler than flat unions in the schema, but more
complicated in C and on the QMP wire: there's extra indirection in C
and extra nesting on the wire, both pointless.  They should be avoided
in new code.

GuestDeviceId was recently added for guest-get-devices.  Convert it to
a flat union.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 8 ++++++++
 qga/commands-win32.c | 9 ++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index c7bfb8bf6a..fe10631e4c 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1256,6 +1256,12 @@
 { 'command': 'guest-get-osinfo',
   'returns': 'GuestOSInfo' }
 
+##
+# @GuestDeviceType:
+##
+{ 'enum': 'GuestDeviceType',
+  'data': [ 'pci' ] }
+
 ##
 # @GuestDeviceIdPCI:
 #
@@ -1276,6 +1282,8 @@
 # Since: 5.2
 ##
 { 'union': 'GuestDeviceId',
+  'base': { 'type': 'GuestDeviceType' },
+  'discriminator': 'type',
   'data': { 'pci': 'GuestDeviceIdPCI' } }
 
 ##
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 1efe3ba076..0c33d48aaa 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2400,16 +2400,15 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
             }
             skip = false;
 
-            id = g_new0(GuestDeviceIdPCI, 1);
             vendor_id = g_match_info_fetch(match_info, 1);
             device_id = g_match_info_fetch(match_info, 2);
-            id->vendor_id = g_ascii_strtoull(vendor_id, NULL, 16);
-            id->device_id = g_ascii_strtoull(device_id, NULL, 16);
 
             device->id = g_new0(GuestDeviceId, 1);
             device->has_id = true;
-            device->id->type = GUEST_DEVICE_ID_KIND_PCI;
-            device->id->u.pci.data = id;
+            device->id->type = GUEST_DEVICE_TYPE_PCI;
+            id = &device->id->u.pci;
+            id->vendor_id = g_ascii_strtoull(vendor_id, NULL, 16);
+            id->device_id = g_ascii_strtoull(device_id, NULL, 16);
 
             g_match_info_free(match_info);
             break;
-- 
2.26.2


