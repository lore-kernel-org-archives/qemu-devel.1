Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB6FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2824F206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qe21vFjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2824F206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgpT2-0006Mc-CG
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 08:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgpSQ-0005tu-SS
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 08:58:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44742
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgpSP-0005hs-9m
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 08:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591275530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=I98Irmyn6MdmRaNbeYergXefR6LuqPsi32iIwH0EGVs=;
 b=Qe21vFjB1pQiLJCFC/YhktNiGLj6tPG54DNIdM32kPoVywRGqAw7StUBq0d8YmW/DRSviv
 X0eTliSxEh/OcdThczZZ0oeU+XLUPBMjNp+qCc4FZTLE2buYfZCusqMcMYKcqCHfrc88st
 RrxbRixdIB2aGCOpYUbagncriQUVOpQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-9_teW_vYN_GK5IeRiW0REQ-1; Thu, 04 Jun 2020 08:58:49 -0400
X-MC-Unique: 9_teW_vYN_GK5IeRiW0REQ-1
Received: by mail-wr1-f71.google.com with SMTP id c14so2387091wrw.11
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 05:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=I98Irmyn6MdmRaNbeYergXefR6LuqPsi32iIwH0EGVs=;
 b=YWX/cYefDLlAFkbkt/hSF8K0Vvwjb4jSkXfDGF++iqBcrc4aeSRLx5bBzk+nnp6olb
 FiDh+1rgBeX9lyFd9UHtueV89wunJi89AtFzaJLqOz1AIrQ625dzcBK/TF9nHbnx6ePu
 7c78LFw8aT7+2RicOAHmz+BayBibvcwRg5oVXmtiGrqA96jNwcH0MxeMs63cJcVmAR9j
 HX/ONQk8xm284DozWQw4CA7y64vf40tyNgEUq1GtWwfJnVisHPuQJ6t84/uPwbkHxs6O
 7CQruOU1QH7SmnPRkANbLKaIq0nveSwKbfiqAFcYil/haOrF6gNc3SAjvU1W28eWFJpM
 0N1w==
X-Gm-Message-State: AOAM533tmh8+qBaHaYvWQjpwfc967/WkCxDTkAw63xPQ4amlwXvB98Gk
 vzIfn1hFihBK+hqIXhUwBx+ANwsy9jgbgXC782Lllpjpxu1kLO9ckHiz7xJuuP7/trc0JzibT3g
 Cah5Wv/jFcLwWon8=
X-Received: by 2002:a05:600c:291e:: with SMTP id
 i30mr3724775wmd.47.1591275525149; 
 Thu, 04 Jun 2020 05:58:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyogVWr743JG2RCJCI2vkjLKUycL+yfMPUIVDkKwqDT4CPY5fr6qHo59Dqa8sEjZxGP/ippwg==
X-Received: by 2002:a05:600c:291e:: with SMTP id
 i30mr3724765wmd.47.1591275524969; 
 Thu, 04 Jun 2020 05:58:44 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id p16sm8500802wru.27.2020.06.04.05.58.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 05:58:44 -0700 (PDT)
Subject: Re: [RFC PATCH] hw/virtio/vhost: re-factor vhost-section and allow
 DIRTY_MEMORY_CODE
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20200604111323.7458-1-alex.bennee@linaro.org>
 <20200604071504-mutt-send-email-mst@kernel.org> <87ftbb59vm.fsf@linaro.org>
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
Message-ID: <0cce5904-fe53-d7ff-93b7-095cded2caf3@redhat.com>
Date: Thu, 4 Jun 2020 14:58:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87ftbb59vm.fsf@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 1:49 PM, Alex Bennée wrote:
> 
> Michael S. Tsirkin <mst@redhat.com> writes:
> 
>> On Thu, Jun 04, 2020 at 12:13:23PM +0100, Alex BennÃ©e wrote:
>>> The purpose of vhost_section is to identify RAM regions that need to
>>> be made available to a vhost client. However when running under TCG
>>> all RAM sections have DIRTY_MEMORY_CODE set which leads to problems
>>> down the line. The original comment implies VGA regions are a problem
>>> but doesn't explain why vhost has a problem with it.
>>>
>>> Re-factor the code so:
>>>
>>>   - steps are clearer to follow
>>>   - reason for rejection is recorded in the trace point
>>>   - we allow DIRTY_MEMORY_CODE when TCG is enabled
>>>
>>> Signed-off-by: Alex BennÃ©e <alex.bennee@linaro.org>
>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>  hw/virtio/vhost.c | 46 ++++++++++++++++++++++++++++++++--------------
>>>  1 file changed, 32 insertions(+), 14 deletions(-)
[...]
>>> +
>>> +    if (memory_region_is_ram(section->mr) && !memory_region_is_rom(section->mr)) {
>>> +        uint8_t dirty_mask = memory_region_get_dirty_log_mask(section->mr);
>>> +        uint8_t handled_dirty;
>>>  
>>> -    if (result && dev->vhost_ops->vhost_backend_mem_section_filter) {
>>> -        result &=
>>> -            dev->vhost_ops->vhost_backend_mem_section_filter(dev, section);
>>> +        /*
>>> +         * Vhost doesn't handle any block which is doing dirty-tracking other
>>> +         * than migration; this typically fires on VGA areas. However
>>> +         * for TCG we also do dirty code page tracking which shouldn't
>>> +         * get in the way.
>>> +         */
>>> +        handled_dirty = (1 << DIRTY_MEMORY_MIGRATION);
>>> +        if (tcg_enabled()) {
>>> +            handled_dirty |= (1 << DIRTY_MEMORY_CODE);
>>> +        }
>>
>> So DIRTY_MEMORY_CODE is only set by TCG right? Thus I'm guessing
>> we can just allow this unconditionally.
> 
> Which actually makes the test:
> 
>   if (dirty_mask & DIRTY_MEMORY_VGA) {

Eh? Shouldn't this be "if (dirty_mask & (1 << DIRTY_MEMORY_VGA))"?

>      .. fail ..
>   }
> 
> which is more in line with the comment although wouldn't fail if we
> added additional DIRTY_MEMORY flags. This leads to the question what
> exactly is it about DIRTY tracking that vhost doesn't like. Is it really
> only avoiding having virtqueue in video RAM? Does this ever actually
> happen?
> 
> I assume boards with unified memory models where video ram is shared
> with system ram just end up partitioning the memory regions?
> 


