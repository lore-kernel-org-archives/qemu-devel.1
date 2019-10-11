Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB36ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4325B206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UMRE9ePa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4325B206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIumq-0007nS-Dl
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 09:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iIulu-0007Ge-CX
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iIult-00030h-6Q
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:15:54 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44583)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iIult-0002tO-06
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:15:53 -0400
Received: by mail-wr1-x441.google.com with SMTP id z9so11882714wrl.11
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IQDSHGDUpjTTiA3YFHv/P6F8WWupFZbnrzEiEAU9mjE=;
 b=UMRE9ePaVOfcHSWz4IvfMJLS8eSvXZVwA0N2XK7xIcTux015JllIDuw+5QP3kGMdsJ
 ktJtfOnAa+b2zd0eYobvJDigud55HrrTtv4kXWHm4p0pe3PQIA4rSV5l486J0f08gEAp
 Or78ZLdgf0n33Sgm5AXXOZgj0CPyjBnwRHA8j2MI+UdHJTucXvk/7rnBz1ONgGIZ9uR4
 J0PapXngYc6tmzz0Fue70+ViuhKDkgZdCtKSnEmi+rGDZ4odMjfvDUfzyUtV071vDf+4
 q0+uyqJTAkv6DbS5SlYVEyI2pxp130TRie2nBADm0i24qcb9/QEpz/RylKepnXoe9ey5
 PZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IQDSHGDUpjTTiA3YFHv/P6F8WWupFZbnrzEiEAU9mjE=;
 b=onSuy+GE1q/4rKRTxLR6lQTEM1fjPnTk7M8gBCoH2jo2hNSta3A44iwCTgBTywyQV+
 wyh5QQIhwPKgiMcrZl+25fKiuZoUSrbh8rP26r8BtCX4xUcY0ZzOeqjuPr4+D68sniky
 FYESjGOu841bG5ueyG80hMifJNDjE5c67CBRx5V8lePZk/omseCrlYyEXfTgZG9z22QY
 X0Eh+fZeQZlvfNePwqQzL4CFF72eOHPcR3Jz8Z/MA4hDUQXjvKa1Sxqtc6hSnmKPj/0r
 bxcwxnFzTZtdDSrR2Ex65CZalL3lrtv4wKfw7dMWwV0+vqtlojmyYN1jXqtXwXom4j5N
 S21Q==
X-Gm-Message-State: APjAAAUY2UYV84WLaQpaYNuqULRBKkmVn8BzUXHX0nX9nMUiqfnRH9++
 Nd2Uelb1TWTxrZnXEG1EaEa1Bw==
X-Google-Smtp-Source: APXvYqynhXMt3u6Ny5iTmo2msaqVnrb6ausacEAxSGJB8StSR1b32TUD/agHoTdEzH9RitRdQBz4Dg==
X-Received: by 2002:adf:f6cd:: with SMTP id y13mr645789wrp.164.1570799749325; 
 Fri, 11 Oct 2019 06:15:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u7sm13434433wrp.19.2019.10.11.06.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:15:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9A7741FF87;
 Fri, 11 Oct 2019 14:15:47 +0100 (BST)
References: <20191010180412.26236-1-mst@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [RFC 1/2] virtio: new post_load hook
In-reply-to: <20191010180412.26236-1-mst@redhat.com>
Date: Fri, 11 Oct 2019 14:15:47 +0100
Message-ID: <871rvjmni4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: mikhail.sennikovskii@cloud.ionos.com, dgilbert@redhat.com,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Michael S. Tsirkin <mst@redhat.com> writes:

> Post load hook in virtio vmsd is called early while device is processed,
> and when VirtIODevice core isn't fully initialized.  Most device
> specific code isn't ready to deal with a device in such state, and
> behaves weirdly.
>
> Add a new post_load hook in a device class instead.  Devices should use
> this unless they specifically want to verify the migration stream as
> it's processed, e.g. for bounds checking.
>
> Suggested-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/virtio/virtio.c         | 7 +++++++
>  include/hw/virtio/virtio.h | 6 ++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 527df03bfd..54a46e204c 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2291,6 +2291,13 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, i=
nt version_id)
>      }
>      rcu_read_unlock();
>
> +    if (vdc->post_load) {
> +        ret =3D vdc->post_load(vdev);
> +        if (ret) {
> +            return ret;
> +        }

I see this pattern repeated above because we get early exits on error
but here it seems superfluous. Why not:

    return vdc->_post_load(vdev)

?


> +    }
> +
>      return 0;
>  }
>
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 48e8d04ff6..ca4f9c0bcc 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -158,6 +158,12 @@ typedef struct VirtioDeviceClass {
>       */
>      void (*save)(VirtIODevice *vdev, QEMUFile *f);
>      int (*load)(VirtIODevice *vdev, QEMUFile *f, int version_id);
> +    /* Post load hook in vmsd is called early while device is processed,=
 and
> +     * when VirtIODevice isn't fully initialized.  Devices should use th=
is instead,
> +     * unless they specifically want to verify the migration stream as i=
t's
> +     * processed, e.g. for bounds checking.
> +     */
> +    int (*post_load)(VirtIODevice *vdev);
>      const VMStateDescription *vmsd;
>  } VirtioDeviceClass;


--
Alex Benn=C3=A9e

