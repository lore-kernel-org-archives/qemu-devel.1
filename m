Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3BDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 09:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A23207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 09:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdJJw1ui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A23207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeb4w-0002vk-O4
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 05:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeb3I-0001j8-5K
 for qemu-devel@nongnu.org; Fri, 29 May 2020 05:11:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20545
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeb3H-0000Jt-6X
 for qemu-devel@nongnu.org; Fri, 29 May 2020 05:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590743499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZmladyTmooEwtW8t8Idh/cXKSlbG8JN1qRhfd3e4VjQ=;
 b=IdJJw1uirXFll33PDqx17G2JxmDwIB4gxrahAVX7lAQ4AlLzRdZIP+7ZhL4Y8vVsrIJT5o
 z6QpqhFvDjDT5dFZAQBR+325asQ6pZXGMJhR1kFS0lEs69xjEHF+datA0uaANZXgbuTVsz
 gQ1iUP8kROk9IDm8RVaagSMEcq01bo0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-gmVQ84RDO3iy9GSi4SLmbw-1; Fri, 29 May 2020 05:11:37 -0400
X-MC-Unique: gmVQ84RDO3iy9GSi4SLmbw-1
Received: by mail-wm1-f71.google.com with SMTP id y202so405358wmd.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 02:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ZmladyTmooEwtW8t8Idh/cXKSlbG8JN1qRhfd3e4VjQ=;
 b=GcpTvbknNAavisfFNKxfeQcFsJ3vhQ14/0nUOMcf1TMd6Hyr3lHW29oXLyEZIM7hf+
 quTVgOe77h489X/iUXlHVGrD2qtKvjrul3aPfS4DjWJ604X5X7Bd2gJCswAi+Q72Au+5
 ytJZawh6dyVyBgcEbzwXnExUvsb6WMsh8WAzunPXGdJ+CvlXd9p3o3Elk184U/Rs6iua
 uxvIU4aky0pTCge1/YyguqYaCnI53GT/whK8dUn7BzzkmJaGLoygksshj/oZIM8xszDz
 P9jVZ8ADwl3P2max19Ds/Q60fKO2UD6FQIzFUWhTsE4dV+r78Dq0x97xMdg0PeAlVgLq
 jaHw==
X-Gm-Message-State: AOAM531cFm1wvSQqbM2PVDNcJXMe/MMShkJNShBBFJgNu5ymtmOS6szq
 FI+v/8p1klnypICEeFLMDgi8CU1eE0gvZWkfOSrcyFOBZm4hAOxtuORyHGhOOpDqC9ta105dun0
 NT7WMWmrdGSBYcG8=
X-Received: by 2002:a1c:6606:: with SMTP id a6mr7202247wmc.37.1590743496375;
 Fri, 29 May 2020 02:11:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUsBBgQVLd416S+QKQrLChguP9FU4Shy/gp+IMLIfAeig10SQGLJJWs3mmfD5c7J93VI/mGw==
X-Received: by 2002:a1c:6606:: with SMTP id a6mr7202224wmc.37.1590743496103;
 Fri, 29 May 2020 02:11:36 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id s72sm5953427wme.35.2020.05.29.02.11.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2020 02:11:35 -0700 (PDT)
Subject: Re: [RFC v2 06/18] target/i386: sev: Remove redundant cbitpos and
 reduced_phys_bits fields
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, frankja@linux.ibm.com, dgilbert@redhat.com,
 pair@us.ibm.com
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-7-david@gibson.dropbear.id.au>
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
Message-ID: <4c045f9e-9506-b33c-3fc6-0ed9ce118569@redhat.com>
Date: Fri, 29 May 2020 11:11:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200521034304.340040-7-david@gibson.dropbear.id.au>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/20 5:42 AM, David Gibson wrote:
> The SEVState structure has cbitpos and reduced_phys_bits fields which are
> simply copied from the SevGuestState structure and never changed.  Now that
> SEVState is embedded in SevGuestState we can just access the original copy
> directly.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/i386/sev.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


