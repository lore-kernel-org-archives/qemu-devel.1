Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB9FC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 321552075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321552075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57981 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUE8L-0005Ag-Ha
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 13:37:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hUE26-0007DD-SQ
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hUDzX-0004O6-Mo
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:28:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hUDzV-0004M5-1Y; Fri, 24 May 2019 13:28:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B238481F07;
	Fri, 24 May 2019 17:28:17 +0000 (UTC)
Received: from localhost (ovpn-204-150.brq.redhat.com [10.40.204.150])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 789551001DED;
	Fri, 24 May 2019 17:28:14 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 24 May 2019 19:28:09 +0200
Message-Id: <20190524172812.27308-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 24 May 2019 17:28:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] =?utf-8?q?=5BRFC_0/3=5D_block=3A_Inquire_images?=
 =?utf-8?q?=E2=80=99_rotational_info?=
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
	Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

http://lists.nongnu.org/archive/html/qemu-block/2019-05/msg00569.html
shows that optimizations affect HDDs and SSDs differently.  It would be
nice if we could differentiate between the two and then choose to adjust
our behavior depending on whether a given image is stored on an HDD or
not.

Or maybe it isn=E2=80=99t so nice.  That=E2=80=99s one reason this is an =
RFC.

The other is that I implemented recognition of the rotational status by
querying sysfs.  That looks stupid, but I didn=E2=80=99t find a better wa=
y
(there is a BLKROTATIONAL ioctl, but that only works on device files).

But, hey, if you look through block/file-posix.c, you=E2=80=99ll find tha=
t I=E2=80=99m
not the first to query sysfs.  hdev_get_max_segments() does so, too.  So
maybe it isn=E2=80=99t that bad of an idea.


What do you think?  Is the whole idea stupid?  Just the implementation?
Or does it make sense?


Max Reitz (3):
  block: Add ImageRotationalInfo
  file-posix: Inquire rotational status
  qcow2: Evaluate rotational info

 qapi/block-core.json  | 19 ++++++++++-
 block/qcow2.h         |  3 ++
 include/block/block.h |  7 +++++
 block.c               | 20 +++++++++++-
 block/file-posix.c    | 73 +++++++++++++++++++++++++++++++++++++++++++
 block/qapi.c          |  3 ++
 block/qcow2.c         | 34 +++++++++++++++++---
 7 files changed, 153 insertions(+), 6 deletions(-)

--=20
2.21.0


