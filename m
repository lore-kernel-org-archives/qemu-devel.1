Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01EDC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29DB920659
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDnYq68D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DB920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sJL-0007WD-TE
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j1sCE-000308-Mo
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j1sCD-0006Zj-L5
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45728
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j1sCD-0006ZO-Fl
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581514613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnA7j/7dCb2HQeznwaM8jgpXjwUCQmnqpmgi0auIHPI=;
 b=NDnYq68D6u8XJXfGA0oj9yUPVWnsb9G/HdPH6tIqhSMEhvvitJynYwFnwgt9ufVXXJiX4i
 WWcVHaOKxcEWBIwfxDhKc26JLodB58u2J9dC5ssvPHJQR2YyN8jZ/WBq/YYzlkUUjtDU3m
 6aIOw/5DW+f64SFCQrCOVtlcrybTpj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-4RLfX8q0NuW1BsGakavHPw-1; Wed, 12 Feb 2020 08:36:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27FA913E4;
 Wed, 12 Feb 2020 13:36:48 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4915027063;
 Wed, 12 Feb 2020 13:36:41 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/16] qmp/hmp: Expose "managed-size" for memory backends
Date: Wed, 12 Feb 2020 14:35:58 +0100
Message-Id: <20200212133601.10555-14-david@redhat.com>
In-Reply-To: <20200212133601.10555-1-david@redhat.com>
References: <20200212133601.10555-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 4RLfX8q0NuW1BsGakavHPw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Expose it, and document what it means and when it was added.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/machine-hmp-cmds.c | 2 ++
 hw/core/machine-qmp-cmds.c | 3 +++
 qapi/machine.json          | 6 ++++++
 3 files changed, 11 insertions(+)

diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index b76f7223af..681216198d 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -122,6 +122,8 @@ void hmp_info_memdev(Monitor *mon, const QDict *qdict)
                        m->value->dump ? "true" : "false");
         monitor_printf(mon, "  prealloc: %s\n",
                        m->value->prealloc ? "true" : "false");
+        monitor_printf(mon, "  managed-size: %s\n",
+                       m->value->managed_size ? "true" : "false");
         monitor_printf(mon, "  policy: %s\n",
                        HostMemPolicy_str(m->value->policy));
         visit_complete(v, &str);
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index eed5aeb2f7..800b55af5d 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -321,6 +321,9 @@ static int query_memdev(Object *obj, void *opaque)
         m->value->prealloc =3D object_property_get_bool(obj,
                                                       "prealloc",
                                                       &error_abort);
+        m->value->managed_size =3D object_property_get_bool(obj,
+                                                          "managed-size",
+                                                          &error_abort);
         m->value->policy =3D object_property_get_enum(obj,
                                                     "policy",
                                                     "HostMemPolicy",
diff --git a/qapi/machine.json b/qapi/machine.json
index b3d30bc816..0c31818853 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -758,6 +758,9 @@
 #
 # @prealloc: enables or disables memory preallocation
 #
+# @managed-size: the owner manages the actual size, 'size' is an upper lim=
it
+#                (since 5.1)
+#
 # @host-nodes: host nodes for its memory policy
 #
 # @policy: memory policy of memory backend
@@ -771,6 +774,7 @@
     'merge':      'bool',
     'dump':       'bool',
     'prealloc':   'bool',
+    'managed-size': 'bool',
     'host-nodes': ['uint16'],
     'policy':     'HostMemPolicy' }}
=20
@@ -793,6 +797,7 @@
 #          "merge": false,
 #          "dump": true,
 #          "prealloc": false,
+#          "manmaged-size": false,
 #          "host-nodes": [0, 1],
 #          "policy": "bind"
 #        },
@@ -801,6 +806,7 @@
 #          "merge": false,
 #          "dump": true,
 #          "prealloc": true,
+#          "manmaged-size": false,
 #          "host-nodes": [2, 3],
 #          "policy": "preferred"
 #        }
--=20
2.24.1


