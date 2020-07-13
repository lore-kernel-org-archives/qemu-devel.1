Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3399C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7166E2068F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2vVqqo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7166E2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4KY-0002ml-OE
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jv4HV-0006xY-CB
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:38:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20970
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jv4HS-0001Hj-Ea
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594669104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1rDsyU6xh3emwMBPYGVZhUoBO4/N2LHStcXqUmWqlus=;
 b=d2vVqqo66MtPypxGzyGaVEIFXCCxekxu1q0pCzni40HL9MbbDLxPNzrWfssGFfVT6YBdx9
 zpek57cknAdDPCljsXqiqf52P+3xPj5PT+Idmk8xdfFkAoVIzhguIOaUk3mBouvAT+ZfLD
 f+qS5CZITKDm1UPhKlMS+D8cEMJD1SU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-gYefE1WkOTCmTCul8G333g-1; Mon, 13 Jul 2020 15:38:20 -0400
X-MC-Unique: gYefE1WkOTCmTCul8G333g-1
Received: by mail-wm1-f70.google.com with SMTP id t18so628990wmj.5
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 12:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=1rDsyU6xh3emwMBPYGVZhUoBO4/N2LHStcXqUmWqlus=;
 b=CvZ69wG73rGRhIbSFw+EYEYD9A5EP12YICtse40kz9vNu7PUjQgOCGTHNIUqtGau4u
 6U4QekBH2pDp9cNB7g/Qe+RnzMZtnJzR1VVbHuLVALd8+jwBWcLQmD0gHN361UxFSyBJ
 yUo4UElw7OyrhP6h0181NYDCXJomb1UDcEhRD6X9ch3jLKcACt5RL5pu1a6mkWN/QfRU
 TXVR0mwVYDpodpAlrbJW7tXnx6mGfEau0TKG+Jb8+uNtUS9U7lJ3nxGtEmzuDHQVuz5w
 zrT23XzRVwt960t3pE2THxo9EiQmwujLu7FDfXM8T3bru4cozWa9q1UyQhYWBQvsNvDm
 GkTw==
X-Gm-Message-State: AOAM532DRCxGH5X6Dfb/H9KnJznz2GcAq+PQZIJaZ4d/fMHRXUaULH9q
 J87MFGWy24uQsxKAURHSQH4XKA5IGtJFw5yV4Q3WXKg22vTSscrs1OJnvfY5wYpAvo2hBMUuxOB
 cFt6k8fLgWJVIckA=
X-Received: by 2002:adf:e60e:: with SMTP id p14mr1054525wrm.31.1594669099368; 
 Mon, 13 Jul 2020 12:38:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRlZUdPVsl9F9RT+YJ6dN2trWlPLP6uiD0Li9lRjFe3upER0hEcgdXjusi8qx8J12NOosEvQ==
X-Received: by 2002:adf:e60e:: with SMTP id p14mr1054504wrm.31.1594669099179; 
 Mon, 13 Jul 2020 12:38:19 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id a2sm25625051wrn.68.2020.07.13.12.38.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 12:38:18 -0700 (PDT)
Subject: Re: [PATCH v3 0/9] memory: assert and define MemoryRegionOps callbacks
To: P J P <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200630122710.1119158-1-ppandit@redhat.com>
 <nycvar.YSQ.7.78.906.2007140023310.6870@xnncv>
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
Message-ID: <61f82e46-5d86-24e5-0a0b-d9973e51c797@redhat.com>
Date: Mon, 13 Jul 2020 21:38:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.78.906.2007140023310.6870@xnncv>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 14:48:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 8:58 PM, P J P wrote:
> +-- On Tue, 30 Jun 2020, P J P wrote --+
> | * This series asserts that MemoryRegionOps objects define read/write 
> |   callback methods. Thus avoids potential NULL pointer dereference.
> |   ex. -> https://git.qemu.org/?p=qemu.git;a=commit;h=bb15013ef34617eb1344f5276292cadd326c21b2
> | 
> | * Also adds various undefined MemoryRegionOps read/write functions
> |   to avoid potential assert failure.
> | 
> | Thank you.
> | --
> | Prasad J Pandit (9):
> |   hw/pci-host: add pci-intack write method
> |   pci-host: add pcie-msi read method
> |   vfio: add quirk device write method
> |   prep: add ppc-parity write method
> |   nvram: add nrf51_soc flash read method
> |   spapr_pci: add spapr msi read method
> |   tz-ppc: add dummy read/write methods
> |   imx7-ccm: add digprog mmio write method
> |   memory: assert MemoryRegionOps callbacks are defined
> | 
> |  hw/misc/imx7_ccm.c       |  7 +++++++
> |  hw/misc/tz-ppc.c         | 14 ++++++++++++++
> |  hw/nvram/nrf51_nvm.c     |  5 +++++
> |  hw/pci-host/designware.c |  9 +++++++++
> |  hw/pci-host/prep.c       |  8 ++++++++
> |  hw/ppc/prep_systemio.c   |  8 ++++++++
> |  hw/ppc/spapr_pci.c       | 13 +++++++++++--
> |  hw/vfio/pci-quirks.c     |  8 ++++++++
> |  memory.c                 | 10 +++++++++-
> |  9 files changed, 79 insertions(+), 3 deletions(-)
> 
> 
> @Paolo: all patches in this series are reviewed/ack'd. Need any change/update 
> from me? (just checking)

Paolo isn't available, maybe ask each maintainer? ARM/PPC mostly.


