Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CFEC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5D020735
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rz0sX6o0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5D020735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGNLG-0008HT-OX
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 09:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jGNKV-0007rW-Vi
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jGNKV-0008Hz-2o
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:41:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:60800)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jGNKU-0008Hp-Ux
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584970882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2jBHKS3B1faRGiQN25joeqmk9aJVCO9fgr6MQuDfgFk=;
 b=Rz0sX6o0ji77HHQc2DawN0MkoqA02Rtn/SVuUx/QJJGtchovQ+BmNbCJfSAmEptMKBaD24
 eKsTPxSM/V3AOSgKF5V3xY9OTnHILlEGQmgSmssl/KGEelxe9pdoCPmZmPmEDjETHF1nJr
 c+/NqHBoj+Y/Hdmhil3skUVe0CivX9M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-PiAZjChRNFqX9CnFvUcY_A-1; Mon, 23 Mar 2020 09:41:21 -0400
X-MC-Unique: PiAZjChRNFqX9CnFvUcY_A-1
Received: by mail-qv1-f70.google.com with SMTP id z2so759031qvw.7
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 06:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=iVpEbrDp4+ilWZlYRp0JNWmhyIo6pKTfGb+Qh8gsbag=;
 b=CI9tji46hf6qnU6aTS/mYxOwERRPzWoNnV+afKbz7FRvu1d405fr/9Rj3LrcWGFb8D
 SeKJc9Rs3zFHyT+seV0SWwcG3osmNQlm2tjQJuBj5v2ZfqSc79WtM+g4MBbLiH6aP8sk
 5Z6OBd6dhQhkRZnhMsjX8WmC67Hzjhqd0LWG54T3/Sieucrp/fm8n1VVcdUdNM5yhXja
 woolQDskMNXCMoGmsvJtGWpsZ972YxynxfIoZElshd3F8VQloaX6kQx/n4fMRFZNlRK0
 mlcZ5Cw42GuzUURt+mmQrcxr+mwFhY9itEIU3XU+WstbrOJmMewxIwBGk6HRAYzGDiR/
 dN7w==
X-Gm-Message-State: ANhLgQ2FQbf2JBa6BxsnpDlIJnLuAuIuVRWAIXqjXBq4VGCSoMn2BEb5
 Izn/m9bjwZJ5nyJBUyOjpNCmhWlRzx21Xw2MIY7bq6PEGGr+b83Isu2iwCRKC1AITuDQSz9HmDn
 3OBJiPuzBfr90SmY=
X-Received: by 2002:ac8:2c51:: with SMTP id e17mr20153141qta.290.1584970880560; 
 Mon, 23 Mar 2020 06:41:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtaTCFg0oxspA+vYhzil2vhGqkLI3W6XYSlGIIBDK8T+pPGee3AfZJTngGROtLRiXaYAuwYsA==
X-Received: by 2002:ac8:2c51:: with SMTP id e17mr20153119qta.290.1584970880284; 
 Mon, 23 Mar 2020 06:41:20 -0700 (PDT)
Received: from redhat.com (bzq-109-65-52-82.red.bezeqint.net. [109.65.52.82])
 by smtp.gmail.com with ESMTPSA id
 z43sm12279246qtb.92.2020.03.23.06.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 06:41:19 -0700 (PDT)
Date: Mon, 23 Mar 2020 09:41:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 0/3] virtio, vhost-gpu: Release memory returned by
 malloc() with free()
Message-ID: <20200323094104-mutt-send-email-mst@kernel.org>
References: <20200323112943.12010-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200323112943.12010-1-philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 23, 2020 at 12:29:40PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Coverity reported a ALLOC_FREE_MISMATCH in vg_handle_cursor(),
> because the memory returned by vu_queue_pop() is allocated with
> malloc(). Fix it.
>=20
> Similar error occurs with virtio. Document and fix.

I will queue this. Thanks!

> Philippe Mathieu-Daud=E9 (3):
>   vhost-user-gpu: Release memory returned by vu_queue_pop() with free()
>   virtio: Document virtqueue_pop()
>   virtio-gpu: Release memory returned by virtqueue_pop() with free()
>=20
>  include/hw/virtio/virtio.h              | 8 ++++++++
>  contrib/vhost-user-gpu/vhost-user-gpu.c | 4 ++--
>  contrib/vhost-user-gpu/virgl.c          | 2 +-
>  hw/display/virtio-gpu-3d.c              | 2 +-
>  hw/display/virtio-gpu.c                 | 8 ++++----
>  5 files changed, 16 insertions(+), 8 deletions(-)
>=20
> --=20
> 2.21.1


