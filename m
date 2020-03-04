Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3250C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E9820870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+0223K0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E9820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9W7m-0002rn-VN
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 10:39:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9W6N-0000SU-HK
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:38:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9W6M-0001Cg-2T
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:38:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56648
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9W6L-0001Bi-V9
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 10:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583336305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OSTKkYQFHVn5wzazJD9/YYpsUv76LJ3wFO/XEgQH2oE=;
 b=C+0223K0dFDh07UkS0rFH9KJrwQoJdcnJQBOqmCs5WYEFkE2F3VePYj6wHupFEDnClZbv/
 2QeZTWmTUhNZWpf04/hM33NUoqSVYjYPCB8DHY6h6yERUhuhwJ6q05g7i1RnhETOjHHOf4
 TlXB/sCnw/bq/udVU6n9/YDb0fwwRSM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-DYgmpvmOOdiUVQ6CLwh2gg-1; Wed, 04 Mar 2020 10:38:22 -0500
X-MC-Unique: DYgmpvmOOdiUVQ6CLwh2gg-1
Received: by mail-wr1-f71.google.com with SMTP id b12so1022354wro.4
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 07:38:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hMC3Q7PnsRY64PBv4jXo0JqVzh5Jib6A4fNKHOxhCBA=;
 b=dXhO+yYI6rnPpdJm73FRAP3ygxqw7s8Ev9rhdGk5Dey+tBmhEsJrRcPiaPLtrabmiL
 paJeI8R1mXVXVTCQvZosuO4KAF2bI5OSQaubsuYg21HyMYjWnvdpOWVdkHwyV2wzTLQH
 LOm6DHNQ417XoG77dHz/PmyBtzLz26qFiqkdPJiqNhNNQqROalwOxujO3o3Yh4DSQ74R
 0+ddA8MA3REb6qLxbYVudEYHhpRY6lCcLjyYNRZIg2RjBycETvkR3dkbSEVJihGk4kq9
 AQQMyTa6zF9NCsKM/0IS9P+PdJbq3YhFqvuPa0zZWT31frcUSrEqcyxquokywQt3wArW
 Jocw==
X-Gm-Message-State: ANhLgQ1bk1DKIdh/cH2mI+6Xe+G/5ITtlHpSzmqZDs0StyBuM9TyD9kB
 +8GbpuadxjZxETe0TOiqjr5KjesJ6cIEhCCJq6DjJ2CEHQ+xRF4HTe90NZihB/iED1pZqBuQ3Yl
 rcivOrRf3JjkLOYs=
X-Received: by 2002:a5d:49c6:: with SMTP id t6mr4590437wrs.218.1583336300627; 
 Wed, 04 Mar 2020 07:38:20 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvzvjQ+3ctpKS8T4AcaaJ8m1iRiiaHyaZVx3N1cF53P83A6GlD1mycXmK26Sd7fyHVDn/iXrQ==
X-Received: by 2002:a5d:49c6:: with SMTP id t6mr4590398wrs.218.1583336300391; 
 Wed, 04 Mar 2020 07:38:20 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id u20sm4407548wmj.14.2020.03.04.07.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 07:38:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] misc: Replace zero-length arrays with flexible array
 member
Date: Wed,  4 Mar 2020 16:38:14 +0100
Message-Id: <20200304153816.23636-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Paul Durrant <paul@xen.org>, Jason Wang <jasowang@redhat.com>,
 David Hildenbrand <david@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
- do not modify qed.h (structure with single member)
- based on hw/scsi/spapr_vscsi fix series:
  https://mid.mail-archive.com/20200304153311.22959-1-philmd@redhat.com

This is a tree-wide cleanup inspired by a Linux kernel commit
(from Gustavo A. R. Silva).

--v-- description start --v--

  The current codebase makes use of the zero-length array language
  extension to the C90 standard, but the preferred mechanism to
  declare variable-length types such as these ones is a flexible
  array member [1], introduced in C99:

  struct foo {
      int stuff;
      struct boo array[];
  };

  By making use of the mechanism above, we will get a compiler
  warning in case the flexible array does not occur last in the
  structure, which will help us prevent some kind of undefined
  behavior bugs from being unadvertenly introduced [2] to the
  Linux codebase from now on.

--^-- description end --^--

Do the similar housekeeping in the QEMU codebase (which uses
C99 since commit 7be41675f7cb).

The first patch is done with the help of a coccinelle semantic
patch. However Coccinelle does not recognize:

  struct foo {
      int stuff;
      struct boo array[];
  } QEMU_PACKED;

but does recognize:

  struct QEMU_PACKED foo {
      int stuff;
      struct boo array[];
  };

I'm not sure why, neither it is worth refactoring all QEMU
structures to use the attributes before the structure name,
so I did the 2nd patch manually.

Anyway this is annoying, because many structures are not handled
by coccinelle. Maybe this needs to be reported to upstream
coccinelle?

I used spatch 1.0.8 with:

  -I include --include-headers \
  --macro-file scripts/cocci-macro-file.h \
  --keep-comments --indent 4

Regards,

Phil.

Based-on: <20200304153311.22959-1-philmd@redhat.com>
Supersedes: <20200304005105.27454-1-philmd@redhat.com>

Philippe Mathieu-Daud=C3=A9 (2):
  misc: Replace zero-length arrays with flexible array member
    (automatic)
  misc: Replace zero-length arrays with flexible array member (manual)

 docs/interop/vhost-user.rst           |  4 ++--
 bsd-user/qemu.h                       |  2 +-
 contrib/libvhost-user/libvhost-user.h |  2 +-
 hw/m68k/bootinfo.h                    |  2 +-
 hw/scsi/srp.h                         |  6 +++---
 hw/xen/xen_pt.h                       |  2 +-
 include/hw/acpi/acpi-defs.h           | 16 ++++++++--------
 include/hw/arm/smmu-common.h          |  2 +-
 include/hw/boards.h                   |  2 +-
 include/hw/i386/intel_iommu.h         |  3 ++-
 include/hw/s390x/event-facility.h     |  2 +-
 include/hw/s390x/sclp.h               |  8 ++++----
 include/hw/virtio/virtio-iommu.h      |  2 +-
 include/sysemu/cryptodev.h            |  2 +-
 include/tcg/tcg.h                     |  2 +-
 pc-bios/s390-ccw/bootmap.h            |  2 +-
 pc-bios/s390-ccw/sclp.h               |  2 +-
 tests/qtest/libqos/ahci.h             |  2 +-
 block/linux-aio.c                     |  2 +-
 block/vmdk.c                          |  2 +-
 hw/acpi/nvdimm.c                      |  6 +++---
 hw/char/sclpconsole-lm.c              |  2 +-
 hw/char/sclpconsole.c                 |  2 +-
 hw/dma/soc_dma.c                      |  2 +-
 hw/i386/x86.c                         |  2 +-
 hw/misc/omap_l4.c                     |  2 +-
 hw/nvram/eeprom93xx.c                 |  2 +-
 hw/rdma/vmw/pvrdma_qp_ops.c           |  4 ++--
 hw/s390x/virtio-ccw.c                 |  2 +-
 hw/usb/dev-network.c                  |  2 +-
 hw/usb/dev-smartcard-reader.c         |  4 ++--
 hw/virtio/virtio.c                    |  4 ++--
 net/queue.c                           |  2 +-
 target/s390x/ioinst.c                 |  2 +-
 34 files changed, 53 insertions(+), 52 deletions(-)

--=20
2.21.1


