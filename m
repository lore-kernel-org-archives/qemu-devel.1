Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E38C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BACAD205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACAD205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54161 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVyPM-0005o1-LN
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 09:14:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVyOB-0005CQ-Hk
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVyOA-0001HT-F5
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:13:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVyOA-0001Gt-AG
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:13:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id h1so1764366wro.4
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 06:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=bLBhYxmyCOK950suWj6xfv2aF2fm0wHyVz3jTsE1p1Q=;
	b=E32ImGb2LZCfeH2iYH+emPNaBmotiW6yQ1gePgdo6Bumwd78nin2YhJrPiimMGzV2K
	cqn9N14yax5cGoq9zY9WOF/f3MtGGp8uL/7KFiz+6gdW3AiosQVC8zgT1goQdY/IAc7J
	J9OrGNZqvt/WIsP3M2BdicRXGHnJ7jlBzki2J6cgLKET6VkJWTzOrCRh1OsqYrEsEAUf
	nGr+MYv+mNEP8z/ibz96LxzKDLKT+UBMUIbR5wo8VHu6o+vdeoiHFglzMJvWG/AElMjv
	9IIGYM29RQdUR+XneQHt7Pvor64f57bSv14d42JeOBv2WcO5iGOGhoUOJiv7nQAuaoS2
	fUqw==
X-Gm-Message-State: APjAAAX1lh8WZQ7NVtvAUgSMFcKRaU3b3YIgUhKHbHiqKaUORTsHAtI+
	nlsQ1PN7ZagKNgKNgbAq4P8hHg==
X-Google-Smtp-Source: APXvYqyPtXSvUmleH1XId5ibwbmRY1+1pYAMBKCRpo7/mYd4JT0LGGvebL2Fp13qKPpVuOhxBmF/WQ==
X-Received: by 2002:a5d:6807:: with SMTP id w7mr15826749wru.336.1559135585215; 
	Wed, 29 May 2019 06:13:05 -0700 (PDT)
Received: from [10.32.224.40] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
	[159.63.51.90]) by smtp.gmail.com with ESMTPSA id
	r16sm4687534wmh.17.2019.05.29.06.13.03
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 06:13:04 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Jie Wang <wangjie88@huawei.com>, qemu-devel@nongnu.org
References: <1556605773-42019-1-git-send-email-wangjie88@huawei.com>
	<9bacd55b-4333-28fd-18cb-c0dbd771062c@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <43413f68-ef2e-27c3-d6e3-62dc6c7930c3@redhat.com>
Date: Wed, 29 May 2019 15:13:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9bacd55b-4333-28fd-18cb-c0dbd771062c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] vhost: fix incorrect print type
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, mst@redhat.com, wu.wubin@huawei.com,
	eric.fangyi@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-trivial

On 4/30/19 10:48 AM, Philippe Mathieu-Daudé wrote:
> On 4/30/19 8:29 AM, Jie Wang wrote:
>> fix incorrect print type in vhost_virtqueue_stop
>>
>> Signed-off-by: Jie Wang <wangjie88@huawei.com>
>> ---
>>  hw/virtio/vhost.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 7f61018f2a..286bb27c65 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -1081,7 +1081,7 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
>>  
>>      r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
>>      if (r < 0) {
>> -        VHOST_OPS_DEBUG("vhost VQ %d ring restore failed: %d", idx, r);
>> +        VHOST_OPS_DEBUG("vhost VQ %u ring restore failed: %d", idx, r);
> 
> 'idx' is indeed unsigned.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
>>          /* Connection to the backend is broken, so let's sync internal
>>           * last avail idx to the device used idx.
>>           */
>>

