Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BCCC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:22:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE21820684
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HddmxWFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE21820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is9mK-0000CG-SC
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 13:22:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1is9lU-00088Q-TU
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:21:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1is9lR-0000Gf-27
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:21:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30910
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1is9lQ-0000GA-UG
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579198864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9IgRdZsHjR8wE/bAcN8Wfvtyqipw6ruE8fcINiAlIVA=;
 b=HddmxWFep3AFLvUpZE7zMqMK90DVW13XFpgRGKySw8RV6L96jsuKMp/N3ICWBauPO9Rm7j
 JfmnxVzRS12f1jlbXCGAI1EKjCGkWxi/tPLHhtelmXZmgTFoSy3z1HerynnoUSX8D3hCsH
 rmOY4rAoVOYezBCi60CLjEWITU1jdk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-uQ5WaPZcOKC6sC3UoPlfgw-1; Thu, 16 Jan 2020 13:21:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C3E9107ACC7
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 18:20:59 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5051160C87;
 Thu, 16 Jan 2020 18:20:58 +0000 (UTC)
Date: Thu, 16 Jan 2020 18:20:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 1/5] multifd: Make sure that we don't do any IO after
 an error
Message-ID: <20200116182055.GM3108@work-vm>
References: <20200116154616.11569-1-quintela@redhat.com>
 <20200116154616.11569-2-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200116154616.11569-2-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: uQ5WaPZcOKC6sC3UoPlfgw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index ba6e0eea15..8f9f3bba5b 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3442,7 +3442,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaq=
ue)
>  {
>      RAMState **temp =3D opaque;
>      RAMState *rs =3D *temp;
> -    int ret;
> +    int ret =3D 0;
>      int i;
>      int64_t t0;
>      int done =3D 0;
> @@ -3521,12 +3521,14 @@ static int ram_save_iterate(QEMUFile *f, void *op=
aque)
>      ram_control_after_iterate(f, RAM_CONTROL_ROUND);
> =20
>  out:
> -    multifd_send_sync_main(rs);
> -    qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> -    qemu_fflush(f);
> -    ram_counters.transferred +=3D 8;
> +    if (ret >=3D 0) {
> +        multifd_send_sync_main(rs);
> +        qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> +        qemu_fflush(f);
> +        ram_counters.transferred +=3D 8;
> =20
> -    ret =3D qemu_file_get_error(f);
> +        ret =3D qemu_file_get_error(f);
> +    }
>      if (ret < 0) {
>          return ret;
>      }
> @@ -3578,9 +3580,11 @@ static int ram_save_complete(QEMUFile *f, void *op=
aque)
>          ram_control_after_iterate(f, RAM_CONTROL_FINISH);
>      }
> =20
> -    multifd_send_sync_main(rs);
> -    qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> -    qemu_fflush(f);
> +    if (ret >=3D 0) {
> +        multifd_send_sync_main(rs);
> +        qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> +        qemu_fflush(f);
> +    }
> =20
>      return ret;
>  }
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


