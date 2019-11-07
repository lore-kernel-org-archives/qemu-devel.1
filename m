Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F66CC5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168B3207FA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgiA2UIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168B3207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSir1-0001YZ-O4
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iSio1-0007yI-N9
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iSinz-0001rG-Bw
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:30:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45653
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iSiny-0001qM-Iv
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573137033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hTEW7RYrw27tu32/8szbs4PszKYgE1CH8kYfT/qNKcg=;
 b=XgiA2UIAJUcxAyYuSuyQ6cPkyQcU66YoSULWDmTLMTe34e6X9nIcEZFTnQHcHegt7Mf0v5
 TDbDhIzc6itsCFcMoVlmRQBJps/Xm8sTPy1qulmAnbfanI7/8UP/XXH62OkLsQGi0EV/HT
 2obkRXsZvywLIK+uIed5U5BybOkAG30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-lMh1sGTVN76OzjOtnirLbA-1; Thu, 07 Nov 2019 09:30:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2B16800EB3;
 Thu,  7 Nov 2019 14:30:28 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E17E75D6D8;
 Thu,  7 Nov 2019 14:30:27 +0000 (UTC)
Date: Thu, 7 Nov 2019 14:30:25 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [Patch v2 5/6] migration/postcopy: enable random order target
 page arrival
Message-ID: <20191107143025.GK2816@work-vm>
References: <20191107123907.29791-1-richardw.yang@linux.intel.com>
 <20191107123907.29791-6-richardw.yang@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191107123907.29791-6-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: lMh1sGTVN76OzjOtnirLbA-1
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
> After using number of target page received to track one host page, we
> could have the capability to handle random order target page arrival in
> one host page.
>=20
> This is a preparation for enabling compress during postcopy.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Yep, that's better

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


> ---
> v2:
>    * use uintptr_t to calculate place_dest
>    * check target pages belongs to the same host page
> ---
>  migration/ram.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index b5759793a9..666ad69284 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4015,7 +4015,7 @@ static int ram_load_postcopy(QEMUFile *f)
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
>      /* Temporary page that is later 'placed' */
>      void *postcopy_host_page =3D mis->postcopy_tmp_page;
> -    void *last_host =3D NULL;
> +    void *this_host =3D NULL;
>      bool all_zero =3D false;
>      int target_pages =3D 0;
> =20
> @@ -4062,24 +4062,26 @@ static int ram_load_postcopy(QEMUFile *f)
>               * that's moved into place later.
>               * The migration protocol uses,  possibly smaller, target-pa=
ges
>               * however the source ensures it always sends all the compon=
ents
> -             * of a host page in order.
> +             * of a host page in one chunk.
>               */
>              page_buffer =3D postcopy_host_page +
>                            ((uintptr_t)host & (block->page_size - 1));
>              /* If all TP are zero then we can optimise the place */
>              if (target_pages =3D=3D 1) {
>                  all_zero =3D true;
> +                this_host =3D (void *)QEMU_ALIGN_DOWN((uintptr_t)host,
> +                                                    block->page_size);
>              } else {
>                  /* not the 1st TP within the HP */
> -                if (host !=3D (last_host + TARGET_PAGE_SIZE)) {
> -                    error_report("Non-sequential target page %p/%p",
> -                                  host, last_host);
> +                if (QEMU_ALIGN_DOWN((uintptr_t)host, block->page_size) !=
=3D
> +                    (uintptr_t)this_host) {
> +                    error_report("Non-same host page %p/%p",
> +                                  host, this_host);
>                      ret =3D -EINVAL;
>                      break;
>                  }
>              }
> =20
> -
>              /*
>               * If it's the last part of a host page then we place the ho=
st
>               * page
> @@ -4090,7 +4092,6 @@ static int ram_load_postcopy(QEMUFile *f)
>              }
>              place_source =3D postcopy_host_page;
>          }
> -        last_host =3D host;
> =20
>          switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
>          case RAM_SAVE_FLAG_ZERO:
> @@ -4143,7 +4144,8 @@ static int ram_load_postcopy(QEMUFile *f)
> =20
>          if (!ret && place_needed) {
>              /* This gets called at the last target page in the host page=
 */
> -            void *place_dest =3D host + TARGET_PAGE_SIZE - block->page_s=
ize;
> +            void *place_dest =3D (void *)QEMU_ALIGN_DOWN((uintptr_t)host=
,
> +                                                       block->page_size)=
;
> =20
>              if (all_zero) {
>                  ret =3D postcopy_place_page_zero(mis, place_dest,
> --=20
> 2.17.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


