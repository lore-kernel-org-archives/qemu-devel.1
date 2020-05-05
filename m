Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4368AC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:53:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08AD0207DD
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJZ/kM8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AD0207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVzt9-0005i6-0v
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVzrK-0004G1-Iv
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:51:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41031
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVzrJ-0003GA-0i
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588693907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jH+XLjnzt2lEz1rZEEqxtFY66bAx2Hlq6qNvPC/A+Y0=;
 b=hJZ/kM8BF0lD3m8ybRFGRN7fKYTNAnuPg22Hgtr52qYYS+q+0vhSy4ftzTRIxlMYqDsYuE
 8raZUfMYs3JqtfhgPmDAMiFL1f15dLNLCXAENlWQObbAwkkeQNFI6hbiozosJOo+Tg236A
 qAwAwS7ozd+wpsLo5gqmNBokp9D8G40=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-j_G6nr4dNoqyErqYdNSmmA-1; Tue, 05 May 2020 11:51:45 -0400
X-MC-Unique: j_G6nr4dNoqyErqYdNSmmA-1
Received: by mail-wm1-f69.google.com with SMTP id o26so1080198wmh.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 08:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j1eZLFI1r578s3+G857KaoHJU270WlW8ISWIwq2ijLk=;
 b=mIUHN4Pi0eK4fvZZpOaLqRgxzoRvJ4K9tXQb+vI/0+xUrHQnCHGJlXv/yGQx4ym8Rl
 zHdMbo07fqAzq2cvpMHqb93l/EBw6Iulg7ivI+Ewlz3cPZXkvap9Vsk+Wcb2SKUhlEEP
 Hq1w8ONQ9OyEOl32Y702yiATx1k5/IwhS+uy6GG2aAa8MQYySEQFJ2qrFWOVV1vkC90X
 1MFpmiI+8wnbjlzNaArCwdCOTibL5pN5siGJdcVN9ROPDBJnMXZpQcBEJaUBEhUfZ+jJ
 JKVlUiinAVryLquqGgRFIAzmEsF+Er5AH6Yafq9APdM95oaYCg+/SUlb96omp5ibiDL0
 1LZw==
X-Gm-Message-State: AGi0PuYEeLHb6nDDhQ9mbf+mfM5UnZPEx9ZIR/CDvn5LmKYsy3329/nl
 4uB1tkd1tsIa0ZZxhwiefb2ZYTzIIOTc2iybPotmb6zCAv6xK/USxE5N87RXzyILLujXbEe5izr
 3zq1e0Zb0Koj0X60=
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr4189067wmc.69.1588693904874; 
 Tue, 05 May 2020 08:51:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypJEq0iHsBrVRgbDOgbRlcKcfziObekTsktTQo6/7yTEsebDQNXv8CzaYPCCBMxLkoYdR5IFKQ==
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr4189051wmc.69.1588693904672; 
 Tue, 05 May 2020 08:51:44 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id 77sm4481397wrc.6.2020.05.05.08.51.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 08:51:44 -0700 (PDT)
Subject: Re: [PATCH 5/6] block/nvme: Align block pages queue to host page size
To: qemu-devel@nongnu.org
References: <20200504094641.4963-1-philmd@redhat.com>
 <20200504094641.4963-6-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <637baf96-2939-fb89-76a3-6db10c4a6c71@redhat.com>
Date: Tue, 5 May 2020 17:51:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200504094641.4963-6-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Keith Busch <keith.busch@intel.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 11:46 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> In nvme_create_queue_pair() we create a page list using
> qemu_blockalign(), then map it with qemu_vfio_dma_map():
>=20
>    q->prp_list_pages =3D qemu_blockalign0(bs, s->page_size * NVME_QUEUE_S=
IZE);
>    r =3D qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
>                          s->page_size * NVME_QUEUE_SIZE, ...);
>=20
> With:
>=20
>    s->page_size =3D MAX(4096, 1 << (12 + ((cap >> 48) & 0xF)));
>=20
> The qemu_vfio_dma_map() documentation says "The caller need
> to make sure the area is aligned to page size". While we use
> multiple s->page_size as alignment, it might be not sufficient
> on some hosts. Use the qemu_real_host_page_size value to be
> sure the host alignment is respected.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Cc: C=C3=A9dric Le Goater <clg@kaod.org>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Laurent Vivier <lvivier@redhat.com>
> ---
>   block/nvme.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index 7b7c0cc5d6..bde0d28b39 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -627,7 +627,7 @@ static int nvme_init(BlockDriverState *bs, const char=
 *device, int namespace,
>  =20
>       s->page_size =3D MAX(4096, 1 << (12 + ((cap >> 48) & 0xF)));
>       s->doorbell_scale =3D (4 << (((cap >> 32) & 0xF))) / sizeof(uint32_=
t);
> -    bs->bl.opt_mem_alignment =3D s->page_size;
> +    bs->bl.opt_mem_alignment =3D MAX(qemu_real_host_page_size, s->page_s=
ize);
>       timeout_ms =3D MIN(500 * ((cap >> 24) & 0xFF), 30000);
>  =20
>       /* Reset device to get a clean state. */
>=20

Please disregard this patch as it is incomplete.


