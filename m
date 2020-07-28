Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A86C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BFF72074F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kt4z69Hg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFF72074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0MH1-0001h4-V6
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 05:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k0MGL-0000kQ-Mx
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:51:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47098
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k0MGJ-0004Qz-Qi
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595929867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TDDW6Vmqlcc/jdTvWAQk+vQDf4pMTloVpXra5sEPZ1M=;
 b=Kt4z69HgMfvqq/ac94D45JNRzKbMXywkUYKU9dkDeAHTyNms6TQpFp1kEtxUZmeyn/qWL7
 l7t9CRZbRK5k1xSCpzeRtQ/J0wEc/LLsyhDMlRLIYHI1YgBmKqwMXZxP7kCD7C7dleQl+4
 8m8lkkJhjOoPcrMH9368HWs25chgP9s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-RxppTDt_NlyuRAI4KT-mBg-1; Tue, 28 Jul 2020 05:51:05 -0400
X-MC-Unique: RxppTDt_NlyuRAI4KT-mBg-1
Received: by mail-wm1-f70.google.com with SMTP id s4so945889wmh.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 02:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=TDDW6Vmqlcc/jdTvWAQk+vQDf4pMTloVpXra5sEPZ1M=;
 b=C8psyz5+pR3iarUIPwUvRTQn2FZ+r9YklCdc/qaIpmyyClITPaR9Q8NkQuNlyoD+qA
 e6J6yUP8XF9xHXurhYW1a4+mVJqc+iePvBCYcvxAEZZjbh+Z1oXgLZmNHCvGS2I+xC3h
 lbv2Wwj87xJysAtJLzwyTai9jEU9CwNxoCwBcbuwcVCN9/92FWRpQFOMM8Q/aj7laDHX
 p3jofGS72c+p5fANOYuF9fRXXnamxJXP+4EyWdx5Pb9H4WIKwnnLBmx/t3JIfq1fEBIm
 Uxsy3Zqgb5QC/lnE6Fe6mOx0dlsWYr2hMDisrXc5DbCZHiIHqhXYt9+6w/Cxkyg7wz2h
 ziIw==
X-Gm-Message-State: AOAM533uFHdJJV4V9JU0IBh/lZ7R1f0ucJE0CZlcWhIh48mMO3JNRpzF
 4WPvNBtLtMWdBQdTPBzqzcvvkLTv5upf/xfSN2BgwUQRRx/dmu9906Se+QocaClg58qOhQm8qs8
 3XXm74vd5FvIbYJ4=
X-Received: by 2002:adf:de07:: with SMTP id b7mr26233020wrm.302.1595929863670; 
 Tue, 28 Jul 2020 02:51:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzO4h2FddLw3k4T2cWIwjScSzLKkXiGx9EEQhnWLPDvoMFerDSIOHcrpY3xpuJiRQ5Sq0g6tg==
X-Received: by 2002:adf:de07:: with SMTP id b7mr26232994wrm.302.1595929863478; 
 Tue, 28 Jul 2020 02:51:03 -0700 (PDT)
Received: from [192.168.1.39] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id h11sm17616910wrb.68.2020.07.28.02.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 02:51:02 -0700 (PDT)
Subject: Re: [PATCH] configure: define CONFIG_XEN when Xen is enabled
To: Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200728091828.21702-1-paul@xen.org>
 <CAFEAcA_wKTFWk9Uk5HMabqfa6QkkTAdzBotmnrA_EH1BR4XjYg@mail.gmail.com>
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
Message-ID: <32ad0742-bff2-1fbc-2f7a-d078980eb171@redhat.com>
Date: Tue, 28 Jul 2020 11:51:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_wKTFWk9Uk5HMabqfa6QkkTAdzBotmnrA_EH1BR4XjYg@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:55:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <pdurrant@amazon.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/28/20 11:27 AM, Peter Maydell wrote:
> On Tue, 28 Jul 2020 at 10:19, Paul Durrant <paul@xen.org> wrote:
>>
>> From: Paul Durrant <pdurrant@amazon.com>
>>
>> The recent commit da278d58a092 "accel: Move Xen accelerator code under
>> accel/xen/" introduced a subtle semantic change, making xen_enabled() always
>> return false unless CONFIG_XEN is defined prior to inclusion of sysemu/xen.h,
>> which appears to be the normal case. This causes various use-cases of QEMU
>> with Xen to break.
>>
>> This patch makes sure that CONFIG_XEN is defined if --enable-xen is passed
>> to configure.
>>
>> Fixes: da278d58a092 ("accel: Move Xen accelerator code under accel/xen/")
>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
>> ---
>> Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Anthony Perard <anthony.perard@citrix.com>
>> ---
>>  configure | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/configure b/configure
>> index 2acc4d1465..f1b9d129fd 100755
>> --- a/configure
>> +++ b/configure
>> @@ -7434,6 +7434,7 @@ if test "$virglrenderer" = "yes" ; then
>>    echo "VIRGL_LIBS=$virgl_libs" >> $config_host_mak
>>  fi
>>  if test "$xen" = "yes" ; then
>> +  echo "CONFIG_XEN=y" >> $config_host_mak
>>    echo "CONFIG_XEN_BACKEND=y" >> $config_host_mak
>>    echo "CONFIG_XEN_CTRL_INTERFACE_VERSION=$xen_ctrl_version" >> $config_host_mak
>>  fi
> 
> Configure already defines CONFIG_XEN as a target-specific
> config define in config-target.mak for the specific targets
> that Xen will work for (ie if you build --enable-xen for
> x86_64-softmmu and ppc64-softmmu then CONFIG_XEN is set for
> the former and not the latter). This patch makes it a
> build-wide config setting by putting it in config-host.mak.
> 
> We should figure out which of those two is correct and do
> just one of them, not do both at the same time.
> 
> Since CONFIG_HAX, CONFIG_KVM and other accelerator-type
> config defines are also per-target, I suspect that the
> correct fix for this bug is not in configure but elsewhere.

This might come from this change:

-#include "hw/xen/xen.h"
+#include "sysemu/xen.h"

Before Xen was target-specific, now it is a target-agnostic accelerator.

However in include/qemu/osdep.h we have:

 30 #include "config-host.h"
 31 #ifdef NEED_CPU_H
 32 #include "config-target.h"
 33 #else
 34 #include "exec/poison.h"
 35 #endif

CONFIG_XEN is generated in "config-target.h" (target-specific),
so target-agnostic code always has it undefined.

I'd rather uninline xen_enabled() but I'm not sure this has perf
penalties. Paolo is that OK to uninline it?

Phil.


