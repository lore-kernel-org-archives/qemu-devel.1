Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440CAC33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 07:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BBD5207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 07:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EgxO+yxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBD5207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irGVC-0003gc-3I
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 02:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1irGUV-0003GE-5T
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 02:19:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1irGUT-0005eF-Ve
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 02:19:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45221
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1irGUT-0005dz-Rx
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 02:19:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578986393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z87fZtv9VeI4nGtXWUGemQVSnaNQe/Wx8eK0QKDLQUY=;
 b=EgxO+yxcnf5dVv++nIqUtRAcDDOHRzkzwzNXALVmx908SUjL396aRQbR9FuI/sGfYLRAw8
 94JyLCSegfn8FnSTzPawB1hIdLjRBCeA5sHfOZ7y2tosmgvvFUNQlzEH28bP0Jod2W9TpI
 /xFkKlgQ6tNgukn3IoFgdpl4EdVELwI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-X5fdQi9kMNqBF_aV63-BTw-1; Tue, 14 Jan 2020 02:19:46 -0500
Received: by mail-qk1-f200.google.com with SMTP id a73so7761094qkg.5
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 23:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zKXCCnO6gL7s1WlTskzFLCykvKdDzrhlts7P9f5bkIc=;
 b=EHg2UNmknPnyFbOSBCpqMiO3kvHiMlSR/uq5xi6DUU6K9FSRWAGg6k6+4lYieRCZ1l
 lPTmoGFN4kBzQWtt/IKBcnMAQ/uShxcN8csEopgZSJyauJHDIEnwLMY8qeVi2BT7/PK8
 WuX+A39U8o/+RxxFw1W1KUOGz52splYgc3KgPg4ISR+gKdRbGZ7ksz3lCa6Y4S++T0D8
 MQ/ZGwsZ4Nq/uWep0jZmLf8cs8yg2gFep2EDWhhJbsVJotMR2OWvpbdA8K1P47Lb9zb6
 88xknPH7faFlunHTcoW5uNkUH/e1Yn0mL5APsBHEAq2S3ZyueYWNBCIzfJyESRQ+aNDq
 m3Pg==
X-Gm-Message-State: APjAAAWYT6uTBk0eEciUvWMzfyOWziLFcZuwlOvHkMTUe+2PV+bkY93S
 57ZnTzw/E0pnh1cuSI8CoP5qXO/+EUNxUAIxqPvsnLiO9zIhsYGPtKuiTY6OmVY4xWubWkUdvU0
 5ZKloztmQOYi2+Ts=
X-Received: by 2002:ac8:747:: with SMTP id k7mr2458661qth.120.1578986385949;
 Mon, 13 Jan 2020 23:19:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqw2pmcJoTdczkWGoOY9+oF36JJnuqrDbD9v4dSn4vHXkzKmp7LeirEt1DeoB6Zl4rg1XKQUCg==
X-Received: by 2002:ac8:747:: with SMTP id k7mr2458631qth.120.1578986385260;
 Mon, 13 Jan 2020 23:19:45 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id a185sm6260559qkg.68.2020.01.13.23.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2020 23:19:44 -0800 (PST)
Date: Tue, 14 Jan 2020 02:19:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 2/3] memory: Allow a MemoryRegion to be marked no_vhost
Message-ID: <20200114021723-mutt-send-email-mst@kernel.org>
References: <20200113173647.84842-1-dgilbert@redhat.com>
 <20200113173647.84842-3-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200113173647.84842-3-dgilbert@redhat.com>
X-MC-Unique: X5fdQi9kMNqBF_aV63-BTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: jasowang@redhat.com, pbonzini@redhat.com, vkuznets@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 13, 2020 at 05:36:46PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Allow a memory region to be marked as 'no_vhost' and
> exclude that region from vhost's list build.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

I thought we agreed vfio needs this as well?
I'd rather this had some meaning not just "no vhost" ...
no_dma?

> ---
>  hw/virtio/vhost.c     |  3 ++-
>  include/exec/memory.h | 21 +++++++++++++++++++++
>  memory.c              | 15 +++++++++++++++
>  3 files changed, 38 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 774d87d98e..462498bfe6 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -402,7 +402,8 @@ static bool vhost_section(struct vhost_dev *dev, Memo=
ryRegionSection *section)
>      bool log_dirty =3D memory_region_get_dirty_log_mask(section->mr) &
>                       ~(1 << DIRTY_MEMORY_MIGRATION);
>      result =3D memory_region_is_ram(section->mr) &&
> -        !memory_region_is_rom(section->mr);
> +             !memory_region_is_rom(section->mr) &&
> +             !memory_region_get_no_vhost(section->mr);
> =20
>      /* Vhost doesn't handle any block which is doing dirty-tracking othe=
r
>       * than migration; this typically fires on VGA areas.
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index aef8123d48..f475c06d63 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -394,6 +394,7 @@ struct MemoryRegion {
>      bool ram_device;
>      bool enabled;
>      bool warning_printed; /* For reservations */
> +    bool no_vhost;
>      uint8_t vga_logging_count;
>      MemoryRegion *alias;
>      hwaddr alias_offset;
> @@ -1625,6 +1626,26 @@ void memory_region_set_readonly(MemoryRegion *mr, =
bool readonly);
>   */
>  void memory_region_set_nonvolatile(MemoryRegion *mr, bool nonvolatile);
> =20
> +/**
> + * memory_region_set_no_vhost: Make vhost ignore a memory region
> + *
> + * Makes vhost ignore a memory region, useful if it isn't real
> + * DMAble memory and is at inconvenient addresses
> + *
> + * @mr: the region being updated.
> + * @no_vhost: true to ignore
> + */
> +void memory_region_set_no_vhost(MemoryRegion *mr, bool no_vhost);
> +
> +/**
> + * memory_region_set_no_vhost: Test if memory region is marked no vhost
> + *
> + * Test if the no_vhost flag is set on the memory region
> + *
> + * @mr: the region being tested.
> + */
> +bool memory_region_get_no_vhost(const MemoryRegion *mr);
> +
>  /**
>   * memory_region_rom_device_set_romd: enable/disable ROMD mode
>   *
> diff --git a/memory.c b/memory.c
> index d7b9bb6951..9371998e30 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2136,6 +2136,21 @@ void memory_region_set_nonvolatile(MemoryRegion *m=
r, bool nonvolatile)
>      }
>  }
> =20
> +void memory_region_set_no_vhost(MemoryRegion *mr, bool no_vhost)
> +{
> +    if (mr->no_vhost !=3D no_vhost) {
> +        memory_region_transaction_begin();
> +        mr->no_vhost =3D no_vhost;
> +        memory_region_update_pending |=3D mr->enabled;
> +        memory_region_transaction_commit();
> +    }
> +}
> +
> +bool memory_region_get_no_vhost(const MemoryRegion *mr)
> +{
> +    return mr->no_vhost;
> +}
> +
>  void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
>  {
>      if (mr->romd_mode !=3D romd_mode) {
> --=20
> 2.24.1


