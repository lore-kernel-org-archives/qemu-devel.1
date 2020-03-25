Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10ADC2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D24206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eviQ6+K7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D24206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHADa-0006Ls-QM
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 13:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jHACp-0005VB-NJ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jHACo-0007B0-Dg
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:52:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37499)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jHACo-000796-9q
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585158761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YfN04JHhEXuAk3BZBYDX3M4SPcTLKZj+FrNLdtpRuV0=;
 b=eviQ6+K73msQNhb8LhUjKLMYbblmEXtuOafinhYD9EzgNyytSgAI/avgdSrmAQ0KA7Oj18
 K9j7vTflmO6IhoKFZ0/VkhPeVbbRje3cv4gv8EvwRLnQQylMkCdEDFj7Gy2vZNpEUUZkcM
 1tcWV4kOzj/GR2yu2LwmYPRj1MKW/0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-3TdgafQnM6iO8csdAmK1Qw-1; Wed, 25 Mar 2020 13:52:39 -0400
X-MC-Unique: 3TdgafQnM6iO8csdAmK1Qw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28D079F413
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 17:52:29 +0000 (UTC)
Received: from work-vm (ovpn-114-213.ams2.redhat.com [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85D3F60C05;
 Wed, 25 Mar 2020 17:52:22 +0000 (UTC)
Date: Wed, 25 Mar 2020 17:52:20 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH RFC 5/9] KVM: Provide helper to get kvm dirty log
Message-ID: <20200325175220.GD2635@work-vm>
References: <20200205141749.378044-1-peterx@redhat.com>
 <20200205141749.378044-6-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205141749.378044-6-peterx@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
> Provide a helper kvm_slot_get_dirty_log() to make the function
> kvm_physical_sync_dirty_bitmap() clearer.  We can even cache the as_id
> into KVMSlot when it is created, so that we don't even need to pass it
> down every time.
>=20
> Since at it, remove return value of kvm_physical_sync_dirty_bitmap()
> because it should never fail.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  accel/kvm/kvm-all.c      | 39 +++++++++++++++++++--------------------
>  include/sysemu/kvm_int.h |  2 ++
>  2 files changed, 21 insertions(+), 20 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index bb635c775f..608216fd53 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -553,6 +553,18 @@ static void kvm_slot_init_dirty_bitmap(KVMSlot *mem)
>      mem->dirty_bmap =3D g_malloc0(bitmap_size);
>  }
> =20
> +/* Sync dirty bitmap from kernel to KVMSlot.dirty_bmap */
> +static void kvm_slot_get_dirty_log(KVMState *s, KVMSlot *slot)
> +{
> +    struct kvm_dirty_log d =3D {};
> +    int ret;
> +
> +    d.dirty_bitmap =3D slot->dirty_bmap;
> +    d.slot =3D slot->slot | (slot->as_id << 16);
> +    ret =3D kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d);
> +    assert(ret !=3D -1);

As discussed on irc, that -1 check seems odd given your previous check
but there seems to be some history as to why it was still there.  Hmm.

It also seems very trusting that it can never possibly fail!

Dave

> +}
> +
>  /**
>   * kvm_physical_sync_dirty_bitmap - Sync dirty bitmap from kernel space
>   *
> @@ -564,15 +576,13 @@ static void kvm_slot_init_dirty_bitmap(KVMSlot *mem=
)
>   * @kml: the KVM memory listener object
>   * @section: the memory section to sync the dirty bitmap with
>   */
> -static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
> -                                          MemoryRegionSection *section)
> +static void kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
> +                                           MemoryRegionSection *section)
>  {
>      KVMState *s =3D kvm_state;
> -    struct kvm_dirty_log d =3D {};
>      KVMSlot *mem;
>      hwaddr start_addr, size;
>      hwaddr slot_size, slot_offset =3D 0;
> -    int ret =3D 0;
> =20
>      size =3D kvm_align_section(section, &start_addr);
>      while (size) {
> @@ -582,27 +592,19 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemory=
Listener *kml,
>          mem =3D kvm_lookup_matching_slot(kml, start_addr, slot_size);
>          if (!mem) {
>              /* We don't have a slot if we want to trap every access. */
> -            goto out;
> +            return;
>          }
> =20
> -        d.dirty_bitmap =3D mem->dirty_bmap;
> -        d.slot =3D mem->slot | (kml->as_id << 16);
> -        if (kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d) =3D=3D -1) {
> -            DPRINTF("ioctl failed %d\n", errno);
> -            ret =3D -1;
> -            goto out;
> -        }
> +        kvm_slot_get_dirty_log(s, mem);
> =20
>          subsection.offset_within_region +=3D slot_offset;
>          subsection.size =3D int128_make64(slot_size);
> -        kvm_get_dirty_pages_log_range(&subsection, d.dirty_bitmap);
> +        kvm_get_dirty_pages_log_range(&subsection, mem->dirty_bmap);
> =20
>          slot_offset +=3D slot_size;
>          start_addr +=3D slot_size;
>          size -=3D slot_size;
>      }
> -out:
> -    return ret;
>  }
> =20
>  /* Alignment requirement for KVM_CLEAR_DIRTY_LOG - 64 pages */
> @@ -1077,6 +1079,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml=
,
>      do {
>          slot_size =3D MIN(kvm_max_slot_size, size);
>          mem =3D kvm_alloc_slot(kml);
> +        mem->as_id =3D kml->as_id;
>          mem->memory_size =3D slot_size;
>          mem->start_addr =3D start_addr;
>          mem->ram =3D ram;
> @@ -1119,14 +1122,10 @@ static void kvm_log_sync(MemoryListener *listener=
,
>                           MemoryRegionSection *section)
>  {
>      KVMMemoryListener *kml =3D container_of(listener, KVMMemoryListener,=
 listener);
> -    int r;
> =20
>      kvm_slots_lock(kml);
> -    r =3D kvm_physical_sync_dirty_bitmap(kml, section);
> +    kvm_physical_sync_dirty_bitmap(kml, section);
>      kvm_slots_unlock(kml);
> -    if (r < 0) {
> -        abort();
> -    }
>  }
> =20
>  static void kvm_log_clear(MemoryListener *listener,
> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
> index ac2d1f8b56..4434e15ec7 100644
> --- a/include/sysemu/kvm_int.h
> +++ b/include/sysemu/kvm_int.h
> @@ -23,6 +23,8 @@ typedef struct KVMSlot
>      int old_flags;
>      /* Dirty bitmap cache for the slot */
>      unsigned long *dirty_bmap;
> +    /* Cache of the address space ID */
> +    int as_id;
>  } KVMSlot;
> =20
>  typedef struct KVMMemoryListener {
> --=20
> 2.24.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


