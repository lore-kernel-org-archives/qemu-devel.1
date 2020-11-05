Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FFAC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F55206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfOXE97p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F55206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaduq-0000OK-83
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 06:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kadu8-0008Mu-Hm
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:58:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kadu5-000219-QT
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604577486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ccS/UuyPduHdruJ4nSVnpqkBQd5qbpTHYCXksDVMaug=;
 b=gfOXE97pIgyaxC9gEQwjZeZjdddjb9i0sPQzdPgP/nFFTRuJMKsZoVvc0MrTH0PCwHvvzz
 K72HXsgeztniJA1ICnHH8SwYq7T2M49s24Ajo7ObOI6uWuYXtN4Bbdx0agFGYwVyN/lhWA
 BpeXDu8ShOgtri9kEQKWvQzLNZmcO3g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-NIx6X83dNHOElgrb0Bw4ZA-1; Thu, 05 Nov 2020 06:58:05 -0500
X-MC-Unique: NIx6X83dNHOElgrb0Bw4ZA-1
Received: by mail-wr1-f70.google.com with SMTP id r16so596571wrw.22
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 03:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ccS/UuyPduHdruJ4nSVnpqkBQd5qbpTHYCXksDVMaug=;
 b=OiEWtodBWOV2NQZCeXkAkmTv+rThMmDv40Xcuxsmu7MXhLak6Bh1wyEReInFPxM3qA
 DHp7o32ClJda64yCY85Qqt1ahlPX1jhomtEPNMjZwMTrggjSADNDR2ilL7J1hqRFgjWb
 BsUobs8fy/vVNn8x0rPUOX63/wRF0DpsZ170qITQRek7nuejryltGlcVr9XxqH5GOMh/
 TQz8vq9014CJ8PuSc8Zvd+ucrWslWjEl09X2vk72biKtARrRTDbU/flqhsuG1ToeydZA
 b7ZsjbL6yGz6sXBmi559iXUCu9486Dw5BhskLkcgoBPveVhfVJ2fdMuEc+XDtYXNFHv8
 vDfg==
X-Gm-Message-State: AOAM533wptf6A218V9l9HLZpfilbUZhCkk8UkZRB2bhF5xowqna8Ai2k
 9P8cuzaCdJuE6taMmCrSwMtsP6T8XuV/P7stdZ8xZs1y5MEcud5fh51xVwWUdt9dppJ1oPC4Ib9
 TJ50Gck6NaVNHIOU=
X-Received: by 2002:a1c:309:: with SMTP id 9mr2240852wmd.80.1604577484363;
 Thu, 05 Nov 2020 03:58:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjUwA3iewExd9LPiRN1RfNeLt0AY+Jew26z6eGpYoBMjR9BeVveiEN3W4T+q19FrTAIqRJEA==
X-Received: by 2002:a1c:309:: with SMTP id 9mr2240823wmd.80.1604577484170;
 Thu, 05 Nov 2020 03:58:04 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id m14sm2355163wro.43.2020.11.05.03.58.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 03:58:03 -0800 (PST)
Subject: Re: [PATCH-for-5.2 v3 1/4] s390x: fix build for
 --without-default-devices
To: Cornelia Huck <cohuck@redhat.com>
References: <20201104115706.3101190-1-philmd@redhat.com>
 <20201104115706.3101190-2-philmd@redhat.com>
 <20201104182547.5ae54d3f.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <394ea3ee-fdef-e25b-4419-3b1bf51a48cc@redhat.com>
Date: Thu, 5 Nov 2020 12:58:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201104182547.5ae54d3f.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, Greg Kurz <groug@kaod.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cornelia,

On 11/4/20 6:25 PM, Cornelia Huck wrote:
> On Wed,  4 Nov 2020 12:57:03 +0100
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> From: Cornelia Huck <cohuck@redhat.com>
>>
>> s390-pci-vfio.c calls into the vfio code, so we need it to be
>> built conditionally on vfio (which implies CONFIG_LINUX).
>>
>> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Fixes: cd7498d07fbb ("s390x/pci: Add routine to get the vfio dma available count")
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> Message-Id: <20201103123237.718242-1-cohuck@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Acked-by: Greg Kurz <groug@kaod.org>
>> Tested-by: Greg Kurz <groug@kaod.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  include/hw/s390x/s390-pci-vfio.h | 3 ++-
>>  hw/s390x/meson.build             | 2 +-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> I think you're missing Matt's r-b?
> 
> Do you plan to send this, or should I include it on my s390-fixes
> branch?

I plan to send a pull request with gitlab patches (or maybe
they will go via Alex's testing tree) but not soon. If you
are preparing s390-fixes patches, please go ahead taking this
one (I only included to have the series build succeed).

Thanks!

Phil.


