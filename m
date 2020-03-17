Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13F1C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:19:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED3920753
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0aWCTMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED3920753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEE0H-0005l4-SB
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jEDuj-0007FK-HN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jEDui-0001m6-Dc
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:13:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:37372)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jEDui-0001ir-8M
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584458031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VXQgEqI7u1+vHQXfFPkilqguRZcam7JP/27YJypzc6Q=;
 b=H0aWCTMg1HO4bnYQ53X1VwcakMTzRo/llUVo7aFu3nvzypbTPKls354m+3s66EdHZ839is
 JqIdsHmPar4i1HGoI2ft+y72K2Bjm2+hB7un10rQ3gm6xHpvweDGFLwc71+e/l5EGQpSe8
 bU610UWen9MOF+E1yDjo2AiRdGQJpJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-aQyz3w4NNtSq-Yg8X655Yw-1; Tue, 17 Mar 2020 11:13:50 -0400
X-MC-Unique: aQyz3w4NNtSq-Yg8X655Yw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59ACE18B9FC6
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 15:13:49 +0000 (UTC)
Received: from office.mammed.net (unknown [10.40.195.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62E3360BF3;
 Tue, 17 Mar 2020 15:13:45 +0000 (UTC)
Date: Tue, 17 Mar 2020 16:13:42 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: pbonzini@redhat.com
Subject: Re: [PATCH] softmmu: fix crash with invalid -M memory-backend=
Message-ID: <20200317161342.53ae8b98@office.mammed.net>
In-Reply-To: <20200309145155.168942-1-marcandre.lureau@redhat.com>
References: <20200309145155.168942-1-marcandre.lureau@redhat.com>
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  9 Mar 2020 15:51:55 +0100
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Fixes: fe64d06afc1c5d895f220c268cfe4d5f1e65d44e ("vl.c: ensure that
> ram_size matches size of machine.memory-backend")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Paolo,

Can you pick up this patch for your pull req?=20

> ---
>  softmmu/vl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 5549f4b619..38e9c404f2 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -4287,6 +4287,11 @@ void qemu_init(int argc, char **argv, char **envp)
> =20
>          backend =3D object_resolve_path_type(current_machine->ram_memdev=
_id,
>                                             TYPE_MEMORY_BACKEND, NULL);
> +        if (!backend) {
> +            error_report("Memory backend '%s' not found",
> +                         current_machine->ram_memdev_id);
> +            exit(EXIT_FAILURE);
> +        }
>          backend_size =3D object_property_get_uint(backend, "size",  &err=
or_abort);
>          if (have_custom_ram_size && backend_size !=3D ram_size) {
>                  error_report("Size specified by -m option must match siz=
e of "


