Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEEEC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557A3221FC
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 07:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHFrCKLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557A3221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV8O1-00048X-8l
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 03:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kV8LL-0001pi-BV
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kV8LJ-0005gZ-8u
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 03:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603264527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDuljDkSH7vZAkqeSRivYSmD1ze7YjH/rNxVNhyCJTI=;
 b=RHFrCKLBM+wUpoLMOGOPMf1FRfNLn/9OtZ8BJTvcl2m0TNXAhq/QhFCrJQ4wW3JPKiejia
 +5HFRB9C1XWecxvH2tP/DBQH4N1ErOEKSa0PQyXZuir8QdgF+WlhHWdwka3CNMHAi4z5yq
 pHDh6FcW9qzN7wTgHBYLbrEiNW8tEjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-hp1ID66fO3mdJsKXxYib4w-1; Wed, 21 Oct 2020 03:15:25 -0400
X-MC-Unique: hp1ID66fO3mdJsKXxYib4w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00B891009E26;
 Wed, 21 Oct 2020 07:15:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB35810013D0;
 Wed, 21 Oct 2020 07:15:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 22718112991E; Wed, 21 Oct 2020 09:15:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] qga: Use common time encoding for guest-get-devices
 'driver-date'
Date: Wed, 21 Oct 2020 09:15:18 +0200
Message-Id: <20201021071520.2168877-3-armbru@redhat.com>
In-Reply-To: <20201021071520.2168877-1-armbru@redhat.com>
References: <20201021071520.2168877-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

guest-get-devices returns 'driver-date' as string in the format
YYYY-MM-DD.  Goes back to recent commit 2e4211cee4 "qga: add command
guest-get-devices for reporting VirtIO devices".

We should avoid use of multiple encodings for the same kind of data.
Especially string encodings.  Change it to return nanoseconds since
the epoch, like guest-get-time does.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json |  4 ++--
 qga/commands-win32.c | 19 +++++++++++--------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index f2c81cda2b..c7bfb8bf6a 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1282,7 +1282,7 @@
 # @GuestDeviceInfo:
 #
 # @driver-name: name of the associated driver
-# @driver-date: driver release date in format YYYY-MM-DD
+# @driver-date: driver release date, in nanoseconds since the epoch
 # @driver-version: driver version
 # @id: device ID
 #
@@ -1291,7 +1291,7 @@
 { 'struct': 'GuestDeviceInfo',
   'data': {
       'driver-name': 'str',
-      '*driver-date': 'str',
+      '*driver-date': 'int',
       '*driver-version': 'str',
       '*id': 'GuestDeviceId'
   } }
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 879b02b6c3..b01616a992 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1641,6 +1641,12 @@ out:
     return head;
 }
 
+static int64_t filetime_to_ns(const FILETIME *tf)
+{
+    return ((((int64_t)tf->dwHighDateTime << 32) | tf->dwLowDateTime)
+            - W32_FT_OFFSET) * 100;
+}
+
 int64_t qmp_guest_get_time(Error **errp)
 {
     SYSTEMTIME ts = {0};
@@ -1657,8 +1663,7 @@ int64_t qmp_guest_get_time(Error **errp)
         return -1;
     }
 
-    return ((((int64_t)tf.dwHighDateTime << 32) | tf.dwLowDateTime)
-                - W32_FT_OFFSET) * 100;
+    return filetime_to_ns(&tf);
 }
 
 void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
@@ -2363,7 +2368,6 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
     slog("enumerating devices");
     for (i = 0; SetupDiEnumDeviceInfo(dev_info, i, &dev_info_data); i++) {
         bool skip = true;
-        SYSTEMTIME utc_date;
         g_autofree LPWSTR name = NULL;
         g_autofree LPFILETIME date = NULL;
         g_autofree LPWSTR version = NULL;
@@ -2434,13 +2438,12 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
             slog("failed to get driver date");
             continue;
         }
-        FileTimeToSystemTime(date, &utc_date);
-        device->driver_date = g_strdup_printf("%04d-%02d-%02d",
-            utc_date.wYear, utc_date.wMonth, utc_date.wDay);
+        device->driver_date = filetime_to_ns(date);
         device->has_driver_date = true;
 
-        slog("driver: %s\ndriver version: %s,%s\n", device->driver_name,
-            device->driver_date, device->driver_version);
+        slog("driver: %s\ndriver version: %" PRId64 ",%s\n",
+             device->driver_name, device->driver_date,
+             device->driver_version);
         item = g_new0(GuestDeviceInfoList, 1);
         item->value = g_steal_pointer(&device);
         if (!cur_item) {
-- 
2.26.2


