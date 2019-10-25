Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7EBCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0845A2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McOQ3Xik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0845A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNxOh-0005mc-38
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNwvB-0007aE-1s
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNwv8-0006xk-Qb
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:34:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25833
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNwv8-0006vc-JK
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571999654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yBat7hbMzDsO+55H3ZDnoBsHSBTrP3BQwKZSIYyi+PE=;
 b=McOQ3Xik5x4B9V4VXfZRgffeGrhwKYw7WhU93uiUgan2D097fX/Efra61sXnK/xL05PbAb
 slncBMIbAijZ/w6gTV8aazMJg5w0MqMWUpRmw7Rvj05Q/sUwrhwif1RmCMHFXeom/sN0kV
 fxnkNyeXbYrT0Fe9ozLXDnyiZ0xQci8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-1V_jBu9iODqHf9qZpAwV1w-1; Fri, 25 Oct 2019 06:34:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6877800D41
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 10:34:11 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC93B5D9CA;
 Fri, 25 Oct 2019 10:34:10 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 2/2] virtio_net: use RCU_READ_LOCK_GUARD
Date: Fri, 25 Oct 2019 11:34:03 +0100
Message-Id: <20191025103403.120616-3-dgilbert@redhat.com>
In-Reply-To: <20191025103403.120616-1-dgilbert@redhat.com>
References: <20191025103403.120616-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 1V_jBu9iODqHf9qZpAwV1w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Use RCU_READ_LOCK_GUARD rather than the manual rcu_read_(un)lock call.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/net/virtio-net.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9f11422337..80622861a8 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1369,12 +1369,9 @@ static ssize_t virtio_net_receive_rcu(NetClientState=
 *nc, const uint8_t *buf,
 static ssize_t virtio_net_do_receive(NetClientState *nc, const uint8_t *bu=
f,
                                   size_t size)
 {
-    ssize_t r;
+    RCU_READ_LOCK_GUARD();
=20
-    rcu_read_lock();
-    r =3D virtio_net_receive_rcu(nc, buf, size);
-    rcu_read_unlock();
-    return r;
+    return virtio_net_receive_rcu(nc, buf, size);
 }
=20
 static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
--=20
2.23.0


