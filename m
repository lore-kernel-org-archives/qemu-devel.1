Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589CDECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31867206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31867206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXe1-0006ff-5b
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWrV-0007DH-Jw
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWrT-0008NF-Jx
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:44:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWrQ-0008Lz-Lg; Thu, 10 Oct 2019 07:44:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E5B9D883C3D;
 Thu, 10 Oct 2019 11:43:59 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B67260BE1;
 Thu, 10 Oct 2019 11:43:59 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 26/36] iotests: Fix 125 for growth_mode = metadata
Date: Thu, 10 Oct 2019 13:42:50 +0200
Message-Id: <20191010114300.7746-27-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Thu, 10 Oct 2019 11:43:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

If we use growth_mode =3D metadata, it is very much possible that the fil=
e
uses more disk space after we have written something to the added area.
We did indeed want to test for this case, but unfortunately we evidently
just copied the code from the "Test creation preallocation" section and
forgot to replace "$create_mode" by "$growth_mode".

We never noticed because we only read the first number from qemu-img
info's "disk size" output -- and that is effectively useless, because
qemu-img prints a human-readable value (which generally includes a
decimal point).  That will be fixed in the patch after the next one.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190925183231.11196-2-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/125 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index dc4b8f5fb9..df328a63a6 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -111,7 +111,7 @@ for GROWTH_SIZE in 16 48 80; do
                 if [ $file_length_2 -gt $file_length_1 ]; then
                     echo "ERROR (grow): Image length has grown from $fil=
e_length_1 to $file_length_2"
                 fi
-                if [ $create_mode !=3D metadata ]; then
+                if [ $growth_mode !=3D metadata ]; then
                     # The host size should not have grown either
                     if [ $host_size_2 -gt $host_size_1 ]; then
                         echo "ERROR (grow): Host size has grown from $ho=
st_size_1 to $host_size_2"
--=20
2.21.0


