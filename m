Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFF2C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 20:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E99206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 20:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUqtc8z/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E99206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYEfe-0008Fe-DL
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 16:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYEea-0006wM-NP
 for qemu-devel@nongnu.org; Mon, 11 May 2020 16:03:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26744
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYEeY-000058-I5
 for qemu-devel@nongnu.org; Mon, 11 May 2020 16:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589227433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RMr9FKzJIvLrY0bKbKAeCdvfEr//mY2ris5St7Uaaco=;
 b=BUqtc8z/z9HMF0m/yFI81c6gCzAq+nXm7In0WSfsJ0xRJ8xSAg2oJ/MGxpw64N+X/Dzjiq
 4XErIPHvgGS5eeki5YAdW5v8QEsLTwUKTTS7GK8/2rEoJRrVbsBOvQDXgthSLTsqwcWUhV
 q9loPbD5dgAIjCJ8DABx0VNXjRuwaF0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-_qaioSmTM2Cys7i2BU9pFw-1; Mon, 11 May 2020 16:03:49 -0400
X-MC-Unique: _qaioSmTM2Cys7i2BU9pFw-1
Received: by mail-wm1-f71.google.com with SMTP id w2so8861561wmc.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 13:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RMr9FKzJIvLrY0bKbKAeCdvfEr//mY2ris5St7Uaaco=;
 b=eTxdXda0649BRQWnED1bGnLeFdUYPJk4lkIaV+/w/DXzWbebrRXIoFgH2TOLc7PdgB
 g+n7yrDCbhq/Gq7082wiXHiHIi7NONHDbBm1V+IUJRbQ5knrri03ZyHxCkZ24zoryq6k
 LZSAhDvUUsN/nxG2cmNih6xVRDwogloBtAA7o4i0sdxCeTaMtSmvWKrXU870iAApHgwS
 w9govkQPMOyJGsyEmeU0Ms1SKZFcQVt7kmYlW39l0cVA208BUOC/MlKCL2cjjZKz1wSz
 CxVXNxZ1PWtMVpAMR/yQ0WAmPQAIKC336+RNRz39FWUFYqWwY5HIEAEfnFlwS6F1WvgR
 oRMw==
X-Gm-Message-State: AGi0PuZrgDCIgr3WfVuLXw9d02JEGQZaSevN/PHuaooCF0+4cqA74OaB
 CRys1Pb0vxo+gCD51QlpZL4s2h0otAU+cjLk42YpQMQAScuFS2QJxYy6UNy6b3s7nYDgGMBEJNy
 NaFCHLlTtdjZoAcU=
X-Received: by 2002:adf:e4cf:: with SMTP id v15mr20442154wrm.43.1589227428069; 
 Mon, 11 May 2020 13:03:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypK1ciI8h807gTMam/ymhqHJQKyTNJ5cvrJEhgCIZave+Ty1FQCDUbTolhkaUPnIQacYfpGi8A==
X-Received: by 2002:adf:e4cf:: with SMTP id v15mr20442134wrm.43.1589227427841; 
 Mon, 11 May 2020 13:03:47 -0700 (PDT)
Received: from [192.168.1.37] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id v131sm876492wmb.27.2020.05.11.13.03.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 13:03:47 -0700 (PDT)
Subject: Re: [PATCH] hostmem: don't use mbind() if host-nodes is epmty
To: Igor Mammedov <imammedo@redhat.com>
References: <20200430154606.6421-1-imammedo@redhat.com>
 <20200504154450.GM5244@habkost.net>
 <34c80b6d-c6f3-3772-140a-4650e2356d25@redhat.com>
 <20200511212442.6e3f4509@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <db2c1505-d5fb-9310-7805-6c3be2435c04@redhat.com>
Date: Mon, 11 May 2020 22:03:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200511212442.6e3f4509@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 01:43:51
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
Cc: berrange@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, mhohmann@physnet.uni-hamburg.de,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/11/20 9:24 PM, Igor Mammedov wrote:
> On Mon, 11 May 2020 18:00:01 +0200
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> Hi Eduardo,
>>
>> On 5/4/20 5:44 PM, Eduardo Habkost wrote:
>>> On Thu, Apr 30, 2020 at 11:46:06AM -0400, Igor Mammedov wrote:
>>>> Since 5.0 QEMU uses hostmem backend for allocating main guest RAM.
>>>> The backend however calls mbind() which is typically NOP
>>>> in case of default policy/absent host-nodes bitmap.
>>>> However when runing in container with black-listed mbind()
>>>> syscall, QEMU fails to start with error
>>>>    "cannot bind memory to host NUMA nodes: Operation not permitted"
>>>> even when user hasn't provided host-nodes to pin to explictly
>>>> (which is the case with -m option)
>>>>
>>>> To fix issue, call mbind() only in case when user has provided
>>>> host-nodes explicitly (i.e. host_nodes bitmap is not empty).
>>>> That should allow to run QEMU in containers with black-listed
>>>> mbind() without memory pinning. If QEMU provided memory-pinning
>>>> is required user still has to white-list mbind() in container
>>>> configuration.
>>>>
>>>> Reported-by: Manuel Hohmann <mhohmann@physnet.uni-hamburg.de>
>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>
>>> Queued on machine-next, thanks!
>>
>> I've been debugging this issue again today and figured it was not
>> merged, if possible can you add the "Cc: qemu-stable@nongnu.org" tag
>> before sending your pull request?
> it's CCed already, so my impression was that will should picked up once it was reviewed.

Correct, however some distributions find easier to grep for the 'Cc: 
qemu-stable@nongnu.org' merged tag before qemu-stable is released.

> 
>>
>> Thanks,
>>
>> Phil.
>>
> 


