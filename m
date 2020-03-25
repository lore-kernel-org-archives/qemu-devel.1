Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D9CC2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:47:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3669D2074D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqJ2RW1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3669D2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHA7M-0000Hz-EQ
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 13:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jHA50-0006fK-6A
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jHA4y-0002CT-Tx
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:44:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:20575)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jHA4y-0002Bv-PM
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585158276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5FdXOkrbohr7uS5cNFXsajo0Z52raWFVu2MXQ2gQtwg=;
 b=VqJ2RW1IkvMbOUJw/xv/mZJKvGOmap7g6ME4hdmz5bLiDqhj6IpkFyOKCacZjl8bIyKiWU
 ccpKrAqo4zSeY/85u+WitL9MAVNk7EsHrvuFpZhS7KikdQ0hOwQjQwoua7i6oQeqqcG4tQ
 qf8gXSRr/5RJkT1RUkl4TueAJ7+q7tY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-AWEW6vosNWaHX3FByJ3-kQ-1; Wed, 25 Mar 2020 13:44:34 -0400
X-MC-Unique: AWEW6vosNWaHX3FByJ3-kQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A856800D4E
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 17:44:33 +0000 (UTC)
Received: from work-vm (ovpn-114-213.ams2.redhat.com [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDD8E100164D;
 Wed, 25 Mar 2020 17:44:27 +0000 (UTC)
Date: Wed, 25 Mar 2020 17:44:24 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH RFC 4/9] KVM: Create the KVMSlot dirty bitmap on flag
 changes
Message-ID: <20200325174424.GC2635@work-vm>
References: <20200205141749.378044-1-peterx@redhat.com>
 <20200205141749.378044-5-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205141749.378044-5-peterx@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
> Previously we have two places that will create the per KVMSlot dirty
> bitmap:
>=20
>   1. When a newly created KVMSlot has dirty logging enabled,
>   2. When the first log_sync() happens for a memory slot.
>=20
> The 2nd case is lazy-init, while the 1st case is not (which is a fix
> of what the 2nd case missed).
>=20
> To do explicit initialization of dirty bitmaps, what we're missing is
> to create the dirty bitmap when the slot changed from not-dirty-track
> to dirty-track.  Do that in kvm_slot_update_flags().
>=20
> With that, we can safely remove the 2nd lazy-init.
>=20
> This change will be needed for kvm dirty ring because kvm dirty ring
> does not use the log_sync() interface at all.
>=20
> Since at it, move all the pre-checks into kvm_slot_init_dirty_bitmap().

'While at it' or just Also

> Signed-off-by: Peter Xu <peterx@redhat.com>


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  accel/kvm/kvm-all.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 4be3cd2352..bb635c775f 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -162,6 +162,8 @@ static NotifierList kvm_irqchip_change_notifiers =3D
>  #define kvm_slots_lock(kml)      qemu_mutex_lock(&(kml)->slots_lock)
>  #define kvm_slots_unlock(kml)    qemu_mutex_unlock(&(kml)->slots_lock)
> =20
> +static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
> +
>  int kvm_get_max_memslots(void)
>  {
>      KVMState *s =3D KVM_STATE(current_accel());
> @@ -442,6 +444,7 @@ static int kvm_slot_update_flags(KVMMemoryListener *k=
ml, KVMSlot *mem,
>          return 0;
>      }
> =20
> +    kvm_slot_init_dirty_bitmap(mem);
>      return kvm_set_user_memory_region(kml, mem, false);
>  }
> =20
> @@ -526,8 +529,12 @@ static int kvm_get_dirty_pages_log_range(MemoryRegio=
nSection *section,
>  #define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
> =20
>  /* Allocate the dirty bitmap for a slot  */
> -static void kvm_memslot_init_dirty_bitmap(KVMSlot *mem)
> +static void kvm_slot_init_dirty_bitmap(KVMSlot *mem)
>  {
> +    if (!(mem->flags & KVM_MEM_LOG_DIRTY_PAGES) || mem->dirty_bmap) {
> +        return;
> +    }
> +
>      /*
>       * XXX bad kernel interface alert
>       * For dirty bitmap, kernel allocates array of size aligned to
> @@ -578,11 +585,6 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryL=
istener *kml,
>              goto out;
>          }
> =20
> -        if (!mem->dirty_bmap) {
> -            /* Allocate on the first log_sync, once and for all */
> -            kvm_memslot_init_dirty_bitmap(mem);
> -        }
> -
>          d.dirty_bitmap =3D mem->dirty_bmap;
>          d.slot =3D mem->slot | (kml->as_id << 16);
>          if (kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d) =3D=3D -1) {
> @@ -1079,14 +1081,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *km=
l,
>          mem->start_addr =3D start_addr;
>          mem->ram =3D ram;
>          mem->flags =3D kvm_mem_flags(mr);
> -
> -        if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
> -            /*
> -             * Reallocate the bmap; it means it doesn't disappear in
> -             * middle of a migrate.
> -             */
> -            kvm_memslot_init_dirty_bitmap(mem);
> -        }
> +        kvm_slot_init_dirty_bitmap(mem);
>          err =3D kvm_set_user_memory_region(kml, mem, true);
>          if (err) {
>              fprintf(stderr, "%s: error registering slot: %s\n", __func__=
,
> --=20
> 2.24.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


