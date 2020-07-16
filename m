Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2931AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 20:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A8B206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 20:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTHB5s+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A8B206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwAAG-0005Ez-W3
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 16:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jwA9g-0004p4-Ut
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 16:06:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51539
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jwA9e-0007u3-Fm
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 16:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594930013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=O0pbMRvcosLRRQ081S7pSYdPLd/Whyn1WqjJAzVlK7U=;
 b=OTHB5s+Wnnf7d4Xd9RIfPh0Tq+oObRVsUfB61/R3xAuSKYB5L/0d1nGcozTTwtMbBDsUV+
 FstW3ExSuHX+M7N6Tkr78H6lxGpkYgTPkD4kasaafVS4fEB9xrAd1f8Rl5LeDdIgtbcDoj
 toydahvypxzfQ5Sgkc6nOn16Q+Lo+jY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-8-Qo4d6sM2mOhqqwjld1VA-1; Thu, 16 Jul 2020 16:06:36 -0400
X-MC-Unique: 8-Qo4d6sM2mOhqqwjld1VA-1
Received: by mail-ej1-f70.google.com with SMTP id q11so3829137eja.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 13:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O0pbMRvcosLRRQ081S7pSYdPLd/Whyn1WqjJAzVlK7U=;
 b=YtvKsGiI4FZ2xmbrn8fwbWELl64VD39VllK/nYeqdFfHIdM25yj1kzfKwNPZf++15v
 UehlJCYkmD/KHuJ+lGcKac9cPh/WXaSmJtVTY9dwrhITp9xGIvngLMHXROcinbFy8MMq
 /JUwlIs1PG5l5AOiQX3yTlDrSE+8JYJAY19nhUEHzUthK6sLGCqqKGFKZfQmP2brDxvq
 jrwVAFj7pgC+GwsQ0wZqawkJycWfAP0IZtN0JAHzx5UaHc/QrvB5HkG5wECgoK9EjaXH
 9fGkixfk5Qc+EgL6wNphyn/LADjYnU8WtKtgO4aLi4hVVx+MoZQCcNy3iytS322E/c/3
 igxg==
X-Gm-Message-State: AOAM533/3YHTWB7Cob77JqDv28TnzQZMAFawUHN3OpFtefDID8u+qz+z
 kV6KsNRlYtAQZA0IDHKBgYxIw5LamyirYronijCOGqNcaJpGeTKV2OjdJyHRkyLR+Z5WSKBCVMj
 +mnYYGV124whEesw=
X-Received: by 2002:a17:906:280c:: with SMTP id
 r12mr2934981ejc.105.1594929995000; 
 Thu, 16 Jul 2020 13:06:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJ9UFm45xcH1NqYmDquTSRcf95Jp1NXjkbxMp5UEp1ChycLQXbFFIF4MrjrbdgBEhOSG/EBg==
X-Received: by 2002:a17:906:280c:: with SMTP id
 r12mr2934956ejc.105.1594929994627; 
 Thu, 16 Jul 2020 13:06:34 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id qn8sm5971301ejb.25.2020.07.16.13.06.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 13:06:34 -0700 (PDT)
Subject: Re: qemu test-qga failure on mergebuild after VERSION file change:
 dependency issues??
To: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA-reu8gKpBMgEffStTRA+M02OWj75riXqBYXjgtOh5Z_A@mail.gmail.com>
 <159492211230.15440.2651129078319986183@sif>
 <78b8c6b3-1710-da21-68ac-194bd19437b2@redhat.com>
 <159492915780.15440.8588802536547059593@sif>
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
Message-ID: <0a4f90df-79bc-f595-7eec-c0577b3c6017@redhat.com>
Date: Thu, 16 Jul 2020 22:06:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159492915780.15440.8588802536547059593@sif>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:25:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On 7/16/20 9:52 PM, Michael Roth wrote:
> Quoting Philippe Mathieu-Daudé (2020-07-16 12:59:28)
>> On 7/16/20 7:55 PM, Michael Roth wrote:
>>> Quoting Peter Maydell (2020-07-16 05:53:17)
>>>> The first merge I tried to process after bumping VERSION for rc0
>>>> failed on test-qga like this:
>>>>
>>>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>>>> tests/test-qga -m=quick -k --tap < /dev/null | ./scripts/tap-driv
>>>> er.pl --test-name="test-qga"
>>>> PASS 1 test-qga /qga/sync-delimited
>>>> PASS 2 test-qga /qga/sync
>>>> PASS 3 test-qga /qga/ping
>>>> **
>>>> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-qga.c:303:test_qga_info:
>>>> assertion failed (version == QEMU_VERSION): ("5.0.9
>>>> 0" == "5.0.50")
>>>> ERROR test-qga - Bail out!
>>>> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-qga.c:303:test_qga_info:
>>>> assertion failed (versio
>>>> n == QEMU_VERSION): ("5.0.90" == "5.0.50")
>>>> Aborted (core dumped)
>>>> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:659:
>>>> recipe for target 'check-unit' failed
>>>>
>>>> Looking at timestamps on files, tests/test-qga.o never got rebuilt,
>>>> even though config-host.h has been updated (and so has the new
>>>> QEMU_VERSION). Any idea what's gone wrong here?
>>>>
>>>> Also weird: this build tree has no .d files in it.
>>>
>>> I've been trying to reproduce with:
>>>
>>> make
>>> make check-unit
>>> *bump VERSION
>>> make check-unit
>>>
>>> but test-qga.o gets rebuilt as expected and the test passed.
>>>
>>> This is with ubuntu 18.04, x86, with out-of-tree build directory. Are you aware
>>> of any other factors that might be needed to reproduce this?
>>
>> The problem is not for qga, it affects all QEMU objects.
> 
> But is it intermittent, environment-dependent? I'm trying to understand how to
> replicate Peter's result since it seems like it would be straightforward
> reproducer.

How to reproduce:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg723531.html

> 
>>
>>>
>>>>
>>>> thanks
>>>> -- PMM
>>>
>>
> 


