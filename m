Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB79C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637C42075D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMp7Scbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637C42075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipX7L-0006nj-GG
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ipX60-00056O-CU
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:39:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ipX5x-0002xV-HG
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:39:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40160
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ipX5x-0002px-1B
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578573563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L2Bl3vsT9mjpdGHo1zUs/yhZeXzjOEHHW7eqQGz8EXU=;
 b=TMp7Scbjy42Ik4Mbfcy1TrJmNcMutzIGQoqrWHyGmL0PHGFFeJ+VCASvwAt9NFf0jTIe4q
 TOynXS85GqgQ1FJ/a209NhZ+UGAFmFuoOC5Y9qiJFTAiF9ma93g2S6JI6CKUbXxeH7y40t
 UhsyFN98/YV9BgO1UKYj+kEzGS5P3io=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-_LdS_BuINxmzhorrkBqudQ-1; Thu, 09 Jan 2020 07:39:22 -0500
Received: by mail-qt1-f197.google.com with SMTP id c8so4078958qte.22
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 04:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=JH/UlGdxNeTPvcMZb06Q76YhS3yZXofkvZLRAqeykmQ=;
 b=XlYcWFmhxBgFQJuaqT7uPySCi9iacvqQdWDAuwlIUldo++Eimb8+sgpWQDI3LmQto1
 KAwW9L4xtM7EdsNCvn0EsXdZWaGdVuTUJfNbt3jN4onJIgdUMSzS7Ceu4V1UG+NqEhDh
 DzlzSmDc0tJV+Ta2KyPQHJ5j1MdlL7fyAQJkGgsYZzPKmHcNYFZe/Vlhg+h24YtPzasW
 0YaVsI/RQ56HfvzlGMU7DKpbqaGRmX2ewztaqdByZO/v1vGgyGVp/s+XhK5QYnlGwQS+
 VGDZRQNV2pbw6KFfVIDrx1FTMEPOsA10uvXDYk4Sr8hoRG1sfs3PWuf/vufNAnLHl0pu
 OfwQ==
X-Gm-Message-State: APjAAAVr+xsS3BIDXylS1rLUseIbknlk5idTq9BKkaNh+nH1H16MhHYp
 Tz48KvufoaFIeBYjENybDS8gmyX9nnjizSLdEDKYLloREoZlCrxNP/hK71KD257ORFZnSrZN5BG
 rKCiVHASnW6ay1cM=
X-Received: by 2002:ac8:138b:: with SMTP id h11mr7548884qtj.153.1578573562102; 
 Thu, 09 Jan 2020 04:39:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3Q22tYdYgLZWMuGzS2YdzNqH6Kd8mihZDJMnTtrDEqEFHikMw3QnKrcdlCyyukoK/AwHp9A==
X-Received: by 2002:ac8:138b:: with SMTP id h11mr7548868qtj.153.1578573561867; 
 Thu, 09 Jan 2020 04:39:21 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id t23sm3219964qto.88.2020.01.09.04.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 04:39:21 -0800 (PST)
Date: Thu, 9 Jan 2020 07:39:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Andr=E9?= Silva <afscoelho@gmail.com>
Subject: Re: [PATCH] virtio: Prevent double swap due to target pre 1.0 VirtIO
Message-ID: <20200109073529-mutt-send-email-mst@kernel.org>
References: <20200108161618.221116-1-afscoelho@gmail.com>
 <20200109054233-mutt-send-email-mst@kernel.org>
 <CAGTcC7yLjP5h4oWfgvrOYobChW-cw-oL5EBmMCH45O41+yuvyA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGTcC7yLjP5h4oWfgvrOYobChW-cw-oL5EBmMCH45O41+yuvyA@mail.gmail.com>
X-MC-Unique: _LdS_BuINxmzhorrkBqudQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 09, 2020 at 09:25:42AM -0300, Andr=E9 Silva wrote:
> Hi Michael!
> Thanks for reviewing the patch!
>=20
> > we always get LE values from memory subsystem,
> > not target endian values:
>=20
> I see. So do you think the patch is correct in eliminating the extra
> swap (as virtio_config_readw for example already makes a swap)?
>=20
> Thanks,
> andr=E9

I don't think it is, I think we do need an extra swap
in some cases. It's possible that some cross-endian
setups are broken now, if so pls include testing
result not just theoretical analysis.

> On Thu, Jan 9, 2020 at 7:50 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jan 08, 2020 at 01:16:18PM -0300, Andre Silva wrote:
> > > Remove the bswap function calls after reading and before writing
> > > memory bytes in virtio_pci_config_read and virtio_pci_config_write
> > > because they are reverting back an already swapped bytes.
> > >
> > > Consider the table below in the context of virtio_pci_config_read
> > > function.
> > >
> > > Host   Target  virtio-config-read[wl]
> > >                swap?                   virtio-is-big-endian?   extra =
bswap?   Should be   Final result   Final result ok?
> > > ----- ------- ------------------------ ----------------------- ------=
-------- ----------- -------------- ------------------
> > > LE     BE      s(x)                    true                    s(s(x)=
)        s(x)        x              No
> > > LE     LE      x                       false                   -     =
         x           x              Yes
> > > BE     LE      s(x)                    false                   -     =
         s(x)        s(x)           Yes
> > > BE     BE      x                       true                    s(x)  =
         x           s(x)           No
> >
> > we always get LE values from memory subsystem,
> > not target endian values:
> >
> > static const MemoryRegionOps virtio_pci_config_ops =3D {
> >     .read =3D virtio_pci_config_read,
> >     .write =3D virtio_pci_config_write,
> >     .impl =3D {
> >         .min_access_size =3D 1,
> >         .max_access_size =3D 4,
> >     },
> >     .endianness =3D DEVICE_LITTLE_ENDIAN,
> > };
> >
> >
> > This triggers another swap in address_space_ldl_internal
> > (memory_ldst.inc.c).
> >
> >
> > > In table above, when target is big endian and VirtIO is pre 1.0,
> > > function virtio_is_big_endian would return true and the extra
> > > swap would be executed, reverting the previous swap made by
> > > virtio_config_read[wl].
> > >
> > > The 's(x)' means that a swap function was applied at
> > > address x. 'LE' is little endian and 'BE' is big endian. The
> > > 'Final result' column is the returned value from
> > > virtio_pci_config_read, considering a target Virtio pre 1.0.
> > > 'x' means that target's value was not swapped in Qemu, 's(x)' means
> > > that Qemu will use a swapped value.
> > >
> > > If we remove the extra swap made in virtio_pci_config_read we will
> > > have the correct result in any host/target combination, both for
> > > VirtIO pre 1.0 or later versions.
> > >
> > > The same reasoning applies to virtio_pci_config_write.
> > >
> > > Signed-off-by: Andre Silva <afscoelho@gmail.com>
> > > ---
> > >  hw/virtio/virtio-pci.c | 12 ------------
> > >  1 file changed, 12 deletions(-)
> > >
> > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > index c6b47a9c73..4ba9e847f3 100644
> > > --- a/hw/virtio/virtio-pci.c
> > > +++ b/hw/virtio/virtio-pci.c
> > > @@ -431,15 +431,9 @@ static uint64_t virtio_pci_config_read(void *opa=
que, hwaddr addr,
> > >          break;
> > >      case 2:
> > >          val =3D virtio_config_readw(vdev, addr);
> > > -        if (virtio_is_big_endian(vdev)) {
> > > -            val =3D bswap16(val);
> > > -        }
> > >          break;
> > >      case 4:
> > >          val =3D virtio_config_readl(vdev, addr);
> > > -        if (virtio_is_big_endian(vdev)) {
> > > -            val =3D bswap32(val);
> > > -        }
> > >          break;
> > >      }
> > >      return val;
> > > @@ -465,15 +459,9 @@ static void virtio_pci_config_write(void *opaque=
, hwaddr addr,
> > >          virtio_config_writeb(vdev, addr, val);
> > >          break;
> > >      case 2:
> > > -        if (virtio_is_big_endian(vdev)) {
> > > -            val =3D bswap16(val);
> > > -        }
> > >          virtio_config_writew(vdev, addr, val);
> > >          break;
> > >      case 4:
> > > -        if (virtio_is_big_endian(vdev)) {
> > > -            val =3D bswap32(val);
> > > -        }
> > >          virtio_config_writel(vdev, addr, val);
> > >          break;
> > >      }
> > > --
> > > 2.24.1
> >


