Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D901CC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B87820722
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lb6xdD+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B87820722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43Yo-0000dq-PH
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:09:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43Xh-0006qI-79
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43Xe-0001Oo-4b
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36139
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43Xe-0001OO-08
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6G3TsZsUmy/T3mGiihPPEpRJssI/cSdPTXrxKzIHPt8=;
 b=Lb6xdD+RAoYOgiXg/VpUlMM+aUrd79B3TYy5JZ2Rg+HnBXwho/GLdSyij5us5h3aENY5bg
 6sdV8uM6k/EGCoflr40EurNSgA01aMFNqyDVXD4A31R4BGeyblU6wf5CjzZdfzzXkMpwRV
 AOjiB03tI9IEs1nw1tAWWQyuoC47dns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-lBP87D3gOsydkjF3ABEidw-1; Tue, 18 Feb 2020 09:07:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C1D18018A2;
 Tue, 18 Feb 2020 14:07:53 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4895A8B54F;
 Tue, 18 Feb 2020 14:07:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 01/36] mirror: Store MirrorOp.co for debuggability
Date: Tue, 18 Feb 2020 15:06:47 +0100
Message-Id: <20200218140722.23876-2-kwolf@redhat.com>
In-Reply-To: <20200218140722.23876-1-kwolf@redhat.com>
References: <20200218140722.23876-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: lBP87D3gOsydkjF3ABEidw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a coroutine is launched, but the coroutine pointer isn't stored
anywhere, debugging any problems inside the coroutine is quite hard.
Let's store the coroutine pointer of a mirror operation in MirrorOp to
have it available in the debugger.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/mirror.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index f0f2d9dff1..8959e4255f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -103,6 +103,7 @@ struct MirrorOp {
     bool is_pseudo_op;
     bool is_active_write;
     CoQueue waiting_requests;
+    Coroutine *co;
=20
     QTAILQ_ENTRY(MirrorOp) next;
 };
@@ -429,6 +430,7 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64=
_t offset,
     default:
         abort();
     }
+    op->co =3D co;
=20
     QTAILQ_INSERT_TAIL(&s->ops_in_flight, op, next);
     qemu_coroutine_enter(co);
--=20
2.20.1


