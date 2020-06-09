Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE08CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88774207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0ZSTLx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88774207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jicGg-0006ew-JP
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jicDU-0002i3-2K
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:14:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55585
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jicDT-0002Mf-Dr
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591701290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pM1sXV/7eH//dmNxCu9L646uRo7LpSiWcH+A4/9rq/Y=;
 b=H0ZSTLx0zfxYBqG/OMI/rc1TYe1D8+DXKhBpi/Z4aY05eEhm6eM/k6Lcn+iCyRmbAyvBHj
 itpPEtMVSApRQa7l2fs71YYlAxyVwoIXy0edmtcyLo/BhgZYsUJRA0is7DTgdE0AqN/6xn
 xI2nRDtqYUXxyVHsPX5FWFQa7Ztta7U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-_2AyzRb-MiyxXVF-qeQ_Zg-1; Tue, 09 Jun 2020 07:14:47 -0400
X-MC-Unique: _2AyzRb-MiyxXVF-qeQ_Zg-1
Received: by mail-wm1-f69.google.com with SMTP id 11so528628wmj.6
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 04:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pM1sXV/7eH//dmNxCu9L646uRo7LpSiWcH+A4/9rq/Y=;
 b=iXNgMoW5eZpnSDvTIX/R22eL7Q/jDfqYq2RXh0T1hDz+0dv2Nil4/eloQy57oyqjkL
 u9g1uFeKj7UM5TJM7IRvVQUODnCvV4CcG6oqyZGbuMukrcCR/UUMT/O53C9qd/IM/INI
 bu2rs3NuJWoAvyvBaM7zrPDBJ5Fp/5vQ4BTo3LSLnavEbtw3GP3WXYaLkR92VhneBL1E
 ppT9ofxVG9vQIcOdY136vNS6aRgoKb6rrwtwXL70xq70PLTejCr6PTPRzp89fu9V1P6A
 ufNXvrp5GR6QQL9DsBGRtuYcgPJyGVo5KemhLCUxC9ffIajZF0gfYcrn1AJkpYCeHwB+
 PwDQ==
X-Gm-Message-State: AOAM5335oJ8WhLNWUyhzkohW4RQfz+7hE2jTsdXJ5NYqKz6PGO6ghaUP
 oU85rDIL+ebRxiWgR085B8aM0P/GUiLekg2gugua0ta7y+XYxdo4+D/TmIb0rs4oMdO6/o4GnJw
 ngKCFzhn+tzviS0c=
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr3651913wru.427.1591701286134; 
 Tue, 09 Jun 2020 04:14:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuPbVlBDSLtlTXx3ZWJ2E6euzR9/JzXQUGOR/hYo9mA/3HQUZQnicNKOucsXO2NrypVrU/9w==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr3651896wru.427.1591701285907; 
 Tue, 09 Jun 2020 04:14:45 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.172.168])
 by smtp.gmail.com with ESMTPSA id f9sm3121051wrf.74.2020.06.09.04.14.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 04:14:45 -0700 (PDT)
Subject: Re: [RFC PATCH 00/35] hw/qdev: Warn when using pre-qdev/QOM devices
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200608160044.15531-1-philmd@redhat.com>
 <CAFEAcA_Ni8=mvyfG=9Aa=ym-ae9HpP8J8B0ekm8=SN2WgZ6_vA@mail.gmail.com>
 <81653f82-484b-a04a-7b2c-1362a724d0e8@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea1a0932-aecf-3e88-1444-2f5ca369cc67@redhat.com>
Date: Tue, 9 Jun 2020 13:14:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <81653f82-484b-a04a-7b2c-1362a724d0e8@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Stafford Horne <shorne@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Henderson <rth@twiddle.net>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Michael Walle <michael@walle.cc>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/06/20 18:17, Philippe Mathieu-Daudé wrote:
> On 6/8/20 6:14 PM, Peter Maydell wrote:
>> On Mon, 8 Jun 2020 at 17:00, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>>
>>> Based on today's IRC chat, this is a trivial RFC series
>>> to anotate pre-qdev/QOM devices so developers using them
>>> without knowing they are not QOM'ified yet can realize
>>> it and convert them if they have time.
>>
>> What mechanism did you use for identifying non-QOM devices?
> 
> I don't think this is the complete list, this is only all the one I
> could find with:
> 
>   $ git grep "g_new|g_malloc" hw/
> 
> Then on each match I manually reviewed (so I might have incorrectly
> flagged code too).

Yes, you did, but I guess for an RFC it was a good bang for the buck.  I
went through the patch and noticed both a few false positives and a
couple blatant violations in recent code.

Paolo


