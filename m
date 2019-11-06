Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC6DC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 19:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F1B217D7
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 19:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRJ9QMOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F1B217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSRQj-0005Cu-SA
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 14:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iSRPP-0004lD-HK
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iSRPM-0005Tq-Qy
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:56:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47633
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iSRPM-0005T2-CN
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 14:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573070159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CzmD1g7ESjJxh2Eupbmuqeh1uwNQljARVUh0vrDKG14=;
 b=QRJ9QMOzxdI3Mo4qSb2Eh8uYiRIg/qwxOukd96kwhKz8QGXWOpKgTV1uvIhIP3aOfXjWBo
 atT7TVumwpi8v/MWNQVmdirjF7yvNP2uFeWSV1lmeCGf/qqHZy8BacnDGdSVp5m6nfMdUz
 z+/OC3WNC+OFQtKA5r6Hxv5RpLztmQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-dUo3iznCMl22sYUI1KVQHw-1; Wed, 06 Nov 2019 14:55:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0682B1005502;
 Wed,  6 Nov 2019 19:55:52 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FC8B5D9D6;
 Wed,  6 Nov 2019 19:55:50 +0000 (UTC)
Date: Wed, 6 Nov 2019 19:55:48 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 6/6] migration/postcopy: enable compress during postcopy
Message-ID: <20191106195548.GH2802@work-vm>
References: <20191018004850.9888-1-richardw.yang@linux.intel.com>
 <20191018004850.9888-7-richardw.yang@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191018004850.9888-7-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: dUo3iznCMl22sYUI1KVQHw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
> postcopy requires to place a whole host page, while migration thread
> migrate memory in target page size. This makes postcopy need to collect
> all target pages in one host page before placing via userfaultfd.
>=20
> To enable compress during postcopy, there are two problems to solve:
>=20
>     1. Random order for target page arrival
>     2. Target pages in one host page arrives without interrupt by target
>        page from other host page
>=20
> The first one is handled by previous cleanup patch.
>=20
> This patch handles the second one by:
>=20
>     1. Flush compress thread for each host page
>     2. Wait for decompress thread for before placing host page
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  migration/migration.c | 11 -----------
>  migration/ram.c       | 28 +++++++++++++++++++++++++++-
>  2 files changed, 27 insertions(+), 12 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 3febd0f8f3..72e53e2249 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1000,17 +1000,6 @@ static bool migrate_caps_check(bool *cap_list,
>  #endif
> =20
>      if (cap_list[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
> -        if (cap_list[MIGRATION_CAPABILITY_COMPRESS]) {
> -            /* The decompression threads asynchronously write into RAM
> -             * rather than use the atomic copies needed to avoid
> -             * userfaulting.  It should be possible to fix the decompres=
sion
> -             * threads for compatibility in future.
> -             */
> -            error_setg(errp, "Postcopy is not currently compatible "
> -                       "with compression");
> -            return false;
> -        }
> -

Yes, I think that's safe - as long as the 'compress' gets set on both
sides you should never get a combination of one side trying it and the
other not being capable.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>          /* This check is reasonably expensive, so only when it's being
>           * set the first time, also it's only the destination that needs
>           * special support.
> diff --git a/migration/ram.c b/migration/ram.c
> index da0596411c..1403978d75 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3449,6 +3449,14 @@ static int ram_save_iterate(QEMUFile *f, void *opa=
que)
> =20
>              rs->target_page_count +=3D pages;
> =20
> +            /*
> +             * During postcopy, it is necessary to make sure one whole h=
ost
> +             * page is sent in one chunk.
> +             */
> +            if (migrate_postcopy_ram()) {
> +                flush_compressed_data(rs);
> +            }
> +
>              /*
>               * we want to check in the 1st loop, just in case it was the=
 1st
>               * time and we had to sync the dirty bitmap.
> @@ -4025,6 +4033,7 @@ static int ram_load_postcopy(QEMUFile *f)
>          void *place_source =3D NULL;
>          RAMBlock *block =3D NULL;
>          uint8_t ch;
> +        int len;
> =20
>          addr =3D qemu_get_be64(f);
> =20
> @@ -4042,7 +4051,8 @@ static int ram_load_postcopy(QEMUFile *f)
> =20
>          trace_ram_load_postcopy_loop((uint64_t)addr, flags);
>          place_needed =3D false;
> -        if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE)) {
> +        if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
> +                     RAM_SAVE_FLAG_COMPRESS_PAGE)) {
>              block =3D ram_block_from_stream(f, flags);
> =20
>              host =3D host_from_ram_block_offset(block, addr);
> @@ -4114,6 +4124,17 @@ static int ram_load_postcopy(QEMUFile *f)
>                                           TARGET_PAGE_SIZE);
>              }
>              break;
> +        case RAM_SAVE_FLAG_COMPRESS_PAGE:
> +            all_zero =3D false;
> +            len =3D qemu_get_be32(f);
> +            if (len < 0 || len > compressBound(TARGET_PAGE_SIZE)) {
> +                error_report("Invalid compressed data length: %d", len);
> +                ret =3D -EINVAL;
> +                break;
> +            }
> +            decompress_data_with_multi_threads(f, page_buffer, len);
> +            break;
> +
>          case RAM_SAVE_FLAG_EOS:
>              /* normal exit */
>              multifd_recv_sync_main();
> @@ -4125,6 +4146,11 @@ static int ram_load_postcopy(QEMUFile *f)
>              break;
>          }
> =20
> +        /* Got the whole host page, wait for decompress before placing. =
*/
> +        if (place_needed) {
> +            ret |=3D wait_for_decompress_done();
> +        }
> +
>          /* Detect for any possible file errors */
>          if (!ret && qemu_file_get_error(f)) {
>              ret =3D qemu_file_get_error(f);
> --=20
> 2.17.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


