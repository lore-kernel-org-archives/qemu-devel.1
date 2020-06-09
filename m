Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C569C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74D420734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dkmkf3qN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74D420734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jifDO-00063R-3L
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jif5U-0004dq-Gk
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:18:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42285
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jif5T-0008Tp-KI
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591712326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0ofLoj6IFVa5Sd46VtPUTRrrKQ+s71NsZoY7qElYny8=;
 b=Dkmkf3qNf3FVjK8vrnD3GFhjk8WaflYPKgKwnNvftomJbCWA7gwuPj7SxffLHtwu6sGrg+
 CkqEg/FXK9F5PsbfJq2LUjRZHBLWOHKmX68fI63d6N+kN877J0yGSVJJBcZlHERaPPDGQU
 xdwCfuwez3kqLtRxm0eht8s+4NmUYIA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-5IA46SivMZazyxJr1lwJUQ-1; Tue, 09 Jun 2020 10:18:44 -0400
X-MC-Unique: 5IA46SivMZazyxJr1lwJUQ-1
Received: by mail-wr1-f70.google.com with SMTP id w16so8659887wru.18
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 07:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=0ofLoj6IFVa5Sd46VtPUTRrrKQ+s71NsZoY7qElYny8=;
 b=J9i7m/YkGuQVwY8Pwl1czhELUD31sY5axHpGz9t3p1cUPHJt0WxW154Z/UNRYDjGwW
 xXu+RwOUuTjtLiUy01PlW2vs//3ko8OxOZvrBU3lvTAg/e1oewzIz57bjlHYaPaYAUq3
 8AaCk4RHLSzkODAq2BqxXg1w2zoRmEm4hddZW1mhoMuZ8ibVHYs56AdaPoly2ba9RGho
 914uWK0N78VTIKMrSEAyudEJXHtoo6bmJr2vuwTDyNHS4zbhptsZl79YKrTbCYp06JY8
 HInIlUrbxRyJ01duE0sbIW5gDQ6mBOg4EhvXS/a4ZqRHM+7xuc5rhXerxP8tqJnCzmCr
 WbCw==
X-Gm-Message-State: AOAM530jJaKgkFQHzv/jo9o2Uj+aUKrg7SGd53BTv2u9OsVTCdUl0e40
 AZocGii9lN6mx2KN7LlDx4nqSr6VcsXV4Q/hlFoP09E0BpBzd5acpmm0ssiBc0qxQHwOUJJyY2V
 Emj4NynDokD81ftw=
X-Received: by 2002:adf:a306:: with SMTP id c6mr4744314wrb.122.1591712323608; 
 Tue, 09 Jun 2020 07:18:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOGHOEJ0JJUuuPLPG6PokIaR4WBnfeKCjRWfSegrn5+ynZ4ydeGNuD2T3mbGvJBn3Au308nA==
X-Received: by 2002:adf:a306:: with SMTP id c6mr4744289wrb.122.1591712323390; 
 Tue, 09 Jun 2020 07:18:43 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y19sm2997370wmi.6.2020.06.09.07.18.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 07:18:42 -0700 (PDT)
Subject: Re: [PATCH 0/1] hw/block/nvme: fix assert on invalid irq vector
To: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Maxim Levitsky <mlevitsk@redhat.com>
References: <20200609094508.32412-1-its@irrelevant.dk>
 <b445a413-598f-23a2-f094-8b68c60722f5@redhat.com>
 <20200609114633.yvwtt6swb47l27yd@apples.localdomain>
 <20200609141425.GC11003@linux.fritz.box>
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
Message-ID: <48537ee1-ed77-ffe6-66ba-d61838083069@redhat.com>
Date: Tue, 9 Jun 2020 16:18:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200609141425.GC11003@linux.fritz.box>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/20 4:14 PM, Kevin Wolf wrote:
> Am 09.06.2020 um 13:46 hat Klaus Jensen geschrieben:
>> On Jun  9 13:17, Philippe Mathieu-DaudÃ© wrote:
>>> On 6/9/20 11:45 AM, Klaus Jensen wrote:
>>>> From: Klaus Jensen <k.jensen@samsung.com>
>>>>
>>>> I goofed up with commit c09794fe40e3 ("hw/block/nvme: allow use of any
>>>> valid msix vector").
>>>
>>> Kevin, since your queue isn't merged, can you directly squash the fix?
>>
>> The commit (c09794fe40e3) can just be dropped without conflicts, but it
>> leaves a use of n->params.num_queues in nvme_create_cq() which commit
>> cde74bfd4b87 ("hw/block/nvme: add max_ioqpairs device parameter") must
>> fix.
> 
> Hm, so it seems this isn't easy to squash in without conflicts (and I
> would have to rewrite the whole commit message), so I think it's better
> to just apply the series on top.
> 
> One problem with the commit message is that it references commit IDs
> which aren't stable yet. Maybe it's best if I apply these patches,
> manually fix up the commit ID references and then immediately do a pull
> request so that they become stable.

This is the friendlier way.

Less friendly way is to drop Klaus's patches and ask him to respin.
While this is a valid outcome, if we can avoid it it will save all of us
review time.

> 
> It would be good to have at least one review, though.

Maxim catched this issue, I'd feel safer if he acks your pre-merge queue.

> 
> Kevin
> 


