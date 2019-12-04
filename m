Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0EDC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85CB20656
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1pqXTTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85CB20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ica3C-0004Ki-QD
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 14:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1ica18-0002ZE-LB
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:08:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1ica15-0005Pg-5L
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:08:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41609
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1ica15-0005P7-0E
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575486529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eNIwwKChEkUgrPYQ/LAyA6XW7ci4CpOGx36/WPobUfo=;
 b=R1pqXTTmlS6VpRHo7lybzgshfNVQGS2k8r8JMehfZz40swI5BQvxqmc4cItTJNE0sSvWQ0
 y6BDmTdnCbIyFXmFl8BA1Nk01l5aedUhjh76TJwfq78oAKjEd6kfz3hpMzjMmO8ryZH76T
 gg2OsYxfX1DaTsKBzVomUxtaytUugBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-nVA2CYpTNImEapIHxUyTnQ-1; Wed, 04 Dec 2019 14:08:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CB831023138
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 19:08:47 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B7AA600CD;
 Wed,  4 Dec 2019 19:08:42 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 09DB72202E9; Wed,  4 Dec 2019 14:08:42 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] [RFC] virtiofsd,
 vhost-user-fs: Add support for notification queue
Date: Wed,  4 Dec 2019 14:08:31 -0500
Message-Id: <20191204190836.31324-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: nVA2CYpTNImEapIHxUyTnQ-1
X-Mimecast-Spam-Score: 0
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
Cc: mszeredi@redhat.com, dgilbert@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Here is V2 of RFC patches for adding a notification queue to
vhost-user-fs device to send notifications from host to guest.
It also has patches to support remote posix locks which make use of this
newly introduced notification queue.

I have taken care of most of the comments from last iteration. Still one
major TODO item is to be able to interrupt/stop blocked thrads for locks
when guest reboots.=20

Patches are also available here.

https://github.com/rhvgoyal/qemu/commits/blocking-locks-v2

Associated kernel changes are available here.

https://github.com/rhvgoyal/linux/commits/blocking-locks-v2

Thanks
Vivek

Vivek Goyal (5):
  virtiofsd: Get rid of unused fields in fv_QueueInfo
  virtiofsd: Release file locks using F_UNLCK
  virtiofd: Create a notification queue
  virtiofsd: Specify size of notification buffer using config space
  virtiofsd: Implement blocking posix locks

 contrib/virtiofsd/fuse_i.h                 |   1 +
 contrib/virtiofsd/fuse_kernel.h            |   7 +
 contrib/virtiofsd/fuse_lowlevel.c          |  23 ++-
 contrib/virtiofsd/fuse_lowlevel.h          |  25 +++
 contrib/virtiofsd/fuse_virtio.c            | 208 +++++++++++++++++----
 contrib/virtiofsd/passthrough_ll.c         |  80 ++++++--
 hw/virtio/vhost-user-fs-pci.c              |   2 +-
 hw/virtio/vhost-user-fs.c                  |  63 ++++++-
 include/hw/virtio/vhost-user-fs.h          |   3 +
 include/standard-headers/linux/virtio_fs.h |   5 +
 10 files changed, 354 insertions(+), 63 deletions(-)

--=20
2.20.1


