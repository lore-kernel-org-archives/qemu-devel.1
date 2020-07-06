Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC89C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F55206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etUnCamz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F55206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsMeO-0007LO-Rz
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 04:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsMFM-0007gf-J6
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:13:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43088
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsMFL-0003vw-2m
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594023182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oKPCDO6bsnMXT75PWaT2RIS7D/p6vt6foCsykajthc0=;
 b=etUnCamz/TY3Fb+dz+KoF0LH1YDa9yJMRykkhZ7d654sBSrHzP7iGGOuvoIfquBPGKIlt4
 fQ7m4sP4lD67/a86gG0Gc9xm7TkwmI4QP5JUCUKohE/r0p5oKfWZT61540QCh7uzi7MkNC
 tbcLSJrnIzEe8Vn6sDW0kZB6+Ump6gA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-aLY-JcHVOB-VR5HxWYJJow-1; Mon, 06 Jul 2020 04:12:59 -0400
X-MC-Unique: aLY-JcHVOB-VR5HxWYJJow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5F88188360D;
 Mon,  6 Jul 2020 08:12:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80A7D7B40A;
 Mon,  6 Jul 2020 08:12:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0CD421138648; Mon,  6 Jul 2020 10:12:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 00/44] Less clumsy error checking
References: <20200706080950.403087-1-armbru@redhat.com>
Date: Mon, 06 Jul 2020 10:12:56 +0200
In-Reply-To: <20200706080950.403087-1-armbru@redhat.com> (Markus Armbruster's
 message of "Mon, 6 Jul 2020 10:09:06 +0200")
Message-ID: <87mu4df4dz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:52:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 ehabkost@redhat.com, qemu-block@nongnu.org, groug@kaod.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

diff between v2 rebased and v3, with hunks that change only whitespace
dropped:

diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 6d8f4b6928..7781c23a42 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -235,12 +235,12 @@ opts_start_list(Visitor *v, const char *name, GenericList **list, size_t size,
     /* we don't support visits without a list */
     assert(list);
     ov->repeated_opts = lookup_distinct(ov, name, errp);
-    if (ov->repeated_opts) {
-        ov->list_mode = LM_IN_PROGRESS;
-        *list = g_malloc0(size);
-    } else {
+    if (!ov->repeated_opts) {
         *list = NULL;
+        return false;
     }
+    ov->list_mode = LM_IN_PROGRESS;
+    *list = g_malloc0(size);
     return true;
 }
 
diff --git a/qapi/qapi-clone-visitor.c b/qapi/qapi-clone-visitor.c
index 5a54bd593f..c45c5caa3b 100644
--- a/qapi/qapi-clone-visitor.c
+++ b/qapi/qapi-clone-visitor.c
@@ -56,8 +56,7 @@ static bool qapi_clone_start_list(Visitor *v, const char *name,
                                   GenericList **listp, size_t size,
                                   Error **errp)
 {
-    qapi_clone_start_struct(v, name, (void **)listp, size, errp);
-    return true;
+    return qapi_clone_start_struct(v, name, (void **)listp, size, errp);
 }
 
 static GenericList *qapi_clone_next_list(Visitor *v, GenericList *tail,
@@ -75,8 +74,7 @@ static bool qapi_clone_start_alternate(Visitor *v, const char *name,
                                        GenericAlternate **obj, size_t size,
                                        Error **errp)
 {
-    qapi_clone_start_struct(v, name, (void **)obj, size, errp);
-    return true;
+    return qapi_clone_start_struct(v, name, (void **)obj, size, errp);
 }
 
 static bool qapi_clone_type_int64(Visitor *v, const char *name, int64_t *obj,
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 7ebb97cf0d..31cc1f6564 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -652,7 +652,6 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
 
     /* Check whether the hotplug is allowed by the machine */
     if (qdev_hotplug && !qdev_hotplug_allowed(dev, errp)) {
-        /* Error must be set in the machine hook */
         goto err_del_dev;
     }
 
diff --git a/qom/object.c b/qom/object.c
index 8d698abf4d..d6bba48e41 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1773,21 +1773,24 @@ static void object_set_link_property(Object *obj, Visitor *v,
     LinkProperty *prop = opaque;
     Object **targetp = object_link_get_targetp(obj, prop);
     Object *old_target = *targetp;
-    Object *new_target = NULL;
+    Object *new_target;
     char *path = NULL;
 
     if (!visit_type_str(v, name, &path, errp)) {
         return;
     }
 
-    if (strcmp(path, "") != 0) {
+    if (*path) {
         new_target = object_resolve_link(obj, name, path, errp);
+        if (!new_target) {
+            g_free(path);
+            return;
+        }
+    } else {
+        new_target = NULL;
     }
 
     g_free(path);
-    if (!new_target) {
-        return;
-    }
 
     prop->check(obj, name, new_target, &local_err);
     if (local_err) {


