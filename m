Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE84C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 18:00:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD1F20578
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 18:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFE+J/mi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD1F20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw8Bk-0003uP-4T
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 14:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jw8Ag-00034E-S0
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:59:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50058
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jw8Ad-0000Ie-Cj
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594922383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zeeoqCKgiwtw/ycTIeTfr1SKk6zRFJxkadzO1rgiPhA=;
 b=dFE+J/mi1DWr/Uh0TcuH+lFAB/YMlAR09SiLfj7wn10YHYvQlEOWNycI2//Jpv5URmuy3W
 Cak7orzUPvqt+pZoE9i/tN00S9IbcSOug7Rr2klJtYHgt6xwOFNL/c3U97xYEGbCt0U4Nv
 BMTLod3iQV3E8ZHpo2FTOIH9amF7rvY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-pWz0Wb0OOMeQbXvTuSwdtw-1; Thu, 16 Jul 2020 13:59:32 -0400
X-MC-Unique: pWz0Wb0OOMeQbXvTuSwdtw-1
Received: by mail-wr1-f71.google.com with SMTP id j5so5761922wro.6
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 10:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zeeoqCKgiwtw/ycTIeTfr1SKk6zRFJxkadzO1rgiPhA=;
 b=h7ro6J7cjtXMy0tQ1iukzoSHZcPaPNmKepTICf7EGwfgWBtX3rQO8GfHb+7GESoVUM
 ltJkhj4JEa4gC5WzmVDzcmJj/LD8RLJyqabWEcH5kEzz6cOpuj/foRQkMS3YmARwtGpP
 C9YVkpVJM9cBNuB/VYo9UDH24fJSGD/SivRfl5gRqfTM3z0KoCjDaEsNLpmukV90P1CR
 NHre5SfHLIBVeIIDRMoR6O9MK4tcVec/I4TQiQVp5BdUrd435J/iL1jWkQxKbmP67kvJ
 3EOjEeYBkTZnWo47Q6yV1qCUiGelRP8pF/YQo0/06qOMl2GoRYk21hnZqarQDEWQ0Xgi
 u19Q==
X-Gm-Message-State: AOAM532Bhjy8pknChUki0Sep3Y49jVsg0humJaqWQA0+sWNIt6zpR8IF
 Ay8CYZ+mRJHtOyIZCF3ZaeIJm5vVb7kSWdQF7gOUvWdXsjHD1Necm2XNwGEWsS8JCEX9OGrKyp4
 aWYafBxeV+mm4ggE=
X-Received: by 2002:a1c:7413:: with SMTP id p19mr5281379wmc.60.1594922370571; 
 Thu, 16 Jul 2020 10:59:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrU224wfOKogl+y3OlDhraTDvcJXUkVY0eCeuesO1QSshsrwjTIx1Knsop/zY/SxN3dM8XWw==
X-Received: by 2002:a1c:7413:: with SMTP id p19mr5281367wmc.60.1594922370315; 
 Thu, 16 Jul 2020 10:59:30 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id v5sm9405475wmh.12.2020.07.16.10.59.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 10:59:29 -0700 (PDT)
Subject: Re: qemu test-qga failure on mergebuild after VERSION file change:
 dependency issues??
To: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA-reu8gKpBMgEffStTRA+M02OWj75riXqBYXjgtOh5Z_A@mail.gmail.com>
 <159492211230.15440.2651129078319986183@sif>
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
Message-ID: <78b8c6b3-1710-da21-68ac-194bd19437b2@redhat.com>
Date: Thu, 16 Jul 2020 19:59:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159492211230.15440.2651129078319986183@sif>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 13:59:43
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

On 7/16/20 7:55 PM, Michael Roth wrote:
> Quoting Peter Maydell (2020-07-16 05:53:17)
>> The first merge I tried to process after bumping VERSION for rc0
>> failed on test-qga like this:
>>
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-qga -m=quick -k --tap < /dev/null | ./scripts/tap-driv
>> er.pl --test-name="test-qga"
>> PASS 1 test-qga /qga/sync-delimited
>> PASS 2 test-qga /qga/sync
>> PASS 3 test-qga /qga/ping
>> **
>> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-qga.c:303:test_qga_info:
>> assertion failed (version == QEMU_VERSION): ("5.0.9
>> 0" == "5.0.50")
>> ERROR test-qga - Bail out!
>> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-qga.c:303:test_qga_info:
>> assertion failed (versio
>> n == QEMU_VERSION): ("5.0.90" == "5.0.50")
>> Aborted (core dumped)
>> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:659:
>> recipe for target 'check-unit' failed
>>
>> Looking at timestamps on files, tests/test-qga.o never got rebuilt,
>> even though config-host.h has been updated (and so has the new
>> QEMU_VERSION). Any idea what's gone wrong here?
>>
>> Also weird: this build tree has no .d files in it.
> 
> I've been trying to reproduce with:
> 
> make
> make check-unit
> *bump VERSION
> make check-unit
> 
> but test-qga.o gets rebuilt as expected and the test passed.
> 
> This is with ubuntu 18.04, x86, with out-of-tree build directory. Are you aware
> of any other factors that might be needed to reproduce this?

The problem is not for qga, it affects all QEMU objects.

> 
>>
>> thanks
>> -- PMM
> 


