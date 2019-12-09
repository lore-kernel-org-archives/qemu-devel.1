Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9397C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 12:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D6102077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 12:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekZlRn0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6102077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieIYs-0005fP-BC
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 07:54:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ieIXE-0004OJ-31
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 07:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ieIXA-0003FN-Ub
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 07:53:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32468
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ieIXA-0003F5-Qn
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 07:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575895984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nskM+w5kU2b/uFzJKA9FriBJzek2c/9LKUNgNhVRSwQ=;
 b=ekZlRn0OangHAx7oVrgaelrcH2pmKT8IMZgtiTLo0LhqSgQm78aYE+h2ONeUtncijUG2qs
 IBYr7awm15BQ+XJSOeXMcYmovf2Y1Cwz4dGB7Ru9fGAf5ar2I96nfd0YsUZKbHM+9PRXSu
 p+l8roa4GV+KC9K4IYfol7E5I4ALTms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-CnJJJVEBPsiSYUP2iocq3g-1; Mon, 09 Dec 2019 07:53:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6B0210054E3;
 Mon,  9 Dec 2019 12:53:00 +0000 (UTC)
Received: from thuth.com (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB3386E3F1;
 Mon,  9 Dec 2019 12:52:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 0/4] Remove deprecated pc-0.x machine types and related
 hacks
Date: Mon,  9 Dec 2019 13:52:44 +0100
Message-Id: <20191209125248.5849-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: CnJJJVEBPsiSYUP2iocq3g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These have been on the deprecation list since a year now, so it's
time to finally remove the pc-0.x machine types.

We then can also remove some compatibility hacks in the devices, i.e.
the "use_broken_id" in ac97, the "command_serr_enable" in PCI devices
and the "rombar" stuff in VGA devices.

v2:
 - Minor updates to the first patch (fix comment, add deprecation_reason
   message for the pc-1.x machines)
 - Keep the QEMU_PCI_CAP_SERR enum in the third patch
 - Added fourth patch to remove the "rombar" hacks from the VGA devices

Thomas Huth (4):
  hw/i386: Remove the deprecated machines 0.12 up to 0.15
  hw/audio: Remove the "use_broken_id" hack from the AC97 device
  hw/pci: Remove the "command_serr_enable" property
  hw/display: Remove "rombar" hack from vga-pci and vmware_vga

 hw/audio/ac97.c         |  9 -----
 hw/display/vga-pci.c    |  5 ---
 hw/display/vga.c        |  4 +-
 hw/display/vmware_vga.c |  5 ---
 hw/i386/pc_piix.c       | 85 +----------------------------------------
 hw/pci/pci.c            |  6 +--
 include/hw/pci/pci.h    |  2 +-
 qemu-deprecated.texi    |  2 +-
 tests/cpu-plug-test.c   |  6 +--
 9 files changed, 7 insertions(+), 117 deletions(-)

--=20
2.18.1


