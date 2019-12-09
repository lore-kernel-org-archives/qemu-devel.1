Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2179C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6CF20692
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USp9yxFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6CF20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieFTl-0005pG-I6
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 04:37:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ieFT8-0005Ql-9y
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:36:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ieFT4-0002XS-WE
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:36:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48847
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ieFT4-0002Wu-Iv
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575884196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ptbnkozHpjQQj699a1Kwu89sfc8iPpGxBS9EWXvwaBM=;
 b=USp9yxFc/0Vrszhi6lZJEa9tbJtrivaklE61INOF/BDc/mvudM5ILWqWJuU/4aarPBiuNt
 KZa4ySi31x9agChMiNIMRm95HxcS1B/Ke5TvwwJLBPEY+Rc17ZFjPeVMGezaQAKE+MPuFE
 qKa0Dp7F3PEHRxI/mi1t1NKyr0v8yLw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-beqfomkkMIyEP_IqyMuSDw-1; Mon, 09 Dec 2019 04:36:35 -0500
Received: by mail-wm1-f70.google.com with SMTP id g78so2839543wme.8
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 01:36:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ptbnkozHpjQQj699a1Kwu89sfc8iPpGxBS9EWXvwaBM=;
 b=Ex3HGG726cdYCrUZbgb66ceBfK8ma/5WLvkI/0nHh6TVGxbFH8P8/WWZ9MErqf13h5
 6RU/diKVZwY0tQG5zuoiIyQAeNa/ueexFFNUpzHG7/LY5tU0Nwr34nggg79b6IhDdW7r
 GxjDw6ttKoQw80DSIrdSKmib3xTp6fLUpErCWMC6H5MmkM/OGkiqBW3xj/fGQFB2NlzT
 VBTv6UDYI2SH7hCy4wbpZRynwtrrb7tCOF8ej+NkTkUeKTBsDwOs4RN67GBMhGggtKzI
 ODqcNWxhQBghoUI8uO5zPahiwiVA/exuyqhtnr8eC/EQRTjpr5jcFf+YCPQszmSsJ80M
 51Yg==
X-Gm-Message-State: APjAAAXUcJEbpCM9e/2yqWLq4hEob1O23IaWG9jZo+wKkUP6cgiorohb
 VZ9kc4QyPHpl6YfhyeBTKGPcceAwCjRLLtwN9DKsFja4EKpGvG6MwoXlpkddwm+vxJC47Is2Uh0
 tMDs5CaZRy8Ahfmo=
X-Received: by 2002:adf:e5cb:: with SMTP id a11mr993665wrn.28.1575884194117;
 Mon, 09 Dec 2019 01:36:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqwERevb7S8on08h21OnPhw1KaFXy82/KT4uC+KEMnVC/d/p/RR1qfXsThvyMyKz/w+do0Mlxg==
X-Received: by 2002:adf:e5cb:: with SMTP id a11mr993633wrn.28.1575884193794;
 Mon, 09 Dec 2019 01:36:33 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id a16sm26043477wrt.37.2019.12.09.01.36.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 01:36:33 -0800 (PST)
Subject: Re: [RFC] Use of the Nacked-by tag by CI scripts
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <4cbaadf8-ae4f-d086-2137-b83d61a5e9a5@redhat.com>
 <CAL1e-=ja7sdqC6sm_AxYkN-m_R__4dofj-WsYreHZB813OG9OA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9f71601e-de90-86d9-7c6b-352d923bbc06@redhat.com>
Date: Mon, 9 Dec 2019 10:36:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=ja7sdqC6sm_AxYkN-m_R__4dofj-WsYreHZB813OG9OA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: beqfomkkMIyEP_IqyMuSDw-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/12/19 10:28, Aleksandar Markovic wrote:
>     If there is a consensus about using this tag, the following patch
>     can be added to Peter's management scripts:
>     https://git.linaro.org/people/pmaydell/misc-scripts.git/
>     <https://git.linaro.org/people/pmaydell/misc-scripts.git/>
> 
> I always assumed that pull requests by sub-maintainers should contain
> "ready for merging" code (justified, reviewed, tested, ...). Why would
> ever a sub-maintainer send something that doesn't comply to these
> conditions?

Because things can and do go wrong, perhaps someone was on vacation
while the original patch was posted, perhaps somebody is giving a
negative review outside his maintenance area, perhaps there would be
conflicts with a tree-wide series being discussed elsewhere...  It's
rare and I don't think it would be misused, but I think it's a good idea
to have a machine-readable way to block patches.

However, I'm not sure why the commits would contain a tag.  Instead, we
could use the patchew REST API
(https://patchew.org/api/v1/projects/1/series/MESSAGE-ID/) and search
for nacked-by tags in there.

Paolo

> I think, in general, this tag would do more harm than good, allowing
> frivolous blocking of patches, and fixing a process that already works,
> without any need.


