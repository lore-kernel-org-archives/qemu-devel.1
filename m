Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965CDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D0C20781
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoiRdNJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D0C20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Y9w-0002Vl-Js
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 13:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5Y6m-0008EG-Bn
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:30:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35272
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5Y6k-00088U-0k
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597167041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xjtYyyFaNjTmVi1iP6UXlj1pi919faeOrcazs0YXjJg=;
 b=LoiRdNJIRdYDO+fgqfmCB3XS+tNpyqWcAu0LVLCE7+gkneApixYtFXzOpTkbb03roncHBv
 KgtIS6VRIJz0wmvoQJgRPHFfTXjPYoamEXCIwmeoA83kqf5qKeaSgklO/rw1MENIvH3ofp
 fMtJYQ5tUgbnUtVhmSHfBuXrYWNN7lY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-QoJJuH19MOu6SVxDf2VwBw-1; Tue, 11 Aug 2020 13:30:35 -0400
X-MC-Unique: QoJJuH19MOu6SVxDf2VwBw-1
Received: by mail-wr1-f69.google.com with SMTP id r14so5857812wrq.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 10:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=xjtYyyFaNjTmVi1iP6UXlj1pi919faeOrcazs0YXjJg=;
 b=bDi4wJIkIWhqphdQGD65hG47PAGBeY8HxVU/UaAUKbnuEYjeVRip9Gi/BaZMU3LaUT
 6DMU4yeg5puquoN4xht7ZVGUg/Phm7h8FE26fU0SpEjWglHWA9XNpStEVyvz6tqM7Ih/
 6eyX2HV6wzi2Qj03HDjHEQJAIIstxb9mrphqEY9WrJjZ+BiKEjX4mFrCNHSvQhlUyU8z
 unSLFIaoVU3o116GnT2NgIul+dLbN+IxMjLykZDNBXuwOy3Hbo0YVedt4SR6Fw9D8e0I
 YYB9nmUMG0hpfd0N/Rz/hxOqRjIdx2Ote0mkGU7cGLTU2JnFLT22Kptk1KYQD9eaLQjg
 FMfg==
X-Gm-Message-State: AOAM533ZuM+aBtf/nWpU8Q6p5EiJKWz9r4CApRajKhGx2GLAHmeDgmw1
 p1EOVLZzTPQ41MIIhVkkvDdGCkYIWwgk0SC7sC8eUF01RKrhrS8fgwrif6YsnaM+LuJOYYpkcFL
 BiSWf8BuuoOZrZpI=
X-Received: by 2002:a1c:984d:: with SMTP id a74mr5177254wme.140.1597167034211; 
 Tue, 11 Aug 2020 10:30:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcQD0WUYwOPgXGPXj2FZ1NUVVPTjhR7ACuYetMy+n9iheVBkuj4Ccw2hAsW+r67K4unk1D7w==
X-Received: by 2002:a1c:984d:: with SMTP id a74mr5177236wme.140.1597167034043; 
 Tue, 11 Aug 2020 10:30:34 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id n5sm26434153wrx.22.2020.08.11.10.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2020 10:30:33 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] util/vfio-helpers: Fixes to allow using multiple
 IRQs
To: qemu-devel@nongnu.org
References: <20200811172845.16698-1-philmd@redhat.com>
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
Message-ID: <2773369a-33d9-f08a-bb42-9d715a29bd0a@redhat.com>
Date: Tue, 11 Aug 2020 19:30:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200811172845.16698-1-philmd@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 06:40:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/11/20 7:28 PM, Philippe Mathieu-Daudé wrote:
> A pair of fixes to allow binding notifiers on different IRQs
> (NVMe block driver series will follow).
> 
> Philippe Mathieu-Daudé (3):
>   util/vfio-helpers: Store eventfd using int32_t type
>   util/vfio-helpers: Add trace event to display device IRQs available
>   util/vfio-helpers: Let qemu_vfio_pci_init_irq take IRQ index argument
> 
>  include/qemu/vfio-helpers.h |  2 +-
>  block/nvme.c                |  2 +-
>  util/vfio-helpers.c         | 17 ++++++++++++-----
>  util/trace-events           |  1 +
>  4 files changed, 15 insertions(+), 7 deletions(-)
> 

Oops I forgot, it is based on "util/vfio-helpers: Fix typo in description":
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg02073.html
Based-on: <20200811151643.21293-4-philmd@redhat.com>


