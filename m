Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61930C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21445204EC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dpeg2/lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21445204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJXM-0007HW-Dt
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 12:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmJWL-0006hQ-T8
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 12:05:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48578
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmJWJ-0001hB-7J
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 12:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592582733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pgEFVL6dLOiX1+AWsk7txI4ebmpKbfLiwkkQ+flagbo=;
 b=Dpeg2/lx7hnf+/jfCrMEg+9nGws/uvr/ulpii3eZ9iz7VqZ8CQZWXqIzESkfGBfoii5Kfb
 kOqyoyAUd5IX3B00JADa6ikb+HTCO8ManvQtsyKSVWbWY+qGP1o0+/0u/6SeFxpFPpuNve
 QUeyPmMa1cbCPPTJSjF41J32gJT9qC8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-xfQUx489OuuGQlARhdeH_A-1; Fri, 19 Jun 2020 12:05:31 -0400
X-MC-Unique: xfQUx489OuuGQlARhdeH_A-1
Received: by mail-wm1-f71.google.com with SMTP id h25so4222495wmb.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 09:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=pgEFVL6dLOiX1+AWsk7txI4ebmpKbfLiwkkQ+flagbo=;
 b=c7dDsOyjSJnTc5zl0892HUyO/yJAyaY/7EAa/bZfnt+ywJtPrBFn++RiB0PbvR0myz
 79rkly9YLRtTI68uy5VwdW2QGTAwpWyJso11feDcBgi9kGP9njLir6nQpp1dhSFnlLV1
 ant8aU3Frb2Znyr6P7wbnLiX3PnWASbb+TPQhHRfmXoZvpkrb1S21PgLRLdBml4roUPe
 +3g/QbsGEj4cVaDlWuDA5BDLdBJNznWbvS78PWWJejVMhO/LhSSdDEPGOok4jnSDtiep
 LtBrXIeOu0yLcFcnKtYY3tbLATVaFpDEzfI/asF3iJDAEE4LcI8IG6dhLtVXtLl4Zb8x
 lPHw==
X-Gm-Message-State: AOAM530A+NaGfpOJY8af25A2NecWrs7JsJ9e2W2QP1vO/j2gOBzkh393
 m5kFxTfejXQe/6tcWPFZpxgTnQRFpZ0h7b831NHU+gM1J6Zzz6CCoV6tIYJCvxymC9o7RrNf5hE
 85RmfS2+3PuSA/6g=
X-Received: by 2002:adf:f5c6:: with SMTP id k6mr5060286wrp.358.1592582730475; 
 Fri, 19 Jun 2020 09:05:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz81N0H0kVobGUIVwVlKDRtowEW1CNukz67h1yAA7TtGzZdnMfZNsFxeeyoqxGDA8Qvntnmfw==
X-Received: by 2002:adf:f5c6:: with SMTP id k6mr5060261wrp.358.1592582730256; 
 Fri, 19 Jun 2020 09:05:30 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id o10sm7628560wrj.37.2020.06.19.09.05.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 09:05:29 -0700 (PDT)
Subject: Re: [PATCH] Deprecate TileGX port
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200619154831.26319-1-peter.maydell@linaro.org>
 <20200619155157.GX700896@redhat.com>
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
Message-ID: <b256be1e-285b-b303-261c-fc29c1554e86@redhat.com>
Date: Fri, 19 Jun 2020 18:05:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200619155157.GX700896@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 05:19:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Chen Gang <chengang@emindsoft.com.cn>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/20 5:51 PM, Daniel P. Berrangé wrote:
> On Fri, Jun 19, 2020 at 04:48:31PM +0100, Peter Maydell wrote:
>> Deprecate our TileGX target support:
>>  * we have no active maintainer for it
>>  * it has had essentially no contributions (other than tree-wide cleanups
>>    and similar) since it was first added
>>  * the Linux kernel dropped support in 2018, as has glibc
>>
>> Note the deprecation in the manual, but don't try to print a warning
>> when QEMU runs -- printing unsuppressable messages is more obtrusive
>> for linux-user mode than it would be for system-emulation mode, and
>> it doesn't seem worth trying to invent a new suppressible-error
>> system for linux-user just for this.
> 
> Potentially we could turn it off by default in configure, so it
> requires an explicit  --target-list to request it, but either way,
> I don't mind.

This is the approach I started 2 releases back... Having a
DEPRECATED_TARGET environment variable, you add your target
there and warnings are displayed. It resulted not that easy,
and 2 releases passed...

> 
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> We discussed dropping this target last year:
>>  https://patchew.org/QEMU/20191012071210.13632-1-philmd@redhat.com/
>> and before that in 2018, when Chen told us he didn't have time
>> to work on tilegx any more:
>> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg03955.html
>> Given that tilegx is no longer in upstream Linux I think it makes sense
>> to finally deprecate-and-drop our linux-user support for it.
>>
>>  docs/system/deprecated.rst | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> 
> Regards,
> Daniel
> 


