Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1877CC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF2821E73
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X4q5ZJst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF2821E73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNqc-0007MI-7I
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53526)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvNpl-0006qW-I4
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvNpk-0002UX-1S
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:26:37 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39816)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvNpj-0002Tx-Ni
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:26:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id t16so1686630wra.6
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=WOTg5KF7EyuEsieJmh6DVJae/NStRnQMDOzZRsN38Kw=;
 b=X4q5ZJstpKGyqf57Fmv0OCEApcUw8DbnFoYsyG/0o0b8IqnfXJZ4TPz5RSwt6iPsTT
 lLcuN9cboggvQSMMaAkbzLySjBtmdy5SaK17irV6TdzRrPvlTYdpRNqfILlVKCOt9TYr
 zsGQ0TQMMgnFI1sbIwxd2wMZXjUIXCxVGOLVa1aZzlabiPbbSCODxxD5Kc2sN/Zrac0y
 yQzs47GU+udG9EUDxXnDxjyrOUBLQiS2r4yT3akkmTiofSH/QfNyUib24SaFzRURjru1
 O+Eaykfbg7zgYoTnr5klXSiikVr7Hybc4Rlxfiq0qtcU+mWdJxLHbpZ2C3Viw8tYutZh
 HNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=WOTg5KF7EyuEsieJmh6DVJae/NStRnQMDOzZRsN38Kw=;
 b=nIGHoncV8Z745ZiR/BTCeNq3oGSTmXVz6L9sauRKyLNpG5VgWVNKFu3seK1bM1e/4e
 YvgIwU/ia+gTdGjXrlXf1um3Lu5YhxMnKgSRonJiUuF/uZCoIRCIT43hEn6wHmkLPKkS
 sQmQ+mVhadDHwur9B4dkAwHgqmyxT/FF7VKjXZ7vhCA9j9YdJL9AG5wt+QdeGYjtYHJd
 1qREaM1w4wIa85kuU0ak0jYQOEKu3d+tTePxGsgp38VYKVe6SNlycMAEdBDwkst5PHtN
 Epd0KoMSn9FU04UE9dffDK2TkPVsujlPiNCEu74FYeIxpNv5oTkVeaPVdifyBnDQ7qy1
 jx8w==
X-Gm-Message-State: APjAAAVIoaXMzjUKUE/bxg22qKQqwwpCbIMM/3I/Za6oJdrjDs7c1tCD
 kkqfrYiqK2XMDHRQ9dYcH4H/D8xSbXM=
X-Google-Smtp-Source: APXvYqxWfg4/rMetvqasEg4zggLAWz1Xnj28NUub5Wo0SAJm3YV7TjchbGAzmp+P+Q6VFq5wP9+f9w==
X-Received: by 2002:adf:f281:: with SMTP id k1mr11690782wro.154.1565191594083; 
 Wed, 07 Aug 2019 08:26:34 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x8sm180164wmc.5.2019.08.07.08.26.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 08:26:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 069321FF87
 for <qemu-devel@nongnu.org>; Wed,  7 Aug 2019 16:26:33 +0100 (BST)
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-29-armbru@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190806151435.10740-29-armbru@redhat.com>
Date: Wed, 07 Aug 2019 16:26:32 +0100
Message-ID: <87h86thu8n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v2 28/29] sysemu: Move the
 VMChangeStateEntry typedef to qemu/typedefs.h
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


Markus Armbruster <armbru@redhat.com> writes:

> In my "build everything" tree, changing sysemu/sysemu.h triggers a
> recompile of some 1800 out of 6600 objects (not counting tests and
> objects that don't depend on qemu/osdep.h, down from 5400 due to the
> previous commit).
>
> Several headers include sysemu/sysemu.h just to get typedef
> VMChangeStateEntry.  Move it from sysemu/sysemu.h to qemu/typedefs.h.
> Spell its structure tag the same while there.
>
> Touching sysemu/sysemu.h now recompiles some 1100 objects.
> qemu/uuid.h also drops from 1800 to 1100, and
> qapi/qapi-types-run-state.h from 5000 to 4400.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/block/vhost-user-blk.c   | 1 +
>  hw/block/virtio-blk.c       | 1 +
>  hw/display/virtio-gpu.c     | 1 +
>  hw/misc/macio/macio.c       | 1 +
>  hw/net/virtio-net.c         | 1 +
>  hw/s390x/s390-ccw.c         | 1 +
>  hw/s390x/s390-virtio-ccw.c  | 1 +
>  hw/scsi/scsi-bus.c          | 1 +
>  hw/scsi/vhost-scsi.c        | 1 +
>  hw/scsi/vhost-user-scsi.c   | 1 +
>  hw/usb/hcd-ehci.c           | 1 +
>  hw/usb/hcd-ehci.h           | 1 -
>  hw/virtio/virtio-rng.c      | 1 +
>  hw/virtio/virtio.c          | 1 +
>  include/hw/ide/internal.h   | 3 ++-
>  include/hw/ppc/spapr_xive.h | 1 -
>  include/hw/scsi/scsi.h      | 1 -
>  include/hw/virtio/virtio.h  | 1 -
>  include/qemu/typedefs.h     | 1 +
>  include/sysemu/sysemu.h     | 1 -
>  vl.c                        | 6 +++---
>  21 files changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 7b44cca6d9..6b6cd07362 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -28,6 +28,7 @@
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/virtio-access.h"
> +#include "sysemu/sysemu.h"
>
>  static const int user_feature_bits[] =3D {
>      VIRTIO_BLK_F_SIZE_MAX,
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 8cc2a232e0..78ac371eba 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -20,6 +20,7 @@
>  #include "hw/block/block.h"
>  #include "hw/qdev-properties.h"
>  #include "sysemu/blockdev.h"
> +#include "sysemu/sysemu.h"
>  #include "hw/virtio/virtio-blk.h"
>  #include "dataplane/virtio-blk.h"
>  #include "scsi/constants.h"
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 6de9689a30..28e868c021 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -17,6 +17,7 @@
>  #include "ui/console.h"
>  #include "trace.h"
>  #include "sysemu/dma.h"
> +#include "sysemu/sysemu.h"
>  #include "hw/virtio/virtio.h"
>  #include "migration/qemu-file-types.h"
>  #include "hw/virtio/virtio-gpu.h"
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index b59df4e3b8..50f20d8206 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -35,6 +35,7 @@
>  #include "hw/char/escc.h"
>  #include "hw/misc/macio/macio.h"
>  #include "hw/intc/heathrow_pic.h"
> +#include "sysemu/sysemu.h"
>  #include "trace.h"
>
>  /* Note: this code is strongly inspirated from the corresponding code
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 4113729fcf..9f11422337 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -31,6 +31,7 @@
>  #include "hw/virtio/virtio-access.h"
>  #include "migration/misc.h"
>  #include "standard-headers/linux/ethtool.h"
> +#include "sysemu/sysemu.h"
>  #include "trace.h"
>
>  #define VIRTIO_NET_VM_VERSION    11
> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
> index 22c6878b84..0c5a5b60bd 100644
> --- a/hw/s390x/s390-ccw.c
> +++ b/hw/s390x/s390-ccw.c
> @@ -19,6 +19,7 @@
>  #include "hw/s390x/css.h"
>  #include "hw/s390x/css-bridge.h"
>  #include "hw/s390x/s390-ccw.h"
> +#include "sysemu/sysemu.h"
>
>  IOInstEnding s390_ccw_cmd_request(SubchDev *sch)
>  {
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index a543b64e56..434d933ec9 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -40,6 +40,7 @@
>  #include "hw/nmi.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/s390x/tod.h"
> +#include "sysemu/sysemu.h"
>
>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>  {
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index db785e6001..cb8e8d1f36 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -10,6 +10,7 @@
>  #include "scsi/constants.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/blockdev.h"
> +#include "sysemu/sysemu.h"
>  #include "trace.h"
>  #include "sysemu/dma.h"
>  #include "qemu/cutils.h"
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index cd5cf1679d..c693fc748a 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -30,6 +30,7 @@
>  #include "hw/fw-path-provider.h"
>  #include "hw/qdev-properties.h"
>  #include "qemu/cutils.h"
> +#include "sysemu/sysemu.h"
>
>  /* Features supported by host kernel. */
>  static const int kernel_feature_bits[] =3D {
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index a5be128b54..31c9d34637 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -28,6 +28,7 @@
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/virtio-access.h"
>  #include "chardev/char-fe.h"
> +#include "sysemu/sysemu.h"
>
>  /* Features supported by the host application */
>  static const int user_feature_bits[] =3D {
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index d7d1ecd45d..e76c939751 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -35,6 +35,7 @@
>  #include "trace.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
> +#include "sysemu/sysemu.h"
>
>  #define FRAME_TIMER_FREQ 1000
>  #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index fdbcfdcbeb..0298238f0b 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -21,7 +21,6 @@
>  #include "qemu/timer.h"
>  #include "hw/usb.h"
>  #include "sysemu/dma.h"
> -#include "sysemu/sysemu.h"
>  #include "hw/pci/pci.h"
>  #include "hw/sysbus.h"
>
> diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
> index 34b4619fd3..c9c2414b7b 100644
> --- a/hw/virtio/virtio-rng.c
> +++ b/hw/virtio/virtio-rng.c
> @@ -17,6 +17,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/virtio/virtio-rng.h"
>  #include "sysemu/rng.h"
> +#include "sysemu/sysemu.h"
>  #include "qom/object_interfaces.h"
>  #include "trace.h"
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 721dcccc96..0ce142bc04 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -26,6 +26,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/virtio/virtio-access.h"
>  #include "sysemu/dma.h"
> +#include "sysemu/sysemu.h"

I'm confused - why do these now need to include sysemu.h if the only
change to sysemu.h is to drop:

 typedef struct vm_change_state_entry VMChangeStateEntry;

in favour of the typedefs header?

--
Alex Benn=C3=A9e

