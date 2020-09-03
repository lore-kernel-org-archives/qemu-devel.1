Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30B2C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 17:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B071320775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 17:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9v0/F5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B071320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDtRR-0000Kc-Qh
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 13:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDtQc-0007wv-OY
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 13:53:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDtQa-0006FI-MY
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 13:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599155619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7asdxu6IhGX/9UW+F2HS8qy4901LeNHb0a8VtCxONAg=;
 b=Z9v0/F5Y9qH8aWjfeeo0H55DBmNfXzsQVnxfn0RHW2lrMpZbr6OYkNe0uT0cpr6zQpRI/V
 dbyk8vToiPzvQji5icDCqVt+QjnPAEu/+Sx7p71rQISdX6JI90QqumrBFoYJ8uNmQGp4SO
 RmhyWppgpFheuVTUDSqa+ARu57oOoQ8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-c4L8ZBsHO-az4vfrwSKFbw-1; Thu, 03 Sep 2020 13:53:37 -0400
X-MC-Unique: c4L8ZBsHO-az4vfrwSKFbw-1
Received: by mail-wr1-f70.google.com with SMTP id a12so1348385wrg.13
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 10:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7asdxu6IhGX/9UW+F2HS8qy4901LeNHb0a8VtCxONAg=;
 b=F+JQMbQQnXY1icqG0CQI+inYIO6qye9z9cw6EwGONgXysgceQb5Xo5hyrVR49zvxPB
 HWLzYdekVucBV6wnKOzPC5uWzC3N2w1TNWyrTqHYfPJm5OX2vzG6p9aa/sPbrH1E7Yd8
 A58hVSd7kZtp/nTPVM6hiBFXun11TSCW/oROfeAAHOAZKIMnPJEIXnga8lj4R5LD7b06
 j89yN/CW0KNrHqYMX/A7rHgov3RxlgGsxJT9XQDUifnxbtYrASYynny/Eav1/H2+mh2A
 YZPr+XjPLwZa8fX0/obTF8waOLxNyzX3cJh0hZYXmjPKM2gmAXcQ/rEs/RZFuD/lScmX
 tL2g==
X-Gm-Message-State: AOAM531U1qKTZhHobkS0nqiMBXD3JVjY63f73R4FCkIWWzu4kCEhjkmH
 9rcaNl5I1NzUkAvF2wJPFxMGwYRsLHxgE0sw9kMexc/70fgU/LAu2GPDSdVuSunuFPEqqP98s10
 Me9CrGfOkUs0c6yQ=
X-Received: by 2002:adf:c182:: with SMTP id x2mr3655746wre.400.1599155616611; 
 Thu, 03 Sep 2020 10:53:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKc1rZepfvbkdLzWxO+rErQb1pkM6l7eFLe6pZFmZrs+QptemRkgY0s8uHeR5xnHH41qzEFQ==
X-Received: by 2002:adf:c182:: with SMTP id x2mr3655704wre.400.1599155616326; 
 Thu, 03 Sep 2020 10:53:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:197c:daa0:48d1:20b2?
 ([2001:b07:6468:f312:197c:daa0:48d1:20b2])
 by smtp.gmail.com with ESMTPSA id v7sm5630559wmj.28.2020.09.03.10.53.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 10:53:35 -0700 (PDT)
Subject: Re: [RFC PATCH 00/12] hw: Forbid DMA write accesses to MMIO regions
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
References: <20200903110831.353476-1-philmd@redhat.com>
 <658fdd16-33da-af3a-6d8d-f7ea1253f061@redhat.com>
 <CAFEAcA8aOzq8UQwKiyuvJokBT9ui6JWxzf=T8=r13Vuu6+_kkQ@mail.gmail.com>
 <20200903142410.GX2954729@toto>
 <d030f14b-5b1d-6028-8fdd-5dbc25abdf74@redhat.com>
 <20200903155023.GC14249@toto>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9105d1fb-8064-076f-9408-ba94c889b765@redhat.com>
Date: Thu, 3 Sep 2020 19:53:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903155023.GC14249@toto>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Li Qiang <liq3ea@163.com>, "Emilio G . Cota" <cota@braap.org>,
 Joel Stanley <joel@jms.id.au>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Robert Foley <robert.foley@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Tony Nguyen <tony.nguyen@bt.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Alexander Bulekov <alxndr@bu.edu>,
 Andrew Jeffery <andrew@aj.id.au>, Laszlo Ersek <lersek@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>, Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/20 17:50, Edgar E. Iglesias wrote:
>>> Hmm, I guess it would make sense to have a configurable option in KVM
>>> to isolate passthrough devices so they only can DMA to guest RAM...
>>
>> Passthrough devices are always protected by the IOMMU, anything else
>> would be obviously insane^H^H^Hecure. :)
> 
> Really? To always do that blindly seems wrong.
> 
> I'm refering to the passthrough device not being able to reach registers
> of other passthrough devices within the same guest.

Ah okay; sorry, I misunderstood.  That makes more sense now!

Multiple devices are put in the same IOMMU "container" (page table
basically), and that takes care of reaching registers of other
passthrough devices.

Paolo

> Obviously the IOMMU should be setup so that passthrough devices don't reach\
> other guests or the host.


