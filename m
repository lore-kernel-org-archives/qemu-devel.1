Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E294AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C532078D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zu8RpSGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C532078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAwsu-0008Ok-Vb
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 10:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kAwpT-0003BO-Hy
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:55:11 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kAwpR-0000F0-Vf
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:55:11 -0400
Received: by mail-oi1-x243.google.com with SMTP id z22so1764703oid.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 07:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GJL0mruKKVRO32qiMzIO/kqKr+HXNmSg+Ygwqd+hL5s=;
 b=Zu8RpSGNtrZ1j+hAqCRdOako4Wk4ZiE56wxpSTBitURCfYlA0XlA6iphFfqRjGwumF
 wkglcBlCUjsxRLF9Ghm6fF1b7Tx+BSiPN00YkMEgNGZv05Z6sn6GWiHz0nrokdhVm4bR
 VUdtQsUMsVOAJiYPfts7kKaIKNZUwv8ZdjAuNXdQwq3GUZVp9u+FoO8UO6d+9Xg0ISrE
 tl4mRrfefVSNu9PhqRANUbUunoNdP3zwSt8lqlk1x/7I4i1J4jZvygNBRBDMOl5cpYcy
 pKiDg0lZjcr9TeWWsC6Q02YEVkyoKHZUMFZ5rV8AFYhvUT8oLWCNPmdMhy+RH58fYGXV
 ZcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GJL0mruKKVRO32qiMzIO/kqKr+HXNmSg+Ygwqd+hL5s=;
 b=dRP3emxxztU2ZmP5bPj7C3JiitoyBYrKLW9DJpAz41Sh7mPWTnQFFevcN4b0K588A/
 nPDn7SBBn7PrnMgWo5ZtxHcjTYSlOg7CpJSk4DLHBsRtARnSwIVglrMRbkCaN2gocfuA
 TXrQtCGQ/2neZjZLIV5rZ6FvRYvIZWVY+IAjV5XeiXIM0OnU0iVF8pP45n0nqNk0YuJt
 IgK/hjhBf69t4hR2uJxqEuWlBh4bEbIHtss1o1uAKliGUrCho7+LeV8eCRggWTagvZRT
 qpoeFuC/vE4JRZZ76xtyXfSWmfuSn3hl6VANhzQbCqyYlarBVG7C9b7mWH+xEw6Y8gGy
 VpZg==
X-Gm-Message-State: AOAM530xgyaq25fVgugsqRJpdcjRlVQBhfeCW6RaLncWNs2NGViInZwL
 3+d17yQhG0xdjjsUmo+B8QMXYI3ZOMl5xJUeyCY=
X-Google-Smtp-Source: ABdhPJxJmNeMcDQU4zY7xxf5Va2qrLsujVHPmSykrEAlMfzynQiPrawet47YjSl1jx8QPSuwoUmfGQxL+aUoOxn+Np8=
X-Received: by 2002:aca:1117:: with SMTP id 23mr4191950oir.97.1598453708425;
 Wed, 26 Aug 2020 07:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200821104708.4632-1-lizhijian@cn.fujitsu.com>
In-Reply-To: <20200821104708.4632-1-lizhijian@cn.fujitsu.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 26 Aug 2020 22:54:32 +0800
Message-ID: <CAKXe6S+5M9Ue=y-W+oJDecYuya7oRbfJsVXg_ZkHhkE2jyz+og@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-gpu: fix unmap the already mapped items
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Li Zhijian <lizhijian@cn.fujitsu.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=887:34=E5=86=99=E9=81=93=EF=BC=9A
>
> we go here either (!(*iov)[i].iov_base) or (len !=3D l), so we need to co=
nsider
> to unmap the 'i'th item as well when the 'i'th item is not nil
>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>
> ---
> v2: address Gerd's comments
> ---
>  hw/display/virtio-gpu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 5f0dd7c150..e93f99932a 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -656,6 +656,9 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>              qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map MMIO memor=
y for"
>                            " resource %d element %d\n",
>                            __func__, ab->resource_id, i);
> +            if ((*iov)[i].iov_base) {
> +                i++; /* cleanup the 'i'th map */

Should we also reset (*iov)[i].iov_len to 'len' so the
dma_memory_unmap has the right size?

Thanks,
Li Qiang

> +            }
>              virtio_gpu_cleanup_mapping_iov(g, *iov, i);
>              g_free(ents);
>              *iov =3D NULL;
> --
> 2.17.1
>
>
>
>

