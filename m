Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12CCC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 09:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1712196E
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 09:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFzG8QIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1712196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUp4A-0007Rp-Ue
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 04:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iUp3R-0006tY-Py
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iUp3Q-0008QF-Q4
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:35:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53803
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iUp3Q-0008On-Mw
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 04:35:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573637711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UWAVBjO4TE8spENeGMJIe9SLcP/MQ3d38TnQilLPNhw=;
 b=fFzG8QIa9wPnAqbmzhG97wHYvFrvAnM8i2YoM3xPQLKFKLXf6tiG6V4bEExQkqCkf7v0J+
 YYut2Tb7tHG2F/aqSwlVt+Gs8xi4sXBY+oCs7dhcqWtgtOPAalJHXdSe7K2ieZlBsADquH
 LvsvvHCmw5ACpG8UFX2UfFYI8LTOxB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-yd9Kk5IhN4maSE1aJEjwbQ-1; Wed, 13 Nov 2019 04:35:08 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFED9800590;
 Wed, 13 Nov 2019 09:35:07 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-243.ams2.redhat.com
 [10.36.116.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CB9B28DCA;
 Wed, 13 Nov 2019 09:35:04 +0000 (UTC)
Subject: Re: [PATCH] ahci: zero-initialize port struct
To: Gerd Hoffmann <kraxel@redhat.com>, seabios@seabios.org
References: <20191113091809.31365-1-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <84d3a1aa-bbb2-d831-0abc-fe1169f8a860@redhat.com>
Date: Wed, 13 Nov 2019 10:35:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191113091809.31365-1-kraxel@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: yd9Kk5IhN4maSE1aJEjwbQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/13/19 10:18, Gerd Hoffmann wrote:
> Specifically port->driver.lchs needs clearing, otherwise seabios will

s/driver/drive/

> try interpret whatever random crap happens to be there as disk geometry,
> which may or may not break boot depending on how lucky you are.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  src/hw/ahci.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/src/hw/ahci.c b/src/hw/ahci.c
> index 97a072a1ca81..d45b4307ec68 100644
> --- a/src/hw/ahci.c
> +++ b/src/hw/ahci.c
> @@ -345,6 +345,7 @@ ahci_port_alloc(struct ahci_ctrl_s *ctrl, u32 pnr)
>          warn_noalloc();
>          return NULL;
>      }
> +    memset(port, 0, sizeof(*port));
>      port->pnr =3D pnr;
>      port->ctrl =3D ctrl;
>      port->list =3D memalign_tmp(1024, 1024);
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>


