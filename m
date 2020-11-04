Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08601C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 08:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C81206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 08:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmI/rQXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C81206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaERF-0002qG-BY
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 03:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaEPq-0001EU-BL
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 03:45:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaEPo-00063j-97
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 03:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604479511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g9wgyGb8o4F7GaxnhdDTBYm66ewkTIL6sWNKaFibb68=;
 b=gmI/rQXfDzOiurgC2oLh0SHUBXAifWU0CR151HnmS7lzm3A74NrFPf0iSV9WK0DKU/UT2x
 q0clQwru04d+u2eg/J2HX0kZZhsS7gjm7r67ciKI775mt2bKVMEiqGZTbLsX1ek4DRJ7Vd
 iL/imLCTZt9l97TKm0czP308WknxFcI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-UsQyzQqMPNKSZD4-wBq5dA-1; Wed, 04 Nov 2020 03:45:07 -0500
X-MC-Unique: UsQyzQqMPNKSZD4-wBq5dA-1
Received: by mail-wr1-f70.google.com with SMTP id i1so8941265wrb.18
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 00:45:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g9wgyGb8o4F7GaxnhdDTBYm66ewkTIL6sWNKaFibb68=;
 b=HRtYmylTiBelD7my9+E1C2uSNe3nek4yVzsRaf0TTNL1m4x+/bjj1VG/X3h5Vlcg+s
 Xjnvjm2e1R8/F0SHvAkbz39Q8InXYimP5Xv/f59KWaoqYVYRMz2nROGDWiL7yLFxMQxu
 2XJrNt62q5zcHyl9NI77tOTtrH6Zw8Cki9EFU+UxcJwedh3ZvNjN1+GZYgtoyvhqYikU
 1vjTqV4guF23PwO3ZvmVOPTvzQrsApfbkSFPDW7P+JREYlWybMEp8klrM6QFe5SP0RsZ
 zbQge9syija6chQItLFbj0d+Y/DQNPjqptOpdbPRgKKE5eM/wnlhMzQ8m9JbEJ2jyw8p
 BrBQ==
X-Gm-Message-State: AOAM532aP3kRhjMZJGyEeNj+dBenzzor+aiU5tXMW7LdLlyuzVvNoY55
 NXuSZt5lGwGo4Zx3xdIibu/+d+TazR/2VjN0d68U0KA//t3h0woawne4EO8MnZUdm5rb3S77l+f
 up0dX3HnPo8TfxW8=
X-Received: by 2002:adf:df91:: with SMTP id z17mr29789661wrl.379.1604479506251; 
 Wed, 04 Nov 2020 00:45:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypJhKD9mliEhFRXq9/vs5yj5xAS5nCVo/ZPDcGmVXxdTH2TVmDPY93zK9Ovrxz/S5RT+KuzQ==
X-Received: by 2002:adf:df91:: with SMTP id z17mr29789641wrl.379.1604479506091; 
 Wed, 04 Nov 2020 00:45:06 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id e6sm1551973wrs.7.2020.11.04.00.45.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 00:45:05 -0800 (PST)
Subject: Re: [PATCH-for-5.2 2/3] gitlab-ci: Add a job to cover the
 --without-default-devices config
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20201103164604.2692357-1-philmd@redhat.com>
 <20201103164604.2692357-3-philmd@redhat.com>
 <20201103165247.GT205187@redhat.com>
 <7654e063-98d3-84e0-8116-5a1b41d14636@redhat.com>
 <CABgObfYN+_GsVS89oxRThCivox0F6BJ6XjM3d2gro85y-_17=g@mail.gmail.com>
 <0a7209fb-5e77-d42e-c823-87573897598b@redhat.com>
 <ac602313-18b7-1517-1261-e9841a6df6d8@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2bcd4007-78c3-2933-105b-e95d17b68c81@redhat.com>
Date: Wed, 4 Nov 2020 09:45:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <ac602313-18b7-1517-1261-e9841a6df6d8@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 10:12 PM, Paolo Bonzini wrote:
> On 03/11/20 22:07, Philippe Mathieu-Daudé wrote:
>>> diff --git a/accel/Kconfig b/accel/Kconfig
>>> index 2ad94a3839..d24664d736 100644
>>> --- a/accel/Kconfig
>>> +++ b/accel/Kconfig
>>> @@ -7,3 +7,4 @@ config KVM
>>>   config XEN
>>>       bool
>>>       select FSDEV_9P if VIRTFS
>>> +    select 9PFS if VIRTFS
>> Without this line ^ it works! Thanks :*
> 
> Without which line?

Not adding "select 9PFS if VIRTFS" (keeping
the current "select FSDEV_9P if VIRTFS").

> 
> (Also if both work I prefer the other one).
> 
> Paolo
> 


