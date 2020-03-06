Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23E1C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 16:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD78B2073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 16:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNQeG9fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD78B2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAFUh-0005AU-VU
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 11:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jAFU1-0004Va-TU
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jAFTz-0005aP-Jh
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:05:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43304
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jAFTz-0005XL-EW
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583510750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y/YgUcjCyha2z0XPrdysI1XIaQ9snDlSl3A5ZshvNp8=;
 b=LNQeG9fcHi6lEGwo4xlQOecwJxhbe2wF/3Jwu9zYpN0IRT+gkk5NInXLt2SMFeboxJE1jD
 KIxnIn9+oHIww9GxO5CSiyTgRd7a7L5NnQzoIz1m2jXT18eROrdNS00+4PtdHKZ9OWl7kA
 NywA8OW5C++uB4jhLsAlpTg7ckz4DYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-E5ORFs-BOtKk5GhN5r0UUg-1; Fri, 06 Mar 2020 11:05:48 -0500
X-MC-Unique: E5ORFs-BOtKk5GhN5r0UUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A9CC10CE7B2;
 Fri,  6 Mar 2020 16:05:47 +0000 (UTC)
Received: from work-vm (ovpn-116-247.ams2.redhat.com [10.36.116.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61B735C28D;
 Fri,  6 Mar 2020 16:05:40 +0000 (UTC)
Date: Fri, 6 Mar 2020 16:05:38 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 08/13] migration/ram: Simplify host page handling in
 ram_load_postcopy()
Message-ID: <20200306160538.GE3033@work-vm>
References: <20200226155304.60219-1-david@redhat.com>
 <20200226155304.60219-9-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226155304.60219-9-david@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> Add two new helper functions. This will in come handy once we want to
> handle ram block resizes while postcopy is active.
>=20
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  migration/ram.c | 54 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 31 insertions(+), 23 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index d5a4d69e1c..f815f4e532 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2734,6 +2734,20 @@ static inline void *host_from_ram_block_offset(RAM=
Block *block,
>      return block->host + offset;
>  }
> =20
> +static void *host_page_from_ram_block_offset(RAMBlock *block,
> +                                             ram_addr_t offset)
> +{
> +    /* Note: Explicitly no check against offset_in_ramblock(). */
> +    return (void *)QEMU_ALIGN_DOWN((uintptr_t)block->host + offset,
> +                                   block->page_size);
> +}
> +
> +static ram_addr_t host_page_offset_from_ram_block_offset(RAMBlock *block=
,
> +                                                         ram_addr_t offs=
et)
> +{
> +    return ((uintptr_t)block->host + offset) & (block->page_size - 1);
> +}
> +
>  static inline void *colo_cache_from_block_offset(RAMBlock *block,
>                                                   ram_addr_t offset)
>  {
> @@ -3111,13 +3125,12 @@ static int ram_load_postcopy(QEMUFile *f)
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
>      /* Temporary page that is later 'placed' */
>      void *postcopy_host_page =3D mis->postcopy_tmp_page;
> -    void *this_host =3D NULL;
> +    void *host_page =3D NULL;
>      bool all_zero =3D false;
>      int target_pages =3D 0;
> =20
>      while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
>          ram_addr_t addr;
> -        void *host =3D NULL;
>          void *page_buffer =3D NULL;
>          void *place_source =3D NULL;
>          RAMBlock *block =3D NULL;
> @@ -3143,9 +3156,12 @@ static int ram_load_postcopy(QEMUFile *f)
>          if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
>                       RAM_SAVE_FLAG_COMPRESS_PAGE)) {
>              block =3D ram_block_from_stream(f, flags);
> +            if (!block) {
> +                ret =3D -EINVAL;

Could we have an error_report there, at the moment it would trigger
the one below.

Other than that,


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


> +                break;
> +            }
> =20
> -            host =3D host_from_ram_block_offset(block, addr);
> -            if (!host) {
> +            if (!offset_in_ramblock(block, addr)) {
>                  error_report("Illegal RAM offset " RAM_ADDR_FMT, addr);
>                  ret =3D -EINVAL;
>                  break;
> @@ -3163,21 +3179,18 @@ static int ram_load_postcopy(QEMUFile *f)
>               * of a host page in one chunk.
>               */
>              page_buffer =3D postcopy_host_page +
> -                          ((uintptr_t)host & (block->page_size - 1));
> +                          host_page_offset_from_ram_block_offset(block, =
addr);
>              /* If all TP are zero then we can optimise the place */
>              if (target_pages =3D=3D 1) {
>                  all_zero =3D true;
> -                this_host =3D (void *)QEMU_ALIGN_DOWN((uintptr_t)host,
> -                                                    block->page_size);
> -            } else {
> +                host_page =3D host_page_from_ram_block_offset(block, add=
r);
> +            } else if (host_page !=3D host_page_from_ram_block_offset(bl=
ock,
> +                                                                    addr=
)) {
>                  /* not the 1st TP within the HP */
> -                if (QEMU_ALIGN_DOWN((uintptr_t)host, block->page_size) !=
=3D
> -                    (uintptr_t)this_host) {
> -                    error_report("Non-same host page %p/%p",
> -                                  host, this_host);
> -                    ret =3D -EINVAL;
> -                    break;
> -                }
> +                error_report("Non-same host page %p/%p", host_page,
> +                             host_page_from_ram_block_offset(block, addr=
));
> +                ret =3D -EINVAL;
> +                break;
>              }
> =20
>              /*
> @@ -3257,16 +3270,11 @@ static int ram_load_postcopy(QEMUFile *f)
>          }
> =20
>          if (!ret && place_needed) {
> -            /* This gets called at the last target page in the host page=
 */
> -            void *place_dest =3D (void *)QEMU_ALIGN_DOWN((uintptr_t)host=
,
> -                                                       block->page_size)=
;
> -
>              if (all_zero) {
> -                ret =3D postcopy_place_page_zero(mis, place_dest,
> -                                               block);
> +                ret =3D postcopy_place_page_zero(mis, host_page, block);
>              } else {
> -                ret =3D postcopy_place_page(mis, place_dest,
> -                                          place_source, block);
> +                ret =3D postcopy_place_page(mis, host_page, place_source=
,
> +                                          block);
>              }
>          }
>      }
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


