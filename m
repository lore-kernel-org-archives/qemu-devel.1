Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1667CC43141
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 20:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D64372073A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 20:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYYClmRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64372073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVig8-00035I-2x
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 15:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1iVieU-0001Kn-J2
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 15:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1iVieS-00046u-Cy
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 15:57:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46554
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1iVieS-00046L-8O
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 15:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573851427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HoO6ruPAVxpQOdAwRSe++ZTUuE+UMCu2boRtR0cZEy8=;
 b=TYYClmRrvnfK4NnOh6xN5ZlG0d7uQ3+nc4I0rRkqtlNk5MEJ+RNeYTH8qeaU3tHXf6HQ54
 +WpgSpmpqlRXlf+PMcPfFhG6kVDt59tPknK55DT0RvIXKPOrNUidlkmkGJMIptjOcuDJJI
 DbUdtPEWV4gN1NN3X6rJ5VGuFHyOV28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-ubEa3dvYNRWGtF9pNoScXg-1; Fri, 15 Nov 2019 15:55:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 979FF1005512;
 Fri, 15 Nov 2019 20:55:57 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DF505C548;
 Fri, 15 Nov 2019 20:55:51 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id C6A67220C26; Fri, 15 Nov 2019 15:55:50 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 0/4] [RFC] virtiofsd,
 vhost-user-fs: Add support for notification queue
Date: Fri, 15 Nov 2019 15:55:39 -0500
Message-Id: <20191115205543.1816-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ubEa3dvYNRWGtF9pNoScXg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: miklos@szeredi.hu, stefanha@redhat.com, vgoyal@redhat.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Here are RFC patches for adding a notification queue to virtio-fs to
send notifications from host to guest. It also has patches to support
remote posix locks which make use of this newly introduced notification
queue.

These patches apply on top of following.

https://gitlab.com/virtio-fs/qemu/tree/virtio-fs-dev

These change require changes in spec also. I have yet to create spec
changes and that's why this is still an RFC patch series.

Any feedback is appreciated.

Thanks
Vivek

Vivek Goyal (4):
  virtiofsd: Release file locks using F_UNLCK
  virtiofd: Create a notification queue
  virtiofsd: Specify size of notification buffer using config space
  virtiofsd: Implement blocking posix locks

 contrib/virtiofsd/fuse_i.h                 |   1 +
 contrib/virtiofsd/fuse_kernel.h            |   7 +
 contrib/virtiofsd/fuse_lowlevel.c          |  23 ++-
 contrib/virtiofsd/fuse_lowlevel.h          |  25 +++
 contrib/virtiofsd/fuse_virtio.c            | 226 +++++++++++++++++++--
 contrib/virtiofsd/passthrough_ll.c         |  79 +++++--
 hw/virtio/vhost-user-fs-pci.c              |   2 +-
 hw/virtio/vhost-user-fs.c                  |  63 +++++-
 include/hw/virtio/vhost-user-fs.h          |   3 +
 include/standard-headers/linux/virtio_fs.h |   5 +
 10 files changed, 386 insertions(+), 48 deletions(-)

--=20
2.20.1


