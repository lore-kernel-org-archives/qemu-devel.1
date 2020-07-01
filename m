Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179D2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D867A2068F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjHocc7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D867A2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdPS-0004gr-3D
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqdFD-00035a-R0
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:57:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49588
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqdFC-0005vx-14
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593611865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OmrBiBd6dVnb172gldiUfJmxwng0IgAgfx+lWbUsTbA=;
 b=BjHocc7EH/ZZYALNzqhvAI0OxU84gO363VBQtSt0MTfyM1YUnXSTbNSfV9wDK529u0m0Wf
 /LOlSkR8TKkqFGtBdGPlmyVkCFzIWoluPY9Kc+yIAsvctzwjdDwQO8UVEC61j1YdJtKpww
 5bNhplyR/NEvI06rDj12WYrirkkWlO8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-UZ150ce1N9mRj53U2tmkVQ-1; Wed, 01 Jul 2020 09:57:31 -0400
X-MC-Unique: UZ150ce1N9mRj53U2tmkVQ-1
Received: by mail-ej1-f70.google.com with SMTP id x15so15391276ejj.23
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 06:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=OmrBiBd6dVnb172gldiUfJmxwng0IgAgfx+lWbUsTbA=;
 b=W42uftqsMCAOIc0fFvNRNmYihcFJ25LfDiaFBxYjHCYdhY9b9U/MYu7ueK6mWTl5vv
 5LSpF9wtpJa16f6FqO/qUfrLE1Lu9ahZ57D/0ayqClCoSk79R7q2eDfIZIpx+YsPJD0y
 mkK6yXeMnJpPWqFzrSBMTSMigzbold3Ufd2D6FHKD5rrCyCj7Qe+Pr6T/kjodr/ynI2o
 OWI6Tc/PUnX//Epuv73Zm6nxopoKW2hhOKa/5Yd9d7r3/d5gSHoxZtmTphLm9Zs72bSL
 AxQKd3qUAsvsADtTzWEf5syYlu+lPsxLIRZqPzhDyQ3Js/UDDiJyM6pfK/N32UjFE7mN
 UVqQ==
X-Gm-Message-State: AOAM533EXlyXVWr1KW8GdYDdpnALIQkLK/c7Jr50IdW6zlYMrbaKEX03
 4YmJLKwiUYg+Vdnm8niMwbfBKVUa6NGWyXiHAHHKXDb5bzJP5OiMCup7s0EUdzaQmpqK8acfJkt
 kqNh+M/TIh5QIy28=
X-Received: by 2002:a17:907:7283:: with SMTP id
 dt3mr23834307ejc.195.1593611849681; 
 Wed, 01 Jul 2020 06:57:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYtjNjKg0Uo/fL6GJjCHQXQRgPhKtpqsX5faZEP4CUaTZPkqFj9Kqj8Cx6gfXM47P47HBXVg==
X-Received: by 2002:a17:907:7283:: with SMTP id
 dt3mr23834275ejc.195.1593611849377; 
 Wed, 01 Jul 2020 06:57:29 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id be2sm6244472edb.92.2020.07.01.06.57.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 06:57:28 -0700 (PDT)
Subject: Re: nvme emulation merge process (was: Re: [PATCH 00/10]
 hw/block/nvme: namespace types and zoned namespaces)
To: Klaus Jensen <its@irrelevant.dk>, Kevin Wolf <kwolf@redhat.com>
References: <20200630100139.1483002-1-its@irrelevant.dk>
 <20200630125932.GA553472@localhost.localdomain>
 <c10b18a8-44f3-7dab-b9bb-7d017f210934@redhat.com>
 <20200630154228.GB1987534@dhcp-10-100-145-180.wdl.wdc.com>
 <20200630203630.am3a3bc5ze5m2r3k@apples.localdomain>
 <20200701103407.GA11634@linux.fritz.box>
 <20200701131820.l4gb2ewjmnm6ysmt@apples.localdomain>
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
Message-ID: <645af679-d2a3-a744-d07c-477198879680@redhat.com>
Date: Wed, 1 Jul 2020 15:57:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200701131820.l4gb2ewjmnm6ysmt@apples.localdomain>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
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
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 3:18 PM, Klaus Jensen wrote:
> On Jul  1 12:34, Kevin Wolf wrote:
>> Am 30.06.2020 um 22:36 hat Klaus Jensen geschrieben:
>>> On Jun 30 08:42, Keith Busch wrote:
>>>> On Tue, Jun 30, 2020 at 04:09:46PM +0200, Philippe Mathieu-DaudÃ© wrote:
>>>>> What I see doable for the following days is:
>>>>> - hw/block/nvme: Fix I/O BAR structure [3]
>>>>> - hw/block/nvme: handle transient dma errors
>>>>> - hw/block/nvme: bump to v1.3
>>>>
>>>>
>>>> These look like sensible patches to rebase future work on, IMO. The 1.3
>>>> updates had been prepared a while ago, at least.
>>>
>>> I think Philippe's "hw/block/nvme: Fix I/O BAR structure" series is a
>>> no-brainer. It just needs to get in asap.
>>
>> I think we need to talk about how nvme patches are supposed to get
>> merged. I'm not familiar with the hardware nor the code, so the model
>> was that I just blindly merge patches that Keith has reviewed/acked,
>> just to spare him the work to prepare a pull request. But obviously, we
>> started doing things this way when there was a lot less activity around
>> the nvme emulation.
>>
>> If we find that this doesn't scale any more, maybe we need to change
>> something.
> 
> Honestly, I do not think the current model has worked very well for some
> time; especially for larger series where I, for one, has felt that my
> work was largely ignored due to a lack of designated reviewers. Things
> only picked up when Beata, Maxim and Philippe started reviewing my
> series - maybe out of pity or because I was bombing the list, I don't
> know ;)

I have no interest in the NVMe device emulation, but one of the first
thing I notice when I look at the wiki the time I wanted to send my
first patch, is the "Return the favor" paragraph:
https://wiki.qemu.org/Contribute/SubmitAPatch#Return_the_favor

 "Peer review only works if everyone chips in a bit of review time.
  If everyone submitted more patches than they reviewed, we would
  have a patch backlog. A good goal is to try to review at least as
  many patches from others as what you submit. Don't worry if you
  don't know the code base as well as a maintainer; it's perfectly
  fine to admit when your review is weak because you are unfamiliar
  with the code."

So as some reviewed my patches, I try to return the favor to the
community, in particular when I see someone is stuck waiting for
review, and the patch topic is some area I can understand.

I don't see that as an "out of pity" reaction.

Note, it is true bomb series scares reviewers. You learned it the
bad way. But you can see, after resending the first part of your
"bomb", even if it took 10 versions, the result is a great
improvement!

> We've also seen good patches from Andrzej linger on the list for quite a
> while, prompting a number of RESENDs. I only recently allocated more
> time and upped my review game, but I hope that contributors feel that
> stuff gets reviewed in a timely fashion by now.
> 
> Please understand that this is in NO WAY a criticism of Keith who
> already made it very clear to me that he did not have a lot time to
> review, but only ack the odd patch.
> 
>> Depending on how much time Keith can spend on review in the
>> near future and how much control he wants to keep over the development,
>> I could imagine adding Klaus to MAINTAINERS, either as a co-maintainer
>> or as a reviewer. Then I could rely on reviews/acks from either of you
>> for merging series.
>>
> 
> I would be happy to step up (officially) to help maintain the device
> with Keith and review on a daily basis, and my position can support
> this.

Sounds good to me, but it is up to Keith Busch to accept.

It would be nice to have at least one developer from WDC listed as
designated reviewer too.

Maxim is candidate for designated reviewer but I think he doesn't
have the time.

It would also nice to have Andrzej Jakowski listed, if he is interested.

> 
>> Of course, the patches don't necessarily have to go through my tree
>> either if this only serves to complicate things these days. If sending
>> separate pull requests directly to Peter would make things easier, I
>> certainly wouldn't object.
>>
> 
> I don't think there is any reason to by-pass your tree. I think the
> volume would need to increase even further for that to make sense.
> 


