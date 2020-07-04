Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ECFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E089720674
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoGidCY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E089720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrlNO-0003Pw-6I
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrlMj-0002j0-Tj
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:50:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51188
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrlMh-0007kg-Sa
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593881410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9vBqyjqJxTJ0Hvxp9gEsOjSbaRC8ShXJ1Dv3lfyjp2o=;
 b=BoGidCY0ba5BOJW+I4UwPP6mzbN3DuO5Ou696fHzRg6YMSi5/rrA31z2umg0NSaOjYGsK7
 P+dGEmFvlx0jHukqDFEr+33yamS5tZSpq3AV4jI1q0o4G1HDD7SIk4bm+5rwlALt+5AcJX
 HFX1OdfDF30Ob8YEDdL6Ab//Swe6Izs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-C_Jj7TH2Mvq5TNTJ0w8auQ-1; Sat, 04 Jul 2020 12:50:07 -0400
X-MC-Unique: C_Jj7TH2Mvq5TNTJ0w8auQ-1
Received: by mail-wm1-f71.google.com with SMTP id e15so39832905wme.8
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 09:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=9vBqyjqJxTJ0Hvxp9gEsOjSbaRC8ShXJ1Dv3lfyjp2o=;
 b=QJcSMSmzujbfud/+m2PXo67d+AA3BytHIgJQAJtO/grGd0174r/dVT3khEDe2jC6+w
 6SBzuSlP98G6eoNXy9qlBRiCN1AKPTmaVbbZGDXvCY3zDZcdeZJeUsbwXTI6fQsJV4zV
 17oDYMEx+4IEDd9qfbl6LcMFU56tltdhmM0mBvt1LgOCezQYwaucyL6+Ie2SzFTc3I0r
 DT0JDRQyb/Liac6Q+lEfsomepgY3RcsDjqFb301cHnQ2gYgjAmyKpLnhDXMrrdolbjVq
 Je6o9V/TJloCms9UhdTl3xcG3mHWmNNbLNx7IuWbcSs4C9pu3DLnRHP90Xi+jT5KFsA4
 1qfA==
X-Gm-Message-State: AOAM530rpEuWHpVeHtlRtJzRuslOWi04pytxUppMHj3mGMwHgXJO62WO
 24Ak/SN0KZ1hjcGztjdiTAElYa/drXr78AWeI67BpMiCBcyg86Cvn+S/q0LnEtjHHZo0G9cB9dE
 vm3NyrvOGpsPP+FM=
X-Received: by 2002:a5d:5187:: with SMTP id k7mr7357835wrv.39.1593881406104;
 Sat, 04 Jul 2020 09:50:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTu9xKJJ+4NEHwYeOQqcTVFMTxH/iLT8xbseTSVWgbfrhk7KNCWKiN4O1uFOWjQ3oy3wsIgg==
X-Received: by 2002:a5d:5187:: with SMTP id k7mr7357818wrv.39.1593881405956;
 Sat, 04 Jul 2020 09:50:05 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v3sm17580444wrq.57.2020.07.04.09.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 09:50:05 -0700 (PDT)
Subject: Re: [PATCH 0/7] accel/kvm: Simplify few functions that can use global
 kvm_state
To: qemu-devel@nongnu.org
References: <20200623105052.1700-1-philmd@redhat.com>
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
Message-ID: <a36faa0a-6aa9-463d-03a0-b862141a427d@redhat.com>
Date: Sat, 4 Jul 2020 18:50:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200623105052.1700-1-philmd@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:57:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

kind ping :)

On 6/23/20 12:50 PM, Philippe Mathieu-Daudé wrote:
> Following Paolo's idea on kvm_check_extension():
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg713794.html
> 
> CI:
> https://travis-ci.org/github/philmd/qemu/builds/701213438
> 
> Philippe Mathieu-Daudé (7):
>   accel/kvm: Let kvm_check_extension use global KVM state
>   accel/kvm: Simplify kvm_check_extension()
>   accel/kvm: Simplify kvm_check_extension_list()
>   accel/kvm: Simplify kvm_set_sigmask_len()
>   target/i386/kvm: Simplify get_para_features()
>   target/i386/kvm: Simplify kvm_get_mce_cap_supported()
>   target/i386/kvm: Simplify kvm_get_supported_[feature]_msrs()
> 
>  include/sysemu/kvm.h         |  4 +-
>  accel/kvm/kvm-all.c          | 76 +++++++++++++++----------------
>  hw/hyperv/hyperv.c           |  2 +-
>  hw/i386/kvm/clock.c          |  2 +-
>  hw/i386/kvm/i8254.c          |  4 +-
>  hw/i386/kvm/ioapic.c         |  2 +-
>  hw/intc/arm_gic_kvm.c        |  2 +-
>  hw/intc/openpic_kvm.c        |  2 +-
>  hw/intc/xics_kvm.c           |  2 +-
>  hw/s390x/s390-stattrib-kvm.c |  2 +-
>  target/arm/kvm.c             | 13 +++---
>  target/arm/kvm32.c           |  2 +-
>  target/arm/kvm64.c           | 15 +++---
>  target/i386/kvm.c            | 88 +++++++++++++++++-------------------
>  target/mips/kvm.c            |  6 +--
>  target/ppc/kvm.c             | 34 +++++++-------
>  target/s390x/cpu_models.c    |  3 +-
>  target/s390x/kvm.c           | 30 ++++++------
>  18 files changed, 141 insertions(+), 148 deletions(-)
> 


