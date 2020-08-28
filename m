Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33BAC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 01:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2F7207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 01:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uz8f8IxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2F7207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBT72-0006Ok-Sj
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 21:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kBT5j-0005Ww-Ft
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 21:22:07 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kBT5h-00087b-Oc
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 21:22:07 -0400
Received: by mail-ot1-x341.google.com with SMTP id e23so5324504otk.7
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 18:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KW79MwxpM+c0KATYbRVB0m+ZNmrl2qmRTbaM7H8x0Cg=;
 b=uz8f8IxWOMOBSAIymAXk8W5TVrvCGZbBfHdeO2orEB8r2JRdCIFn2W0HxLv8nlchQ7
 4/FkPAbamuuai32kH0h6nMOsSUQJG96FdJZw2CsXsif1h0X/rKkpVvV8vtQW3ucl7NXz
 1DjIg7F6QN4ianB/lGcHIBxN0Sa3eCbeHr4RcJESDTYwrua48eeaoHsq6lGSWlnXU5rK
 birngvNMzX8Za7G2GXazipJQiFCgSstlmMqYqUDu2t2J26nE0eB564BOXcFH292OoIZ/
 vw9p3QZ1sZCcTlO/tkRX1VjYC49IkYeJPt4h9pT6Gq9+xHAxgRjfHEvARCu8l7A9t9Qa
 oJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KW79MwxpM+c0KATYbRVB0m+ZNmrl2qmRTbaM7H8x0Cg=;
 b=O16bpdjH/ARWbYYQfDourOMVfCq1WN/z4txzJPXf8QXzFSYY2bAbJmrRREScs2Ht/+
 IMLGfkgVk0/pmXsoP/0xQG0XrTXLEm4eX/xu+/J3Z6LfSPrlyjKgPZKLNVXrMVr16hVE
 0QPvg7V+q0XLk25r3VxJeyjFJObH2/TBPHigp0AdYoFHM9J+KDal9+oRK0HWGv0SRR8j
 m1NhyIW7JfiAwudWPjEtbb0pjfKV2bTYFR8cO8sY2W4KNJifQbZmdgR3GJ60ihsvQxvg
 3t8MNF7wwXuTfkBo7okT+FKwImrxqb73nFzGTOJlZtkmfKezie5O6lMhSGcEvY8cohfU
 23eQ==
X-Gm-Message-State: AOAM531miHOhlDWD1SVpJ6fGT5WWObKmgA37ziSsKE2Bhkq0t/K3nsva
 BOJDze95EZXkG1c7J/55pT0Fi++rNRdnwrzY/kM=
X-Google-Smtp-Source: ABdhPJxWUYSWbITYr69UvThoqGWRUJXw2O1amxJ9CN3IlxP7tkYW+AyRsjKr7qQxA1D1IulUx9Ja2+GPgnmeMdENhIQ=
X-Received: by 2002:a9d:788:: with SMTP id 8mr8364307oto.181.1598577724135;
 Thu, 27 Aug 2020 18:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200816142245.17556-1-liq3ea@163.com>
In-Reply-To: <20200816142245.17556-1-liq3ea@163.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 28 Aug 2020 09:21:28 +0800
Message-ID: <CAKXe6SJjrTZ5cW3h227MUpPt8jsPimcrjiN8-WXSbVCZvdkCFg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-mem: detach the element from the virtqueue when
 error occurs
To: Li Qiang <liq3ea@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
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
 Qemu Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kindly ping.

Li Qiang <liq3ea@163.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8816=E6=97=A5=E5=91=
=A8=E6=97=A5 =E4=B8=8B=E5=8D=8810:23=E5=86=99=E9=81=93=EF=BC=9A
>
> If error occurs while processing the virtio request we should call
> 'virtqueue_detach_element' to detach the element from the virtqueue
> before free the elem.
>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
> Change since v1:
> Change the subject
> Avoid using the goto label
>
>  hw/virtio/virtio-mem.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 7740fc613f..e6ffc781b3 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -318,6 +318,7 @@ static void virtio_mem_handle_request(VirtIODevice *v=
dev, VirtQueue *vq)
>          if (iov_to_buf(elem->out_sg, elem->out_num, 0, &req, len) < len)=
 {
>              virtio_error(vdev, "virtio-mem protocol violation: invalid r=
equest"
>                           " size: %d", len);
> +            virtqueue_detach_element(vq, elem, 0);
>              g_free(elem);
>              return;
>          }
> @@ -327,6 +328,7 @@ static void virtio_mem_handle_request(VirtIODevice *v=
dev, VirtQueue *vq)
>              virtio_error(vdev, "virtio-mem protocol violation: not enoug=
h space"
>                           " for response: %zu",
>                           iov_size(elem->in_sg, elem->in_num));
> +            virtqueue_detach_element(vq, elem, 0);
>              g_free(elem);
>              return;
>          }
> @@ -348,6 +350,7 @@ static void virtio_mem_handle_request(VirtIODevice *v=
dev, VirtQueue *vq)
>          default:
>              virtio_error(vdev, "virtio-mem protocol violation: unknown r=
equest"
>                           " type: %d", type);
> +            virtqueue_detach_element(vq, elem, 0);
>              g_free(elem);
>              return;
>          }
> --
> 2.17.1
>
>

