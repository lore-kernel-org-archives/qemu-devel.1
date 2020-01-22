Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49437C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 22:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD3F2465A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 22:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cP2c2IVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD3F2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuOaY-0003Oa-FN
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 17:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuOYm-0001jz-Eo
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 17:33:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuOYk-0001Vp-DP
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 17:33:16 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55866
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuOYk-0001VF-9s
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 17:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579732393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WfbFbjO3CVtH6Hm3NqnkBneFE06NKsCSxcSEnAOyc3g=;
 b=cP2c2IVdYE+6n/lhP9C5iKmAdt+8AL42ufuB+wsJc3mPVVfUlCV6TeDMzql7wOlfe+myX1
 6d2uBICEKmKXIZKfXzgaJ9gn5Z0+RB7Sx6t+tV/cG72KVAtRqtgqSP1cBdI+JFXJ8ndlUy
 vM8dm1DcK1x5SIU//KSK4Yk3LTlqSsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-gL9XE_u7M8uIIjvkqQz8Ig-1; Wed, 22 Jan 2020 17:33:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A72EDB60;
 Wed, 22 Jan 2020 22:33:11 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-78.brq.redhat.com [10.40.204.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6638C845A5;
 Wed, 22 Jan 2020 22:33:08 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
Subject: [PATCH 2/6] tests/acceptance/virtio_seg_max_adjust: Improve exception
 logging
Date: Wed, 22 Jan 2020 23:32:43 +0100
Message-Id: <20200122223247.30419-3-philmd@redhat.com>
In-Reply-To: <20200122223247.30419-1-philmd@redhat.com>
References: <20200122223247.30419-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: gL9XE_u7M8uIIjvkqQz8Ig-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/virtio_seg_max_adjust.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptance/v=
irtio_seg_max_adjust.py
index 4a417b8ef5..51a2dd76e8 100755
--- a/tests/acceptance/virtio_seg_max_adjust.py
+++ b/tests/acceptance/virtio_seg_max_adjust.py
@@ -77,8 +77,12 @@ class VirtioMaxSegSettingsCheck(Test):
             vm.set_machine(mt["name"])
             for s in VM_DEV_PARAMS[dev_type_name]:
                 vm.add_args(s)
-            vm.launch()
-            query_ok, props, error =3D self.query_virtqueue(vm, dev_type_n=
ame)
+            try:
+                vm.launch()
+                query_ok, props, error =3D self.query_virtqueue(vm, dev_ty=
pe_name)
+            except:
+                query_ok =3D False
+                error =3D sys.exc_info()[0]
=20
         if not query_ok:
             self.fail('machine type {0}: {1}'.format(mt['name'], error))
--=20
2.21.1


