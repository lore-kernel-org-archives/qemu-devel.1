Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1B9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F4FD205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZMa4C1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4FD205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWK8-0001wB-HQ
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZWIc-0007zY-6C
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:06:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39481
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZWIb-0002LL-3B
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589533592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=frfSkXLGb2Gs7NglNQYmQor/+GNC7jflBzuc//1OHrI=;
 b=bZMa4C1l/NsMekWeoot0c4GV5//Wy4ckssDDJ0QpjvEKhV2dCfaTQ82J+t54sNRC28ldTb
 W4u2Ye5JUXpvpCtPz80Mwr2zkO60Poq1EwhNcv8Eum0pN7g31RINZOVtYV0xVEBrn+QYFb
 3gXx5gwT0R/h1C/dH56Jb6lRBU8Pxzs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-ukljZFcONrif3jENL2Z86Q-1; Fri, 15 May 2020 05:06:27 -0400
X-MC-Unique: ukljZFcONrif3jENL2Z86Q-1
Received: by mail-wm1-f70.google.com with SMTP id n66so867672wme.4
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 02:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=frfSkXLGb2Gs7NglNQYmQor/+GNC7jflBzuc//1OHrI=;
 b=QkK3fVu58blxrljFEYUepvLu6wfU98hIIk10fEBd8PSBaiqY/Cxx3DxK3wkRmG8vgU
 91vSrGm5KMx87aW+IN04FVevqAVV+rl2JrNA+ANvOCFt1HoEQBOfKu3ozywY0Wy51rKI
 pfRZqzgpw8MVrAFzHuFDnhvhIPfwt7flZbmNZ0H/1mUfHfD4DD7Gq30l8egOruCRnRAf
 GGuAh1L4Njg1EE3EzMpafas52Qjb4oKOYw9fi92I1NdGg/tU62KpDOnga51XJJRjW9Vk
 YINdSLPwandRQzelwblAzsWxXHPno1FOoPK3o09xvrUw/Yy4sbjzp1SGPeYwaJ9RwhFD
 ZrWg==
X-Gm-Message-State: AOAM530q0RSuodQyU84IkUGabetIbivfwlBbEx7hmfdMOCqlFXIV1nAP
 OqI1Mc2EBR4IVDr7dYqdKC1EN1GXEfYG5EhauhlfxTHta69xm3Vm/oYGZZjYf4Quepzf5vnS9vl
 aKQPuPYXtNd8hbPQ=
X-Received: by 2002:a1c:65c1:: with SMTP id z184mr2905898wmb.60.1589533586465; 
 Fri, 15 May 2020 02:06:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbGPFZq3qv+XtKrzslcIAg5YAgV0dZLl86xOi25v9IKIJQ3C9N10DM4/rx9P2GEaefkISflg==
X-Received: by 2002:a1c:65c1:: with SMTP id z184mr2905880wmb.60.1589533586292; 
 Fri, 15 May 2020 02:06:26 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m23sm2609515wmg.45.2020.05.15.02.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 02:06:25 -0700 (PDT)
Subject: Re: [PATCH 5/5] docs/system: Document Musca boards
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200507151819.28444-1-peter.maydell@linaro.org>
 <20200507151819.28444-6-peter.maydell@linaro.org>
 <9a94c5a6-cbf3-184e-40f3-25b18052dfa6@redhat.com>
 <CAFEAcA9BR6Aajz72=vLwpASrt=Px3gdMu+VhS9m0LZxySgdMvA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c1015c97-840e-1db4-4480-6c70ff252e46@redhat.com>
Date: Fri, 15 May 2020 11:06:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9BR6Aajz72=vLwpASrt=Px3gdMu+VhS9m0LZxySgdMvA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 10:48 AM, Peter Maydell wrote:
> On Fri, 15 May 2020 at 08:56, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> On 5/7/20 5:18 PM, Peter Maydell wrote:
>>> Provide a minimal documentation of the Musca boards.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
>>> --- /dev/null
>>> +++ b/docs/system/arm/musca.rst
>>> @@ -0,0 +1,31 @@
>>> +Arm Musca boards (``musca-a``, ``musca-b1``)
>>> +============================================
>>> +
>>> +The Arm Musca development boards are a reference implementation
>>> +of a system using the SSE-200 subsystem for embedded.
>>
>> Maybe nitpicking, but this sentence seems unfinished.
>>
>> " ... for embedded [?]."
> 
> That's the name of the IP block:
> https://developer.arm.com/docs/101104/latest/introduction/about-the-sse-200
> 
> I guess it ought to be capitalized: "SSE-200 Subsystem for Embedded".

Ah yes, it is clearer.

> 
> thanks
> -- PMM
> 


