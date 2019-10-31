Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE63CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 08:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 880532083E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 08:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQudVZwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880532083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ6Eu-0002cC-AT
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 04:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iQ6DD-00015k-Ir
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iQ6DB-0001y4-TF
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:53:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22094
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iQ6DB-0001xE-Pk
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572512025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j6PW58cSORG/p6fyTlB1042zVQntN2g3gKkkcv4mJFc=;
 b=eQudVZwoySlczilnUSjCe3T1G0upL1VK2g4VGy47iHNw9srGOro9hbO4SOYqSl/atAd2J7
 WLXGt79t+ZQ3vWu4mSp83qdBZoPTEQjFpmilHXiw3aU/Cs1DOJcdH3+9eLKeoaUtg9Dzk4
 q6bMXPu5MJBQm7Y04oisks/CifA7qAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-LiPzAHi4NEe0H7Rf7gDgQw-1; Thu, 31 Oct 2019 04:53:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8A7C1005500
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 08:53:41 +0000 (UTC)
Received: from lupin.home.kraxel.org (ovpn-116-222.ams2.redhat.com
 [10.36.116.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E375F5C28D;
 Thu, 31 Oct 2019 08:53:38 +0000 (UTC)
Received: by lupin.home.kraxel.org (Postfix, from userid 1000)
 id 7235F6114A3B; Thu, 31 Oct 2019 09:53:36 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/4] tests/vm: netbsd autoinstall
Date: Thu, 31 Oct 2019 09:53:02 +0100
Message-Id: <20191031085306.28888-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: LiPzAHi4NEe0H7Rf7gDgQw-1
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hopefully the last revision on this one ...

Patch #1 is the latest patch sent by Eduardo, unmodified.
Patch #2+#3 fix the installer boot hang.
Patch #4 finally updates to netbsd version 8.1

Gerd Hoffmann (4):
  tests/vm: netbsd autoinstall, using serial console
  tests/vm: add console_consume helper
  tests/vm: use console_consume for netbsd
  tests/vm: update netbsd to version 8.1

 tests/vm/basevm.py |  19 +++++
 tests/vm/netbsd    | 189 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 198 insertions(+), 10 deletions(-)

--=20
2.18.1


