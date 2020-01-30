Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A96C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ABA220702
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8ddlPJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABA220702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8rG-0001VM-Mu
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 07:23:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ix8qk-00012s-89
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ix8qj-0001Ih-9l
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:23:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46169
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ix8qj-0001HR-5p
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580386988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fz1FtsP4XHsahPGdM+bDkI1rqdVC9JOqkJC29NIytqM=;
 b=G8ddlPJgHOXSHaBpzbafCm07xBEdVsbDvAO6eKxRIzRyfqEZvi0C56AAqJxrg+q60a4IdH
 t70HG0FAkH7JepCP2t769zq+k0qXeFc48y9EP0xRVvtKx/A1rqmNn/AGJYuAxzGZSVOQyV
 lipKbswpNW40ogMWksD1i2CS1iylJls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-Q1j4dt_0Ph-wcmE9DhDF0Q-1; Thu, 30 Jan 2020 07:23:04 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 110C4107BAFA;
 Thu, 30 Jan 2020 12:23:04 +0000 (UTC)
Received: from gondolin (ovpn-117-199.ams2.redhat.com [10.36.117.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 155C660BE2;
 Thu, 30 Jan 2020 12:22:57 +0000 (UTC)
Date: Thu, 30 Jan 2020 13:22:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 02/29] accel/accel: Make TYPE_ACCEL abstract
Message-ID: <20200130132247.2bd101e3.cohuck@redhat.com>
In-Reply-To: <20200129212345.20547-3-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-3-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Q1j4dt_0Ph-wcmE9DhDF0Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jan 2020 22:23:18 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> There is no generic acceleration, we have to use specific
> implementations. Make the base class abstract.
>=20
> Fixes: b14a0b7469f

Fixes: b14a0b7469fa ("accel: Use QOM classes for accel types")

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  accel/accel.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/accel/accel.c b/accel/accel.c
> index cb555e3b06..a0169b4e69 100644
> --- a/accel/accel.c
> +++ b/accel/accel.c
> @@ -33,6 +33,7 @@
>  static const TypeInfo accel_type =3D {
>      .name =3D TYPE_ACCEL,
>      .parent =3D TYPE_OBJECT,
> +    .abstract =3D true,
>      .class_size =3D sizeof(AccelClass),
>      .instance_size =3D sizeof(AccelState),
>  };

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


