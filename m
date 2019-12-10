Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F185C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A443207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFdWfmxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A443207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieh2R-0005kJ-7k
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 10:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ieh1g-0005DS-J5
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 10:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ieh1b-0004HY-JQ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 10:02:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28867
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ieh1b-0004HM-Fm
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 10:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575990127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lReS2R0aRIReKgjC6upRWpB4x00FQ45qJ1Kl5Di3O2I=;
 b=CFdWfmxxqfHUC5Hb8A4x+a/A3GLFOVaQhk4xa95S47ToOIGbVz0woPWxDUmbfcHeoWcedg
 pnoloPbZwMbjKeoIwZGf+qAMH/M+LW7dEAhNTaYBm9LY9V8rICPxc73JP+opdrbU9NbPU9
 PFABDOGJf74y3OySmisXs/fbJqaVEog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-lAfNpCI6M3e-SolHHtTdEQ-1; Tue, 10 Dec 2019 10:02:03 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E3759798D;
 Tue, 10 Dec 2019 15:02:02 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-11.ams2.redhat.com [10.36.117.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7352B5C1B0;
 Tue, 10 Dec 2019 15:02:01 +0000 (UTC)
Date: Tue, 10 Dec 2019 16:02:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] qemu-img: fix info --backing-chain --image-opts
Message-ID: <20191210150200.GB7103@linux.fritz.box>
References: <20191205134646.445427-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191205134646.445427-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: lAfNpCI6M3e-SolHHtTdEQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 05.12.2019 um 14:46 hat Stefan Hajnoczi geschrieben:
> Only apply --image-opts to the topmost image when listing an entire
> backing chain.  It is incorrect to treat backing filenames as image
> options.  Assuming we have the backing chain t.IMGFMT.base <-
> t.IMGFMT.mid <- t.IMGFMT, qemu-img info fails as follows:
>=20
>   $ qemu-img info --backing-chain --image-opts \
>       driver=3Dqcow2,file.driver=3Dfile,file.filename=3Dt.IMGFMT
>   qemu-img: Could not open 'TEST_DIR/t.IMGFMT.mid': Cannot find device=3D=
TEST_DIR/t.IMGFMT.mid nor node_name=3DTEST_DIR/t.IMGFMT.mid
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

> diff --git a/tests/qemu-iotests/279 b/tests/qemu-iotests/279
> new file mode 100755
> index 0000000000..b555a92859
> --- /dev/null
> +++ b/tests/qemu-iotests/279
> @@ -0,0 +1,56 @@
> +#!/usr/bin/env bash
> +#
> +# Test qemu-img --backing-chain --image-opts
> +#
> +# Copyright (C) 2019 Red Hat, Inc.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +seq=3D$(basename "$0")
> +echo "QA output created by $seq"
> +
> +status=3D1=09# failure is the default!
> +
> +_cleanup()
> +{
> +    _cleanup_test_img

I'm squashing in this fixup:

diff --git a/tests/qemu-iotests/279 b/tests/qemu-iotests/279
index b555a92859..6682376808 100755
--- a/tests/qemu-iotests/279
+++ b/tests/qemu-iotests/279
@@ -26,6 +26,7 @@ status=3D1      # failure is the default!
 _cleanup()
 {
     _cleanup_test_img
+    rm -f "$TEST_IMG.mid"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15


Thanks, applied to the block branch.

Kevin


