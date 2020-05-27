Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B68C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E60E2078B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSW44r3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E60E2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxSv-0002Hl-C7
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdxRU-00009S-3S
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:54:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27169
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdxRS-00077T-So
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590591242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LayDpP1uENphGckZh8jBERvtaCKhk+KyegIwXKRsm3k=;
 b=dSW44r3P4EwHSpYQSFDK4L0de6snwd6Cmjh0ZCoLY2OcZ2KQeXA+XJYWT0H6UDWQP3PhMM
 Hia4/EH7YsAOTsq8OjnBoWCf+Bf+GXdmQ2ZrK+Swg0uil4tFROZPMOSbQCMyqIADWfAek5
 gadtf4GOBVxRFMTs20oZMsy7EN87DNY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-niOMZ_L_MaWOTjbon2JMjQ-1; Wed, 27 May 2020 10:53:59 -0400
X-MC-Unique: niOMZ_L_MaWOTjbon2JMjQ-1
Received: by mail-ej1-f71.google.com with SMTP id q2so2674038ejf.6
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=LayDpP1uENphGckZh8jBERvtaCKhk+KyegIwXKRsm3k=;
 b=fz/3UggcQL4Srqt5InCx46a23+j9aVA1mPSOew4w/fUyhCEQAoTXwq1WrCBMtcNceD
 +XZaMxd5wVwrttv6PnuicYznEd83QwFGp/kX821t/b2mWFRZefpZCXbug1ny7ENL3S/0
 GDpjw2j49H3vSxpv7XelcxsRHWUrGxmSoZ4RMMi0PQdWqrLUGmP5n3QYxaNbLc2DGvOR
 pVzobv+mg4WAcKSux0TtJ0gPjN+KJ5i7hCXOviOPVysM7Q1DZ5odCEkyuBSKWpkBEBEJ
 MKsT8VLirlUUj9Lam3f8+3j1acp9rC/YpSCRNbVgTKzTiPr5isiY1e+AXfsaEuvIFWIs
 aE0A==
X-Gm-Message-State: AOAM532eRH+Lj1P65IdMfXPQhAcKfOVXS2L896Yghup6I5hG5pPaJnO7
 2chUUu2vevzCPrgEriAcTgwIx4TKrHpEF0CHWamNArkK04gWEgqqQw90u+G5s3TdWDvqrjGO+ss
 Bv7iUpBYK0VhDy0E=
X-Received: by 2002:a05:6402:709:: with SMTP id
 w9mr23435253edx.255.1590591237875; 
 Wed, 27 May 2020 07:53:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbD0CkhllRKfO+iASiW/PHwGccDOwhCm9zOaRllEr9qgYRJLm239gGuSBdQjqOadMryhuu4w==
X-Received: by 2002:a05:6402:709:: with SMTP id
 w9mr23435238edx.255.1590591237673; 
 Wed, 27 May 2020 07:53:57 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id b23sm2932281ejz.121.2020.05.27.07.53.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 07:53:57 -0700 (PDT)
Subject: Re: [PATCH v2 00/11] Record/replay acceptance tests
To: qemu-devel@nongnu.org, Pavel.Dovgaluk@gmail.com
References: <159058688028.16318.18277405305142866353@45ef0f9c86ae>
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
Message-ID: <ac997bec-d700-2ee2-8b98-c1e58ab30933@redhat.com>
Date: Wed, 27 May 2020 16:53:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159058688028.16318.18277405305142866353@45ef0f9c86ae>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: wrampazz@redhat.com, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru,
 crosa@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 3:41 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
[...]>
> ERROR: line over 90 characters
> #83: FILE: tests/acceptance/replay_linux.py:41:
> +        vm.add_args('-drive', 'driver=blkreplay,id=disk%s-rr,if=none,image=disk%s' % (id, id))
> 
> WARNING: line over 80 characters
> #84: FILE: tests/acceptance/replay_linux.py:42:
> +        vm.add_args('-device', '%s,drive=disk%s-rr%s' % (device, id, bus_string))

Please try to respect the QEMU 80 chars limit (it eases review by blind
developers) and align methods & arguments to QEMU style.

Otherwise I'm glad to see this series.

So far:
Tested-by: Philippe Mathieu-Daude <philmd@redhat.com>

I plan to add R-b on v3 once you addressed Alex's comments.

Good job!


