Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEA2C43466
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15A621D95
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Un9oTSY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15A621D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKMrQ-0004AW-RI
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKMmd-0008Pb-5i
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:27:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25778
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKMlz-0003FR-Fp
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600698390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fxF26PZawxWXclAP73zJ+zzwzsdyddAmKCn8EK2rV5I=;
 b=Un9oTSY2rBe1f7NQO+vr4L/qjJsE5ktFMTxRRuZ2LbIvgih3sLoFUIALwyl1emQke2DIrx
 Iu9o/Trjmt/YG5J/54Dk0FwyQh2hIvEvvJDJZRg5cSUJ9xNhg7z+2pC7VVDTntVT+HKBYv
 1e/BVM5Am1vyKPczIhIosJ//VDA2p7E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-_XbBNWccONmaiUV-mAQizw-1; Mon, 21 Sep 2020 10:26:29 -0400
X-MC-Unique: _XbBNWccONmaiUV-mAQizw-1
Received: by mail-wm1-f72.google.com with SMTP id a7so3817360wmc.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 07:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=fxF26PZawxWXclAP73zJ+zzwzsdyddAmKCn8EK2rV5I=;
 b=tkatOoAAY2ViYKCYCTjXF4quDMksA5VlUPmyS5WiJPXvbSd09rsOf9az7+pSC2WV0n
 qkcxdsc1iw2WesnTo+AiHdBst5Lsr9U9rDXFTaRlzgP4DyfOBC3bgqofqzbqPtAJoEI0
 /+pQwlUhIAOPZWzkelRB45h5eihafJldIvL3l9u/3xylDYNKuVsYaKvhuWysB+DYDRSU
 e6NFnu/8S/RKRox7VRaxU9w6epon6qvq/7EWb+opPhxGFinhOrf/HDgetrLtVzyV6e8q
 vIFDCK/6JGeNbmZLbZzxmTK4VcHeEwn0v3RMNHa8rhbFCj0Q5Vb0OWtsp30IUzzCY68j
 vfXw==
X-Gm-Message-State: AOAM533c+rIMJ0XJQPsogy0DiChC4PCqaHksPyO5GIaPR+SDDdfKppik
 hlvvR9EZK+pyy6oOHh7NyQvargehvj0q18mqlx+STmRh5/+Q3KzIo9rlnQ6mm++Urr9eTQhS5e7
 XpSNeYTBvzK+T5hE=
X-Received: by 2002:a7b:c92c:: with SMTP id h12mr92279wml.121.1600698387690;
 Mon, 21 Sep 2020 07:26:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+QC3Ms7ino5DYFx1KPHxaO9aU78mxqzIVnuv+I7d4vqT7xmV77USqAredDdlmYz0rTvYV6g==
X-Received: by 2002:a7b:c92c:: with SMTP id h12mr92262wml.121.1600698387503;
 Mon, 21 Sep 2020 07:26:27 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id m4sm22122689wro.18.2020.09.21.07.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 07:26:26 -0700 (PDT)
Subject: Re: [PATCH 1/2] libvhost-user: return early on virtqueue errors
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200921113420.154378-1-stefanha@redhat.com>
 <20200921113420.154378-2-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <1782531b-37ba-496f-163b-3bfda242b388@redhat.com>
Date: Mon, 21 Sep 2020 16:26:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921113420.154378-2-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 07:01:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 1:34 PM, Stefan Hajnoczi wrote:
> vu_panic() is not guaranteed to exit the program. Return early when
> errors are encountered.
> 
> Note that libvhost-user does not have an "unmap" operation for mapped
> descriptors. Therefore it is correct to return without explicit cleanup.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index 53f16bdf08..27626e629a 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -2407,7 +2407,7 @@ vu_queue_set_notification(VuDev *dev, VuVirtq *vq, int enable)
>      }
>  }
>  
> -static void
> +static bool
>  virtqueue_map_desc(VuDev *dev,
>                     unsigned int *p_num_sg, struct iovec *iov,
>                     unsigned int max_num_sg, bool is_write,
> @@ -2419,7 +2419,7 @@ virtqueue_map_desc(VuDev *dev,
>  
>      if (!sz) {
>          vu_panic(dev, "virtio: zero sized buffers are not allowed");
> -        return;
> +        return false;
>      }
>  
>      while (sz) {
> @@ -2427,13 +2427,13 @@ virtqueue_map_desc(VuDev *dev,
>  
>          if (num_sg == max_num_sg) {
>              vu_panic(dev, "virtio: too many descriptors in indirect table");
> -            return;
> +            return false;
>          }
>  
>          iov[num_sg].iov_base = vu_gpa_to_va(dev, &len, pa);
>          if (iov[num_sg].iov_base == NULL) {
>              vu_panic(dev, "virtio: invalid address for buffers");
> -            return;
> +            return false;
>          }
>          iov[num_sg].iov_len = len;
>          num_sg++;
> @@ -2442,6 +2442,7 @@ virtqueue_map_desc(VuDev *dev,
>      }
>  
>      *p_num_sg = num_sg;
> +    return true;
>  }

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>  static void *
> @@ -2479,6 +2480,7 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
>      if (desc[i].flags & VRING_DESC_F_INDIRECT) {
>          if (desc[i].len % sizeof(struct vring_desc)) {
>              vu_panic(dev, "Invalid size for indirect buffer table");
> +            return NULL;
>          }
>  
>          /* loop over the indirect descriptor table */
> @@ -2506,22 +2508,27 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
>      /* Collect all the descriptors */
>      do {
>          if (desc[i].flags & VRING_DESC_F_WRITE) {
> -            virtqueue_map_desc(dev, &in_num, iov + out_num,
> -                               VIRTQUEUE_MAX_SIZE - out_num, true,
> -                               desc[i].addr, desc[i].len);
> +            if (!virtqueue_map_desc(dev, &in_num, iov + out_num,
> +                                    VIRTQUEUE_MAX_SIZE - out_num, true,
> +                                    desc[i].addr, desc[i].len)) {
> +                return NULL;
> +            }
>          } else {
>              if (in_num) {
>                  vu_panic(dev, "Incorrect order for descriptors");
>                  return NULL;
>              }
> -            virtqueue_map_desc(dev, &out_num, iov,
> -                               VIRTQUEUE_MAX_SIZE, false,
> -                               desc[i].addr, desc[i].len);
> +            if (!virtqueue_map_desc(dev, &out_num, iov,
> +                                    VIRTQUEUE_MAX_SIZE, false,
> +                                    desc[i].addr, desc[i].len)) {
> +                return NULL;
> +            }
>          }
>  
>          /* If we've got too many, that implies a descriptor loop. */
>          if ((in_num + out_num) > max) {
>              vu_panic(dev, "Looped descriptor");
> +            return NULL;
>          }
>          rc = virtqueue_read_next_desc(dev, desc, i, max, &i);
>      } while (rc == VIRTQUEUE_READ_DESC_MORE);
> 


