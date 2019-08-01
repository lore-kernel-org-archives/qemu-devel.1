Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B776EC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D16D206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D16D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htCmc-0002lP-QG
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 11:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34993)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1htCl9-0001Nk-QM
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1htCl8-0006OV-Tj
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:12:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53943)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1htCky-0006L3-9V; Thu, 01 Aug 2019 11:12:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9AE3E309C984;
 Thu,  1 Aug 2019 15:12:37 +0000 (UTC)
Received: from localhost (ovpn-204-187.brq.redhat.com [10.40.204.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C104100032A;
 Thu,  1 Aug 2019 15:12:36 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu,  1 Aug 2019 17:12:33 +0200
Message-Id: <20190801151235.8434-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 01 Aug 2019 15:12:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1 0/2] backup: Copy only dirty areas
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

In a discussion with Vladimir today, we noticed that the backup job
currently is pretty broken when using copy offloading.  I don=E2=80=99t k=
now
about you, but my local filesystem (XFS) supports copy offloading, so
the job uses it automatically.  That means, that backup is broken and
has been broken for a year on my local FS.

The last working version was 2.12, so this isn=E2=80=99t a regression in =
4.1.
We could thus justify moving it to 4.2.  But I think this should really
go into 4.1, because this is not really an edge case and as far as I
know users cannot do anything to prevent the backup job from performing
copy offloading if the system and all involved block drivers support it.
I just wonder why nobody has noticed...


Max Reitz (2):
  backup: Copy only dirty areas
  iotests: Test backup job with two guest writes

 block/backup.c             | 13 +++++++++++--
 tests/qemu-iotests/056     | 34 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/056.out |  4 ++--
 3 files changed, 47 insertions(+), 4 deletions(-)

--=20
2.21.0


