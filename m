Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840EBC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E2E920767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHR8RlO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2E920767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoKy-0006ec-8B
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDoKA-0005gC-6M
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:26:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60547
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDoK8-0007eq-39
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599135999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UomRoFy3iVqdBdFlSJivlh63ysnacNH4u5rhTJV7rTI=;
 b=JHR8RlO9KtfOA5vxip9vW0HRX1AnbWvMGz3jZuBR2LB66tIOFemoYBDKMNuKVLeLD/ePJv
 yj6eqTucL5mh+xily25VZVrTRmj/vAZhM/3CaxrPWQg8G5NTlb+UyBNbGeY/Mvs2adWaJ3
 3PbDTD71P6F8j73YYYHxnc8hShHFF+8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-0iMBVbxwMOGhhaQvKugDfg-1; Thu, 03 Sep 2020 08:26:38 -0400
X-MC-Unique: 0iMBVbxwMOGhhaQvKugDfg-1
Received: by mail-wr1-f72.google.com with SMTP id o6so902876wrp.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UomRoFy3iVqdBdFlSJivlh63ysnacNH4u5rhTJV7rTI=;
 b=EAXqH+vC14zFafMyvPfmt+aO+EwM+Fb7rCH6tNNsA3QrPGgDS9bAK2KeO3/sgYjaL3
 gKNMp3aJ5a0tY07QeMCA2d5yfS7JrPVKVF0h5gi0ZFYdAe9wL9pkl83NiATB9ugdLu4x
 Gr6uW0lwcIucNXYcGenJ7gGr1cPNvHZ4RxB8vsrXR5dQBnY34cx0zc6NNINV0EFITgQV
 DmRaPJgPSJk8J5ZgVsHjJlEPYohk8EOcTKJkJ4RUmYjnkSOLE/uRfArSlV9qpoF8/sEE
 OxsZW8Q7i+ZO/3Vl+KzMJz9Orxi+/Hn6dtVn8c1Uivspdn0lVgiUW3I8NksGY4AlAsJt
 Hq3Q==
X-Gm-Message-State: AOAM533WihCBzlonJXXB+buFG20iiCn9JffyGB/bu621S6RcxMFUXM7x
 RvYOI8oEfn+Fod5aMCPNJ+A2JRNEG5YEQYOrxOEf3d4DfAPL1QR7gNjOxg1ve/wc5jyTI2eA1MX
 t6+UL6S/MpC8dTcI=
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr2246915wmi.107.1599135996857; 
 Thu, 03 Sep 2020 05:26:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyy3QZ+RvQhS/uefGWI37xgaP1SqChDdvVS/zm2e67+cYC9Iric0qY2amgecRTVTfvtLW+4Rg==
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr2246854wmi.107.1599135996555; 
 Thu, 03 Sep 2020 05:26:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:197c:daa0:48d1:20b2?
 ([2001:b07:6468:f312:197c:daa0:48d1:20b2])
 by smtp.gmail.com with ESMTPSA id l15sm4344741wrt.81.2020.09.03.05.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 05:26:35 -0700 (PDT)
Subject: Re: [RFC PATCH 11/12] hw/pci: Only allow PCI slave devices to write
 to direct memory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200903110831.353476-1-philmd@redhat.com>
 <20200903110831.353476-12-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7e4fd726-07e9-dc09-d66b-5692dd51820f@redhat.com>
Date: Thu, 3 Sep 2020 14:26:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903110831.353476-12-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-block@nongnu.org,
 Li Qiang <liq3ea@163.com>, "Emilio G . Cota" <cota@braap.org>,
 Joel Stanley <joel@jms.id.au>, Richard Henderson <rth@twiddle.net>,
 Laszlo Ersek <lersek@redhat.com>, Robert Foley <robert.foley@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Tony Nguyen <tony.nguyen@bt.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Alexander Bulekov <alxndr@bu.edu>,
 Andrew Jeffery <andrew@aj.id.au>, Klaus Jensen <k.jensen@samsung.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/20 13:08, Philippe Mathieu-Daudé wrote:
> Do not allow PCI slaves to write to indirect memory
> regions such MMIO.
> 
> This fixes LP#1886362 and LP#1888606.

What is a "PCI slave"?  Which devices would still be allowed to write?

I'm worried that there are cases of MMIO reads that would be broken.
They are certainly niche these days, but they should still work; the
most "famous" one is perhaps the old BASIC

   DEF SEG=&HB800
   BLOAD "picture.pic", 0

Paolo


