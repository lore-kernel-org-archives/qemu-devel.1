Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70976C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CCC520801
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDWdeJr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCC520801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ictgw-0003tY-PY
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 11:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ictex-0002Ss-UC
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ictew-0007K1-2X
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:07:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33737
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ictev-0007Hr-Rs
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575562031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+TJURHbgwtwSMnKanxguUL8bYuKNTWr18xlZzi+hJzc=;
 b=fDWdeJr8xycYIj5BpXXLGq63RnFZiv+meLBB7C6GZXqgGGUOY5DDfOLEEKyBxdHkNsDLjR
 h0JLt4qGsjOwBMxE0HTQwljf7m/Dth6Znj21fqaam6/iVryDfy99ndf7bf4kt7g7P74R3X
 EF7iFS084ufdz6NjpiE7WTVWRYc4lQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-ARs52UWnM36fl8FN9g8B7g-1; Thu, 05 Dec 2019 11:07:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7DADDB6A;
 Thu,  5 Dec 2019 16:07:06 +0000 (UTC)
Received: from thuth.com (ovpn-116-87.ams2.redhat.com [10.36.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 914496BF60;
 Thu,  5 Dec 2019 16:06:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/3] Remove deprecated pc-0.x machine types and related hacks
Date: Thu,  5 Dec 2019 17:06:49 +0100
Message-Id: <20191205160652.23493-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ARs52UWnM36fl8FN9g8B7g-1
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
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These have been on the deprecation list since a year now, so it's
time to finally remove the pc-0.x machine types.

We then can also remove some compatibility hacks in the devices, i.e.
the "use_broken_id" in ac97 and "command_serr_enable" in PCI devices.

Note that there is also the "rombar" property of the PCI devices which
is now not required for the x86 machine types anymore. But it seems to
me like this is still used by various people to bypass the ROM loading
for PCI devices in certain cases, so I did not remove that property here
yet.

Thomas Huth (3):
  hw/i386: Remove the deprecated machines 0.12 up to 0.15
  hw/audio: Remove the "use_broken_id" hack from the AC97 device
  hw/pci: Remove the "command_serr_enable" property

 hw/audio/ac97.c       |  9 -----
 hw/i386/pc_piix.c     | 82 -------------------------------------------
 hw/pci/pci.c          |  6 +---
 include/hw/pci/pci.h  |  3 --
 qemu-deprecated.texi  |  2 +-
 tests/cpu-plug-test.c |  6 +---
 6 files changed, 3 insertions(+), 105 deletions(-)

--=20
2.18.1


