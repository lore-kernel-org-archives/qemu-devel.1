Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA30C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 11:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0DF2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 11:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URrdQZJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0DF2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLmEk-0001s9-T4
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 07:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kLmE4-0001S5-97
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 07:49:20 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:36797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kLmE2-0001tL-6V
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 07:49:19 -0400
Received: by mail-io1-xd42.google.com with SMTP id d190so2377990iof.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 04:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iDELtK3qK5r8ls8Cv6k1wYcYXwjcCP2crHaVJ6o/APE=;
 b=URrdQZJQpravz8+B2EhAY1OyVbYQRxjx6dqbD/rrwVgyJDAVeIWutARkp9cIz7/D19
 oMhyOmGuWBXTpez8YD/o0olAvzBGaj4nxaItTM8JPeuKrnBRDIvUtvXJeu1lxZLFWDor
 Vxgsb4tPZfm7YsPAecTi7C+amMKgUrXEj9JVXRtL/PlrCUcrF5NiSoJDjDRJrMjAL+GQ
 i4VzMqQ90pgi2pumvhuazA9tCNQ63GS3fSRMcRAigvWxSBthOqGbAHJbZBkYy964urGm
 1Me0qPpueQ1Eh3L2KqtNv4K9ii+PL4o2SCky33utGQ7Vd8fVjPBhBg5xyTzWUoGYEvMc
 q2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iDELtK3qK5r8ls8Cv6k1wYcYXwjcCP2crHaVJ6o/APE=;
 b=JVaW4Fmvq1Xp+oc6CaRnpnkAHJH5VdFAOjwuKKHV4cft0LgZ5uVqocYN4sPvyKcF8L
 WMiXXZr1bVY4qSPX4hFwf8Pk+OAt6PAlqZaEjmcXL2ddR49DMLhBLphkObdEZur8/XQr
 dEkn/RqIvIZw1Gvkkt051c4hY/3ManER3EjJrQRBy3nhBAqESl3teY3wzL3TFO7++3MU
 rS+YEf4OJ5II+EqnINXfuXTSPIVsB2sEZFZcatTKzhts1dtSKsRKLNjQuZs6q5ZCyTXS
 w2H2zvk+4njqaad/s3z/MTdpSYFu38f77rvIxEuDH+Red/rWUCDiAoXmPg5idtl8sGwl
 OgOw==
X-Gm-Message-State: AOAM533WTWs8XlhPN9gTUwZ6UUBO88MuxFwJsFEJeJjYKfJo/SSwpU+D
 fgaBVD+w5lR9JMwe7KnP5hWz3xZ/DvZp6WS7kLU=
X-Google-Smtp-Source: ABdhPJyzcCUeZ2uP7hAuWdH3j54nyraLGYoR9GFc9XISgj6So+z5JHeiaAwQwBgj51Zdj+T4BuOw7hxi44Lg0c7mcQE=
X-Received: by 2002:a02:6623:: with SMTP id k35mr2976667jac.105.1601034556180; 
 Fri, 25 Sep 2020 04:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200925102251.7216-1-pankaj.gupta.linux@gmail.com>
 <20200925123837.1733dcdc.cohuck@redhat.com>
In-Reply-To: <20200925123837.1733dcdc.cohuck@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Fri, 25 Sep 2020 13:49:05 +0200
Message-ID: <CAM9Jb+gmKmqVmb+BsNQ5R_rxiwEKBJKhEiO_=j_dYnoLkLC_cQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-pmem-pci: force virtio version 1
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: David Hildenbrand <david@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>
> >  Qemu fails with below error when trying to run with virtio pmem:
> >
> >  (qemu) qemu-system-x86_64: -device virtio-pmem-pci,memdev=mem1,id=nv1:
> >   device is modern-only, use disable-legacy=on
>
> Oh, another one :(
:)
>
> >
> >  This patch fixes this by forcing virtio 1 with virtio-pmem.
> >
> > fixes: adf0748a49 ("virtio-pci: Proxy for virtio-pmem")
> > Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> > ---
> >  hw/virtio/virtio-pmem-pci.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/virtio/virtio-pmem-pci.c b/hw/virtio/virtio-pmem-pci.c
> > index 21a457d151..2b2a0b1eae 100644
> > --- a/hw/virtio/virtio-pmem-pci.c
> > +++ b/hw/virtio/virtio-pmem-pci.c
> > @@ -22,6 +22,7 @@ static void virtio_pmem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> >      VirtIOPMEMPCI *pmem_pci = VIRTIO_PMEM_PCI(vpci_dev);
> >      DeviceState *vdev = DEVICE(&pmem_pci->vdev);
> >
> > +    virtio_pci_force_virtio_1(vpci_dev);
> >      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> >  }
> >
>
> The alternative would be to force virtio 1 only for 5.1 and later (see
> https://lore.kernel.org/qemu-devel/20200921122506.82515-1-sgarzare@redhat.com/).

Thanks for sharing this. It's still good to mark virtio pmem as a
modern virtio device.

Best regards,
Pankaj
>

