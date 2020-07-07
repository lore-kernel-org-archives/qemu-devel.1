Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7460C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 04:59:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869D720708
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 04:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/7OAPMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869D720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsfhk-0003jn-Ow
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 00:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsfhC-0003Ku-0A
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 00:59:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24213
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jsfh9-0001Gs-7y
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 00:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594097942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XY9duJjr9kzfWdl2XXOzerDFnXcajE7pA8T/3CH8DME=;
 b=h/7OAPMp3ih55cSg22p4xtAIFLTmDfxTbHiC3cjOwUX7fA/S4zOtC2TEac7WXY0qF6/htb
 2rd/S9YiUi0n636t5wr448XV/6oNdpLLhtXpOZhRWTEum5lWkAx34BO/O8o4CZdcA2v6GD
 fPeZDZ7wnIWTXWrK91c8cfKoUHBBDpo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-5VZRAQBWPhuq01g9MZzwjg-1; Tue, 07 Jul 2020 00:59:00 -0400
X-MC-Unique: 5VZRAQBWPhuq01g9MZzwjg-1
Received: by mail-wr1-f69.google.com with SMTP id c6so28249128wru.7
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 21:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=XY9duJjr9kzfWdl2XXOzerDFnXcajE7pA8T/3CH8DME=;
 b=N95uhzv80KPjMYRQ8GYvKzTxxUQpQngahF3g2gE/g/RJ7lerfcgbXlfaotMjyO2QA+
 WEvvbiNGGkPtmIkgW5uTDWB6Eh7loQwyyky7VfSXCQ9slJBai5WObNzuJ1GtGmRzJMJI
 7+VNhf0KO1q7kenNR3JbKN+SKlI/IXm+rU8U0EEsbW3F0+b78b/DYU7zzzBofgCqMSAM
 rmxDdt8KrLuIn5GtimKLQDL+Gbg1QtFKWDhYD8aKi1hXe9nMHMJVSONKcJ/J7E1CPKzg
 i2kT8aJqfmYHatv39VPMdTcag0Mswi/1lA51XW7XBRF0Z5PiRXnnewSXR9sYxGEyP46s
 dzRA==
X-Gm-Message-State: AOAM531ZM5W1eZr6HJbkFsFhCzlZq0tYkwL9xLCMxu4QUuIgwClyvNet
 aaAi7ihUi7HMnbTGpPgdOGVcI7wD9VrbJUmp/lvUv50e4o3MSQD0x94NYzfwuGpN8aP4gPJtlsZ
 86BmdcbplXbblhbA=
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr2322585wmb.185.1594097939311; 
 Mon, 06 Jul 2020 21:58:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlcvUyairg0icEjY2gPyPzB+8cSJZp43jfK0nFva4F64Pct6d2dYygbhXsGlrK8ksa1zIiEQ==
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr2322562wmb.185.1594097939097; 
 Mon, 06 Jul 2020 21:58:59 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id f15sm1726576wmj.44.2020.07.06.21.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 21:58:58 -0700 (PDT)
Subject: Re: Slow down with: 'Make "info qom-tree" show children sorted'
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
References: <20200527084754.7531-1-armbru@redhat.com>
 <20200527084754.7531-3-armbru@redhat.com>
 <49bea110-0a3d-5a40-6647-67b116fb41b5@redhat.com>
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
Message-ID: <5e967e5f-8ae5-01cc-0dfe-f22e0f03b6b3@redhat.com>
Date: Tue, 7 Jul 2020 06:58:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <49bea110-0a3d-5a40-6647-67b116fb41b5@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, berrange@redhat.com,
 ehabkost@redhat.com, mark.cave-ayland@ilande.co.uk, Greg Kurz <groug@kaod.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <dgibson@redhat.com>, pbonzini@redhat.com,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 6:45 AM, Thomas Huth wrote:
> On 27/05/2020 10.47, Markus Armbruster wrote:
>> "info qom-tree" prints children in unstable order.  This is a pain
>> when diffing output for different versions to find change.  Print it
>> sorted.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qom/qom-hmp-cmds.c | 24 ++++++++++++++++--------
>>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
>  Hi Markus,
> 
> this patch causes a slow down of the qtests which becomes quite massive
> when e.g. using the ppc64 and thourough testing. When I'm running
> 
> QTEST_QEMU_BINARY="ppc64-softmmu/qemu-system-ppc64" time \
> ./tests/qtest/device-introspect-test -m slow | tail -n 10
> 
> the test runs for ca. 6m40s here before the patch got applied, and for
> mor than 20 minutes after the patch got applied!

Argh, yesterday I reviewed again all the range except this patch... not
sure why as looking at it now it is obvious.

> This causes our gitlab CI to constantly fail since the patch got merged,
> since the testing time now exceeds the 1h time limit:
> 
>  https://gitlab.com/qemu-project/qemu/-/pipelines/156767175
> 
> Sure, we can work around that problem in the CI (Alex has already a
> patch queued), but still, is there something you could do about this
> massive slowdown?

Suggestion: add a '-u' option for unsorted mode, to use in qtests.

Humans want the new behavior (default: sorted).

Regards,

Phil.


