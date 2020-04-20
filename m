Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D589C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5E120B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIEYCRCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5E120B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQaey-00040u-87
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 13:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36648 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQabe-0007M6-Bs
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:53:23 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQabd-0004pS-9e
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:53:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52187
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jQabc-0004mV-LE
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587405195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KzgD9Ym5NSVjFf97eN0txk+Ac2jVc+WQkP8DXaLEsyM=;
 b=eIEYCRCeRY4aLwZ9DGNFLmcKNUbW2xlBgWOOqkBOYYVOxK/QnlfNecsITw9TOobD3VOnV3
 towyXZGxbLB71I2DlZbsYWv6rpUgNynPP4zrQilkLLecEDhx1Cs7joOv6nIWn0ejHhv4Mt
 qOqYuBiqMg6EhovxP0o7stqXE5Cjg2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-n3PrMgIWNCKysEQTbyC-Ew-1; Mon, 20 Apr 2020 13:53:11 -0400
X-MC-Unique: n3PrMgIWNCKysEQTbyC-Ew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 476178017F3;
 Mon, 20 Apr 2020 17:53:10 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C851A103F;
 Mon, 20 Apr 2020 17:53:09 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] fix fcntl(F_SETFD) usage
Date: Mon, 20 Apr 2020 12:53:06 -0500
Message-Id: <20200420175309.75894-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 04:32:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As recently pointed out:
https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg03133.html
code that blindly calls fcntl(fd, F_SETFD, 1) rather than performing a
read-modify-write when it intends to add FD_CLOEXEC is broken, in that
it can inadvertently clear other bits.

Thankfully, the culprits fixed in this series are unlikely to be
clearing either FD_CLOFORK (if Linux ever follows Solaris' lead in
adding that), or the new FD_32BIT_MODE being proposed (as the fds in
question are unlikely to have that set) - but it is still better to
write proper code than to set up a bad example prone to copy-and-paste
propagation.  And as these usages are not new to 5.0, I don't see any
reason against waiting until 5.1 to apply them.

Eric Blake (2):
  hax: Fix setting of FD_CLOEXEC
  tools: Fix use of fcntl(F_SETFD) during socket activation

 target/i386/hax-posix.c | 6 +++---
 util/systemd.c          | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

--=20
2.26.1


