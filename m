Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0D9C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 20:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D3E2076F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 20:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTJT45+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D3E2076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHD0i-0000NT-RG
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 16:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jHD02-0008NV-KS
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jHD01-0001qg-Hz
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:51:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58251)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jHD01-0001qU-Ev
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 16:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585169500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWJVLk6wUdVFkzfVlzqy85lAAob63kPuuEpMyZeg1JE=;
 b=jTJT45+r145r9Y/nuziCfka9aiNjXAp55RlGHJNVYTaF4G1hBeO+n2Tdoh0fW4gznGkBLx
 L0A7sMQ0ylrsP5sgEWeiBwW9iJlW1PNzCD/ud2xVK908BNLNRyK5XhZZTvhI0BqBThSSrz
 f6rJK0FK0ERSKzb/N16mH5KFpWCzqj4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-64Y-uvwRPFGJo2qr08f_Cw-1; Wed, 25 Mar 2020 16:51:39 -0400
X-MC-Unique: 64Y-uvwRPFGJo2qr08f_Cw-1
Received: by mail-ed1-f70.google.com with SMTP id j10so3114731edy.21
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 13:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x3BHn38rM7OQvkz8Un/aPoLZqgTdjcRI9v+x7jcHAbY=;
 b=qsgb2XaOsBNa75p3SsUQjrkAu6hncvZRj0izDB87ObFn47/gUB3SIiyFLUuME1IUFH
 TQMy0A1e5tehHpI/VQNWc9fvbQbSMXeAFqRPuNbnNkE2jmKXNOBS9RUBLNYkz2AmG/xC
 znpOpSi3onWNkoo8g8XLeLA8rb4NALX5gElf3pgZJKDnyRoPCfxDT/H56fKla5EgsISO
 onioXpx112XxtBgaB+elShowwsDGR8iCDHzPz24B7eY0U7FaI9xGApH3/CixZAzT5mqT
 WdEYcfpD6hV3Bs63jqea6OTvPYRTV1q+Lp6JVV9voob4WPb6A89pEKvIfmWaJpfZ3s+B
 npQg==
X-Gm-Message-State: ANhLgQ3uL5/sj/SJM0A9nPS5wDLxJNEZFiGBkBRx18LNT61lFqpzto7h
 6xlZ1lbrNBFZsu4OU/3V+4CswO2G/bWeOTOpeAM8iJUuAUvuH+w0S4BtjsTAh18YUwBPLQhfE1z
 YvXoiEdIPaX+ww4U=
X-Received: by 2002:aa7:d855:: with SMTP id f21mr5192373eds.366.1585169497617; 
 Wed, 25 Mar 2020 13:51:37 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvl0m8VnM5Bfnv+AWo0CzOSjyV2Qkln4zznWdWejGUpPNtwNRBkSpU6WORe53mnVInySmDeTA==
X-Received: by 2002:aa7:d855:: with SMTP id f21mr5192351eds.366.1585169497427; 
 Wed, 25 Mar 2020 13:51:37 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id c64sm1753158edd.66.2020.03.25.13.51.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2020 13:51:36 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 2/3] virtio: Document virtqueue_pop()
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <20200323112943.12010-1-philmd@redhat.com>
 <20200323112943.12010-3-philmd@redhat.com>
 <CAMxuvazGfXXz0tc4DJpRecW1CYdT5WGO=t7VbjS9hLqhC2rO8Q@mail.gmail.com>
 <CAJ+F1CLwE7uBsryb2oRJH_4Mi_19XaxeSJUipD=M35W48Kz88g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f10101cc-ce81-284f-57bc-55c28da44e87@redhat.com>
Date: Wed, 25 Mar 2020 21:51:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLwE7uBsryb2oRJH_4Mi_19XaxeSJUipD=M35W48Kz88g@mail.gmail.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/25/20 6:50 PM, Marc-Andr=C3=A9 Lureau wrote:
> On Mon, Mar 23, 2020 at 12:55 PM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
>>
>> On Mon, Mar 23, 2020 at 12:30 PM Philippe Mathieu-Daud=C3=A9
>> <philmd@redhat.com> wrote:
>>>
>>> Document that virtqueue_pop() returned memory must be released
>>> with free().
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> nack, hw/virtio/virtio.c uses g_malloc

Indeed... I opened hw/virtio/ and contrib/libvhost-user/ in the geany=20
editor, and when I navigated from virtio.c to the=20
virtqueue_alloc_element() definition I ended in libvhost-user.c:

static void *
virtqueue_alloc_element(size_t sz,
                                      unsigned out_num, unsigned in_num)
{
     VuVirtqElement *elem;
     size_t in_sg_ofs =3D ALIGN_UP(sz, __alignof__(elem->in_sg[0]));
     size_t out_sg_ofs =3D in_sg_ofs + in_num * sizeof(elem->in_sg[0]);
     size_t out_sg_end =3D out_sg_ofs + out_num * sizeof(elem->out_sg[0]);

     assert(sz >=3D sizeof(VuVirtqElement));
     elem =3D malloc(out_sg_end);
     elem->out_num =3D out_num;
     elem->in_num =3D in_num;
     elem->in_sg =3D (void *)elem + in_sg_ofs;
     elem->out_sg =3D (void *)elem + out_sg_ofs;
     return elem;
}

>=20
>>
>>
>>> ---
>>>   include/hw/virtio/virtio.h | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>>> index b69d517496..c6e3bfc500 100644
>>> --- a/include/hw/virtio/virtio.h
>>> +++ b/include/hw/virtio/virtio.h
>>> @@ -199,6 +199,14 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueue=
Element *elem,
>>>                       unsigned int len, unsigned int idx);
>>>
>>>   void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem);
>>> +/**
>>> + * virtqueue_pop:
>>> + * @vq: a VirtQueue queue
>>> + * @sz: the size of struct to return (must be >=3D VirtQueueElement)
>>> + *
>>> + * Returns: a VirtQueueElement filled from the queue or NULL.
>>> + * The returned element must be free()-d by the caller.
>>> + */
>>>   void *virtqueue_pop(VirtQueue *vq, size_t sz);
>>>   unsigned int virtqueue_drop_all(VirtQueue *vq);
>>>   void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, siz=
e_t sz);
>>> --
>>> 2.21.1
>>>
>>
>>
>=20
>=20


