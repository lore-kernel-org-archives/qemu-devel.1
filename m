Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1713C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:13:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99620214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhTihGvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99620214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgy8-0005Qm-Pc
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izgdc-0003l9-K0
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izgdb-0001n6-Lv
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55985
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izgdb-0001lf-Ho
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580993527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kPbx+krUXpbscyYUiKrhyMv0I7dRYUoEf7YQ4xzU4YI=;
 b=PhTihGvza9LuGrqaFOMyVjfToxe+MqaEhH2USN8dTpv6YbxYmXebWMZxG8BqfkbIdWHy4c
 +GbZrHz/H9UTXQPK5U01yUzZoCxiNYGAUJewCWryKylzMOrqLpL35wOOYcepa63qN7nWlp
 V2KCjPmKc6ksAS18TnaPuHb3nEJtGy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-Fg_kAZaDMNSKLQbz_qA1aw-1; Thu, 06 Feb 2020 07:52:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F56018CA242;
 Thu,  6 Feb 2020 12:52:03 +0000 (UTC)
Received: from localhost (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04B5D5C1B0;
 Thu,  6 Feb 2020 12:52:02 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 14/17] qcow2: Don't require aligned offsets in
 qcow2_co_copy_range_from()
Date: Thu,  6 Feb 2020 13:51:29 +0100
Message-Id: <20200206125132.594625-15-mreitz@redhat.com>
In-Reply-To: <20200206125132.594625-1-mreitz@redhat.com>
References: <20200206125132.594625-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Fg_kAZaDMNSKLQbz_qA1aw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

qemu-img's convert_co_copy_range() operates at the sector level and
block_copy() operates at the cluster level so this condition is always
true, but it is not necessary to restrict this here, so let's leave it
to the driver implementation return an error if there is any.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: a4264aaee656910c84161a2965f7a501437379ca.1579374329.git.berto@i=
galia.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 6cb5aee4a5..ff257d1a6c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3828,10 +3828,6 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
         case QCOW2_CLUSTER_NORMAL:
             child =3D s->data_file;
             copy_offset +=3D offset_into_cluster(s, src_offset);
-            if ((copy_offset & 511) !=3D 0) {
-                ret =3D -EIO;
-                goto out;
-            }
             break;
=20
         default:
--=20
2.24.1


