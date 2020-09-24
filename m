Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E17C4727E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:09:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB2C239CF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0p9zM+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB2C239CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLP7W-0008Qp-88
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLP6O-0007vu-QQ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:07:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kLP6M-0002Yy-Uu
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600945669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8K5Ao2K1tAo5wPDpnQ8xTxtGOVbRyDlwDjXQ5JHHOQI=;
 b=E0p9zM+K6m0mihvXq2tSbf68QeNqJvfel6ZVjONxIxE1E21lXFfOaeWv5T48cNNTdm5aAc
 Wbc7csu2LM9pckf7qcvkFkwaSJ3PzJ+cx4xnGVXXgY+5dzwk0C+qhYp06L0RICNGd7iOuK
 Wv284Ij0YZYwZKBWVfO3abtmNPNdsAQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-ihe_lnkMOviwMUcNIH-QIw-1; Thu, 24 Sep 2020 07:07:47 -0400
X-MC-Unique: ihe_lnkMOviwMUcNIH-QIw-1
Received: by mail-wm1-f69.google.com with SMTP id x6so1106573wmi.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 04:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8K5Ao2K1tAo5wPDpnQ8xTxtGOVbRyDlwDjXQ5JHHOQI=;
 b=JapAuMas2nMwmwCVraIsCOEsMD2mh+CNbayTx0J8hYHWxrHsyzJO/y0KJ5ZXUmG7Sk
 n28Q5UMiI2F54B8Qplz4vjW0DZldkm7FpcVctWL/CjuqRJwiY6wMoR4tpcqbnCY50WA1
 amkbScLLXQvNyyw5P1rqgR2V/88ZX42GP9vqLHz39K5pC0ZAvnw4WryyXnTrzmhy4F1P
 bOBJgdGE613GX1pvn3RI1yESHp7Hl9V4XuFSXHbWL4kBEZwAc3rUfoSuY5eibeVBAnON
 EYNXsETA7dUcAGZA3OA6yU0+k+WQtI3wE3oFHPUYEv7Iwr7ho8b+kD+WgWK4epzXRCvl
 aW+A==
X-Gm-Message-State: AOAM530Aa3SEWCi9GE1NSPgrJ7apB+WmwFXJ9lIyv7CZMUqNOFMHEaAP
 JNELQOCxb+BFUq4cLBGYFoi2DV7yNHSacA89X5Nm9fmHLuBzxlk4vs/rvCV6r4gTe5M1Cx4SYOw
 z9OD3Vh1JaWO7fO0=
X-Received: by 2002:adf:e44b:: with SMTP id t11mr4716159wrm.101.1600945666264; 
 Thu, 24 Sep 2020 04:07:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycmaRWN9c4djkSlctWDFZw5Pn+xkQp3FmVFe+frGkjwjHpIVSa+lHYWEeRBvTMXWxVMR62Sw==
X-Received: by 2002:adf:e44b:: with SMTP id t11mr4716142wrm.101.1600945666092; 
 Thu, 24 Sep 2020 04:07:46 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id z19sm3105588wmi.3.2020.09.24.04.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 04:07:45 -0700 (PDT)
Subject: Re: [PATCH v2] monitor: Use LOCK_GUARD macros
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 armbru@redhat.com
References: <20200922095741.101911-1-dgilbert@redhat.com>
 <20200924091755.GB4980@work-vm>
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
Message-ID: <26577b3e-0255-cd0c-58e5-e38cf3f1b9b9@redhat.com>
Date: Thu, 24 Sep 2020 13:07:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200924091755.GB4980@work-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/20 11:17 AM, Dr. David Alan Gilbert wrote:
> * Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>
>> Use the lock guard macros in monitor/misc.c - saves
>> a lot of unlocks in error paths, and the occasional goto.
>>
>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> Queued

Sorry I had this tagged but forgot:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


