Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797E9C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44FAC20578
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVLnHb0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FAC20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58jO-0001Mb-GY
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:52:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j58JT-0002mq-Ut
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:25:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j58JO-0007Dw-PS
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:25:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28644
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j58JO-00079w-Jo
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582291543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1nwUdvT0Ryvn0nDx9c3g1DWkP++mcmbDXXlxbjBWa0Y=;
 b=aVLnHb0rxvcewymeQM7jEjsDWxobPeP4q8IvDUwPi/2UnkNE2hDiMZIRRJVrDAos7+yO/D
 u1Lp2CY8JFVhY0AB8tW4AhY6VEWx5fk6ByFZV0mgf5F6WVPbMrVe6QgnvaSIDlr8yPegUN
 SGArefSGeFfGdZjEBsX9Zc+kypzSHdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-7Tvyli1YPOyb1L81XBuSeA-1; Fri, 21 Feb 2020 08:25:41 -0500
X-MC-Unique: 7Tvyli1YPOyb1L81XBuSeA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C4EA800D4E;
 Fri, 21 Feb 2020 13:25:40 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 543FA8B740;
 Fri, 21 Feb 2020 13:25:39 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, philmd@redhat.com, yangx.jy@cn.fujitsu.com,
 mrezanin@redhat.com
Subject: [PULL 0/6] virtiofs queue
Date: Fri, 21 Feb 2020 13:25:30 +0000
Message-Id: <20200221132536.38364-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit b651b80822fa8cb66ca30087ac7fbc75507ae5d2=
:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.0-pul=
l-request' into staging (2020-02-20 17:35:42 +0000)

are available in the Git repository at:

  https://gitlab.com/dagrh/qemu.git tags/pull-virtiofs-20200221

for you to fetch changes up to 5bb8e8beedb47fc0d0a44957a154918c4f4afc80:

  docs: Fix virtiofsd.1 location (2020-02-21 13:05:27 +0000)

----------------------------------------------------------------
virtiofs pull 20200221

Mostly minor cleanups.
Miroslav's fixes a make install corner case.
Philippe's set includes an error corner case fix.

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      virtiofsd: Help message fix for 'seconds'

Miroslav Rezanina (1):
      docs: Fix virtiofsd.1 location

Philippe Mathieu-Daud=C3=A9 (3):
      tools/virtiofsd/passthrough_ll: Remove unneeded variable assignment
      tools/virtiofsd/passthrough_ll: Remove unneeded variable assignment
      tools/virtiofsd/fuse_lowlevel: Fix fuse_out_header::error value

Xiao Yang (1):
      virtiofsd: Remove fuse.h and struct fuse_module

 Makefile                         |    2 +-
 tools/virtiofsd/fuse.h           | 1229 ----------------------------------=
----
 tools/virtiofsd/fuse_i.h         |   16 -
 tools/virtiofsd/fuse_lowlevel.c  |    2 +-
 tools/virtiofsd/helper.c         |    2 +-
 tools/virtiofsd/passthrough_ll.c |    4 -
 6 files changed, 3 insertions(+), 1252 deletions(-)
 delete mode 100644 tools/virtiofsd/fuse.h


