Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B29C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C70207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIUrPCsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C70207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4B2z-0004z5-1Q
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 17:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4B22-0004ER-JZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:07:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4B20-0002cL-70
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:07:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27878
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4B1z-0002ZP-Si
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582063671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ywjc2L8Xgi7xdp/wAYMuOv283RIxd5J2/yY6yDczeNQ=;
 b=OIUrPCsuW6HoHYUAmze6CciyC/hAEQsq6oefETpxdqt/qULh7yq2DJ+dfWOySz35wuw3q6
 Fio0Nxbqgf3w283M8lcGztEjDAdixodz5d3eEwp4VHUtcylcdQwDMuEmgHz+phtSUxtLM4
 nI+NzBw/VWH6KvQnFtPRT7XM/w6YSBs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-xgBWtwAFN7-N6WpkQ80puQ-1; Tue, 18 Feb 2020 17:07:49 -0500
Received: by mail-qv1-f72.google.com with SMTP id g15so13316131qvk.11
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 14:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6iBMFx1E5TIpcauZaohlukYm//QIcGrAAFPUakOTMwI=;
 b=HpIAIAzxVhAvQf5MTZ08A1IkTGiftGIj+3h0Ocu3V2OtnqQY2oZQMJ8r6kaUMhaXGW
 iBRVTIHKj3QmHzE0x+qv3jPy9h0jG1eYxCjDm4GSCztldH59BaoIFdEQCe4g8l71kkNA
 yzj8xt7NJcD+Kty3UyigV6Nm8/R/flbskVR2yWBKugkuJnHbf4353cNtosyPUg+/Yd6K
 zU3kdWupmGdExqdEMa6DS+qsGXLfAPqQOjGUIodHmWdvInY6Zks3vcdANzhCSvEkPbJM
 BYXysY88trKhUIyFW1eVWwP2L6LHcN3fz3KpA3cTGx6NH3g/7B4JRMdLxrRfwpVJvk7V
 TurQ==
X-Gm-Message-State: APjAAAUqZilGUfMRRBz79SPKYoP/i4PvcZcIpgkIHRKQ3l/ioGdB8cd7
 VhepNc+lAdgzZtXVItKTPeAkc/kgkuga1qoFm8OB2r6f+F158COUdtZeftwqLHkso85XN8Oj8JG
 RqqPeIlg4RBBq4/E=
X-Received: by 2002:a05:620a:579:: with SMTP id
 p25mr20089930qkp.291.1582063668494; 
 Tue, 18 Feb 2020 14:07:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqy33NApd8ewFBxLytpchdvTZSif5ffYvUnvtXlQ4QiIVBqrfyVTwVncggDeB2rS5oYdYal9NQ==
X-Received: by 2002:a05:620a:579:: with SMTP id
 p25mr20089909qkp.291.1582063668266; 
 Tue, 18 Feb 2020 14:07:48 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id k50sm2562458qtc.90.2020.02.18.14.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 14:07:47 -0800 (PST)
Date: Tue, 18 Feb 2020 17:07:46 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 fixed 03/16] util: vfio-helpers: Remove Error
 parameter from qemu_vfio_undo_mapping()
Message-ID: <20200218220746.GG7090@xz-x1>
References: <20200212134254.11073-1-david@redhat.com>
 <20200212134254.11073-4-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200212134254.11073-4-david@redhat.com>
X-MC-Unique: xgBWtwAFN7-N6WpkQ80puQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 02:42:41PM +0100, David Hildenbrand wrote:
> Everybody discards the error. Let's error_report() instead so this error
> doesn't get lost.
>=20
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

IMHO error_setg() should be preferred comparing to error_report()
because it has a context to be delivered to the caller, so the error
has a better chance to be used in a better way (e.g., QMP only
supports error_setg()).

A better solution is that we deliver the error upper.  For example,
qemu_vfio_dma_map() is one caller of qemu_vfio_undo_mapping, if you
see the callers of qemu_vfio_dma_map() you'll notice most of them has
Error** defined (e.g., nvme_init_queue).  Then we can link all of them
up.

Another lazy solution (and especially if vfio-helpers are still mostly
used only by advanced users) is we can simply pass in &error_abort for
the three callers then they won't be missed...

Thanks,

> ---
>  util/vfio-helpers.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index d6332522c1..13dd962d95 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -540,8 +540,7 @@ static int qemu_vfio_do_mapping(QEMUVFIOState *s, voi=
d *host, size_t size,
>  /**
>   * Undo the DMA mapping from @s with VFIO, and remove from mapping list.
>   */
> -static void qemu_vfio_undo_mapping(QEMUVFIOState *s, IOVAMapping *mappin=
g,
> -                                   Error **errp)
> +static void qemu_vfio_undo_mapping(QEMUVFIOState *s, IOVAMapping *mappin=
g)
>  {
>      int index;
>      struct vfio_iommu_type1_dma_unmap unmap =3D {
> @@ -556,7 +555,7 @@ static void qemu_vfio_undo_mapping(QEMUVFIOState *s, =
IOVAMapping *mapping,
>      assert(QEMU_IS_ALIGNED(mapping->size, qemu_real_host_page_size));
>      assert(index >=3D 0 && index < s->nr_mappings);
>      if (ioctl(s->container, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
> -        error_setg(errp, "VFIO_UNMAP_DMA failed: %d", -errno);
> +        error_report("VFIO_UNMAP_DMA failed: %d", -errno);
>      }
>      memmove(mapping, &s->mappings[index + 1],
>              sizeof(s->mappings[0]) * (s->nr_mappings - index - 1));
> @@ -621,7 +620,7 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, s=
ize_t size,
>              assert(qemu_vfio_verify_mappings(s));
>              ret =3D qemu_vfio_do_mapping(s, host, size, iova0);
>              if (ret) {
> -                qemu_vfio_undo_mapping(s, mapping, NULL);
> +                qemu_vfio_undo_mapping(s, mapping);
>                  goto out;
>              }
>              s->low_water_mark +=3D size;
> @@ -681,7 +680,7 @@ void qemu_vfio_dma_unmap(QEMUVFIOState *s, void *host=
)
>      if (!m) {
>          goto out;
>      }
> -    qemu_vfio_undo_mapping(s, m, NULL);
> +    qemu_vfio_undo_mapping(s, m);
>  out:
>      qemu_mutex_unlock(&s->lock);
>  }
> @@ -698,7 +697,7 @@ void qemu_vfio_close(QEMUVFIOState *s)
>          return;
>      }
>      while (s->nr_mappings) {
> -        qemu_vfio_undo_mapping(s, &s->mappings[s->nr_mappings - 1], NULL=
);
> +        qemu_vfio_undo_mapping(s, &s->mappings[s->nr_mappings - 1]);
>      }
>      ram_block_notifier_remove(&s->ram_notifier);
>      qemu_vfio_reset(s);
> --=20
> 2.24.1
>=20
>=20

--=20
Peter Xu


