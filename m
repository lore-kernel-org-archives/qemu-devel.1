Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF28C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046A8206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKRt1tBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046A8206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUA2k-0004ho-4w
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 08:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iUA0w-0004Ae-KN
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:45:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iUA0v-0001qi-Dj
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:45:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46245
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iUA0v-0001qc-9m
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573479952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ARhPkn31aPnd0ZWeUIBEWQhmx3DRB25VIXrq+KL1tmk=;
 b=QKRt1tBY1KucO9GFjx00qnbuq70bA2e5+P6BiowT0zNytmRCCan8E5EGJ6XxIOVcD30VsL
 E2zqqkHUh28zXkOdaKpBn+O+lWoSJIu1wvSGUHioENwWzZiqDn6Pp0JjhC4q8XO+xgnh07
 WbOepGMQi0NZ5ATTFTuGya8+pT01UT4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-XoV0-hlXMyWojRzUR5zBWA-1; Mon, 11 Nov 2019 08:45:48 -0500
Received: by mail-qv1-f70.google.com with SMTP id 41so6288805qvw.5
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 05:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sWFViG7URUjSFfO9JltNDF/AwNvWscH+GBK6FRNjcjI=;
 b=fflR1DFh677eZjzIEde5s1d/DCB5UrPUmRyufNEKp6lrJHeoxTpqnuWRb63MjVKtIi
 dVt8WS+XfKFUSAwF7WIo5Iswycf3XlnIMYOolwlAcfck3zuBY/1bR3+I/PWbpG69btFC
 8ieVrYHz7+UzxReUj6+PzpgW7D3ZjaCK1cHzg4t/Jkk4VKJ3y96KAg2axJ6fR2X6FcEt
 7dhl3ysWi3JTIuee9S4eZppBxSIfEX1WU5pwp73Af17ZlLw9boKWtotmVmjrh4+ShKMW
 XZvxMWMAGCXsSv2Y4x/d6iZd+MN9y5roes85ck69GEyKx3WTbt5NQsTUTMzmdLVp5bR8
 jmqQ==
X-Gm-Message-State: APjAAAU0j5Z1DxrHzWYeJTQOatNr9/IkT6nvfbtBaHxiq2M+he74DMT5
 Q3/T6NBWoxnYznno2g5K6mSkEDm3DTO4EjUcVFKE503g9og6TJAT/Am/W8Oc5/GzQKT6k2l9i3c
 uA0Y5bWuLxdGYOx0=
X-Received: by 2002:a37:62c6:: with SMTP id w189mr9665860qkb.48.1573479948562; 
 Mon, 11 Nov 2019 05:45:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqwx3ktR7IuX9y6fn8MpECZQi5cBlVoE4Xihvx6C0l7vFxekqYtmce8HxdHXG7KZbZa9nxs1YQ==
X-Received: by 2002:a37:62c6:: with SMTP id w189mr9665835qkb.48.1573479948294; 
 Mon, 11 Nov 2019 05:45:48 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id a7sm2472310qka.136.2019.11.11.05.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 05:45:47 -0800 (PST)
Date: Mon, 11 Nov 2019 08:45:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [RFC][PATCH 2/3] docs/specs: Add specification of ivshmem device
 revision 2
Message-ID: <20191111084327-mutt-send-email-mst@kernel.org>
References: <cover.1573477032.git.jan.kiszka@siemens.com>
 <f5996d934d24775160bcedbf28ac975a95d91101.1573477032.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
In-Reply-To: <f5996d934d24775160bcedbf28ac975a95d91101.1573477032.git.jan.kiszka@siemens.com>
X-MC-Unique: XoV0-hlXMyWojRzUR5zBWA-1
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
Cc: liang yan <lyan@suse.com>, Jailhouse <jailhouse-dev@googlegroups.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 11, 2019 at 01:57:11PM +0100, Jan Kiszka wrote:
> +| Offset | Register               | Content                             =
                 |
> +|-------:|:-----------------------|:------------------------------------=
-----------------|
> +|    00h | Vendor ID              | 1AF4h                               =
                 |
> +|    02h | Device ID              | 1110h                               =
                 |

Given it's a virtio vendor ID, please reserve a device ID
with the virtio TC.

Thanks!

--=20
MST


