Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4E1C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 13:29:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 465D1206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 13:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8wmc/Ap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465D1206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLoIZ-0003cX-HB
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 09:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jLoHf-0002LH-9w
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 09:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jLoHb-0001A6-4k
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 09:28:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27217
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jLoHb-00017d-0n
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 09:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586266129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocp6EFI20MUtjHSglurSSfhDC1bsCpIKAKWMCb27vzI=;
 b=C8wmc/ApfSPTDQMeecRBpm24CcDpxKJs6lYevHzo++gu9KQE7zxCh5+0F23yjGu0upyTbp
 ApbRaHAyRZNuB1u/rgzV6R/NsSh0s/PhXSAH+XjuSVTgjQqsbwPtJSR7Y1k/Q6UVG+aX32
 lYqlLsK6LKaGuvpS9YrtkTszqdOxwQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-98bDI2EnMXS9kxLZ7dlJew-1; Tue, 07 Apr 2020 09:28:48 -0400
X-MC-Unique: 98bDI2EnMXS9kxLZ7dlJew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A002801E66;
 Tue,  7 Apr 2020 13:28:42 +0000 (UTC)
Received: from gondolin (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CF6C7E303;
 Tue,  7 Apr 2020 13:28:00 +0000 (UTC)
Date: Tue, 7 Apr 2020 15:27:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.1 v2 49/54] various: Use &error_abort in
 instance_init()
Message-ID: <20200407152758.1cf47130.cohuck@redhat.com>
In-Reply-To: <20200406174743.16956-50-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
 <20200406174743.16956-50-f4bug@amsat.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, Jiri Slaby <jslaby@suse.cz>,
 Li Zhijian <lizhijian@cn.fujitsu.com>,
 "open list:Floppy" <qemu-block@nongnu.org>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, "open
 list:Old World g3beige" <qemu-ppc@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Amit Shah <amit@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>,
 "open list:Raspberry Pi" <qemu-arm@nongnu.org>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "open list:RISC-V TCG
 CPUs" <qemu-riscv@nongnu.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Max Reitz <mreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  6 Apr 2020 19:47:38 +0200
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Patch created mechanically by running:
>=20
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h \
>     --include-headers --keep-comments --in-place \
>     --sp-file \
>       scripts/coccinelle/use-error_abort-in-instance_init.cocci
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  backends/cryptodev-vhost-user.c |  2 +-
>  backends/rng-egd.c              |  2 +-
>  backends/rng-random.c           |  2 +-
>  backends/vhost-user.c           |  3 ++-
>  hw/arm/bcm2835_peripherals.c    |  6 ++++--
>  hw/arm/vexpress.c               |  8 ++++----
>  hw/arm/xlnx-zcu102.c            |  8 ++++----
>  hw/block/fdc.c                  |  4 ++--
>  hw/block/vhost-user-blk.c       |  2 +-
>  hw/block/virtio-blk.c           |  2 +-
>  hw/core/machine.c               |  6 +++---
>  hw/cpu/core.c                   |  4 ++--
>  hw/display/vga-pci.c            |  7 +++++--
>  hw/display/xlnx_dp.c            |  4 ++--
>  hw/dma/sparc32_dma.c            |  2 +-
>  hw/gpio/aspeed_gpio.c           |  2 +-
>  hw/ide/macio.c                  |  4 +++-
>  hw/ide/qdev.c                   |  4 ++--
>  hw/intc/apic_common.c           |  2 +-
>  hw/mem/nvdimm.c                 |  4 ++--
>  hw/misc/aspeed_sdmc.c           |  2 +-
>  hw/misc/edu.c                   |  3 ++-
>  hw/misc/macio/macio.c           |  4 ++--
>  hw/misc/macio/pmu.c             |  3 ++-
>  hw/misc/pca9552.c               |  2 +-
>  hw/misc/tmp105.c                |  2 +-
>  hw/misc/tmp421.c                |  8 ++++----
>  hw/net/e1000.c                  |  3 ++-
>  hw/net/lance.c                  |  3 ++-
>  hw/net/lasi_i82596.c            |  3 ++-
>  hw/net/ne2000-isa.c             |  4 ++--
>  hw/net/spapr_llan.c             |  2 +-
>  hw/net/virtio-net.c             |  2 +-
>  hw/pci-host/grackle.c           |  2 +-
>  hw/pci-host/i440fx.c            |  8 ++++----
>  hw/pci-host/prep.c              |  2 +-
>  hw/pci-host/q35.c               | 23 ++++++++++++++---------
>  hw/pci-host/sabre.c             |  3 ++-
>  hw/pci-host/uninorth.c          |  9 +++++----
>  hw/pcmcia/pxa2xx.c              |  3 ++-
>  hw/ppc/spapr_drc.c              |  6 +++---
>  hw/ppc/spapr_rng.c              |  2 +-
>  hw/riscv/sifive_u.c             |  4 ++--
>  hw/s390x/event-facility.c       |  6 +++---
>  hw/s390x/s390-ccw.c             |  2 +-
>  hw/s390x/s390-skeys.c           |  4 ++--
>  hw/s390x/s390-stattrib.c        |  4 ++--
>  hw/s390x/sclp.c                 |  2 +-
>  hw/scsi/scsi-bus.c              |  2 +-
>  hw/ssi/xilinx_spips.c           |  2 +-
>  hw/usb/bus.c                    |  4 ++--
>  hw/usb/dev-network.c            |  2 +-
>  hw/usb/dev-storage.c            |  4 ++--
>  hw/usb/host-libusb.c            |  2 +-
>  hw/usb/redirect.c               |  2 +-
>  hw/virtio/virtio-balloon.c      |  4 ++--
>  net/dump.c                      |  4 ++--
>  net/filter-buffer.c             |  2 +-
>  net/filter-mirror.c             | 10 +++++-----
>  net/filter-rewriter.c           |  3 ++-
>  target/arm/cpu64.c              |  4 ++--
>  target/i386/cpu.c               | 23 ++++++++++++++---------
>  target/s390x/cpu.c              |  3 ++-
>  tests/check-qom-proplist.c      |  7 ++++---
>  tests/test-qdev-global-props.c  |  4 ++--
>  65 files changed, 155 insertions(+), 126 deletions(-)
>=20

s390 parts:
Acked-by: Cornelia Huck <cohuck@redhat.com>


