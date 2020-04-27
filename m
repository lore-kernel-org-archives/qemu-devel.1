Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5ABC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0F52064A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmmMY2J+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0F52064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT21G-00026y-Vr
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 07:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jT1zi-0000Vt-CW
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jT1zh-00069A-Ix
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:32:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55255
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jT1zh-00068t-3I
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587987132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Fe2SGE05jTtO1HcW5HTJTcnInGvjahvKHdsypY82R0=;
 b=WmmMY2J+Z29nnrXQQmgBNRF50quseo/S17+MSdCHjzRrCMmdSbLavG592n61kYtUA/AUrE
 Eaoe/ViLSrlgr2pXXd9nnjT6+UbZ10n/4dyehRwEgFDpSq0YoS7y/sFdC8/K8MCuPFgCvs
 Q9SmAlMCY7st07tASaNmXhvRd3Qx8as=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-6HxVRWniNX2xU99q_hCjQw-1; Mon, 27 Apr 2020 07:32:10 -0400
X-MC-Unique: 6HxVRWniNX2xU99q_hCjQw-1
Received: by mail-wm1-f71.google.com with SMTP id 71so8535462wmb.8
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 04:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/4ljSgazZ1QljpI19t0LnArsIuH5lDGLnlpw1Az4HbA=;
 b=JD8AnJrLKCJf5v5IRxZIfegwJuiGEeT/BX4tTdp3RW4vbhLBqNJwxd8i71CCCCN+1y
 oi6B2uckpadgmFsujSoeFyvJqtfuRJ0S1Yb9szxVWDJKJJ6gPPo6FgFZ4IkNdsz8Ez/w
 G1KrM3owwgiqIpdd5hCXoS4Dz22ZMjSOX2HejHqHY6u9PKmW+q7belKNAXciR8AffMxz
 A0oB8Y12VT3H1Gr/9OJdg6QgaLABP8FwFRDJwo3vv/7FMEKgfZkmq2kR7kRg9ej1vXxG
 PbA0iJvKMRzXmyt1efcHC+Vi8CLB8BCMei1zY4o2xtMibIdS+RT6zPFRygxbpL73jE+/
 ZzvA==
X-Gm-Message-State: AGi0PuY5Mc7ynbcIsyOMmwpt8vZ6tSmxE4Tnw7MgdOEyCwXzNh7zzHeG
 2ZhjgrTOAjls2Q8hCb+feOvR+8Hlhj3ZiiqZpKI5y3ZxXRrxpgh/GMb2kB7UlLH6Bu1e6y0ADZF
 Sf6vvHChj01jS8yc=
X-Received: by 2002:a1c:4304:: with SMTP id q4mr27615989wma.152.1587987129400; 
 Mon, 27 Apr 2020 04:32:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypKj3OSOX4iMbVyfj8Ez9pSaTebcGpFcKFrriuzQ/BTyF2XpCYVVo7DLbZSlcML6Vn/m4wYHeA==
X-Received: by 2002:a1c:4304:: with SMTP id q4mr27615977wma.152.1587987129254; 
 Mon, 27 Apr 2020 04:32:09 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 e21sm21730777wrc.1.2020.04.27.04.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 04:32:08 -0700 (PDT)
Date: Mon, 27 Apr 2020 07:32:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 3/3] virtio-net: remove VIRTIO_NET_HDR_F_RSC_INFO compat
 handling
Message-ID: <20200427073200-mutt-send-email-mst@kernel.org>
References: <20200427102415.10915-1-cohuck@redhat.com>
 <20200427102415.10915-4-cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200427102415.10915-4-cohuck@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 01:12:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 27, 2020 at 12:24:15PM +0200, Cornelia Huck wrote:
> VIRTIO_NET_HDR_F_RSC_INFO is available in the headers now.
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/net/virtio-net.c | 8 --------
>  1 file changed, 8 deletions(-)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index e85d902588b3..7449570c7123 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -77,14 +77,6 @@
>     tso/gso/gro 'off'. */
>  #define VIRTIO_NET_RSC_DEFAULT_INTERVAL 300000
> =20
> -/* temporary until standard header include it */
> -#if !defined(VIRTIO_NET_HDR_F_RSC_INFO)
> -
> -#define VIRTIO_NET_HDR_F_RSC_INFO  4 /* rsc_ext data in csum_ fields */
> -#define VIRTIO_NET_F_RSC_EXT       61
> -
> -#endif
> -
>  static inline __virtio16 *virtio_net_rsc_ext_num_packets(
>      struct virtio_net_hdr *hdr)
>  {
> --=20
> 2.21.1


