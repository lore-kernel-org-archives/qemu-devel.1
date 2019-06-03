Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B782C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 13:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DD026B02
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 13:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DD026B02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35421 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXnEU-0005Di-MC
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 09:42:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXnDK-0004Q8-Pw
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 09:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXnDJ-0007sh-So
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 09:41:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXnDH-0007lK-Gi; Mon, 03 Jun 2019 09:41:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A993356FF;
	Mon,  3 Jun 2019 13:41:09 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-129.ams2.redhat.com [10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D0BB466618;
	Mon,  3 Jun 2019 13:40:55 +0000 (UTC)
Date: Mon, 3 Jun 2019 15:40:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190603134054.GF6523@linux.fritz.box>
References: <20190423125706.26989-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423125706.26989-1-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 03 Jun 2019 13:41:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 0/3] Fix overflow bug in qcow2 discard
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, den@virtuozzo.com, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.04.2019 um 14:57 hat Vladimir Sementsov-Ogievskiy geschrieben:
> v5: by Kevin's comments
> 02: add check for invalid @bytes parameter, drop r-b
> 03: move from qemu-img info to qemu-img map -f raw, drop r-b and t-b

The patches look good to me, but the test case fails (this is on XFS; it
does work on tmpfs):

--- /home/kwolf/source/qemu/tests/qemu-iotests/250.out  2019-06-03 15:22:51.212961123 +0200
+++ /home/kwolf/source/qemu/tests/qemu-iotests/250.out.bad      2019-06-03 15:37:37.202959101 +0200
@@ -12,12 +12,10 @@
 0               0xa00000        0x82f00000      TEST_DIR/t.qcow2
 0x82a00000      0xa00000        0x500000        TEST_DIR/t.qcow2
 Offset          Length          Mapped to       File
-0               0x301000        0               TEST_DIR/t.qcow2
-0x400000        0xb00000        0x400000        TEST_DIR/t.qcow2
+0               0xf00000        0               TEST_DIR/t.qcow2
 0x82f00000      0xa00000        0x82f00000      TEST_DIR/t.qcow2
 Image resized.
 Offset          Length          Mapped to       File
-0               0x301000        0               TEST_DIR/t.qcow2
-0x400000        0x100000        0x400000        TEST_DIR/t.qcow2
+0               0x500000        0               TEST_DIR/t.qcow2
 0x82f00000      0x500000        0x82f00000      TEST_DIR/t.qcow2
 *** done

I'll apply the first two patches without the test for now, but please
try if you can tweak the test case to work on all common filesystems.

Kevin

