Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09B1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DB8F20679
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oq3RvKl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB8F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joP2j-0002NH-OG
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joP1v-0001db-4A
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:22:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33409
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joP1t-0005h1-4R
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593080568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Yfmxpy5uQxgStAKnRU4jGnoVm0zydGHvT0Y0P6mx7yk=;
 b=Oq3RvKl3cH7NDagOH54XmQiVcajDq43tjoC1ONpN4HGcFDjE8Z4CLXWPn9dTrRMmVZ6Jxf
 4YG7tkk8PLJcS28j0aQrAwinOAza+jBl++Ghm+Db+c01GtGOXrb+MljtEAjfvkdiFp1Nsg
 iP13CKyrEUi8FybQxCa29VGBcZrKl5E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-D4WIVBuZN8SeMfnTb-nNAg-1; Thu, 25 Jun 2020 06:22:46 -0400
X-MC-Unique: D4WIVBuZN8SeMfnTb-nNAg-1
Received: by mail-wr1-f71.google.com with SMTP id o12so6439531wrj.23
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 03:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Yfmxpy5uQxgStAKnRU4jGnoVm0zydGHvT0Y0P6mx7yk=;
 b=sjr2E/X7j7rNXowooYKPik39WpWwUoliGQCiMfbDkrFHvozXxWyABG953gpT0ZX0z7
 9SVYm9WJJmNarneJAYZzkxWqx0fsvAW5vjG4f6ENq9exE0ZxDfhE8WLJpLkepkSG9UT2
 d+h6id6uGIxshOLc5gsyWTaX1h6mwTf2njDN2dqN4m9s9Hpz+2evdRqCMzhIKyUNsZHa
 xFIiEBZj35V4RRJG3OJlW0ofq+Ja0Ma0vHD80jX2aJjxtfW/skpSfwHFqWw3dHv3A5vO
 FvTeWiF4y9bJJTwEKKlhwC9HdUTP57Mgu0YQMo6Xcq5Q5vZTt4Sp/+VcakBDp/KcF02h
 wWZA==
X-Gm-Message-State: AOAM530l8iur7WeZmSD1Zd3IOBFVk9tW3xkDCLICsRSGasnKylXrmEbG
 vL7sQQ7KVyewpL3cjGbVGPs1fqWohnIPkPx1W0XTvb0MIzhZcVi2tFJ63tNt9IqqNbnMRSRuf6w
 3VWKLpj0vMjH2QqM=
X-Received: by 2002:a5d:6802:: with SMTP id w2mr9211160wru.88.1593080565845;
 Thu, 25 Jun 2020 03:22:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyum9XIpVs9Z4AgWdAFNt8dhQKng/+DSt/8BZ0Pp8+X3ozQ1dlt+jp89yOC28mxEWRT/iZX1Q==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr9211139wru.88.1593080565641;
 Thu, 25 Jun 2020 03:22:45 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id j6sm4111419wma.25.2020.06.25.03.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 03:22:45 -0700 (PDT)
Subject: Re: [PATCH v9 00/10] accel: Allow targets to use Kconfig
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200618123342.10693-1-philmd@redhat.com>
 <5332815d-49d7-21da-e752-c39c5b35adc4@redhat.com>
 <05a17243-6203-0663-2bc1-e5efd59c4e67@redhat.com>
 <ee53f6e6-e1dd-2c58-244f-9dc98160e3fd@redhat.com>
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
Message-ID: <b5c55c72-17f6-12d4-76e1-a3704c42b12b@redhat.com>
Date: Thu, 25 Jun 2020 12:22:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ee53f6e6-e1dd-2c58-244f-9dc98160e3fd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>, haxm-team <haxm-team@intel.com>,
 Claudio Fontana <cfontana@suse.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 12:20 PM, Paolo Bonzini wrote:
> On 25/06/20 09:49, Philippe Mathieu-Daudé wrote:
>> Hi Paolo,
>>
>> Claudio raised an issue with patch #4, so at this point
>> I have to admit again having the KVM-only build merged
>> for the next release won't be possible :(
>>
>> Only patch #9 depends on patch #4. Are you OK to take
>> the rest of the series, patches 1-3, 5-8, 10 (all but
>> 4 and 9). Patches are fully reviewed. If it is easier
>> for you I can respin without 4/9.
> 
> Yes, sounds good.  Patch 4 isn't great and with Meson we can indeed do
> better because all config-target.mak files are parsed in a single
> non-recursive build.

OK, thanks!


