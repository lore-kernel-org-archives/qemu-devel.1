Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0ABC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D484121569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVfM6bm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D484121569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuhJl-0003aN-7d
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iufdA-00046X-La
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iufd9-00066u-Bf
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:46:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46920
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iufd9-00066j-8y
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pAEsHYhzxB5DzySRrqDKsV0TyjTvyd0eVKdu0rwskEs=;
 b=jVfM6bm+TLffP537oDcylfwDHp2DPnaddmfgiLKKI9JVDUhXMImAdrBjVEWwW4iuY58p23
 jOvrck9e7TQfnnix9kvfTRm5hRcWQEyZcO7SZRDu2ZE/0EC4/O9X4FyilegAgqk5pWnz+l
 0bY9LY1j489IJX0gVrFFeD2/ouPGLPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-wIFeBnVPPxWIu95OYYuj6A-1; Thu, 23 Jan 2020 11:46:53 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34F6510120AD;
 Thu, 23 Jan 2020 16:46:52 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C981F2CE3A;
 Thu, 23 Jan 2020 16:46:50 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] finish qemu-nbd --partition deprecation
Date: Thu, 23 Jan 2020 10:46:48 -0600
Message-Id: <20200123164650.1741798-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: wIFeBnVPPxWIu95OYYuj6A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20200116141511.16849-1-peter.maydell@linaro.org>
(0/3 convert qemu-nbd, qemu-block-drivers to rST)

In v2:
- rebased on top of rST doc changes
- patch 1 added

Eric Blake (2):
  docs: Fix typo in qemu-nbd -P replacement
  qemu-nbd: Removed deprecated --partition option

 docs/interop/qemu-nbd.rst |  15 ++---
 qemu-deprecated.texi      |  49 ++++++--------
 qemu-nbd.c                | 133 +-------------------------------------
 3 files changed, 24 insertions(+), 173 deletions(-)

--=20
2.24.1


