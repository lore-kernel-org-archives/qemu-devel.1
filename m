Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60D9C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC322166E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdN8Ir9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC322166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUb9O-0008GA-Nm
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 15:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jUb83-0006XW-JL
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jUb82-0008Ue-54
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:15:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51692
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jUb81-0008SJ-Kd
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588360516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rzf6scuqvP2Ba5NKL2ng6cu0R00rpFtr/wAlNQDWLPI=;
 b=YdN8Ir9KCY8T87aIR9saTm5nyl2s5JZLkTZqyuULt4hbQrYf+aFS24Ebc2/q15JqIBu+hG
 KSpjpZzOqTM8pTf+RoBO8DQ7AceLqnBrofkzrqJyukdBETyepIdHrbWY0yFgX5iEG3LawV
 6o3g8m/6kAiTTZJjA/gkLa1AhbtZyug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-qnJf7fxAM1qmwx_bZn5DQw-1; Fri, 01 May 2020 15:15:12 -0400
X-MC-Unique: qnJf7fxAM1qmwx_bZn5DQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E73A41030989;
 Fri,  1 May 2020 19:15:11 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-112-191.ams2.redhat.com
 [10.36.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9634A1000322;
 Fri,  1 May 2020 19:15:02 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, yavrahami@paloaltonetworks.com,
 mszeredi@redhat.com, mreitz@redhat.com
Subject: [PULL 0/6] virtiofs queue
Date: Fri,  1 May 2020 20:14:54 +0100
Message-Id: <20200501191500.126432-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 12:40:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 1c47613588ccff44422d4bdeea0dc36a0a308ec7=
:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into stagi=
ng (2020-04-30 19:25:41 +0100)

are available in the Git repository at:

  https://gitlab.com/dagrh/qemu.git tags/pull-virtiofs-20200501

for you to fetch changes up to 66502bbca37ca7a3bfa57e82cfc03b89a7a11eae:

  virtiofsd: drop all capabilities in the wait parent process (2020-05-01 2=
0:05:37 +0100)

----------------------------------------------------------------
virtiofsd: Pull 2020-05-01 (includes CVE fix)

This set includes a security fix, other fixes and improvements.

Security fix:
The security fix is for CVE-2020-10717 where, on low RAM hosts,
the guest can potentially exceed the maximum fd limit.
This fix adds some more configuration so that the user
can explicitly set the limit.
Thank you to Yuval Avrahami for reporting this.

Fixes:

Recursive mounting of the exported directory is now used in
the sandbox, such that if there was a mount underneath present at
the time the virtiofsd was started, that mount is also
visible to the guest; in the existing code, only mounts that
happened after startup were visible.

Security improvements:

The jailing for /proc/self/fd is improved - but it's something
that shouldn't be accessible anyway.

Most capabilities are now dropped at startup; again this shouldn't
change any behaviour but is extra protection.

----------------------------------------------------------------
Max Reitz (1):
      virtiofsd: Show submounts

Miklos Szeredi (1):
      virtiofsd: jail lo->proc_self_fd

Stefan Hajnoczi (4):
      virtiofsd: add --rlimit-nofile=3DNUM option
      virtiofsd: stay below fs.file-max sysctl value (CVE-2020-10717)
      virtiofsd: only retain file system capabilities
      virtiofsd: drop all capabilities in the wait parent process

 tools/virtiofsd/fuse_lowlevel.h  |   1 +
 tools/virtiofsd/helper.c         |  47 ++++++++++++++++++
 tools/virtiofsd/passthrough_ll.c | 102 ++++++++++++++++++++++++++++++++---=
----
 3 files changed, 133 insertions(+), 17 deletions(-)


