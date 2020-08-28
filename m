Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE7CC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 01:22:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B46207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 01:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/49csG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B46207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBT6M-0005my-Py
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 21:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kBT5O-0005G0-Lp
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 21:21:46 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:41319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kBT5N-00086z-1E
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 21:21:46 -0400
Received: by mail-oo1-xc43.google.com with SMTP id x6so1687637ooe.8
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 18:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EX7Ze2xfCBzFjGOIOronxQRybLg8rGgMDRTusRk1w0w=;
 b=V/49csG9beWnz9saa97BHMZxwmNZMnw7o+15fBwb+iWqtp+nHU9P1rlKL4hYHTHoQR
 wrak9fBIDMJyzYTXvMI4+vzYA3M8ODdmIBq4/1Y7sKn1nQ2wSJ/ETsphSvYF5AwwNdok
 KNjH1/l/6tRiFmjwxIJ60liW4Gh0vKB3WvVepZZ5e/9m/TK38juoSHEaO22PHcc08qTL
 bIR4NylyjuZSh3fFL/JoAl3DWEnPjplzrwbYE88+W6ztKoyH5AD/RbziQwKg/VdBoDdX
 6a0gnN2KKdL5RzWr9A/jY+jBwCQtl4CN4ffY4KXfu/EfGwclDBGLpDe/U1xx7hOn2ve8
 tg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EX7Ze2xfCBzFjGOIOronxQRybLg8rGgMDRTusRk1w0w=;
 b=V5Y38/ijagsI/YMdilPIAaMlt8Z1UYZ4ntfu/YE/fPjI9nwQvm+RKXTo624LVVvYd/
 bt/iXL0LH+ZI+TCmvOHIxw8e2VekRroPiorIVuMXNEqhsO01OfuFhl44V4+W+IhS2glv
 XRIUFkT4slJ7HMM51TTGyuxo2iWJnC3cfeN+IWgG/6XMHdBwGcL61912Z+xmqkio/pCy
 8LxqwY8Ec6DcVTSQXuDaAo2NbI/GbdSwaW+deS/MTPUC6Ll39g8Mc9xTc6xhSs1aZJfq
 1MG/iFKd5G4OtTXjAmnMtyZaOuklDGUcy6eKZRKMOptDMI5idTq7ZLXAphySMzpV5OR7
 VkHA==
X-Gm-Message-State: AOAM533hmM/g+Kj+ifGjAEQ1o+2cJix2kyuGUkwU5/agbdUT2eMyWTte
 CKUE7IoK5O+/BxI+9ZUA2c0bEqZhVtsq0Rz64WU=
X-Google-Smtp-Source: ABdhPJzYtF+bFYnMT7txU2gNOmBbxUHazCzJqg5SrCfPRp+V6Oe2K38hgll+D67liimbv/6gQJlf5HeOCGn3x7AJoV4=
X-Received: by 2002:a4a:be0c:: with SMTP id l12mr16408533oop.22.1598577703068; 
 Thu, 27 Aug 2020 18:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200813165125.59928-1-liq3ea@163.com>
In-Reply-To: <20200813165125.59928-1-liq3ea@163.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 28 Aug 2020 09:21:07 +0800
Message-ID: <CAKXe6SL3myrx1XcoOVxkD6RxpDMRiOOVorXQrfPnShC0+Y6WUg@mail.gmail.com>
Subject: Re: [PATCH] hw: virtio-pmem: detach the element fromt the virtqueue
 when error occurs
To: Li Qiang <liq3ea@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc43.google.com
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
Cc: Qemu Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kindly ping.

Li Qiang <liq3ea@163.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8814=E6=97=A5=E5=91=
=A8=E4=BA=94 =E4=B8=8A=E5=8D=8812:52=E5=86=99=E9=81=93=EF=BC=9A
>
> If error occurs while processing the virtio request we should call
> 'virtqueue_detach_element' to detach the element from the virtqueue
> before free the elem.
>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/virtio/virtio-pmem.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
> index 1e0c137497..ddb0125901 100644
> --- a/hw/virtio/virtio-pmem.c
> +++ b/hw/virtio/virtio-pmem.c
> @@ -77,6 +77,7 @@ static void virtio_pmem_flush(VirtIODevice *vdev, VirtQ=
ueue *vq)
>
>      if (req_data->elem.out_num < 1 || req_data->elem.in_num < 1) {
>          virtio_error(vdev, "virtio-pmem request not proper");
> +        virtqueue_detach_element(vq, (VirtQueueElement *)req_data, 0);
>          g_free(req_data);
>          return;
>      }
> --
> 2.17.1
>
>

