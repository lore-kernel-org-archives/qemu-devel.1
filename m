Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D29AC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 16:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26947216FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 16:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26947216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39539 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVfJv-0008S3-BC
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 12:51:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVfCJ-0002Vc-6e
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVfC9-0001b2-CI
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:43:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43173)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hVfC5-0000Ha-L3; Tue, 28 May 2019 12:43:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CFBFC309C001;
	Tue, 28 May 2019 16:41:14 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.206.32])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 08E6B60BDF;
	Tue, 28 May 2019 16:40:23 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
Date: Tue, 28 May 2019 18:40:10 +0200
Message-Id: <20190528164020.32250-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 28 May 2019 16:41:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 00/10] qom: Use BUS()/DEVICE() macros
 instead of looking inside definitions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Markus Armbruster <armbru@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v1 was a simple patch:
'use qbus_reset_all() directly instead of qbus_reset_all_fn'
where I was looking inside the definition of BusState.

Peter suggested to use the prefered QOM style, using the BUS/DEVICE
macros. While here, I also cleaned the rest of the codebase.

Philippe Mathieu-Daud=C3=A9 (10):
  hw/scsi/vmw_pvscsi: Use qbus_reset_all() directly
  hw/scsi: Use the QOM BUS() macro to access BusState.qbus
  hw/pci-bridge: Use the QOM BUS() macro to access BusState.qbus
  hw/s390x/event-facility: Use the QOM BUS() macro to access
    BusState.qbus
  hw/sd: Use the QOM BUS() macro to access BusState.qbus
  hw/audio/ac97: Use the QOM DEVICE() macro to access DeviceState.qdev
  hw/isa: Use the QOM DEVICE() macro to access DeviceState.qdev
  hw/usb-storage: Use the QOM DEVICE() macro to access DeviceState.qdev
  hw/vfio/pci: Use the QOM DEVICE() macro to access DeviceState.qdev
  hw/watchdog/wdt_i6300esb: Use DEVICE() macro to access
    DeviceState.qdev

 hw/audio/ac97.c            | 2 +-
 hw/isa/lpc_ich9.c          | 2 +-
 hw/isa/vt82c686.c          | 2 +-
 hw/pci/pci_bridge.c        | 2 +-
 hw/s390x/event-facility.c  | 4 ++--
 hw/scsi/lsi53c895a.c       | 2 +-
 hw/scsi/mptsas.c           | 4 ++--
 hw/scsi/virtio-scsi.c      | 2 +-
 hw/scsi/vmw_pvscsi.c       | 4 ++--
 hw/sd/milkymist-memcard.c  | 2 +-
 hw/sd/ssi-sd.c             | 2 +-
 hw/usb/dev-storage.c       | 2 +-
 hw/vfio/pci.c              | 4 ++--
 hw/watchdog/wdt_i6300esb.c | 2 +-
 14 files changed, 18 insertions(+), 18 deletions(-)

--=20
2.20.1


