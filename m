Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7070BC35242
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 11:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40217206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 11:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzUP8V/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40217206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuxNB-0003UC-Dw
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 06:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuxMU-0002nI-44
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 06:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuxMT-0004Lk-2N
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 06:42:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26674
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuxMS-0004L4-Up
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 06:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579866172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s+bdSgTBvcVajf1/gwQTIYTl+3Z3aUKK32pYkNec3oA=;
 b=PzUP8V/b8dCxtKy28cKBC2LUK/wXlI0uH4H5YiVi3eXX0L+wJ09DhnWslbpCVBveZEuFcu
 kysjyRJyb3kMSPhHTTEpOR4261gZ+YB7oQgV3Bts1fe3TPVjyHa12sQqKkZTp+WoQyogev
 +Q+46V3LDi9vJGbVQSMHGl3N/zQQPbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-pmlnu-hpMaeIWhPtPC5mbw-1; Fri, 24 Jan 2020 06:42:48 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D552A1088382
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 11:42:47 +0000 (UTC)
Received: from work-vm (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01EDF60BE1;
 Fri, 24 Jan 2020 11:42:45 +0000 (UTC)
Date: Fri, 24 Jan 2020 11:42:43 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 14/21] multifd: Use qemu_target_page_size()
Message-ID: <20200124114243.GL2970@work-vm>
References: <20200123115831.36842-1-quintela@redhat.com>
 <20200123115831.36842-15-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123115831.36842-15-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: pmlnu-hpMaeIWhPtPC5mbw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> We will make it cpu independent.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index 2783dc60f4..14b7cbdbc9 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -882,14 +882,14 @@ static int multifd_recv_unfill_packet(MultiFDRecvPa=
rams *p, Error **errp)
>      for (i =3D 0; i < p->pages->used; i++) {
>          uint64_t offset =3D be64_to_cpu(packet->offset[i]);
> =20
> -        if (offset > (block->used_length - TARGET_PAGE_SIZE)) {
> +        if (offset > (block->used_length - qemu_target_page_size())) {
>              error_setg(errp, "multifd: offset too long %" PRIu64
>                         " (max " RAM_ADDR_FMT ")",
>                         offset, block->max_length);
>              return -1;
>          }
>          p->pages->iov[i].iov_base =3D block->host + offset;
> -        p->pages->iov[i].iov_len =3D TARGET_PAGE_SIZE;
> +        p->pages->iov[i].iov_len =3D qemu_target_page_size();
>      }
> =20
>      return 0;
> @@ -964,7 +964,8 @@ static int multifd_send_pages(QEMUFile *f)
>      p->packet_num =3D multifd_send_state->packet_num++;
>      multifd_send_state->pages =3D p->pages;
>      p->pages =3D pages;
> -    transferred =3D ((uint64_t) pages->used) * TARGET_PAGE_SIZE + p->pac=
ket_len;
> +    transferred =3D ((uint64_t) pages->used) * qemu_target_page_size()
> +                + p->packet_len;
>      qemu_file_update_transfer(f, transferred);
>      ram_counters.multifd_bytes +=3D transferred;
>      ram_counters.transferred +=3D transferred;;
> @@ -985,7 +986,7 @@ static int multifd_queue_page(QEMUFile *f, RAMBlock *=
block, ram_addr_t offset)
>      if (pages->block =3D=3D block) {
>          pages->offset[pages->used] =3D offset;
>          pages->iov[pages->used].iov_base =3D block->host + offset;
> -        pages->iov[pages->used].iov_len =3D TARGET_PAGE_SIZE;
> +        pages->iov[pages->used].iov_len =3D qemu_target_page_size();
>          pages->used++;
> =20
>          if (pages->used < pages->allocated) {
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


