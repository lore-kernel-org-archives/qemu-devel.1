Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC8FC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 298972078D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ho4QiDdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298972078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8QRw-0005lu-Fg
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 11:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8QRF-0005GT-3x
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:55:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46408
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8QRD-0004jC-76
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597852541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OwvkBiEiyOu9HdL520ekUZwmF/ccL6t6lDgDsQllKeE=;
 b=ho4QiDdCMz1Ku0CG1opsTL/3uOhzvfHfgeQtxq5w/Mbv+R1eIpOYtHPKoJWuxieVhnrU7B
 ZphiHcjeSxSE0Byh4wj3dfl7+aFv1Nc3IUEop7iYHsuA5zaoEsVhMQxkYbY/fEBI2cy69L
 g+aKrj+frGVA4o6mnzQOSSNyPTBfRYs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-Zkh2WJZFPDmjQO1z0xJlJg-1; Wed, 19 Aug 2020 11:55:38 -0400
X-MC-Unique: Zkh2WJZFPDmjQO1z0xJlJg-1
Received: by mail-wm1-f70.google.com with SMTP id h7so1080476wmm.7
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 08:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=6h+gida0+5vFiB4i6es9WgtWNsJle+TN/LxhkRuA9Iw=;
 b=TibRKopE5t9u3C5Ki3IqTKtAmwNMdD7M9aqQFizFj7XJHSaRCY70q60v10RxwUGgak
 gfW80hKJTxIXkZY0JBVA5s22Xzn6dgCpwDR7j4/84GNMm167btrnb66tO//MB0hgsOgW
 C+b0uF8x6TfNB7TUtqDpn/ZoozBSNBgXrkwdvfHe46ftGVgKVnZ/0fQ/sxknc4zGP52C
 oVCZRUcl24jE2RSGiJuh2eBzufcsUECKYoiNRfdNCECrVr7myjcKWBGHZNYD7iXpVyc/
 M48PfJyDu+Rx7McTUZ45GEw6T9NvcCzzUwmC/zwF7bJpXVbssE5lNbHyA2bAzlJ2IgkZ
 VJig==
X-Gm-Message-State: AOAM532KGHB1eZ0iXSTwSPHtG6rmGQhDRjFYodLJUD6JhTqWOcuDmsW6
 HKxZ5VHMSL8EGbBK7mpkkmBEFIy+ugIT5fZzhcH8RlSciQylU2YiBGCpBBcIcHQIoPIt4Zfmjwz
 VnWXVVnqEMlTDtKA=
X-Received: by 2002:a7b:cd09:: with SMTP id f9mr5236137wmj.184.1597852537426; 
 Wed, 19 Aug 2020 08:55:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxP6cy2v1BwSQoywmxKx68GuB4OXl+bYvKbB6LHKwmiYKt3EVTBgVsPsFgbEvHIDai5EkC6eQ==
X-Received: by 2002:a7b:cd09:: with SMTP id f9mr5236120wmj.184.1597852537159; 
 Wed, 19 Aug 2020 08:55:37 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id j24sm45011186wrb.49.2020.08.19.08.55.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 08:55:36 -0700 (PDT)
Subject: Re: [RFC PATCH v3 1/5] block/nvme: Use an array of EventNotifier
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200818164509.736367-1-philmd@redhat.com>
 <20200818164509.736367-2-philmd@redhat.com>
 <20200819080852.GA339340@stefanha-x1.localdomain>
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
Message-ID: <93bef7bd-98fa-4f54-4615-1aae0c534257@redhat.com>
Date: Wed, 19 Aug 2020 17:55:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819080852.GA339340@stefanha-x1.localdomain>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/20 10:08 AM, Stefan Hajnoczi wrote:
> On Tue, Aug 18, 2020 at 06:45:05PM +0200, Philippe Mathieu-Daudé wrote:
>> In preparation of using multiple IRQ (thus multiple eventfds)
>> make BDRVNVMeState::irq_notifier an array (for now of a single
>> element, the admin queue notifier).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  block/nvme.c | 28 ++++++++++++++++++----------
>>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> This looks like an intermediate step before using multiple irqs. I think
> it makes the code confusing because on one hand INDEX_ADMIN gives the
> impression that INDEX_IO() should be used for io queues, while on the
> other hand only a single EventNotifier is allocated and we actually
> can't use INDEX_IO() yet.
> 
> If this intermediate patch is really necessary, please don't use
> INDEX_ADMIN. Define a new constant instead:
> 
>   /* This driver shares a single MSIX IRQ for the admin and I/O queues */
>   #define MSIX_SHARED_IRQ_IDX 0
> 
> In the future the array index can be changed to INDEX_ADMIN and
> INDEX_IO(n) when there are multiple EventNotifiers.
> 
> I think that would make the code clearer.

Very good idea, thanks!


