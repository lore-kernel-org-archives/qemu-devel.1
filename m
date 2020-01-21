Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1C9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD05220882
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 09:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="InEW9wvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD05220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itqGB-0003LT-Sw
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 04:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1itqCo-0007On-UO
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1itqCn-0005S8-Om
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:52:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43743
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1itqCn-0005RX-KG
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 04:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579600337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QVxzrtuXbDfB3RFILPFLESht/1CjsbPr9SIFw02g/vw=;
 b=InEW9wvlbIeD6zirzR9CCUy/Cf7Mh/E3y98YKbb3P7CKlQ64SEHkJWNPuSty1Nj8tLO7WW
 jNVDFSIV+NIxOuAl3YdanMx2kc6hXDj0Rbgtp3/qfZDPP3/zRWpXlQDkJdN7B/HXRUL2+i
 EEa1uIT274X51tYhk7jdFx3TF8sEbC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-laIOQz7ANf6DSjAhKkjIMg-1; Tue, 21 Jan 2020 04:52:15 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42DA5DB60;
 Tue, 21 Jan 2020 09:52:14 +0000 (UTC)
Received: from thuth.com (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1F8410002A2;
 Tue, 21 Jan 2020 09:52:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v5 2/6] iotests: Test 041 only works on certain systems
Date: Tue, 21 Jan 2020 10:52:01 +0100
Message-Id: <20200121095205.26323-3-thuth@redhat.com>
In-Reply-To: <20200121095205.26323-1-thuth@redhat.com>
References: <20200121095205.26323-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: laIOQz7ANf6DSjAhKkjIMg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

041 works fine on Linux, FreeBSD, NetBSD and OpenBSD, but fails on macOS.
Let's mark it as only supported on the systems where we know that it is
working fine.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/041 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index c07437fda1..0181f7a9b6 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1134,4 +1134,5 @@ class TestOrphanedSource(iotests.QMPTestCase):
=20
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2', 'qed'],
-                 supported_protocols=3D['file'])
+                 supported_protocols=3D['file'],
+                 supported_platforms=3D['linux', 'freebsd', 'netbsd', 'ope=
nbsd'])
--=20
2.18.1


