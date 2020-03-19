Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD03FC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9874920722
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DB+UHcOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9874920722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jErtU-0002je-KV
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ppandit@redhat.com>) id 1jErsn-0001rD-1i
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1jErsl-0004qr-LU
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:54:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35977)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1jErsl-0004qP-I7
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584611670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TQEf021rsn2O+uJbv2MfnoWfJZ1YBI7MF/3VxixkJtQ=;
 b=DB+UHcOtr/gd2gBWqAYDD89ZQxeMMTScDPhSVsef6arr+8WUEEhf1ZSP1PKwropYY7mEaP
 ESWYGP5gbi/OFMaNG4JzcTWBQo0yXkzHj4YzIIQOMOvfHYLWqlmC1rhGyQpz4KusjMIycy
 Nae9b5uqrI+ZkFe3TmlL4TGElV84gfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-0E0u7c4LMg-reZ3CdgGLxQ-1; Thu, 19 Mar 2020 05:54:25 -0400
X-MC-Unique: 0E0u7c4LMg-reZ3CdgGLxQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8403A8018CE;
 Thu, 19 Mar 2020 09:54:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67D5491296;
 Thu, 19 Mar 2020 09:54:17 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 0/3] net: tulip: add checks to avoid OOB access
Date: Thu, 19 Mar 2020 15:22:08 +0530
Message-Id: <20200319095211.741445-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Li Qiang <pangpei.lq@antfin.com>, Sven Schnelle <svens@stackframe.org>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Hello,

* This series adds checks to avoid potential OOB access and infinite loop
  issues while processing rx/tx data.

* Tulip tx descriptors are capped at 128 to avoid infinite loop in
  tulip_xmit_list_update(), wrt Tulip kernel driver
  -> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/drivers/net/ethernet/dec/tulip/tulip.h#n319

* Update v3: add .can_receive routine
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg06275.html

* Update v4: flush queued packets once they are received
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg05868.html

Thank you.
--
Prasad J Pandit (3):
  net: tulip: check frame size and r/w data length
  net: tulip: add .can_recieve routine
  net: tulip: flush queued packets post receive

 hw/net/tulip.c | 51 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 9 deletions(-)

--
2.25.1


