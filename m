Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BCCC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0556220709
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVHxVYDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0556220709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9S0B-0005VP-1h
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 06:15:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j9RzQ-0004mP-O3
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:15:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j9RzP-0005q5-7H
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:15:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22073
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j9RzO-0005nI-Qh
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583320497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HSK98NP1FXKbRshKg14Z6I9R093MnlZSyFArmEQhph8=;
 b=jVHxVYDqsIgygnbH0IAylxxviwMJxVk/KprJa4S6uQHHTo/1CD7Bqw5BEaTwSCsA+ucBFt
 BIgwNLQO3MGBbrvHpZnChSPqItNPYgtpjNaJICaZ3c6ckJqcDu/4v4s5QbfqErFMSFR1SZ
 DvAqCINeJL9uscMOlskjq4KIqxqx+nw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-PYunPIcJNyKqyv_KX9w4-w-1; Wed, 04 Mar 2020 06:14:56 -0500
X-MC-Unique: PYunPIcJNyKqyv_KX9w4-w-1
Received: by mail-wm1-f69.google.com with SMTP id m4so711565wmi.5
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 03:14:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AWb2lS/0Q4WHKen5zSqK5CWqt+E1FAZE9sUsehJoDaA=;
 b=SvODVEc0XHz24moE49lT848U7B3fkuSepFXzr0hpgZV/RnDsiXkEa2jyIam//qI/I6
 V0vth4NiIcsMQ2teziGHvXDJxtlBfcp0SnzXorK3JN9POHSatV6bh6YtLHkMFGs9Vg5b
 UTgI5e0AsWD6a5Gi6v5zVBqasqz9Cf3y1cODuOv9HFG3cMfa2tlC7DLYuiq3rNd2aIiP
 Wi5glFefiAkO/jg/g5SyGFZFhmpghgUXSf8uvekHxy8ci0dozXXXLZRw1lWbjJX+Fz7x
 hf6O2yKITuDwq/+yVtKE/vqOBCaTxz6I4WSY3gYMY39WnyJ5Zg4THfBeOEFMJgkqPnB/
 UEZQ==
X-Gm-Message-State: ANhLgQ3J4ssHSdRfM5AS7F1nzxS/gMF16GNgRGLklN/VofHMmos5kWNZ
 KWqCB+cwVbl6fiQG+LQklaHSx/tlOVbqgVoVexlWWz2860qMgsr2c448kHUKJAEBD/WfrSQ5Uh3
 XZWGlX9WHlCyYlFY=
X-Received: by 2002:adf:b609:: with SMTP id f9mr3364469wre.380.1583320495033; 
 Wed, 04 Mar 2020 03:14:55 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuhY3YUEefrzO8BOCtqRLYBt54qdDwnDOEIPq+r1gfcWz9xqg2WwOWhIwqFr0RVqL8jYffVNQ==
X-Received: by 2002:adf:b609:: with SMTP id f9mr3364408wre.380.1583320494634; 
 Wed, 04 Mar 2020 03:14:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993?
 ([2001:b07:6468:f312:9def:34a0:b68d:9993])
 by smtp.gmail.com with ESMTPSA id i7sm4213331wma.32.2020.03.04.03.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 03:14:53 -0800 (PST)
Subject: Re: [PATCH 0/2] misc: Replace zero-length arrays with flexible array
 member
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200304005105.27454-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <447f74eb-d47e-e03c-5686-ae02a700d040@redhat.com>
Date: Wed, 4 Mar 2020 12:14:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304005105.27454-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Paul Durrant <paul@xen.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, xen-devel@lists.xenproject.org,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/03/20 01:51, Philippe Mathieu-Daud=C3=A9 wrote:
> This is a tree-wide cleanup inspired by a Linux kernel commit
> (from Gustavo A. R. Silva).
>=20
> --v-- description start --v--
>=20
>   The current codebase makes use of the zero-length array language
>   extension to the C90 standard, but the preferred mechanism to
>   declare variable-length types such as these ones is a flexible
>   array member [1], introduced in C99:
>=20
>   struct foo {
>       int stuff;
>       struct boo array[];
>   };
>=20
>   By making use of the mechanism above, we will get a compiler
>   warning in case the flexible array does not occur last in the
>   structure, which will help us prevent some kind of undefined
>   behavior bugs from being unadvertenly introduced [2] to the
>   Linux codebase from now on.
>=20
> --^-- description end --^--
>=20
> Do the similar housekeeping in the QEMU codebase (which uses
> C99 since commit 7be41675f7cb).
>=20
> The first patch is done with the help of a coccinelle semantic
> patch. However Coccinelle does not recognize:
>=20
>   struct foo {
>       int stuff;
>       struct boo array[];
>   } QEMU_PACKED;
>=20
> but does recognize:
>=20
>   struct QEMU_PACKED foo {
>       int stuff;
>       struct boo array[];
>   };
>=20
> I'm not sure why, neither it is worth refactoring all QEMU
> structures to use the attributes before the structure name,
> so I did the 2nd patch manually.
>=20
> Anyway this is annoying, because many structures are not handled
> by coccinelle. Maybe this needs to be reported to upstream
> coccinelle?
>=20
> I used spatch 1.0.8 with:
>=20
>   -I include --include-headers \
>   --macro-file scripts/cocci-macro-file.h \
>   --keep-comments --indent 4
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=C3=A9 (2):
>   misc: Replace zero-length arrays with flexible array member
>     (automatic)
>   misc: Replace zero-length arrays with flexible array member (manual)
>=20
>  docs/interop/vhost-user.rst           |  4 ++--
>  block/qed.h                           |  2 +-
>  bsd-user/qemu.h                       |  2 +-
>  contrib/libvhost-user/libvhost-user.h |  2 +-
>  hw/m68k/bootinfo.h                    |  2 +-
>  hw/scsi/srp.h                         |  6 +++---
>  hw/xen/xen_pt.h                       |  2 +-
>  include/hw/acpi/acpi-defs.h           | 16 ++++++++--------
>  include/hw/arm/smmu-common.h          |  2 +-
>  include/hw/boards.h                   |  2 +-
>  include/hw/i386/intel_iommu.h         |  3 ++-
>  include/hw/s390x/event-facility.h     |  2 +-
>  include/hw/s390x/sclp.h               |  8 ++++----
>  include/hw/virtio/virtio-iommu.h      |  2 +-
>  include/sysemu/cryptodev.h            |  2 +-
>  include/tcg/tcg.h                     |  2 +-
>  pc-bios/s390-ccw/bootmap.h            |  2 +-
>  pc-bios/s390-ccw/sclp.h               |  2 +-
>  tests/qtest/libqos/ahci.h             |  2 +-
>  block/linux-aio.c                     |  2 +-
>  block/vmdk.c                          |  2 +-
>  hw/acpi/nvdimm.c                      |  6 +++---
>  hw/char/sclpconsole-lm.c              |  2 +-
>  hw/char/sclpconsole.c                 |  2 +-
>  hw/dma/soc_dma.c                      |  2 +-
>  hw/i386/x86.c                         |  2 +-
>  hw/misc/omap_l4.c                     |  2 +-
>  hw/nvram/eeprom93xx.c                 |  2 +-
>  hw/rdma/vmw/pvrdma_qp_ops.c           |  4 ++--
>  hw/s390x/virtio-ccw.c                 |  2 +-
>  hw/usb/dev-network.c                  |  2 +-
>  hw/usb/dev-smartcard-reader.c         |  4 ++--
>  hw/virtio/virtio.c                    |  4 ++--
>  net/queue.c                           |  2 +-
>  target/s390x/ioinst.c                 |  2 +-
>  35 files changed, 54 insertions(+), 53 deletions(-)
>=20

Queued (minus the qed part).

Paolo


