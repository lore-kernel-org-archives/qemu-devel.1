Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0BDC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14BCF20731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPcKP9Vm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BCF20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioTil-0006zP-MB
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 09:51:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ioTae-0005vi-LQ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:42:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ioTad-0008SJ-HR
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:42:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39227
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ioTad-0008Rg-E3
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578321762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HcR8kdZVNr6+Xmm97ZoQXx/mtvvqp3phSsQ3QlqYEE8=;
 b=GPcKP9VmlVcBzcV++eCEoeQLfTtM4BorLGlqciRF/vzEtlsPEBdTQ8yf00YWU1JPVt2Yal
 2uvCMw7Fz85UUHGsCpMWeZPTe0H/JYczJnWsoUprNJ6SThEh1kozxZYmnHaE00qR9pVlLM
 iKadDg4QTLkcyV1bFBja5W6u3wC9OO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-PGKEBlKJPtyFb-0gutoewA-1; Mon, 06 Jan 2020 09:42:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 281C585B6FE;
 Mon,  6 Jan 2020 14:42:38 +0000 (UTC)
Received: from localhost (ovpn-117-91.ams2.redhat.com [10.36.117.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8499B29342;
 Mon,  6 Jan 2020 14:42:37 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 06/34] throttle-groups: fix memory leak in
 throttle_group_set_limit:
Date: Mon,  6 Jan 2020 15:41:38 +0100
Message-Id: <20200106144206.698920-7-mreitz@redhat.com>
In-Reply-To: <20200106144206.698920-1-mreitz@redhat.com>
References: <20200106144206.698920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: PGKEBlKJPtyFb-0gutoewA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: PanNengyuan <pannengyuan@huawei.com>

This avoid a memory leak when qom-set is called to set throttle_group
limits, here is an easy way to reproduce:

1. run qemu-iotests as follow and check the result with asan:
       ./check -qcow2 184

Following is the asan output backtrack:
Direct leak of 912 byte(s) in 3 object(s) allocated from:
    #0 0xffff8d7ab3c3 in __interceptor_calloc   (/lib64/libasan.so.4+0xd33c=
3)
    #1 0xffff8d4c31cb in g_malloc0   (/lib64/libglib-2.0.so.0+0x571cb)
    #2 0x190c857 in qobject_input_start_struct  /mnt/sdc/qemu-master/qemu-4=
.2.0-rc0/qapi/qobject-input-visitor.c:295
    #3 0x19070df in visit_start_struct   /mnt/sdc/qemu-master/qemu-4.2.0-rc=
0/qapi/qapi-visit-core.c:49
    #4 0x1948b87 in visit_type_ThrottleLimits   qapi/qapi-visit-block-core.=
c:3759
    #5 0x17e4aa3 in throttle_group_set_limits   /mnt/sdc/qemu-master/qemu-4=
.2.0-rc0/block/throttle-groups.c:900
    #6 0x1650eff in object_property_set     /mnt/sdc/qemu-master/qemu-4.2.0=
-rc0/qom/object.c:1272
    #7 0x1658517 in object_property_set_qobject   /mnt/sdc/qemu-master/qemu=
-4.2.0-rc0/qom/qom-qobject.c:26
    #8 0x15880bb in qmp_qom_set  /mnt/sdc/qemu-master/qemu-4.2.0-rc0/qom/qo=
m-qmp-cmds.c:74
    #9 0x157e3e3 in qmp_marshal_qom_set  qapi/qapi-commands-qom.c:154

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: PanNengyuan <pannengyuan@huawei.com>
Message-id: 1574835614-42028-1-git-send-email-pannengyuan@huawei.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/throttle-groups.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 77014c741b..37695b0cd7 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -893,8 +893,7 @@ static void throttle_group_set_limits(Object *obj, Visi=
tor *v,
 {
     ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
     ThrottleConfig cfg;
-    ThrottleLimits arg =3D { 0 };
-    ThrottleLimits *argp =3D &arg;
+    ThrottleLimits *argp;
     Error *local_err =3D NULL;
=20
     visit_type_ThrottleLimits(v, name, &argp, &local_err);
@@ -912,6 +911,7 @@ static void throttle_group_set_limits(Object *obj, Visi=
tor *v,
 unlock:
     qemu_mutex_unlock(&tg->lock);
 ret:
+    qapi_free_ThrottleLimits(argp);
     error_propagate(errp, local_err);
     return;
 }
--=20
2.24.1


