Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87810C76194
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643322190F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643322190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpaYF-0003BE-4Z
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 11:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53579)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hpaXu-0002D1-2J
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hpaXs-0007bm-N0
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:48:13 -0400
Received: from smtpe1.intersmtp.com ([62.239.224.234]:43242)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hpaXl-0007WK-Pe; Mon, 22 Jul 2019 11:48:06 -0400
Received: from tpw09926dag18g.domain1.systemhost.net (10.9.212.34) by
 RDW083A012ED68.bt.com (10.187.98.38) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 22 Jul 2019 16:47:47 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18g.domain1.systemhost.net (10.9.212.34) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Mon, 22 Jul 2019 16:48:01 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Mon, 22 Jul
 2019 16:48:00 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 11/20] hw/virtio: Access MemoryRegion
 with MemOp
Thread-Index: AQHVQKTX+Ks5rP6+AkSy2PJ+oMCFiQ==
Date: Mon, 22 Jul 2019 15:48:00 +0000
Message-ID: <1563810480347.95681@bt.com>
References: <e9c6e5310b1a4863be45d45bf087fc3d@tpw09926dag18e.domain1.systemhost.net>
In-Reply-To: <e9c6e5310b1a4863be45d45bf087fc3d@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.37]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 62.239.224.234
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] [PATCH v2 11/20] hw/virtio: Access MemoryRegion with
 MemOp
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, mst@redhat.com,
 palmer@sifive.com, mark.cave-ayland@ilande.co.uk, Alistair.Francis@wdc.com,
 arikalo@wavecomp.com, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, rth@twiddle.net, atar4qemu@gmail.com,
 ehabkost@redhat.com, sw@weilnetz.de, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, david@gibson.dropbear.id.au, qemu-riscv@nongnu.org,
 cohuck@redhat.com, claudio.fontana@huawei.com, alex.williamson@redhat.com,
 qemu-ppc@nongnu.org, amarkovic@wavecomp.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/07/19 08:06, Paolo Bonzini wrote:

> My main concern is that MO_BE/MO_LE/MO_TE do not really apply to the
> memory.c paths.  MO_BSWAP is never passed into the MemOp, even if target
> endianness !=3D host endianness.
>
> Therefore, you could return MO_TE | MO_{8,16,32,64} from this function,
> and change memory_region_endianness_inverted to test
> HOST_WORDS_BIGENDIAN instead of TARGET_WORDS_BIGENDIAN.  Then the two
> MO_BSWAPs (one from MO_TE, one from adjust_endianness because
> memory_region_endianness_inverted returns true) cancel out if the
> memory region's endianness is the same as the host's but different
> from the target's.
>
> Some care is needed in virtio_address_space_write and zpci_write_bar.  I
> think the latter is okay, while the former could do something like this:
>
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index ce928f2429..61885f020c 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -541,16 +541,16 @@ void virtio_address_space_write(VirtIOPCIProxy *pro=
xy,
> hwaddr addr,
>          val =3D pci_get_byte(buf);
>          break;
>      case 2:
> -        val =3D cpu_to_le16(pci_get_word(buf));
> +        val =3D pci_get_word(buf);
>          break;
>      case 4:
> -        val =3D cpu_to_le32(pci_get_long(buf));
> +        val =3D pci_get_long(buf);
>          break;
>      default:
>          /* As length is under guest control, handle illegal values. */
>          return;
>      }
> -    memory_region_dispatch_write(mr, addr, val, len, MEMTXATTRS_UNSPECIF=
IED);
> +    memory_region_dispatch_write(mr, addr, val, size_memop(len) & ~MO_BS=
WAP,
> MEMTXATTRS_UNSPECIFIED);
>  }
>
>  static void

Sorry Paolo, I noted the need to take care in virtio_address_space_write an=
d
zpci_write_bar but did not understand.

> Some care is needed in virtio_address_space_write and zpci_write_bar.
Is this advice for my v1 implementation, or in the case of the
MO_TE | MO_{8,16,32,64} idead suggested in the paragraph before?

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 hw/virtio/virtio-pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index ce928f2..265f066 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -17,6 +17,7 @@

 #include "qemu/osdep.h"

+#include "exec/memop.h"
 #include "standard-headers/linux/virtio_pci.h"
 #include "hw/virtio/virtio.h"
 #include "hw/pci/pci.h"
@@ -550,7 +551,8 @@ void virtio_address_space_write(VirtIOPCIProxy *proxy, =
hwaddr addr,
         /* As length is under guest control, handle illegal values. */
         return;
     }
-    memory_region_dispatch_write(mr, addr, val, len, MEMTXATTRS_UNSPECIFIE=
D);
+    memory_region_dispatch_write(mr, addr, val, SIZE_MEMOP(len),
+                                 MEMTXATTRS_UNSPECIFIED);
 }

 static void
@@ -573,7 +575,8 @@ virtio_address_space_read(VirtIOPCIProxy *proxy, hwaddr=
 addr,
     /* Make sure caller aligned buf properly */
     assert(!(((uintptr_t)buf) & (len - 1)));

-    memory_region_dispatch_read(mr, addr, &val, len, MEMTXATTRS_UNSPECIFIE=
D);
+    memory_region_dispatch_read(mr, addr, &val, SIZE_MEMOP(len),
+                                MEMTXATTRS_UNSPECIFIED);
     switch (len) {
     case 1:
         pci_set_byte(buf, val);
--
1.8.3.1



