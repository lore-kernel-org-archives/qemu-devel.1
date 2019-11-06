Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BD0C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 20:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56E7D2173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 20:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3Py557d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E7D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSRaU-0003m2-Iu
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 15:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iSRYC-0001l6-1Y
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 15:05:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iSRYA-00037N-W5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 15:05:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57315
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iSRYA-000363-NA
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 15:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573070706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7sj2Obe9Y5oiwh2KMZVJgKr0eN+4Gzr0/ECtf5o8JXo=;
 b=W3Py557dkltExNzWF7ellbNyhjDIZWpbUaVyaEUb/tDCmBvfSgYG2G3BJp29YwANSQwfnD
 V2UjSZZhWnBmvMx2oDiiyNAHuOT6pSGVUZvsferVajzft+l3s3UbDoqVj6vfFyT4jdCnQJ
 7hIxoj2/lx493brsWQqHwntTZauvC+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-qrtKLJXkMryzFm0FS84-mg-1; Wed, 06 Nov 2019 15:05:02 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 083931800D53;
 Wed,  6 Nov 2019 20:05:02 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D64960872;
 Wed,  6 Nov 2019 20:05:01 +0000 (UTC)
Date: Wed, 6 Nov 2019 20:04:58 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 4/6] migration/postcopy: set all_zero to true on the
 first target page
Message-ID: <20191106200458.GK2802@work-vm>
References: <20191018004850.9888-1-richardw.yang@linux.intel.com>
 <20191018004850.9888-5-richardw.yang@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191018004850.9888-5-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: qrtKLJXkMryzFm0FS84-mg-1
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
> For the first target page, all_zero is set to true for this round check.
>=20
> After target_pages introduced, we could leverage this variable instead
> of checking the address offset.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Yes, OK - I find target_pages being incremented before
this point a bit confusing, I think of '0' as the first one.

Still, it's OK:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index 5c05376d8d..b5759793a9 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4067,7 +4067,7 @@ static int ram_load_postcopy(QEMUFile *f)
>              page_buffer =3D postcopy_host_page +
>                            ((uintptr_t)host & (block->page_size - 1));
>              /* If all TP are zero then we can optimise the place */
> -            if (!((uintptr_t)host & (block->page_size - 1))) {
> +            if (target_pages =3D=3D 1) {
>                  all_zero =3D true;
>              } else {
>                  /* not the 1st TP within the HP */
> --=20
> 2.17.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


