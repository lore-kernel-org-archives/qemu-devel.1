Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD90FC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:30:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BC124676
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFb5x0wu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BC124676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihzck-0003iR-3C
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihzXj-000674-FZ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:24:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihzXh-0005U8-MC
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:24:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22567
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihzXh-0005RE-FW
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576776292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q40D87wpfXXBcX5JqBIMu2XiRxmI1n/8wqQbJGu/rFg=;
 b=RFb5x0wuGTItygEI9ey8GWdGPunqYWx7GR5Huh8NLWPXeHRYQjHK2w8JZtS4jYkdCn6aSz
 AhGdZyIJaKiK4h2/oC6v1XrXKYui+rEqcAEfiPFQipfdajvmEQWvjZxt+KE59JXBN1HnJQ
 H4IikTGSCe5Ux4BpDis8TqDOT0K7gzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-qCzthPRiO0O9dGWXM0Rvgw-1; Thu, 19 Dec 2019 12:24:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D844107ACE4;
 Thu, 19 Dec 2019 17:24:50 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25DAC63B8A;
 Thu, 19 Dec 2019 17:24:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 02/30] iotests: Skip test 060 if it is not possible to create
 large files
Date: Thu, 19 Dec 2019 18:24:13 +0100
Message-Id: <20191219172441.7289-3-kwolf@redhat.com>
In-Reply-To: <20191219172441.7289-1-kwolf@redhat.com>
References: <20191219172441.7289-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: qCzthPRiO0O9dGWXM0Rvgw-1
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Test 060 fails in the arm64, s390x and ppc64le LXD containers on Travis
(which we will hopefully enable in our CI soon). These containers
apparently do not allow large files to be created. The repair process
in test 060 creates a file of 64 GiB, so test first whether such large
files are possible and skip the test if that's not the case.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/060 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index b91d8321bb..d96f17a484 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -49,6 +49,9 @@ _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
=20
+# The repair process will create a large file - so check for availability =
first
+_require_large_file 64G
+
 rt_offset=3D65536  # 0x10000 (XXX: just an assumption)
 rb_offset=3D131072 # 0x20000 (XXX: just an assumption)
 l1_offset=3D196608 # 0x30000 (XXX: just an assumption)
--=20
2.20.1


