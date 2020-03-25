Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C34AC2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 18:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BF72076F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 18:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DpdkdIFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BF72076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHB5l-0003LK-DR
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 14:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jHB3g-0001lN-RN
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 14:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jHB3f-0003SV-EQ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 14:47:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:54631)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jHB3f-0003Ru-9i
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 14:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585162038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKyEXQL7MBlymTaj16RsRzElxTNKQE4ON4awu9lhFKI=;
 b=DpdkdIFxuLXmNVovylyWolKBl+XjrVeG6p1LV8lDXHSIbF7Uc9i1xzuNBMt3g/EbVx5Loz
 dnONvvmWxHud5vsXFDE/w5Gelwp0qvdZFH6cHWtVGwTLzUNSLU09xXPOjCgjwZDI39jE8N
 zB5MwBZWEM9Eg4+YmgH1BEY0T14urdw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-HqUCbcvOMdGr8OzG_cnf6A-1; Wed, 25 Mar 2020 14:47:17 -0400
X-MC-Unique: HqUCbcvOMdGr8OzG_cnf6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F74A189F762
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 18:47:16 +0000 (UTC)
Received: from work-vm (ovpn-114-213.ams2.redhat.com [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C61825DA7B;
 Wed, 25 Mar 2020 18:47:10 +0000 (UTC)
Date: Wed, 25 Mar 2020 18:47:07 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH RFC 6/9] KVM: Provide helper to sync dirty bitmap from
 slot to ramblock
Message-ID: <20200325184707.GE2635@work-vm>
References: <20200205141749.378044-1-peterx@redhat.com>
 <20200205141749.378044-7-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205141749.378044-7-peterx@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> kvm_physical_sync_dirty_bitmap() calculates the ramblock offset in an
> awkward way from the MemoryRegionSection that passed in from the
> caller.  The truth is for each KVMSlot the ramblock offset never
> change for the lifecycle.  Cache the ramblock offset for each KVMSlot
> into the structure when the KVMSlot is created.
>=20
> With that, we can further simplify kvm_physical_sync_dirty_bitmap()
> with a helper to sync KVMSlot dirty bitmap to the ramblock dirty
> bitmap of a specific KVMSlot.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  accel/kvm/kvm-all.c      | 37 +++++++++++++++++--------------------
>  include/sysemu/kvm_int.h |  2 ++
>  2 files changed, 19 insertions(+), 20 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 608216fd53..f81e7a644b 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -515,15 +515,12 @@ static void kvm_log_stop(MemoryListener *listener,
>  }
> =20
>  /* get kvm's dirty pages bitmap and update qemu's */
> -static int kvm_get_dirty_pages_log_range(MemoryRegionSection *section,
> -                                         unsigned long *bitmap)
> +static void kvm_slot_sync_dirty_pages(KVMSlot *slot)
>  {
> -    ram_addr_t start =3D section->offset_within_region +
> -                       memory_region_get_ram_addr(section->mr);
> -    ram_addr_t pages =3D int128_get64(section->size) / qemu_real_host_pa=
ge_size;
> +    ram_addr_t start =3D slot->ram_start_offset;
> +    ram_addr_t pages =3D slot->memory_size / qemu_real_host_page_size;
> =20
> -    cpu_physical_memory_set_dirty_lebitmap(bitmap, start, pages);
> -    return 0;
> +    cpu_physical_memory_set_dirty_lebitmap(slot->dirty_bmap, start, page=
s);
>  }
> =20
>  #define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
> @@ -582,12 +579,10 @@ static void kvm_physical_sync_dirty_bitmap(KVMMemor=
yListener *kml,
>      KVMState *s =3D kvm_state;
>      KVMSlot *mem;
>      hwaddr start_addr, size;
> -    hwaddr slot_size, slot_offset =3D 0;
> +    hwaddr slot_size;
> =20
>      size =3D kvm_align_section(section, &start_addr);
>      while (size) {
> -        MemoryRegionSection subsection =3D *section;
> -
>          slot_size =3D MIN(kvm_max_slot_size, size);
>          mem =3D kvm_lookup_matching_slot(kml, start_addr, slot_size);
>          if (!mem) {
> @@ -596,12 +591,7 @@ static void kvm_physical_sync_dirty_bitmap(KVMMemory=
Listener *kml,
>          }
> =20
>          kvm_slot_get_dirty_log(s, mem);
> -
> -        subsection.offset_within_region +=3D slot_offset;
> -        subsection.size =3D int128_make64(slot_size);
> -        kvm_get_dirty_pages_log_range(&subsection, mem->dirty_bmap);
> -
> -        slot_offset +=3D slot_size;
> +        kvm_slot_sync_dirty_pages(mem);
>          start_addr +=3D slot_size;
>          size -=3D slot_size;
>      }
> @@ -1023,7 +1013,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml=
,
>      int err;
>      MemoryRegion *mr =3D section->mr;
>      bool writeable =3D !mr->readonly && !mr->rom_device;
> -    hwaddr start_addr, size, slot_size;
> +    hwaddr start_addr, size, slot_size, mr_offset;
> +    ram_addr_t ram_start_offset;
>      void *ram;
> =20
>      if (!memory_region_is_ram(mr)) {
> @@ -1041,9 +1032,13 @@ static void kvm_set_phys_mem(KVMMemoryListener *km=
l,
>          return;
>      }
> =20
> -    /* use aligned delta to align the ram address */
> -    ram =3D memory_region_get_ram_ptr(mr) + section->offset_within_regio=
n +
> -          (start_addr - section->offset_within_address_space);
> +    /* The offset of the kvmslot within the memory region */
> +    mr_offset =3D section->offset_within_region + start_addr -
> +        section->offset_within_address_space;
> +
> +    /* use aligned delta to align the ram address and offset */
> +    ram =3D memory_region_get_ram_ptr(mr) + mr_offset;
> +    ram_start_offset =3D memory_region_get_ram_addr(mr) + mr_offset;
> =20
>      kvm_slots_lock(kml);
> =20
> @@ -1082,6 +1077,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml=
,
>          mem->as_id =3D kml->as_id;
>          mem->memory_size =3D slot_size;
>          mem->start_addr =3D start_addr;
> +        mem->ram_start_offset =3D ram_start_offset;
>          mem->ram =3D ram;
>          mem->flags =3D kvm_mem_flags(mr);
>          kvm_slot_init_dirty_bitmap(mem);
> @@ -1092,6 +1088,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml=
,
>              abort();
>          }
>          start_addr +=3D slot_size;
> +        ram_start_offset +=3D slot_size;
>          ram +=3D slot_size;
>          size -=3D slot_size;
>      } while (size);
> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
> index 4434e15ec7..1a19bfef80 100644
> --- a/include/sysemu/kvm_int.h
> +++ b/include/sysemu/kvm_int.h
> @@ -25,6 +25,8 @@ typedef struct KVMSlot
>      unsigned long *dirty_bmap;
>      /* Cache of the address space ID */
>      int as_id;
> +    /* Cache of the offset in ram address space */
> +    ram_addr_t ram_start_offset;
>  } KVMSlot;
> =20
>  typedef struct KVMMemoryListener {
> --=20
> 2.24.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


