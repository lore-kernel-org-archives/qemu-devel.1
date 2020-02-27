Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763E5C4BA35
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 01:56:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E9420838
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 01:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/FjqajG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E9420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j78Pl-0006ck-5w
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 20:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j78OA-0004c6-NO
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j78O9-0002aB-EQ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:54:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40790
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j78O9-0002Xv-9v
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582768496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8IZ81wz+GqrsTJ4jOYNuawo0WpVuRcrvYE66jTI0Fg=;
 b=h/FjqajGDBeyYSC1H2855WDn9IQoVa//N6zF6o2PlUa8YD6WBofzsEnhfbXt9OLfx413vm
 zZtiJNKzy48DyyE1DXg23hUGVpGqnznvQSI/qpUo9F05RbPDgIV/1J5JITI6yPVRmEUtoR
 /q2mNMGb3wsptGaESzwkfGfv0jQauBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-QGwgA4GtMuC_GFy0pLHs3w-1; Wed, 26 Feb 2020 20:54:55 -0500
X-MC-Unique: QGwgA4GtMuC_GFy0pLHs3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDFFA107ACCA;
 Thu, 27 Feb 2020 01:54:53 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 216375C578;
 Thu, 27 Feb 2020 01:54:53 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] block/nbd: fix memory leak in nbd_open()
Date: Wed, 26 Feb 2020 19:54:48 -0600
Message-Id: <20200227015448.960538-5-eblake@redhat.com>
In-Reply-To: <20200227015448.960538-1-eblake@redhat.com>
References: <20200227015448.960538-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Pan Nengyuan <pannengyuan@huawei.com>, qemu-stable <qemu-stable@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Euler Robot <euler.robot@huawei.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

In currently implementation there will be a memory leak when
nbd_client_connect() returns error status. Here is an easy way to
reproduce:

1. run qemu-iotests as follow and check the result with asan:
    ./check -raw 143

Following is the asan output backtrack:
Direct leak of 40 byte(s) in 1 object(s) allocated from:
    #0 0x7f629688a560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
    #1 0x7f6295e7e015 in g_malloc0  (/usr/lib64/libglib-2.0.so.0+0x50015)
    #2 0x56281dab4642 in qobject_input_start_struct  /mnt/sdb/qemu-4.2.0-rc=
0/qapi/qobject-input-visitor.c:295
    #3 0x56281dab1a04 in visit_start_struct  /mnt/sdb/qemu-4.2.0-rc0/qapi/q=
api-visit-core.c:49
    #4 0x56281dad1827 in visit_type_SocketAddress  qapi/qapi-visit-sockets.=
c:386
    #5 0x56281da8062f in nbd_config   /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1=
716
    #6 0x56281da8062f in nbd_process_options /mnt/sdb/qemu-4.2.0-rc0/block/=
nbd.c:1829
    #7 0x56281da8062f in nbd_open /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1873

Direct leak of 15 byte(s) in 1 object(s) allocated from:
    #0 0x7f629688a3a0 in malloc (/usr/lib64/libasan.so.3+0xc73a0)
    #1 0x7f6295e7dfbd in g_malloc (/usr/lib64/libglib-2.0.so.0+0x4ffbd)
    #2 0x7f6295e96ace in g_strdup (/usr/lib64/libglib-2.0.so.0+0x68ace)
    #3 0x56281da804ac in nbd_process_options /mnt/sdb/qemu-4.2.0-rc0/block/=
nbd.c:1834
    #4 0x56281da804ac in nbd_open /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1873

Indirect leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x7f629688a3a0 in malloc (/usr/lib64/libasan.so.3+0xc73a0)
    #1 0x7f6295e7dfbd in g_malloc (/usr/lib64/libglib-2.0.so.0+0x4ffbd)
    #2 0x7f6295e96ace in g_strdup (/usr/lib64/libglib-2.0.so.0+0x68ace)
    #3 0x56281dab41a3 in qobject_input_type_str_keyval /mnt/sdb/qemu-4.2.0-=
rc0/qapi/qobject-input-visitor.c:536
    #4 0x56281dab2ee9 in visit_type_str /mnt/sdb/qemu-4.2.0-rc0/qapi/qapi-v=
isit-core.c:297
    #5 0x56281dad0fa1 in visit_type_UnixSocketAddress_members qapi/qapi-vis=
it-sockets.c:141
    #6 0x56281dad17b6 in visit_type_SocketAddress_members qapi/qapi-visit-s=
ockets.c:366
    #7 0x56281dad186a in visit_type_SocketAddress qapi/qapi-visit-sockets.c=
:393
    #8 0x56281da8062f in nbd_config /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:171=
6
    #9 0x56281da8062f in nbd_process_options /mnt/sdb/qemu-4.2.0-rc0/block/=
nbd.c:1829
    #10 0x56281da8062f in nbd_open /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1873

Fixes: 8f071c9db506e03ab
Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <1575517528-44312-3-git-send-email-pannengyuan@huawei.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/nbd.c b/block/nbd.c
index ed0f93ab27a9..976be7664786 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1915,6 +1915,7 @@ static int nbd_open(BlockDriverState *bs, QDict *opti=
ons, int flags,

     ret =3D nbd_client_connect(bs, errp);
     if (ret < 0) {
+        nbd_clear_bdrvstate(s);
         return ret;
     }
     /* successfully connected */
--=20
2.24.1


