Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8F3C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 09:12:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA85206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 09:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XywyWezs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA85206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icQhn-0007dU-EB
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 04:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1icQZE-00056I-PW
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:03:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1icQZ6-0003m6-6e
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:03:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43314
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1icQZ5-0003ep-V8
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575450198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=q/GC5hiiZzEWashjgVrsrHyJD3yt6cJWQOXOf8YBx+0=;
 b=XywyWezsaUqW8rf626M/kUJ5pl510VLG/9aB4wwwScFP6/3P9xbmjJj3+YntGOMEH+9Dkv
 9xhSyCfoe/IRmIqFYbk/acl1RINBJ0Y5D3jIb+CtZA6kzBbakN2MN0B8LvR1G3qJVbhRrO
 IE87h3V1wvDFgfwY9iQZ6W3gIM1SysA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-idm9q25yNwOU_UhurdUUUQ-1; Wed, 04 Dec 2019 04:03:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78C40802C86;
 Wed,  4 Dec 2019 09:03:15 +0000 (UTC)
Received: from [10.36.117.138] (ovpn-117-138.ams2.redhat.com [10.36.117.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F05E5DA76;
 Wed,  4 Dec 2019 09:03:08 +0000 (UTC)
Subject: Re: [PATCH] virtio-serial-bus: fix memory leak while attach
 virtio-serial-bus
To: pannengyuan <pannengyuan@huawei.com>, mst@redhat.com, amit@kernel.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
References: <1575285343-21864-1-git-send-email-pannengyuan@huawei.com>
 <dad28876-1850-32f3-fe47-9e4ec2c68f20@redhat.com>
 <4e9efebf-1862-8879-ed01-60f8777d4a65@huawei.com>
 <4f535277-0494-7089-eb6f-9daea79463c8@redhat.com>
 <755efa85-b9a2-1cd5-1168-cd3181ac87ea@huawei.com>
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCNMYXVyZW50IFZp
 dmllciA8bHZpdmllckByZWRoYXQuY29tPokCOAQTAQIAIgUCVgVQgAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQ8ww4vT8vvjwpgg//fSGy0Rs/t8cPFuzoY1cex4limJQfReLr
 SJXCANg9NOWy/bFK5wunj+h/RCFxIFhZcyXveurkBwYikDPUrBoBRoOJY/BHK0iZo7/WQkur
 6H5losVZtrotmKOGnP/lJYZ3H6OWvXzdz8LL5hb3TvGOP68K8Bn8UsIaZJoeiKhaNR0sOJyI
 YYbgFQPWMHfVwHD/U+/gqRhD7apVysxv5by/pKDln1I5v0cRRH6hd8M8oXgKhF2+rAOL7gvh
 jEHSSWKUlMjC7YwwjSZmUkL+TQyE18e2XBk85X8Da3FznrLiHZFHQ/NzETYxRjnOzD7/kOVy
 gKD/o7asyWQVU65mh/ECrtjfhtCBSYmIIVkopoLaVJ/kEbVJQegT2P6NgERC/31kmTF69vn8
 uQyW11Hk8tyubicByL3/XVBrq4jZdJW3cePNJbTNaT0d/bjMg5zCWHbMErUib2Nellnbg6bc
 2HLDe0NLVPuRZhHUHM9hO/JNnHfvgiRQDh6loNOUnm9Iw2YiVgZNnT4soUehMZ7au8PwSl4I
 KYE4ulJ8RRiydN7fES3IZWmOPlyskp1QMQBD/w16o+lEtY6HSFEzsK3o0vuBRBVp2WKnssVH
 qeeV01ZHw0bvWKjxVNOksP98eJfWLfV9l9e7s6TaAeySKRRubtJ+21PRuYAxKsaueBfUE7ZT
 7ze0LUxhdXJlbnQgVml2aWVyIChSZWQgSGF0KSA8bHZpdmllckByZWRoYXQuY29tPokCOAQT
 AQIAIgUCVgUmGQIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQ8ww4vT8vvjxtNBAA
 o2xGmbXl9vJQALkj7MVlsMlgewQ1rdoZl+bZ6ythTSBsqwwtl1BUTQGA1GF2LAchRVYca5bJ
 lw4ai5OdZ/rc5dco2XgrRFtj1np703BzNEhGU1EFxtms/Y9YOobq/GZpck5rK8jV4osEb8oc
 3xEgCm/xFwI/2DOe0/s2cHKzRkvdmKWEDhT1M+7UhtSCnloX776zCsrofYiHP2kasFyMa/5R
 9J1Rt9Ax/jEAX5vFJ8+NPf68497nBfrAtLM3Xp03YJSr/LDxer44Mevhz8dFw7IMRLhnuSfr
 8jP93lr6Wa8zOe3pGmFXZWpNdkV/L0HaeKwTyDKKdUDH4U7SBnE1gcDfe9x08G+oDfVhqED8
 qStKCxPYxRUKIdUjGPF3f5oj7N56Q5zZaZkfxeLNTQ13LDt3wGbVHyZxzFc81B+qT8mkm74y
 RbeVSuviPTYjbBQ66GsUgiZZpDUyJ6s54fWqQdJf4VFwd7M/mS8WEejbSjglGHMxMGiBeRik
 Y0+ur5KAF7z0D1KfW1kHO9ImQ0FbEbMbTMf9u2+QOCrSWOz/rj23EwPrCQ2TSRI2fWakMJZ+
 zQZvy+ei3D7lZ09I9BT/GfFkTIONgtNfDxwyMc4v4XyP0IvvZs/YZqt7j3atyTZM0S2HSaZ9
 rXmQYkBt1/u691cZfvy+Tr2xZaDpFcjPkci5Ag0EVgUmGQEQALxSQRbl/QOnmssVDxWhHM5T
 Gxl7oLNJms2zmBpcmlrIsn8nNz0rRyxT460k2niaTwowSRK8KWVDeAW6ZAaWiYjLlTunoKwv
 F8vP3JyWpBz0diTxL5o+xpvy/Q6YU3BNefdq8Vy3rFsxgW7mMSrI/CxJ667y8ot5DVugeS2N
 yHfmZlPGE0Nsy7hlebS4liisXOrN3jFzasKyUws3VXek4V65lHwB23BVzsnFMn/bw/rPliqX
 Gcwl8CoJu8dSyrCcd1Ibs0/Inq9S9+t0VmWiQWfQkz4rvEeTQkp/VfgZ6z98JRW7S6l6eoph
 oWs0/ZyRfOm+QVSqRfFZdxdP2PlGeIFMC3fXJgygXJkFPyWkVElr76JTbtSHsGWbt6xUlYHK
 XWo+xf9WgtLeby3cfSkEchACrxDrQpj+Jt/JFP+q997dybkyZ5IoHWuPkn7uZGBrKIHmBunT
 co1+cKSuRiSCYpBIXZMHCzPgVDjk4viPbrV9NwRkmaOxVvye0vctJeWvJ6KA7NoAURplIGCq
 kCRwg0MmLrfoZnK/gRqVJ/f6adhU1oo6z4p2/z3PemA0C0ANatgHgBb90cd16AUxpdEQmOCm
 dNnNJF/3Zt3inzF+NFzHoM5Vwq6rc1JPjfC3oqRLJzqAEHBDjQFlqNR3IFCIAo4SYQRBdAHB
 CzkM4rWyRhuVABEBAAGJAh8EGAECAAkFAlYFJhkCGwwACgkQ8ww4vT8vvjwg9w//VQrcnVg3
 TsjEybxDEUBm8dBmnKqcnTBFmxN5FFtIWlEuY8+YMiWRykd8Ln9RJ/98/ghABHz9TN8TRo2b
 6WimV64FmlVn17Ri6FgFU3xNt9TTEChqAcNg88eYryKsYpFwegGpwUlaUaaGh1m9OrTzcQy+
 klVfZWaVJ9Nw0keoGRGb8j4XjVpL8+2xOhXKrM1fzzb8JtAuSbuzZSQPDwQEI5CKKxp7zf76
 J21YeRrEW4WDznPyVcDTa+tz++q2S/BpP4W98bXCBIuQgs2m+OflERv5c3Ojldp04/S4NEjX
 EYRWdiCxN7ca5iPml5gLtuvhJMSy36glU6IW9kn30IWuSoBpTkgV7rLUEhh9Ms82VWW/h2Tx
 L8enfx40PrfbDtWwqRID3WY8jLrjKfTdR3LW8BnUDNkG+c4FzvvGUs8AvuqxxyHbXAfDx9o/
 jXfPHVRmJVhSmd+hC3mcQ+4iX5bBPBPMoDqSoLt5w9GoQQ6gDVP2ZjTWqwSRMLzNr37rJjZ1
 pt0DCMMTbiYIUcrhX8eveCJtY7NGWNyxFCRkhxRuGcpwPmRVDwOl39MB3iTsRighiMnijkbL
 XiKoJ5CDVvX5yicNqYJPKh5MFXN1bvsBkmYiStMRbrD0HoY1kx5/VozBtc70OU0EB8Wrv9hZ
 D+Ofp0T3KOr1RUHvCZoLURfFhSQ=
Message-ID: <76651cff-9467-ce3f-a160-a6968b7f040f@redhat.com>
Date: Wed, 4 Dec 2019 10:03:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <755efa85-b9a2-1cd5-1168-cd3181ac87ea@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: idm9q25yNwOU_UhurdUUUQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: liyiting@huawei.com, kuhn.chenqun@huawei.com, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/12/2019 04:02, pannengyuan wrote:
> 
> 
> On 2019/12/3 16:32, Laurent Vivier wrote:
>> On 03/12/2019 01:53, pannengyuan wrote:
>>>
>>>
>>> On 2019/12/2 21:58, Laurent Vivier wrote:
>>>> On 02/12/2019 12:15, pannengyuan@huawei.com wrote:
>>>>> From: PanNengyuan <pannengyuan@huawei.com>
>>>>>
>>>>> ivqs/ovqs/c_ivq/c_ovq is forgot to cleanup in
>>>>> virtio_serial_device_unrealize, the memory leak stack is as bellow:
>>>>>
>>>>> Direct leak of 1290240 byte(s) in 180 object(s) allocated from:
>>>>>     #0 0x7fc9bfc27560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
>>>>>     #1 0x7fc9bed6f015 in g_malloc0 (/usr/lib64/libglib-2.0.so.0+0x50015)
>>>>>     #2 0x5650e02b83e7 in virtio_add_queue /mnt/sdb/qemu-4.2.0-rc0/hw/virtio/virtio.c:2327
>>>>>     #3 0x5650e02847b5 in virtio_serial_device_realize /mnt/sdb/qemu-4.2.0-rc0/hw/char/virtio-serial-bus.c:1089
>>>>>     #4 0x5650e02b56a7 in virtio_device_realize /mnt/sdb/qemu-4.2.0-rc0/hw/virtio/virtio.c:3504
>>>>>     #5 0x5650e03bf031 in device_set_realized /mnt/sdb/qemu-4.2.0-rc0/hw/core/qdev.c:876
>>>>>     #6 0x5650e0531efd in property_set_bool /mnt/sdb/qemu-4.2.0-rc0/qom/object.c:2080
>>>>>     #7 0x5650e053650e in object_property_set_qobject /mnt/sdb/qemu-4.2.0-rc0/qom/qom-qobject.c:26
>>>>>     #8 0x5650e0533e14 in object_property_set_bool /mnt/sdb/qemu-4.2.0-rc0/qom/object.c:1338
>>>>>     #9 0x5650e04c0e37 in virtio_pci_realize /mnt/sdb/qemu-4.2.0-rc0/hw/virtio/virtio-pci.c:1801
>>>>>
>>>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>>>> Signed-off-by: PanNengyuan <pannengyuan@huawei.com>
>>>>> ---
>>>>>  hw/char/virtio-serial-bus.c | 6 ++++++
>>>>>  1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
>>>>> index 3325904..da9019a 100644
>>>>> --- a/hw/char/virtio-serial-bus.c
>>>>> +++ b/hw/char/virtio-serial-bus.c
>>>>> @@ -1126,9 +1126,15 @@ static void virtio_serial_device_unrealize(DeviceState *dev, Error **errp)
>>>>>  {
>>>>>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>>>>      VirtIOSerial *vser = VIRTIO_SERIAL(dev);
>>>>> +    int i;
>>>>>  
>>>>>      QLIST_REMOVE(vser, next);
>>>>>  
>>>>> +    for (i = 0; i <= vser->bus.max_nr_ports; i++) {
>>>>> +        virtio_del_queue(vdev, 2 * i);
>>>>> +        virtio_del_queue(vdev, 2 * i + 1);
>>>>> +    }
>>>>> +
>>>>
>>>> According to virtio_serial_device_realize() and the number of
>>>> virtio_add_queue(), I think you have more queues to delete:
>>>>
>>>>   4 + 2 * vser->bus.max_nr_ports
>>>>
>>>> (for vser->ivqs[0], vser->ovqs[0], vser->c_ivq, vser->c_ovq,
>>>> vser->ivqs[i], vser->ovqs[i]).
>>>>
>>>> Thanks,
>>>> Laurent
>>>>
>>>>
>>> Thanks, but I think the queues is correct, the queues in
>>> virtio_serial_device_realize is as follow:
>>>
>>> // here is 2
>>> vser->ivqs[0] = virtio_add_queue(vdev, 128, handle_input);
>>> vser->ovqs[0] = virtio_add_queue(vdev, 128, handle_output);
>>>
>>> // here is 2
>>> vser->c_ivq = virtio_add_queue(vdev, 32, control_in);
>>> vser->c_ovq = virtio_add_queue(vdev, 32, control_out);
>>>
>>> // here 2 * (max_nr_ports - 1)  ----- i is from 1 to max_nr_ports - 1
>>> for (i = 1; i < vser->bus.max_nr_ports; i++) {
>>>     vser->ivqs[i] = virtio_add_queue(vdev, 128, handle_input);
>>>     vser->ovqs[i] = virtio_add_queue(vdev, 128, handle_output);
>>> }
>>>
>>> so the total queues number is:  2 * (vser->bus.max_nr_ports + 1)
>>>
>>
>> Yes, you're right. A comment in the code would have helped or written
>> clearly like:
>>
>> for (i = 0; i < 2 * (vser->bus.max_nr_ports + 1); i++) {
>>     virtio_del_queue(vdev, i);
>> }
>>
>> Thanks,
>> Laurent
>>
>>
> yes, it would be helpful, Michael S. Tsirkin posted another way to make
> it more clear, I will reuse it in next version.

Yes, the proposition from Michael is much more better.

Thanks,
Laurent


