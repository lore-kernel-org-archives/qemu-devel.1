Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D25C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 21:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553EA206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 21:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tb20N+wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553EA206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jViS4-0005HR-8t
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 17:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jViQR-0003sX-S7
 for qemu-devel@nongnu.org; Mon, 04 May 2020 17:14:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31170
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jViQQ-0000nj-Sl
 for qemu-devel@nongnu.org; Mon, 04 May 2020 17:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588626893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EreIJQ4hJ/hcapIcvpXQICfb5MIGrsU9rUtkQuqOyIc=;
 b=Tb20N+whEQtuY+793W5mi8KConYRuD9RvIYa/4M2ubgmDzt7OHp9AQH1v90cJdTRkEmOf5
 J2/VJSTJhWmruVISUWbkF4J6lfSXslBdJivtiNmwNxzLtm2Xk05brqDC5LVzxSZ5wMrLX3
 5yOu9XhntIOTLXK7KZsXkqIeE8rsqpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-_fKDn3UZMj6_6hFppjCE3Q-1; Mon, 04 May 2020 17:14:51 -0400
X-MC-Unique: _fKDn3UZMj6_6hFppjCE3Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4688464;
 Mon,  4 May 2020 21:14:50 +0000 (UTC)
Received: from blue.redhat.com (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8052A7052A;
 Mon,  4 May 2020 21:14:47 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] iotests/041: Fix NBD socket path
Date: Mon,  4 May 2020 16:14:36 -0500
Message-Id: <20200504211438.195926-3-eblake@redhat.com>
In-Reply-To: <20200504211438.195926-1-eblake@redhat.com>
References: <20200504211438.195926-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

We should put all UNIX socket files into the sock_dir, not test_dir.

Reported-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200424134626.78945-1-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Fixes: a1da1878607a
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/041 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 5d67bf14bfe8..46bf1f6c8164 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -35,7 +35,7 @@ quorum_img3 =3D os.path.join(iotests.test_dir, 'quorum3.i=
mg')
 quorum_repair_img =3D os.path.join(iotests.test_dir, 'quorum_repair.img')
 quorum_snapshot_file =3D os.path.join(iotests.test_dir, 'quorum_snapshot.i=
mg')

-nbd_sock_path =3D os.path.join(iotests.test_dir, 'nbd.sock')
+nbd_sock_path =3D os.path.join(iotests.sock_dir, 'nbd.sock')

 class TestSingleDrive(iotests.QMPTestCase):
     image_len =3D 1 * 1024 * 1024 # MB
--=20
2.26.2


