Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FF7C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0FB5206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FB5206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2YCR-0004hL-PX
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 05:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i2YBg-00049s-Oq
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i2YBe-0004eV-Do
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:54:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i2YBe-0004dv-8p
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:54:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 61B0085360
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 09:54:48 +0000 (UTC)
Received: from localhost (ovpn-116-148.ams2.redhat.com [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D27E05C1D6;
 Tue, 27 Aug 2019 09:54:38 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 10:54:33 +0100
Message-Id: <20190827095437.18819-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 27 Aug 2019 09:54:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/4] virtiofsd: implement vhost-user.rst
 "Backend program conventions"
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series implements the conventions for vhost-user backend programs
described in vhost-user.rst:
1. Run in the foreground by default.
2. Show vhost-user.json capabilities when --print-capabilities is given.
3. Ship a vhost-user.json file so the program can be discovered.

No command-line options or VHostUserBackendCapabilities are defined for t=
he
'fs' backend type yet.  Let's until it becomes clear what should be stand=
ard
for all 'fs' backends and what is specific to virtiofsd.

Stefan Hajnoczi (4):
  virtiofsd: make -f (foreground) the default
  virtiofsd: add --print-capabilities option
  virtiofsd: install virtiofsd in libexec
  virtiofsd: add vhost-user.json file

 docs/interop/vhost-user.json                |  4 +++-
 Makefile                                    |  3 +++
 contrib/virtiofsd/fuse_lowlevel.h           |  1 +
 contrib/virtiofsd/helper.c                  |  5 +++++
 contrib/virtiofsd/passthrough_ll.c          | 12 ++++++++++++
 .gitignore                                  |  1 +
 contrib/virtiofsd/50-qemu-virtiofsd.json.in |  5 +++++
 7 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 contrib/virtiofsd/50-qemu-virtiofsd.json.in

--=20
2.21.0


