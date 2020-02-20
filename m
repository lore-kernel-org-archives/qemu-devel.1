Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86262C11D0B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52321207FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkWFfmfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52321207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oOT-0004CS-7y
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4oN9-0002Xa-Lo
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4oN8-0004nM-41
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:08:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43167
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4oN8-0004mt-0Y
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582214897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OhMxv/IG+GIdXRB2FTwhfQ52TVogWpuaqU23iG/opWM=;
 b=TkWFfmfCKtl0H1PbSG6hj/kJVmXZtGEIHDMq8B8gb9nJHrCgTT4pDdG6LRsTrfBZTxwXq1
 pedTIBL9wVzymxn6BsSRmGe92XLXM96MO1L1eCfLQ5hGs7iUMS2zAFRtNA1zjr5we6Anoo
 BZsd5IGbvYY4R7kejUyL05JYJxceotc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-Bhe8QZU4OeeGseZZwQ1TCQ-1; Thu, 20 Feb 2020 11:08:08 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AFC9800D53;
 Thu, 20 Feb 2020 16:08:07 +0000 (UTC)
Received: from localhost (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD6DF5C1B0;
 Thu, 20 Feb 2020 16:08:06 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 02/18] docs: qcow2: introduce compression type feature
Date: Thu, 20 Feb 2020 17:06:54 +0100
Message-Id: <20200220160710.533297-3-mreitz@redhat.com>
In-Reply-To: <20200220160710.533297-1-mreitz@redhat.com>
References: <20200220160710.533297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Bhe8QZU4OeeGseZZwQ1TCQ-1
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

The patch adds a new additional field to the qcow2 header: compression_type=
,
which specifies compression type. If field is absent or zero, default
compression type is set: ZLIB, which corresponds to current behavior.

New compression type (ZSTD) is to be added in further commit.

Suggested-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200131142219.3264-3-vsementsov@virtuozzo.com>
[mreitz: s/Bits 3-63:  Reserved/Bits 4-63:  Reserved/]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 docs/interop/qcow2.txt | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 823cc266e0..5597e24474 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -109,7 +109,12 @@ the next fields through header_length.
                                 An External Data File Name header extensio=
n may
                                 be present if this bit is set.
=20
-                    Bits 3-63:  Reserved (set to 0)
+                    Bit 3:      Compression type bit.  If this bit is set,
+                                a non-default compression is used for comp=
ressed
+                                clusters. The compression_type field must =
be
+                                present and not zero.
+
+                    Bits 4-63:  Reserved (set to 0)
=20
          80 -  87:  compatible_features
                     Bitmask of compatible features. An implementation can
@@ -190,7 +195,19 @@ present*, if not altered by a specific incompatible bi=
t.
 to the field's offset. Also, all additional fields are not present for
 version 2.
=20
-        < ... No additional fields in the header currently ... >
+              104:  compression_type
+
+                    Defines the compression method used for compressed clu=
sters.
+                    All compressed clusters in an image use the same compr=
ession
+                    type.
+
+                    If the incompatible bit "Compression type" is set: the=
 field
+                    must be present and non-zero (which means non-zlib
+                    compression type). Otherwise, this field must not be p=
resent
+                    or must be zero (which means zlib).
+
+                    Available compression type values:
+                        0: zlib <https://www.zlib.net/>
=20
=20
 =3D=3D=3D Header padding =3D=3D=3D
--=20
2.24.1


