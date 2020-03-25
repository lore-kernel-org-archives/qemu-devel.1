Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EB4C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA322073E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXWRJk8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA322073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH9Hl-0000Zt-SX
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 12:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jH9H9-00008m-Th
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jH9H7-0001TQ-Fw
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:53:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jH9H7-0001SP-5c
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585155184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eByqlIsX4SJgAmsoxibAAAy4tbBM36e5+k0JTbS7sbY=;
 b=JXWRJk8ld6cRb47AgPOrEXzPXDDoz64SgHukipgn41ijTnKgqi25DOZ/ft9Tj9cnzE5tjB
 4XMXh+rTah8Ah2zV9gHT8vIYkKug2EY8H4FM2Bc+1THIRYvJwhmYRZBUHe7dRxGWUzMde2
 3RsxT3ZBPl2nOKfKQLerLGWqmHT5yfs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-MXqyrFakNTiXBU0RwUOdMA-1; Wed, 25 Mar 2020 12:53:02 -0400
X-MC-Unique: MXqyrFakNTiXBU0RwUOdMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 923FC18B9FC2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 16:53:01 +0000 (UTC)
Received: from work-vm (ovpn-114-213.ams2.redhat.com [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2BB91BC6D;
 Wed, 25 Mar 2020 16:52:54 +0000 (UTC)
Date: Wed, 25 Mar 2020 16:52:52 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH RFC 3/9] memory: Introduce log_sync_global() to memory
 listener
Message-ID: <20200325165252.GB2635@work-vm>
References: <20200205141749.378044-1-peterx@redhat.com>
 <20200205141749.378044-4-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205141749.378044-4-peterx@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
> Some of the memory listener may want to do log synchronization without
> being able to specify a range of memory to sync but always globally.
> Such a memory listener should provide this new method instead of the
> log_sync() method.
>=20
> Obviously we can also achieve similar thing when we put the global
> sync logic into a log_sync() handler. However that's not efficient
> enough because otherwise memory_global_dirty_log_sync() may do the
> global sync N times, where N is the number of flat views.
>=20
> Make this new method be exclusive to log_sync().
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>

OK, so I guess the idea here is that when you have a ring with dirty
pages on it, you just need to clear all outstanding things on the ring
whereever they came from.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/exec/memory.h | 12 ++++++++++++
>  memory.c              | 33 +++++++++++++++++++++++----------
>  2 files changed, 35 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index e85b7de99a..c4427094bb 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -533,6 +533,18 @@ struct MemoryListener {
>       */
>      void (*log_sync)(MemoryListener *listener, MemoryRegionSection *sect=
ion);
> =20
> +    /**
> +     * @log_sync_global:
> +     *
> +     * This is the global version of @log_sync when the listener does
> +     * not have a way to synchronize the log with finer granularity.
> +     * When the listener registers with @log_sync_global defined, then
> +     * its @log_sync must be NULL.  Vice versa.
> +     *
> +     * @listener: The #MemoryListener.
> +     */
> +    void (*log_sync_global)(MemoryListener *listener);
> +
>      /**
>       * @log_clear:
>       *
> diff --git a/memory.c b/memory.c
> index aeaa8dcc9e..53828ba00c 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2016,6 +2016,10 @@ void memory_region_set_dirty(MemoryRegion *mr, hwa=
ddr addr,
>                                          memory_region_get_dirty_log_mask=
(mr));
>  }
> =20
> +/*
> + * If memory region `mr' is NULL, do global sync.  Otherwise, sync
> + * dirty bitmap for the specified memory region.
> + */
>  static void memory_region_sync_dirty_bitmap(MemoryRegion *mr)
>  {
>      MemoryListener *listener;
> @@ -2029,18 +2033,24 @@ static void memory_region_sync_dirty_bitmap(Memor=
yRegion *mr)
>       * address space once.
>       */
>      QTAILQ_FOREACH(listener, &memory_listeners, link) {
> -        if (!listener->log_sync) {
> -            continue;
> -        }
> -        as =3D listener->address_space;
> -        view =3D address_space_get_flatview(as);
> -        FOR_EACH_FLAT_RANGE(fr, view) {
> -            if (fr->dirty_log_mask && (!mr || fr->mr =3D=3D mr)) {
> -                MemoryRegionSection mrs =3D section_from_flat_range(fr, =
view);
> -                listener->log_sync(listener, &mrs);
> +        if (listener->log_sync) {
> +            as =3D listener->address_space;
> +            view =3D address_space_get_flatview(as);
> +            FOR_EACH_FLAT_RANGE(fr, view) {
> +                if (fr->dirty_log_mask && (!mr || fr->mr =3D=3D mr)) {
> +                    MemoryRegionSection mrs =3D section_from_flat_range(=
fr, view);
> +                    listener->log_sync(listener, &mrs);
> +                }
>              }
> +            flatview_unref(view);
> +        } else if (listener->log_sync_global) {
> +            /*
> +             * No matter whether MR is specified, what we can do here
> +             * is to do a global sync, because we are not capable to
> +             * sync in a finer granularity.
> +             */
> +            listener->log_sync_global(listener);
>          }
> -        flatview_unref(view);
>      }
>  }
> =20
> @@ -2727,6 +2737,9 @@ void memory_listener_register(MemoryListener *liste=
ner, AddressSpace *as)
>  {
>      MemoryListener *other =3D NULL;
> =20
> +    /* Only one of them can be defined for a listener */
> +    assert(!(listener->log_sync && listener->log_sync_global));
> +
>      listener->address_space =3D as;
>      if (QTAILQ_EMPTY(&memory_listeners)
>          || listener->priority >=3D QTAILQ_LAST(&memory_listeners)->prior=
ity) {
> --=20
> 2.24.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


