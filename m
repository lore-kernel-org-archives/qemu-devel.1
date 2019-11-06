Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D7AC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 20:00:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E232075C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 20:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqNyCVAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E232075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSRTh-0000Z1-CM
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 15:00:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iSRT0-0008UA-HB
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iSRSy-0007r3-5V
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:59:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49440
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iSRSy-0007qU-1n
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573070383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SuZCHrOupDQfKm3qvHStH9j0bthJyB94E/CHpzdao9s=;
 b=GqNyCVAOQj0kdXvDVXNfaDxp8MGNMpGxMkj0l16390dRfUeHlh6BLa0C+wTsaTZbYOuFdo
 rPI9dRQby+L/hdR5mQSqk6snZhrRqNGJjqqP81OjURu3J3Wv++7yEMmd/7dL9kV5yCZ6GQ
 oIofrvkYvuZnzpTPttcfFq3UycabqSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-T4JLAazmO6KC6J5zlKoE2g-1; Wed, 06 Nov 2019 14:59:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A66E8064D1;
 Wed,  6 Nov 2019 19:59:41 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 407F55D9D6;
 Wed,  6 Nov 2019 19:59:40 +0000 (UTC)
Date: Wed, 6 Nov 2019 19:59:37 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 3/6] migration/postcopy: count target page number to
 decide the place_needed
Message-ID: <20191106195937.GJ2802@work-vm>
References: <20191018004850.9888-1-richardw.yang@linux.intel.com>
 <20191018004850.9888-4-richardw.yang@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191018004850.9888-4-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: T4JLAazmO6KC6J5zlKoE2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> In postcopy, it requires to place whole host page instead of target
> page.
>=20
> Currently, it relies on the page offset to decide whether this is the
> last target page. We also can count the target page number during the
> iteration. When the number of target page equals
> (host page size / target page size), this means it is the last target
> page in the host page.
>=20
> This is a preparation for non-ordered target page transmission.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index f59e3fe197..5c05376d8d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4017,6 +4017,7 @@ static int ram_load_postcopy(QEMUFile *f)
>      void *postcopy_host_page =3D mis->postcopy_tmp_page;
>      void *last_host =3D NULL;
>      bool all_zero =3D false;
> +    int target_pages =3D 0;
> =20
>      while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
>          ram_addr_t addr;
> @@ -4051,6 +4052,7 @@ static int ram_load_postcopy(QEMUFile *f)
>                  ret =3D -EINVAL;
>                  break;
>              }
> +            target_pages++;
>              matches_target_page_size =3D block->page_size =3D=3D TARGET_=
PAGE_SIZE;
>              /*
>               * Postcopy requires that we place whole host pages atomical=
ly;
> @@ -4082,8 +4084,10 @@ static int ram_load_postcopy(QEMUFile *f)
>               * If it's the last part of a host page then we place the ho=
st
>               * page
>               */
> -            place_needed =3D (((uintptr_t)host + TARGET_PAGE_SIZE) &
> -                                     (block->page_size - 1)) =3D=3D 0;
> +            if (target_pages =3D=3D (block->page_size / TARGET_PAGE_SIZE=
)) {
> +                place_needed =3D true;
> +                target_pages =3D 0;
> +            }
>              place_source =3D postcopy_host_page;
>          }
>          last_host =3D host;
> --=20
> 2.17.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


