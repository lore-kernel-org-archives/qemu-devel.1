Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFA0C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A9920728
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfKeZE8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A9920728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRvXU-0001ou-NK
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 06:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jRvWW-0000ys-Eo
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jRvWV-0006R8-Ka
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:25:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20742
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jRvWV-0006A7-1N
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587723929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZE9zaHrDnslFgNCpOz10jETAHDD8bMuyXU6hgEjkWXI=;
 b=JfKeZE8P/pYjCCjQE6aR21dLGac9mviRN55WZ3dcEzWfE8G2Ms4NqHUYB13q25H6JJhSGx
 sLijpEVQGBXXgTWpQxx60nUIacyDmVzpk3Dnd65pn7bjfBXKfmbdB+bnTeI3yiAUIcJryN
 +9shSlmzUnKyXPt4Iq/bTDHWzaymZI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-_olNiLi4NSSG7TsNf6fjHQ-1; Fri, 24 Apr 2020 06:25:28 -0400
X-MC-Unique: _olNiLi4NSSG7TsNf6fjHQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E0EE800FC7;
 Fri, 24 Apr 2020 10:25:27 +0000 (UTC)
Received: from work-vm (ovpn-113-179.ams2.redhat.com [10.36.113.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3E135D70B;
 Fri, 24 Apr 2020 10:25:17 +0000 (UTC)
Date: Fri, 24 Apr 2020 11:25:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 09/13] migration/ram: Consolidate variable reset after
 placement in ram_load_postcopy()
Message-ID: <20200424102514.GD3106@work-vm>
References: <20200421085300.7734-1-david@redhat.com>
 <20200421085300.7734-10-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200421085300.7734-10-david@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> Let's consolidate resetting the variables.
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
> index 2a2165b478..7eca3165c8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3150,7 +3150,7 @@ static int ram_load_postcopy(QEMUFile *f)
>      /* Temporary page that is later 'placed' */
>      void *postcopy_host_page =3D mis->postcopy_tmp_page;
>      void *host_page =3D NULL;
> -    bool all_zero =3D false;
> +    bool all_zero =3D true;
>      int target_pages =3D 0;
> =20
>      while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
> @@ -3176,7 +3176,6 @@ static int ram_load_postcopy(QEMUFile *f)
>          addr &=3D TARGET_PAGE_MASK;
> =20
>          trace_ram_load_postcopy_loop((uint64_t)addr, flags);
> -        place_needed =3D false;
>          if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
>                       RAM_SAVE_FLAG_COMPRESS_PAGE)) {
>              block =3D ram_block_from_stream(f, flags);
> @@ -3204,9 +3203,7 @@ static int ram_load_postcopy(QEMUFile *f)
>               */
>              page_buffer =3D postcopy_host_page +
>                            host_page_offset_from_ram_block_offset(block, =
addr);
> -            /* If all TP are zero then we can optimise the place */
>              if (target_pages =3D=3D 1) {
> -                all_zero =3D true;
>                  host_page =3D host_page_from_ram_block_offset(block, add=
r);
>              } else if (host_page !=3D host_page_from_ram_block_offset(bl=
ock,
>                                                                      addr=
)) {
> @@ -3223,7 +3220,6 @@ static int ram_load_postcopy(QEMUFile *f)
>               */
>              if (target_pages =3D=3D (block->page_size / TARGET_PAGE_SIZE=
)) {
>                  place_needed =3D true;
> -                target_pages =3D 0;
>              }
>              place_source =3D postcopy_host_page;
>          }
> @@ -3300,6 +3296,10 @@ static int ram_load_postcopy(QEMUFile *f)
>                  ret =3D postcopy_place_page(mis, host_page, place_source=
,
>                                            block);
>              }
> +            place_needed =3D false;
> +            target_pages =3D 0;
> +            /* Assume we have a zero page until we detect something diff=
erent */
> +            all_zero =3D true;
>          }
>      }
> =20
> --=20
> 2.25.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


