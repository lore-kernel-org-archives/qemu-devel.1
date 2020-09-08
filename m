Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B547C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C684322838
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfmU132u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C684322838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFeOO-0000uN-S1
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFeNj-0000Tf-R7
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:13:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37756
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFeNi-00051L-7v
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599574437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4CrLf6Iv5x5rLW0cbZf0c0jZaqZ0s4edj8gilGSfglk=;
 b=NfmU132ukM2WuSRdi/nWdgFJ9lk7Yec6Y6fO9lZW7w08I5XL7ktOFOqQb5CyEkZw3gvwU3
 64BROqaP65r648SgE6CUEzsBivE3cLhb4DVL3DVHtUojJi/oXvjgAyt9cjVBuha94/maEB
 f00AIhS24VbraUI9mOLjg5mCMHggtdE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-oSZ2HK3aMhyntVDFPf9INg-1; Tue, 08 Sep 2020 10:13:56 -0400
X-MC-Unique: oSZ2HK3aMhyntVDFPf9INg-1
Received: by mail-wr1-f72.google.com with SMTP id v12so7036562wrm.9
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 07:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4CrLf6Iv5x5rLW0cbZf0c0jZaqZ0s4edj8gilGSfglk=;
 b=Z+YHA37BfDGWGsQfcoGueHz0sMWIa/o01iT9rIQYtnpu4oAcFkRzvnDxDqpLxMGLE+
 xjJ9fWWLwvIfszX07sIjxsGKjhXetG8xhPB588jE/TsMatOkHVytNDawsAiA/DzYRzHJ
 7kyN+n4JRLRWRmD0ha4nMeB1DrBotR8tQ1ZX3IcBRH3RCUVZ/EeBpudeIkyzU1ucgHua
 AMFyHrWUb/KPY6wUWrwRgepS6K5I/u7Tre3qFGtX+LXq+HzNud+sM7SFPr8nUEeFLhAV
 WH/6qCkHOA4UAS+jdERf9HCEo0cfcChAksu75iFVJI3xulJRiPVPlNjwofKo720dGVJs
 kVyQ==
X-Gm-Message-State: AOAM532+ovuDoLnRNmfA2lghUEgD4FrqM1sUX4ifwMTx5rrgBBGLJw+y
 bJ7oemc2T+JlF1uQucQbgf7x+Qvr8YQflNsEDsQkHBMjnWVtUU74y5jwow1+I0ZGd6e8a++DzHJ
 TSreqA+YmAzelKIc=
X-Received: by 2002:adf:e952:: with SMTP id m18mr26524990wrn.171.1599574432268; 
 Tue, 08 Sep 2020 07:13:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqdpEvd1AkFho84XyWakDPEc2izUFkpYhK+ou/fNgf5xBQ5kh2WZyoCHi1FsEs+wb7MtVUHQ==
X-Received: by 2002:adf:e952:: with SMTP id m18mr26524977wrn.171.1599574432095; 
 Tue, 08 Sep 2020 07:13:52 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id d5sm37366165wrb.28.2020.09.08.07.13.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 07:13:51 -0700 (PDT)
Subject: Re: [PULL v5 00/46] Next round of Meson bugfixes and cleanups
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200908094408.27091-1-pbonzini@redhat.com>
 <CAFEAcA8JZhrxNgayLaCGqQiGLhybvXo7qrXDUpVmkrX5FmjV5A@mail.gmail.com>
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
Message-ID: <dbc559bd-8e4c-d4d3-6719-143cd8b7b8d7@redhat.com>
Date: Tue, 8 Sep 2020 16:13:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8JZhrxNgayLaCGqQiGLhybvXo7qrXDUpVmkrX5FmjV5A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 3:26 PM, Peter Maydell wrote:
> On Tue, 8 Sep 2020 at 10:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit e11bd71f89649da3cff439c030d2ccac0cc914e3:
>>
>>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-09-07' into staging (2020-09-07 16:51:00 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to ef6a0d6e3927464de67f70cb13abbfe67361e0c9:
>>
>>   docs: update build system documentation (2020-09-08 07:21:55 +0200)
>>
>> ----------------------------------------------------------------
>> meson related:
>> * convert unit tests
>> * bugfixes for mtest2make
>> * miscellaneous bugfixes
>> * dead code removal and configure cleanups
>> * oss-fuzz fixes
>> * msys fixes
> 
> 
> Applied, thanks.

Once rebased I got:

Makefile.include:144: warning: overriding recipe for target 'check-block'
Makefile.mtest:1339: warning: ignoring old recipe for target 'check-block'
config-host.mak is out-of-date, running configure

Nothing to worry about as Makefile.mtest is generated.
I wonder if it is possible to avoid such warnings though...


