Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA8AC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264312176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPQx0/ew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264312176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihZqp-00016a-6t
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ihZq6-0000Qs-5h
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ihZq2-0004ps-8G
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:58:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42982
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ihZq1-0004ZD-JU
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576677483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=to+nYckjyZPzjza1ahOrP/9nFc/ZIc+LIBKYYGHVQZI=;
 b=fPQx0/ew9OTQMEi1YNIfiEB9iCM+8yjgWw7uDo60CJ2H81R3g0Rd9Tlq9gEf5w10QlBskn
 3Ol3Hv8oOMjTABTtr69+R6wJynMiY4CmQk8/A80EefrKg9B2/n0gETwGPKwJ8fZa/N8UvL
 ALZLwLIolaPV0Vm7jTpnTGWOuwKiE1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-E-yFdpSOOEGBYcS-OouJ-w-1; Wed, 18 Dec 2019 08:58:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDEA992455
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 13:58:00 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63210808E4;
 Wed, 18 Dec 2019 13:57:56 +0000 (UTC)
Date: Wed, 18 Dec 2019 13:57:54 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 2/4] multifd: Make sure that we don't do any IO after an
 error
Message-ID: <20191218135754.GG3707@work-vm>
References: <20191218050439.5989-1-quintela@redhat.com>
 <20191218050439.5989-3-quintela@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191218050439.5989-3-quintela@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: E-yFdpSOOEGBYcS-OouJ-w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

I wonder if the fflush's should happen anyway?

> ---
>  migration/ram.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index db90237977..4b44578e57 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4132,7 +4132,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaq=
ue)
>  {
>      RAMState **temp =3D opaque;
>      RAMState *rs =3D *temp;
> -    int ret;
> +    int ret =3D 0;
>      int i;
>      int64_t t0;
>      int done =3D 0;
> @@ -4203,12 +4203,14 @@ static int ram_save_iterate(QEMUFile *f, void *op=
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
> @@ -4260,9 +4262,11 @@ static int ram_save_complete(QEMUFile *f, void *op=
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
> 2.23.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


