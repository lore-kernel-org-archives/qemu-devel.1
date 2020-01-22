Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE33DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA39624655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSsNjzGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA39624655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuBJq-0007w5-Sn
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 03:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuBJ5-0007FE-4W
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:24:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuBJ3-0006ox-Ua
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:24:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22759
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuBJ3-0006nr-Q5
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579681449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PqMC5ATtymyogmyk9DOIESKGj6xAnGTXxyJxkbqP1fM=;
 b=hSsNjzGj9OgAs754TdWgHjTzC66GTKV9INHM07QVk40dn+kqt8+CFDLRwPrzrd2uDb2CGL
 5qwKGB+4OAZWU0YdOrH5BS65S09ApW0YG1h4wuxUMcLVVs5JABxVeJV2PuDQA6FLAw/FZF
 XzCXfzI7GObby+AaQ6AzaCEI4qoB28U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-8k1579LWOSKB486q1S2HXQ-1; Wed, 22 Jan 2020 03:24:07 -0500
Received: by mail-wm1-f72.google.com with SMTP id g26so1060937wmk.6
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 00:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9CB3c1RgKQtL6GIuLgiLd8m8lbT5ybTkGXxDqzVPwqI=;
 b=s0rnOy5rt+U2mtYMEvyos8qGybr4o9Kqv6QUlc6lcPpWa3bStb3vM/uXwuN1weO3TX
 6IWq+U5Sejxv+nIhhOxSWDy6xD/Ir4JiYDvp7tQsMOqJKsRJSj85cIcjz+JxgkYblCsb
 pM9J1TN3nsOt7jMM94kIxLJd1WMdBJFgbA/Y7k0iW5d4wTHHMwmepqbVR6uo2cG9AQXh
 wDBHUwNuZNrB7Pd5Q2/3Lab45QW7A7WHwRHNkkHA1rxfXtV0L31cGStIBwVEp2nm2sFl
 nvpbwIIkKc+PWvTb+xBkmznIHs1miJafWQb823LqbAonbjTzi0PeVEdzPfBJO3vRQk1g
 Ox4Q==
X-Gm-Message-State: APjAAAV6RpIoazAhn/Hf8F0gArMdupKhGOu2UexjKXdGryVXSD06ayn0
 5+vj2Rgeql+xoSGjhe1RVTRAuxS+ZG4dEY9IsfrJ/vAEXCLvuZZmC116e2hlQmF6tbONdvpf9B3
 puvUNfZkgnJuzcB4=
X-Received: by 2002:a7b:c935:: with SMTP id h21mr1559253wml.173.1579681446230; 
 Wed, 22 Jan 2020 00:24:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqw4pGRQw2MOBdhkwrpfKACw+YIDKNWHU3FopMP3GQ2nRE7TttIAWR9UgHuwDTfrOFfiAUcvkw==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr1559210wml.173.1579681445926; 
 Wed, 22 Jan 2020 00:24:05 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 e6sm58416087wru.44.2020.01.22.00.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 00:24:05 -0800 (PST)
Date: Wed, 22 Jan 2020 03:24:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Stevens <stevensd@chromium.org>
Subject: Re: [virtio-dev][RFC PATCH v2 0/2] Cross-device resource sharing
Message-ID: <20200122032328-mutt-send-email-mst@kernel.org>
References: <CAD=HUj71Z_eQUj93LZYOAc+Prj9ohym1oJtiLWzCy5=T-cNxCQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD=HUj71Z_eQUj93LZYOAc+Prj9ohym1oJtiLWzCy5=T-cNxCQ@mail.gmail.com>
X-MC-Unique: 8k1579LWOSKB486q1S2HXQ-1
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
Cc: virtio-dev@lists.oasis-open.org, Zach Reizner <zachr@chromium.org>,
 Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Alex Lau <alexlau@chromium.org>,
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 22, 2020 at 04:16:15PM +0900, David Stevens wrote:
> This RFC comes from the recent discussion on buffer sharing [1],
> specifically about the need to share resources between different
> virtio devices. For a concrete use case, this can be used to share
> virtio-gpu allocated buffers with the recently proposed virtio video
> device [2], without the need to memcpy decoded frames through the
> guest.
>=20
> [1] https://markmail.org/thread/jeh5xjjxvylyrbur
> [2] https://markmail.org/thread/yb25fim2dqfuktgf


Wrong list- this belongs on virtio-comment.
dev is for implementation discussions.

> Changes v1 -> v2:
> Rename exported resource to exported object
> Rename the virtio-gpu export command
>=20
> David Stevens (2):
>   content: define what an exported object is
>   virtio-gpu: add the ability to export resources
>=20
>  content.tex    | 18 ++++++++++++++++++
>  virtio-gpu.tex | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


