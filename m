Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AACC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D35E20674
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTqYQMXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D35E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSYC-00082g-7w
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iXSF4-0003we-Ew
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:50:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iXSF3-0002Jv-FJ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:50:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45250
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iXSF3-0002Jb-C6
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574265004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qcoZucwgOalaIHzzTbveuBrCPhkujz6bPR/7gpRAwMo=;
 b=GTqYQMXum9SPdeuDjobmms65E3GmrRho5uarbkMBMosOwM8vwQubcMsmKVjU4g9Ngcgo+j
 RqOaqceoSFjJCc79ugvCHKH8LFzSle+H8ajxVnfAkFXZdkYgLVWnajuAnUW2/icOvuXmzh
 0pU7B1ea+ruGh8vmSVwIZWVhI0XZkBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-a9j9X46SM42lTfvaVYsYtw-1; Wed, 20 Nov 2019 10:50:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C36C68024CE;
 Wed, 20 Nov 2019 15:50:01 +0000 (UTC)
Received: from localhost (dhcp-192-217.str.redhat.com [10.33.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB8C4503F1;
 Wed, 20 Nov 2019 15:49:58 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] net/virtio: return early when failover primary alread
 added
Date: Wed, 20 Nov 2019 16:49:49 +0100
Message-Id: <20191120154951.27877-3-jfreimann@redhat.com>
In-Reply-To: <20191120154951.27877-1-jfreimann@redhat.com>
References: <20191120154951.27877-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: a9j9X46SM42lTfvaVYsYtw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, dgilbert@redhat.com,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Bail out when primary device was already added before.
This avoids printing a wrong warning message during reboot.

Fixes: 9711cd0dfc3f ("net/virtio: add failover support")
Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 946039c0dc..ac4d19109e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -759,6 +759,10 @@ static void failover_add_primary(VirtIONet *n, Error *=
*errp)
 {
     Error *err =3D NULL;
=20
+    if (n->primary_dev) {
+        return;
+    }
+
     n->primary_device_opts =3D qemu_opts_find(qemu_find_opts("device"),
             n->primary_device_id);
     if (n->primary_device_opts) {
--=20
2.21.0


