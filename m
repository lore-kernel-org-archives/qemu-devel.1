Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299E0C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E93052166E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQiBdlEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93052166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9PAo-000255-5t
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 03:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1j9P9e-0000EE-Cl
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:13:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1j9P9d-0006sS-F6
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:13:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29367
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1j9P9d-0006q4-Ax
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 03:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583309600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1mBnaz0mCEBpN71DEwtXkXBqmLGfYXTDGVbl5aH+grw=;
 b=KQiBdlEiqOYiyFQ3L4Zrpt5JOaDvaNV8Q85oaomEywC/5xqr5jXde8arWR1At5riLafwTn
 n78UuU8OuCHeai6CZQSga7LCGqGiaeHelgx9Ibg7McFdEfOccEjpSHszSX1iw1JxppSujS
 R4uyJlE2aBtH1iMquBvdscEn1uwzAfM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-UEYDcMPBOH6usCA2UympDw-1; Wed, 04 Mar 2020 03:13:19 -0500
X-MC-Unique: UEYDcMPBOH6usCA2UympDw-1
Received: by mail-wm1-f72.google.com with SMTP id d129so536714wmd.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 00:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CWJSsRVzOBoQMTYYqTABgoVY2xa9XWgBbZcEtmX3I4o=;
 b=XvsPkXHPLGasdD0WZhWf8Sy+0NxzNfzzL2RQUVJuQXbAlG5C77oeQd3ubKA+YsYynK
 RbVB6Zia8HvfL1Em1aG8eUYr78eBBhsp9ZN0aSS1QhUj5FqC8cu6eyAtzOGZtZh38gNW
 Lojv6dqU2ezTSvH+4hRmJtpUQVHCLHT4T3g/VsvkqicxFUFrcM7n0PZN80sZa0/Exxzz
 WBCRFH41DzxOiQfTJ4Nnp5uH4vbIwRcwUJm3ML6KqbMOEVFIXpZZd3KxUW5pKUUQjSWa
 YqUR40yFZ2nwXJ+gS4+QWEzelkin+M/q/CA2gAxfkHAl0RXKRpzyw/tMsYd85jW2j3lB
 sNHQ==
X-Gm-Message-State: ANhLgQ2RmbXYuJ4MY7/AgrJ5yBTG3g28RUKaw4yz1yr88t2wtrbrPDkQ
 3bfBLii0A+WQQQC0vrg6aOVxksXRBs6Sum0M2awbLiZ0441NpUwhX6bq2z4fa+LZ4mcjXb8FS8T
 bcNYuigOupEzLnLI=
X-Received: by 2002:a1c:4604:: with SMTP id t4mr2285418wma.164.1583309597985; 
 Wed, 04 Mar 2020 00:13:17 -0800 (PST)
X-Google-Smtp-Source: ADFU+vue20tPLBy8vlOvwtl3wfQbY5WuckZcqmTyiMfZZVYd7+SFaZcUEq9dC2GNwrBwqBmemF5K1Q==
X-Received: by 2002:a1c:4604:: with SMTP id t4mr2285384wma.164.1583309597613; 
 Wed, 04 Mar 2020 00:13:17 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.4.209])
 by smtp.gmail.com with ESMTPSA id j14sm38619493wrn.32.2020.03.04.00.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 00:13:16 -0800 (PST)
Date: Wed, 4 Mar 2020 09:13:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Nick Erdmann <n@nirf.de>
Subject: Re: [PATCH] vhost-vsock: fix error message output
Message-ID: <20200304081314.bwkpny6mumoxqfvh@steredhat>
References: <04df3f47-c93b-1d02-d250-f9bda8dbc0fa@nirf.de>
MIME-Version: 1.0
In-Reply-To: <04df3f47-c93b-1d02-d250-f9bda8dbc0fa@nirf.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 01, 2020 at 01:03:06PM +0100, Nick Erdmann wrote:
> error_setg_errno takes a positive error number, so we should not invert
> errno's sign.
>=20
> Signed-off-by: Nick Erdmann <n@nirf.de>
> ---
>  hw/virtio/vhost-vsock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> index 66da96583b..9f9093e196 100644
> --- a/hw/virtio/vhost-vsock.c
> +++ b/hw/virtio/vhost-vsock.c
> @@ -325,7 +325,7 @@ static void vhost_vsock_device_realize(DeviceState *d=
ev, Error **errp)
>      } else {
>          vhostfd =3D open("/dev/vhost-vsock", O_RDWR);
>          if (vhostfd < 0) {
> -            error_setg_errno(errp, -errno,
> +            error_setg_errno(errp, errno,
>                               "vhost-vsock: failed to open vhost device")=
;
>              return;
>          }

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano


