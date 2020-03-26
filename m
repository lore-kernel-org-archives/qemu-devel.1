Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB6FC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 01:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1685820714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 01:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UaFhiOVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1685820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHH5X-0004FI-4K
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 21:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jHH4Z-0003AR-NV
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 21:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jHH4X-0002PP-Nd
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 21:12:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:54934)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jHH4X-0002PA-JD
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 21:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585185156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=407L3w+jO+TLTewlegxFG6RoUuZ6W6toBUnGWKsj7wc=;
 b=UaFhiOVyYCMTFBICCislJOSPGUSbXY4hIS2WNoB44gPzTp6xcR4fHlGrxLf23jX0316++j
 aEoBiePe/i2OFGickk2oPwa1pTfAeUHJ71iPozit/WvWziCewtTHbvGncRBJClooLc28uS
 Yjm1bZ48px3KM/pvT3IOGxmOtld5S4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-AORGJBEGOA2Dzvpl2K94KQ-1; Wed, 25 Mar 2020 21:12:35 -0400
X-MC-Unique: AORGJBEGOA2Dzvpl2K94KQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76099100550D;
 Thu, 26 Mar 2020 01:12:32 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F055410002A5;
 Thu, 26 Mar 2020 01:12:19 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Fix the generic image creation code
Date: Thu, 26 Mar 2020 03:12:16 +0200
Message-Id: <20200326011218.29230-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 integration@gluster.org, sheepdog@lists.wpkg.org,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Jason Dillaman <dillaman@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Liu Yuan <namei.unix@gmail.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The recent patches from Max Reitz allowed some block drivers to not
provide the .bdrv_co_create_opts and still allow qemu-img to
create/format images as long as the image is already existing
(that is the case with various block storage drivers like nbd/iscsi/nvme, e=
tc)

However it was found out that some places in the code depend on the
.bdrv_co_create_opts/.create_opts to be !=3D NULL to decide if to allow
image creation.

To avoid adding failback code to all these places, just make generic failba=
ck
code be used by the drivers that need it, so that for outside user, there
is no diffirence if failback was used or not.

Best regards,
=09Maxim Levitsky

Maxim Levitsky (2):
  block: pass BlockDriver reference to the .bdrv_co_create
  block: trickle down the fallback image creation function use to the
    block drivers

 block.c                   | 38 ++++++++++++++++++++++----------------
 block/crypto.c            |  3 ++-
 block/file-posix.c        | 11 +++++++++--
 block/file-win32.c        |  4 +++-
 block/gluster.c           |  3 ++-
 block/iscsi.c             | 16 ++++------------
 block/nbd.c               |  6 ++++++
 block/nfs.c               |  4 +++-
 block/nvme.c              |  3 +++
 block/parallels.c         |  3 ++-
 block/qcow.c              |  3 ++-
 block/qcow2.c             |  4 +++-
 block/qed.c               |  3 ++-
 block/raw-format.c        |  4 +++-
 block/rbd.c               |  3 ++-
 block/sheepdog.c          |  4 +++-
 block/ssh.c               |  4 +++-
 block/vdi.c               |  4 +++-
 block/vhdx.c              |  3 ++-
 block/vmdk.c              |  4 +++-
 block/vpc.c               |  6 ++++--
 include/block/block.h     |  7 +++++++
 include/block/block_int.h |  3 ++-
 23 files changed, 95 insertions(+), 48 deletions(-)

--=20
2.17.2


