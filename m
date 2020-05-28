Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AA6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 05:11:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E162084C
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 05:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyyWt/Xu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E162084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeApV-00033k-Bt
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 01:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jeAog-0002Jl-W0
 for qemu-devel@nongnu.org; Thu, 28 May 2020 01:10:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20138
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jeAof-0002M6-Cr
 for qemu-devel@nongnu.org; Thu, 28 May 2020 01:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590642651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JS/IdXvCml+htZjMdy9V/9MB0MlEBFf1Ew3Q+rvaZT8=;
 b=EyyWt/Xu66c9O7n6cT1igpWZmVrXQ4hgCdYSJueCXnV4qQiZBy2vy0p2aELjZqEUbC22lh
 iXjnily6jiy09mnsP0BQgoU8R+ev4oKc5omTeBqivDi3JNlmiKuIFziL/UU19nQVi0NH1o
 4ZRDV9+sik0JIXUJnpzgaXX0Hsd3gT0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-kQ5fsirNOcCuk0pjGPFXfQ-1; Thu, 28 May 2020 01:10:49 -0400
X-MC-Unique: kQ5fsirNOcCuk0pjGPFXfQ-1
Received: by mail-ej1-f69.google.com with SMTP id ng1so9679468ejb.22
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 22:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JS/IdXvCml+htZjMdy9V/9MB0MlEBFf1Ew3Q+rvaZT8=;
 b=cJUDPNMVlX+gDz4ebgSMQhs2v1AClXxdJSme1qu5woBw/V1ysIsukdmPoW3R93LIsc
 B9xCSdgX3tMZ55dHwBym4LpctqfhnmatH+30kUewtGVlBikxuiOrVkCqfrEKI2g5/pcO
 YFiaOFe79HU59f5cAQNd2T54gPhEFDjBbwWr+ao3KYF4Ikd0QymEZFQhC8cCYZCSH61u
 G+51T0i9T1OaWwSxmsU2qLap8+EZQSIHA2neBG6G81VFoQq8Hkm2YAEmnr2OGpzVDFXS
 zZUq4egFF5MKG51D/3NEfFHL3QWOZr98UOqN6IreIJsM49iakJsE7/cO5UZBTmLdbglH
 cIQA==
X-Gm-Message-State: AOAM533awszjMqfzSr/Z0RDNbQ7ic+e2FinhiJ82stSN1M0uc2n80LJS
 Zr6HhS6qpFScYXLGa059Pm3hCUjQLP36dWXlpfVFYhS8czZn1xMTULQdj0/B0vhII4D+Yw0xEZq
 PSQg3+MO+tCKV3Bg=
X-Received: by 2002:aa7:d90b:: with SMTP id a11mr1303341edr.159.1590642648412; 
 Wed, 27 May 2020 22:10:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6dhAiAqDCUtKpvLu3w1EiTPA6lUK3eRfqb4powVUE5XVsxxS2/TC4OKzEl5VdlM9PDY7wqw==
X-Received: by 2002:aa7:d90b:: with SMTP id a11mr1303327edr.159.1590642648158; 
 Wed, 27 May 2020 22:10:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8?
 ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
 by smtp.gmail.com with ESMTPSA id a13sm3738412eds.6.2020.05.27.22.10.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 22:10:47 -0700 (PDT)
Subject: Re: [PATCH v6 1/3] memory: drop guest writes to read-only ram device
 regions
To: Yan Zhao <yan.y.zhao@intel.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20200430080744.31232-1-yan.y.zhao@intel.com>
 <20200430080946.31286-1-yan.y.zhao@intel.com>
 <CAFEAcA-8NH_4ZV0J9urBZdQWmqOe-Nyy4y2gLAjTJ08MpfFY0g@mail.gmail.com>
 <9dd7f00b-1199-1097-80d4-1b700c0f28d6@redhat.com>
 <20200525011853.GB8867@joy-OptiPlex-7040>
 <f836eeb3-0655-2842-2e8a-b8a42710a765@redhat.com>
 <CAFEAcA9vG8RO1A3mSkHGN+ZMisDHzAu3QM5GfCkrDaK-A0Tw9w@mail.gmail.com>
 <20200528043529.GA1378@joy-OptiPlex-7040>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bec3aa98-2df2-f1e9-3188-b7c0e395c934@redhat.com>
Date: Thu, 28 May 2020 07:10:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200528043529.GA1378@joy-OptiPlex-7040>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:10:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, xin.zeng@intel.com,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/05/20 06:35, Yan Zhao wrote:
> On Tue, May 26, 2020 at 10:26:35AM +0100, Peter Maydell wrote:
>> On Mon, 25 May 2020 at 11:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> Not all of them, only those that need to return MEMTX_ERROR.  I would
>>> like some guidance from Peter as to whether (or when) reads from ROMs
>>> should return MEMTX_ERROR.  This way, we can use that information to
>>> device  what the read-only ram-device regions should do.
>>
>> In general I think writes to ROMs (and indeed reads from ROMs) should
>> not return MEMTX_ERROR. I think that in real hardware you could have
>> a ROM that behaved either way; so our default behaviour should probably
>> be to do what we've always done and not report a MEMTX_ERROR. (If we
>> needed to I suppose we should implement a MEMTX_ERROR-reporting ROM,
>> but to be honest there aren't really many real ROMs in systems these
>> days: it's more often flash, whose response to writes is defined
>> by the spec and is I think to ignore writes which aren't the
>> magic "shift to program-the-flash-mode" sequence.)
>>
> then should I just drop the writes to read-only ram-device regions and
> vfio regions without returning MEMTX_ERROR?
> do you think it's good?

I am not really sure, I have to think more about it.  I think read-only
RAMD regions are slightly different because the guest can expect "magic"
behavior from RAMD regions (e.g. registers that trigger I/O on writes)
that are simply not there for ROM.  So I'm still inclined to queue your
v6 patch series.

Thanks,

Paolo


