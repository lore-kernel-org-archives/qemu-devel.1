Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4C6C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4E3206E2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOhJrnt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4E3206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGMA-0003VQ-1t
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:01:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jAGKG-0001vV-QQ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jAGKE-0001XH-Si
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:59:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27209
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jAGKE-0001TL-Oy
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583513989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XPbo67gN6yYaHpgcZWD8eKDjr9PG3n/u8Llc+kDwgEc=;
 b=UOhJrnt5eOzPFXvMuA8WR0c1w0gUSt800cXRZIxHTEclR3oa3e6RQ1nkS84dlqU2sUoKsj
 oKPuN+33aTgD+b9Ql22QpLirp6Q1BBtSqqOa/ScDmSI8aEDHxCkc+laAQPHlcDPuN96TkI
 xtr4+I4zAn4jISuW7zM9bOoHPA/A0G4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-yrd2wUK2Pq67dLVjLbhJ4Q-1; Fri, 06 Mar 2020 11:59:45 -0500
X-MC-Unique: yrd2wUK2Pq67dLVjLbhJ4Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1A818010F6;
 Fri,  6 Mar 2020 16:59:44 +0000 (UTC)
Received: from work-vm (ovpn-116-247.ams2.redhat.com [10.36.116.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA4438D57C;
 Fri,  6 Mar 2020 16:59:37 +0000 (UTC)
Date: Fri, 6 Mar 2020 16:59:35 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 12/13] migration/ram: Use offset_in_ramblock() in
 range checks
Message-ID: <20200306165935.GI3033@work-vm>
References: <20200226155304.60219-1-david@redhat.com>
 <20200226155304.60219-13-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226155304.60219-13-david@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
> We never read or write beyond the used_length of memory blocks when
> migrating. Make this clearer by using offset_in_ramblock() consistently.
>=20
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index ee5c3d5784..5cc9993899 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1309,8 +1309,8 @@ static bool find_dirty_block(RAMState *rs, PageSear=
chStatus *pss, bool *again)
>          *again =3D false;
>          return false;
>      }
> -    if ((((ram_addr_t)pss->page) << TARGET_PAGE_BITS)
> -        >=3D pss->block->used_length) {
> +    if (!offset_in_ramblock(pss->block,
> +                            ((ram_addr_t)pss->page) << TARGET_PAGE_BITS)=
) {
>          /* Didn't find anything in this RAM Block */
>          pss->page =3D 0;
>          pss->block =3D QLIST_NEXT_RCU(pss->block, next);
> @@ -1514,7 +1514,7 @@ int ram_save_queue_pages(const char *rbname, ram_ad=
dr_t start, ram_addr_t len)
>          rs->last_req_rb =3D ramblock;
>      }
>      trace_ram_save_queue_pages(ramblock->idstr, start, len);
> -    if (start+len > ramblock->used_length) {
> +    if (!offset_in_ramblock(ramblock, start + len - 1)) {
>          error_report("%s request overrun start=3D" RAM_ADDR_FMT " len=3D=
"
>                       RAM_ADDR_FMT " blocklen=3D" RAM_ADDR_FMT,
>                       __func__, start, len, ramblock->used_length);
> @@ -3325,8 +3325,8 @@ static void colo_flush_ram_cache(void)
>          while (block) {
>              offset =3D migration_bitmap_find_dirty(ram_state, block, off=
set);
> =20
> -            if (((ram_addr_t)offset) << TARGET_PAGE_BITS
> -                >=3D block->used_length) {
> +            if (!offset_in_ramblock(block,
> +                                    ((ram_addr_t)offset) << TARGET_PAGE_=
BITS)) {
>                  offset =3D 0;
>                  block =3D QLIST_NEXT_RCU(block, next);
>              } else {
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


