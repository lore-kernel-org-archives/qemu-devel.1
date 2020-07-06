Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9D8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 12:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83CC206E6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 12:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNSJHR8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83CC206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsQH8-0006IQ-Tj
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 08:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsQGK-0005TG-Ha
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 08:30:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24624
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsQGG-0002Hn-BI
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 08:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594038614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6yOqG5hefrKTG5oiSu+re5PjeBcHmm8gnKoetysJypM=;
 b=KNSJHR8enghvrAD6t4hvpbE+GVAxcX9Ro5QY9u975+FPCxz6sOujcv4SsNSrGZ03AEGIxf
 3+A33pi8/NeOuUzb/x2Fzf4pjcChAjzvdEQADngH3Yc6dJVmfBpTJBbPr/3OPa8qLRlSv7
 Z4Ppx6tb8og45FfhZU4XH64B4iTBPao=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-iYMb-kJXM8aThPt1w2QUXw-1; Mon, 06 Jul 2020 08:30:13 -0400
X-MC-Unique: iYMb-kJXM8aThPt1w2QUXw-1
Received: by mail-wm1-f71.google.com with SMTP id s134so46126146wme.6
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 05:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4RSq671o+WrE4kqJ6/tfWcuHNkkGSxSeucb6UhdCG90=;
 b=dtEsBQVq1jT9RaGKSzL/UpLgO3WkQnCoJePuyp2lDE9oRMUBqYE/VbY6YLSlfMdqFf
 L6+yla8OwtO2B9E03KCMqHmvMdcceGRT0fh3ls+CQfFkVLC7a5DwkGgpwf1MPmb9/C9f
 wHlJccRIZOhNA+cMzjQ9YtueuNZtu5NQkfaIakR6cT0ci1LsO3jMaa5MyuUXtoThgBY2
 0BLJ1Oo4LFc2S3wOyHNdXYX6zIv1BGRq81k8emtc8NZwnVjIKsC2KN76UUqAn+eEk9lI
 ZZq2U0vqOIs+/gcT9JS+g9QJnrMCBZFPbEOQysaRjy0BitWhjys7ZZY7hjvXCmDF710Z
 gKEg==
X-Gm-Message-State: AOAM531PwIUyweD6tw2oj+TbhZP/Jba/nq9DR58yeTe1Tqk4MtT+oKjv
 QaCSGLE6WhdCag/CCBUt4ENJcF79nbtkaT1kQGPmM9z+yS/qL8glskybr9X4n70AJPtkwCYGpcb
 LfkimfgWLA3dUB6c=
X-Received: by 2002:adf:de8d:: with SMTP id w13mr47699725wrl.129.1594038612168; 
 Mon, 06 Jul 2020 05:30:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwsDsTAMujsi3i2JucHs2puK/2XXWJyR/ntqjTUDnmlljTmpKPEEzJBHUXMonUChwqMPfiDg==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr47699690wrl.129.1594038611884; 
 Mon, 06 Jul 2020 05:30:11 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k18sm15166635wrx.34.2020.07.06.05.30.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 05:30:11 -0700 (PDT)
Subject: Re: [PATCH v3 16/16] block/nvme: Use per-queuepair IRQ notifier and
 AIO context
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200704213051.19749-1-philmd@redhat.com>
 <20200704213051.19749-17-philmd@redhat.com>
 <20200706120453.GE342708@stefanha-x1.localdomain>
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
Message-ID: <f7804215-f9dd-39ba-1708-94373aa3f72c@redhat.com>
Date: Mon, 6 Jul 2020 14:30:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200706120453.GE342708@stefanha-x1.localdomain>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/6/20 2:04 PM, Stefan Hajnoczi wrote:
> On Sat, Jul 04, 2020 at 11:30:51PM +0200, Philippe Mathieu-Daudé wrote:
>> @@ -683,6 +676,17 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
>>      s->queues = g_renew(NVMeQueuePair *, s->queues, n + 1);
>>      s->queues[n] = q;
>>      s->nr_queues++;
>> +
>> +    ret = qemu_vfio_pci_init_irq(s->vfio,
>> +                                 &s->queues[n]->irq_notifier,
>> +                                 VFIO_PCI_MSIX_IRQ_INDEX, errp);
>> +    if (ret) {
>> +        goto out_error;
>> +    }
>> +    aio_set_event_notifier(aio_context,
>> +                           &s->queues[n]->irq_notifier,
>> +                           false, nvme_handle_event, nvme_poll_cb);
> 
> s->queues[n] can be replaced with q to make the code easier to read.

Indeed.

> 
>> @@ -784,12 +782,14 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>>          }
>>      }
>>  
>> -    ret = qemu_vfio_pci_init_irq(s->vfio, &s->irq_notifier,
>> +    ret = qemu_vfio_pci_init_irq(s->vfio,
>> +                                 &s->queues[QUEUE_INDEX_ADMIN]->irq_notifier,
>>                                   VFIO_PCI_MSIX_IRQ_INDEX, errp);
> 
> QEMU is setting up only 1 MSI-X vector that is shared by the admin and
> all io queues?
> 
> I'm not very familiar with the VFIO ioctls but I guess this call
> replaces the admin queue's irq_notifier registration with VFIO. So now
> the queue's irq_notifier is signalled on admin cq events. The admin
> irq_notifier is no longer signalled. This seems broken.

I'll look into that. Cc'ing VFIO experts meanwhile...

> 
> If there are multiple irq_notifiers then multiple MSI-X vectors are
> needed.
> 
> Stefan
> 


