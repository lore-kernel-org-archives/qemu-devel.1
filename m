Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71023C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C54C20757
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEEUFoyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C54C20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEBRC-0001H2-FU
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jEBQU-0000fq-Sv
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jEBQT-0002V0-9B
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:34:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48101)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jEBQS-0002Oz-Vh
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584448468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWHzOfIQGW0MJ5alHlJ6a9h3mg0RHml5HycFc5GFPiw=;
 b=YEEUFoygC1/SlIH0qxPH5yfSJ19pkfO57nCZaJbX+SrFAzeAnKkRyHcEAOBpa2Xu2w6WRk
 dT++CEqkqbT7hL2Mbh2YycwOrKkFTDs00ejh1aZG5ArXLmWX4K0hcyDzqFrX6rjtpMrOI1
 WBvAQtJ2768JDbnJkTHrYGbdZKQK1dg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-2_BcEghuOquEiF--E0lEUg-1; Tue, 17 Mar 2020 08:34:26 -0400
X-MC-Unique: 2_BcEghuOquEiF--E0lEUg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4407800D55
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 12:34:25 +0000 (UTC)
Received: from localhost (unknown [10.40.208.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85F3B60BFB;
 Tue, 17 Mar 2020 12:34:21 +0000 (UTC)
Date: Tue, 17 Mar 2020 13:34:18 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH] vl.c/memdev: Error on bad memory backend
Message-ID: <20200317133418.7e084477@redhat.com>
In-Reply-To: <20200317120759.49367-1-dgilbert@redhat.com>
References: <20200317120759.49367-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 12:07:59 +0000
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> If memory-backend is a non-existent object, qemu crashes.
> Check that the backend actually resolves.
>=20
> e.g.   ./qemu-system-x86_64 -machine pc,accel=3Dkvm,memory-backend=3Dfoo

there is a patch to fix it already
 [PATCH] softmmu: fix crash with invalid -M memory-backend=3D
   by Marc-Andr=C3=A9=20

but looks like it fell through cracks ...

>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  softmmu/vl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index ff2685dff8..76507e99c4 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -4288,6 +4288,11 @@ void qemu_init(int argc, char **argv, char **envp)
> =20
>          backend =3D object_resolve_path_type(current_machine->ram_memdev=
_id,
>                                             TYPE_MEMORY_BACKEND, NULL);
> +        if (!backend) {
> +            error_report("Unknown memory backend object id '%s'",
> +                         current_machine->ram_memdev_id);
> +            exit(EXIT_FAILURE);
> +        }
>          backend_size =3D object_property_get_uint(backend, "size",  &err=
or_abort);
>          if (have_custom_ram_size && backend_size !=3D ram_size) {
>                  error_report("Size specified by -m option must match siz=
e of "


