Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB089C4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8494120781
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J59t/j/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8494120781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGKth-00046z-Mg
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGKsp-0003CO-Eg
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGKso-0004LW-8t
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:04:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:51578)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGKso-0004LI-4v
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584961477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Ig74dzz5S101YH2m7OjZvHoCb6f5iJR941tNAoR4F0=;
 b=J59t/j/G/x3//pygNE8zg4g9+L7pDDQ91DwlKpYMMTn51lRJqKV9d6VXJO/IehCgBIEg0W
 Q3ULpDBviN5ElYtnu6GILN0M5AP91yVc2lezHQ76ZtaCA71Amrh7aDNrU1FAoxt98wF5ve
 8NZh6Pvin9ggWT4xheAo5UEddVDl+5E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-XkoJFUNCOYKowntINIgPZA-1; Mon, 23 Mar 2020 07:04:36 -0400
X-MC-Unique: XkoJFUNCOYKowntINIgPZA-1
Received: by mail-ed1-f71.google.com with SMTP id m24so11251824edq.8
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 04:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h7UE/S47UgdAtUXsbORIuW/u9EYW59EaTTzt6CN0ZFQ=;
 b=FYs9prqM7FxYz+QitEiTDN2X/1wq8n28dE+nu0DYG5v785r96g+4XfbVYEIKRGHvKG
 Ki+KosuDX82vptWQtFN6MQwoJH2tf7K6a7t08vxXdGaUcYapkb6x9v1O5MRsKLj/GkGh
 eg1O0pB/ZuL9P3A1BMrNtCFcNO0rwPUzoUyW8Li7f4uQm+6Thkht5/XLxBTvESdJ5JxY
 E+dQu5EK/tZr50QjJBUENJMps6QHgUJJ/0LvVZeJDI7MQGKg8I0lIzhliXK2kZTOte4G
 iNVgMKRw6HuVVnc3JfS1/pFOv+9yddIVJ/ObqPEbPus6R2WGHeCXIUBvTPvWDa8idUDE
 Ld/Q==
X-Gm-Message-State: ANhLgQ1WXm1jL8O0lLPPkoWtj2wRgXzz/Y9WmYSnEYz3ACJT6R769OVa
 V8XOajeK+K4pbpCOnt/SV2Tby0YMRLZ7WyQqLki976CHqe2TCa/blNH/9TweURpWl2oYpYF4x4r
 a46l14ptjFgM9YTI=
X-Received: by 2002:a50:bb67:: with SMTP id y94mr17499603ede.213.1584961475094; 
 Mon, 23 Mar 2020 04:04:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuV/SVq6MJ4EkAXhODFcUU/NZpU8vGD9yZ/JG7yZ9s8CL/fgaRoDTP2IRPUzvDy6wr+KnzYyw==
X-Received: by 2002:a50:bb67:: with SMTP id y94mr17499579ede.213.1584961474884; 
 Mon, 23 Mar 2020 04:04:34 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id e25sm801535ejl.4.2020.03.23.04.04.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 04:04:34 -0700 (PDT)
Subject: Re: [Qemu-devel] [PULL 5/9] contrib: add vhost-user-gpu
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20190529044020.27003-1-kraxel@redhat.com>
 <20190529044020.27003-6-kraxel@redhat.com>
 <CAFEAcA_+3w+ctCE5Bm_LVNi+xWmgSmOudRsSQp0O5OfWkme7MQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <70362380-a0a8-348f-93b6-bc03f0772d1b@redhat.com>
Date: Mon, 23 Mar 2020 12:04:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_+3w+ctCE5Bm_LVNi+xWmgSmOudRsSQp0O5OfWkme7MQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 11:11 AM, Peter Maydell wrote:
> On Wed, 29 May 2019 at 05:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Add a vhost-user gpu backend, based on virtio-gpu/3d device. It is
>> associated with a vhost-user-gpu device.
>>
>> Various TODO and nice to have items:
>> - multi-head support
>> - crash & resume handling
>> - accelerated rendering/display that avoids the waiting round trips
>> - edid support
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Message-id: 20190524130946.31736-6-marcandre.lureau@redhat.com
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>=20
> Hi; the latest coverity run has spotted a mismatch of
> memory allocate/free, where memory allocated with malloc()
> is freed with g_free():
>=20
>> +static void
>> +vg_handle_cursor(VuDev *dev, int qidx)
>> +{
>> +    VuGpu *g =3D container_of(dev, VuGpu, dev.parent);
>> +    VuVirtq *vq =3D vu_get_queue(dev, qidx);
>> +    VuVirtqElement *elem;
>> +    size_t len;
>> +    struct virtio_gpu_update_cursor cursor;
>> +
>> +    for (;;) {
>> +        elem =3D vu_queue_pop(dev, vq, sizeof(VuVirtqElement));
>=20
> vu_queue_pop() returns memory that must be freed with free()
> (as documented in its API doc-comment; it calls vu_queue_map_desc()
> which calls virtqueue_alloc_element() which calls malloc())...
>=20
>> +        if (!elem) {
>> +            break;
>> +        }
>> +        g_debug("cursor out:%d in:%d\n", elem->out_num, elem->in_num);
>> +
>> +        len =3D iov_to_buf(elem->out_sg, elem->out_num,
>> +                         0, &cursor, sizeof(cursor));
>> +        if (len !=3D sizeof(cursor)) {
>> +            g_warning("%s: cursor size incorrect %zu vs %zu\n",
>> +                      __func__, len, sizeof(cursor));
>> +        } else {
>> +            virtio_gpu_bswap_32(&cursor, sizeof(cursor));
>> +            vg_process_cursor_cmd(g, &cursor);
>> +        }
>> +        vu_queue_push(dev, vq, elem, 0);
>> +        vu_queue_notify(dev, vq);
>> +        g_free(elem);
>=20
> ...but here we free it with g_free(), not free().
>=20
> Coverity spotted this as CID 1421887. The use of vu_queue_pop()
> in vg_handle_ctrl() also seem to have this issue, though Coverity
> hasn't caught that one.
>=20
> Would somebody like to write a patch?

OK.


