Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB3FC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB5F20789
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtI6CRsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB5F20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNEv6-0005gk-G6
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 08:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNEri-0001nP-AT
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNErg-0008TI-Ft
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:36:17 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601382974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4lBUYOJ/zf4AUShZShTIEBCNI9Us+gFkJTQTP44uR+E=;
 b=RtI6CRsUd78Mzio+aUJbOHEtyFbcLu297VPc9EbpfOA+aS2tVTpWNc6ZM7fb+AGGq07meG
 QfQQAC7qOYZnQQV72JZTmMRGsFBXOSa6u3tIMmsBqV43sNU9GVDF7oyz3cUMSBw/zIMNtW
 fW/RKLWdAmn2pQT+b1WRw6ANI9ddlrc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-wfrYFJbOOTynXpeuUJxaTQ-1; Tue, 29 Sep 2020 08:36:12 -0400
X-MC-Unique: wfrYFJbOOTynXpeuUJxaTQ-1
Received: by mail-wm1-f69.google.com with SMTP id b20so3338317wmj.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 05:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4lBUYOJ/zf4AUShZShTIEBCNI9Us+gFkJTQTP44uR+E=;
 b=RwvO3GNOn/sT1WL+thy4zpXDYMkxOCDfXGxfedyrMVpnlaWXHVNlesULrpXY7LEc6o
 UAAWrnKXa1OlZ4yX7BH1V3gw+SekTvmbyRsOlnV/ej5T4E6djjrlINC7jjfZp8Bni9vM
 xlKqG41uo0uSpSjC1O4e8GggyvQ0Iff+oNghWINME4wgHBQW6kgfI7RZvZ7GsaPWuGtv
 MOGflnCaNPcAbf7FG30U9G8t6sEcGYAcOt4ZuzQuerq1BWU2k9g4bZzaXPgiBreB8D5p
 mO/ytkfZiXIJbvMOibTiIkYviOh+oIEqpBE/bOly9ZEH3saRbESjBDX7UBabxlOVcmKZ
 i9zw==
X-Gm-Message-State: AOAM530kJsXCn03JeVs6hGTsjg3ZVQyqio9gRlDtChOedZQD+rmGsHIX
 zajV9ATU2E5zR6cytYYIzKZBr5bSVMBTPT6es26ntlEcgm8ysWy6YDTNb/yTHn3rsl89MFeUoA2
 qfmXq17aSxBHmUnk=
X-Received: by 2002:adf:ee01:: with SMTP id y1mr4261632wrn.2.1601382971253;
 Tue, 29 Sep 2020 05:36:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/Piev54bo7P9na83hVr2E7aIomfMMwXhMiYw6QcJ3MozmIqbp2HFMiczJ5OhB0KDSTrf+6A==
X-Received: by 2002:adf:ee01:: with SMTP id y1mr4261618wrn.2.1601382971101;
 Tue, 29 Sep 2020 05:36:11 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id q18sm5802629wre.78.2020.09.29.05.36.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 05:36:10 -0700 (PDT)
Subject: Re: [PULL 0/1] acpi: fixup
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <20200929111255.381871-1-mst@redhat.com>
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
Message-ID: <ed9c633d-63c0-4e84-4eb1-adf634416bec@redhat.com>
Date: Tue, 29 Sep 2020 14:36:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200929111255.381871-1-mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 1:13 PM, Michael S. Tsirkin wrote:
> The following changes since commit 213057383c9f73a17cfe635b204d88e11f918df1:
> 
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-09-29 11:10:29 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to f142e4ede72853aaa7d306bc79b099caed45769b:
> 
>   tests/acpi: drop unnecessary files (2020-09-29 07:10:37 -0400)
> 
> ----------------------------------------------------------------
> acpi: fixup
> 
> My last pull included a ton of useless files by mistake.
> Drop them all.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

It might be cleaner to directly apply this as a "buildsys fix",
sometimes Peter accepts to do it.


