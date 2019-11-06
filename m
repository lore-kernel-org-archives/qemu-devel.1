Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13A8C5DF64
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 18:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8B5217D7
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 18:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGyPe42v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8B5217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSPtg-00053n-PP
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 13:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iSPt0-0004bu-P2
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 13:18:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iSPsy-0002hE-BL
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 13:18:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25997
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iSPsx-0002eY-UW
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 13:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573064306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x8QUsa5WH2msLCKZIjBy13LlAgtnfN0Y3xMqDy1B95g=;
 b=jGyPe42vVxj4XN2t3WkhFfnmic9k/XuciURg3GiyszZJOZeriTVGrUeWrTMln499i6OL8x
 aiHhl2AneGNMMzbJ69GjVLHcZrZvOSwFGb+ngUqiUfbU+pTvwuHWwQy2TwNPB8PTaTgVXR
 T+W63YeQ0G4E5dRz27ncd+6axvgXgX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-6CnZLKdHPwSZxpx4QvzNUQ-1; Wed, 06 Nov 2019 13:18:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 421138017DD;
 Wed,  6 Nov 2019 18:18:23 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E8B660872;
 Wed,  6 Nov 2019 18:18:22 +0000 (UTC)
Date: Wed, 6 Nov 2019 18:18:19 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 1/6] migration/postcopy: reduce memset when it is zero
 page and matches_target_page_size
Message-ID: <20191106181819.GG2802@work-vm>
References: <20191018004850.9888-1-richardw.yang@linux.intel.com>
 <20191018004850.9888-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191018004850.9888-2-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 6CnZLKdHPwSZxpx4QvzNUQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> In this case, page_buffer content would not be used.
>=20
> Skip this to save some time.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  migration/ram.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index 99a98b2da4..7938a643d9 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4091,7 +4091,13 @@ static int ram_load_postcopy(QEMUFile *f)
>          switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
>          case RAM_SAVE_FLAG_ZERO:
>              ch =3D qemu_get_byte(f);
> -            memset(page_buffer, ch, TARGET_PAGE_SIZE);
> +            /*
> +             * Can skip to set page_buffer when
> +             * this is a zero page and (block->page_size =3D=3D TARGET_P=
AGE_SIZE).
> +             */

When it's zero we will use place_page_zero which doesn't need
to page_buffer; so yes that's OK; and you're right, the gotcha is with=20
mismatched page sizes where one subpage might be zero but not all of
them; so yes it's right that we need that check.

SO yes,


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> +            if (ch || !matches_target_page_size) {
> +                memset(page_buffer, ch, TARGET_PAGE_SIZE);
> +            }
>              if (ch) {
>                  all_zero =3D false;
>              }
> --=20
> 2.17.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


