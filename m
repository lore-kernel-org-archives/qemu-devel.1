Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02605C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA28221E2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyyTBfpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA28221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k43YC-0002NE-Sd
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 10:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k43X5-0001Ft-IH
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:39:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50732
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k43X2-0006Mw-JY
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596811178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vcrQEf7IFc+KQDbkqwkgRqtZTgKeick8rUky5PX0Gew=;
 b=RyyTBfpK8veQjV9/95LAMEK5kokqU0doI/BpSGvNLjywReIVMXdzcuydr6aMFiS07mRCh8
 ZFw+VOrT+9Fq6wKhormZfe3DiBikWsIG89A+xrnloHAYYst61A1Xz8/bw4WMLMioOSelTy
 V8F7JK+0nHbDGX13ZEskaKJiNZItuig=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-gMzGVu27PRezbrUHuxeILw-1; Fri, 07 Aug 2020 10:39:37 -0400
X-MC-Unique: gMzGVu27PRezbrUHuxeILw-1
Received: by mail-wr1-f70.google.com with SMTP id e14so825067wrr.7
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 07:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vcrQEf7IFc+KQDbkqwkgRqtZTgKeick8rUky5PX0Gew=;
 b=mqZ0/ATj69Hlcb+qLwe1sjBG+TmR4mS9JdG4eiJzpZOdqqNR9cBfPzqy5rjUnoMxkv
 kg/js2lx6CCq0YVpDQBGPeGqmGoHREV9ePVqXa+aX7HoYwGpsoZg2iRho+mnZPH5MkMv
 ASKhix5j7KrVbOelg1FfMxwHl7ryOzFrv0h7qkg1tnr4wWk8T3mWbKHjxc5hkbuVST+v
 1Bjy9K/mCkvDfy0drk2+yPf4X3WCwM0nS+/0yDFf+dvZcNI2+Erxlf/TCnzuMUkVmV4T
 hgoucx530zB9vz+bpDgD9IQCQHi5UIU7v/oF7BmQwoPEZ95RYddWrAcDWk6BryJpeD4F
 8pmQ==
X-Gm-Message-State: AOAM532fHlZWA5ZXJH2/J8i75qrGZjI7h5zeFZQ32nShnfgEDgeh9DT/
 S5Z816/hSELXKk8Ub1Sa0fhM40wXq8wTNB9Tp9j+hmAWG9eQLwiuFDU14+TBWXF7tXroIuZJwIU
 jX59SMQcv4zuJ6BU=
X-Received: by 2002:a7b:c954:: with SMTP id i20mr14120763wml.189.1596811176155; 
 Fri, 07 Aug 2020 07:39:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1/JUTQQF3YOz/MCvGNO2zBo7/VA3rXNwdjp2wwxh1k83mPHMP8STH/8kIJvdtQKJ4Ll9eug==
X-Received: by 2002:a7b:c954:: with SMTP id i20mr14120748wml.189.1596811175925; 
 Fri, 07 Aug 2020 07:39:35 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id g7sm10856013wrv.82.2020.08.07.07.39.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 07:39:35 -0700 (PDT)
Subject: Re: [PATCH 068/143] meson: convert most of softmmu/
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-69-git-send-email-pbonzini@redhat.com>
 <bac67efd-d736-b7ae-b9b3-0373393d2849@redhat.com>
 <a54f3ef9-5905-628c-c277-f7d6190c3be6@redhat.com>
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
Message-ID: <99776241-88f2-3d32-522c-e72cc5815442@redhat.com>
Date: Fri, 7 Aug 2020 16:39:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a54f3ef9-5905-628c-c277-f7d6190c3be6@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:53:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/20 4:18 PM, Paolo Bonzini wrote:
> On 07/08/20 15:36, Philippe Mathieu-Daudé wrote:
>> There is still "obj-y += vl.o" in softmmu/Makefile.objs.
>>
>> Did you meant to squash this into the previous patch?
> 
> This is what I meant:
> 
> diff --git a/meson.build b/meson.build
> index a7ad3248cc..ef6f811c51 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -618,6 +618,8 @@ softmmu_ss.add(when: ['CONFIG_FDT', fdt],  if_true: [files('device_tree.c')])
>  
>  common_ss.add(files('cpus-common.c'))
>  
> +subdir('softmmu')
> +
>  # needed for fuzzing binaries
>  subdir('tests/qtest/libqos')
>  
> diff --git a/softmmu/Makefile.objs b/softmmu/Makefile.objs
> index a414a74c50..ebcfd15695 100644
> --- a/softmmu/Makefile.objs
> +++ b/softmmu/Makefile.objs
> @@ -1,14 +1,2 @@
>  softmmu-main-y = softmmu/main.o
> -
> -obj-y += arch_init.o
> -obj-y += cpus.o
> -obj-y += cpu-throttle.o
> -obj-y += balloon.o
> -obj-y += ioport.o
> -obj-y += memory.o
> -obj-y += memory_mapping.o
> -
> -obj-y += qtest.o
> -
> -obj-y += vl.o
> -vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)
> +main.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS)

OK now I understand.

Please add "Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>" to
the new patch with this snippet content.

> diff --git a/softmmu/meson.build b/softmmu/meson.build
> new file mode 100644
> index 0000000000..95d38df259
> --- /dev/null
> +++ b/softmmu/meson.build
> @@ -0,0 +1,10 @@
> +specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files(
> +  'arch_init.c',
> +  'balloon.c',
> +  'cpus.c',
> +  'cpu-throttle.c',
> +  'ioport.c',
> +  'memory.c',
> +  'memory_mapping.c',
> +  'qtest.c',
> +  'vl.c'))
> 


