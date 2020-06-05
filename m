Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FEAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8325920659
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/rqXRv+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8325920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhDJI-0001JX-RP
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 10:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhDId-0000Xd-IX
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:26:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41034
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhDIc-0001Ao-Ku
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591367181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=27WuZTL7NnEN3Ju65h/8x51tlzjKghgjHXh6xlX5Hlk=;
 b=Z/rqXRv+hvMgXVXmrvJ0UYLbln8/pWpqq1Hy6NGvPmCaI+9AldZRAQoFOFHOGqNArEgBxc
 TLuBX5YYHeK5YNpubC9Zmo0yWyAKiyaj0d1DTy/NRHvWUiRFztlPCoHRaKnfNrtXgZmex6
 R+N6twYuV83HWgG38VsB2oEjn2jh+/U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-9Fp0PeJTM321pUbpP1S3rQ-1; Fri, 05 Jun 2020 10:26:19 -0400
X-MC-Unique: 9Fp0PeJTM321pUbpP1S3rQ-1
Received: by mail-wr1-f72.google.com with SMTP id p9so3845475wrx.10
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 07:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=27WuZTL7NnEN3Ju65h/8x51tlzjKghgjHXh6xlX5Hlk=;
 b=FPusx0E7FfDG3K7BfliFL6dBjhn+w+Y+eRJ8orDEd45XuysWOWJ9TSZOlvuXgr+feq
 ecaVO1lrvkSrqObgAZK4tSCYNY74hyFs1aTI8+1Tli5IaILRmxMoxlCzJz1PsZd6yGiq
 mbpc5w8fDk0X6BQ/cUP6bAAagwLvsLdLEKHEP7I6J/6DM/sIoMVzG1gQzvr9+/00vlsv
 HJbSFwyKQAImUl1WrfIylHTv9+QP+HuqJpNZmEkVowTZLJz/JxMf34NGG8CuQW3Zvyvn
 Tdh5GNWrfwEJmBG+Vd/Jy2vb0zHgWXtaMbNJttFa6Q2xPEYFWrnThxHwAVQTYB4N68ZX
 gDtA==
X-Gm-Message-State: AOAM5318iRloc3a+d7rlMF3ruIP8JONu7N3LIqm0GI29hGjywyITFT1b
 E9C0MuwR5+b7A4xZD8Og6kmn496czWXHNCZHPCTNDBPsknRGoaBDFNaqZKZaBqfLC0c3mPnlPsM
 Xdx2L9zd2mRsR48g=
X-Received: by 2002:a1c:b7d5:: with SMTP id h204mr2996688wmf.100.1591367178610; 
 Fri, 05 Jun 2020 07:26:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxBTvZBjzTXTNsAhVcGitLE+Q2HKSRV9rLyCR3N98yTMzpgIGG5c0HcLFR447V7Bsuem/eJw==
X-Received: by 2002:a1c:b7d5:: with SMTP id h204mr2996650wmf.100.1591367178243; 
 Fri, 05 Jun 2020 07:26:18 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y14sm1269531wma.25.2020.06.05.07.26.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 07:26:17 -0700 (PDT)
Subject: Re: [PATCH] block: Remove trailing newline in format used by
 error_report API
To: Markus Armbruster <armbru@redhat.com>
References: <20200228123637.15160-1-philmd@redhat.com>
 <8736auipnb.fsf@dusky.pond.sub.org>
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
Message-ID: <fd516cf1-72bc-63db-84f0-d2f2c5cbad7a@redhat.com>
Date: Fri, 5 Jun 2020 16:26:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8736auipnb.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/28/20 6:32 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> The error_report API doesn't want trailing newline characters.
>> Remove it, to avoid and error when moving the code around:
>>
>>   ERROR: Error messages should not contain newlines
> 
> Commit 312fd5f2909 has a Coccinelle script.  It should be committed and
> re-run.
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  block.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block.c b/block.c
>> index 1bdb9c679d..e466d15914 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -5994,7 +5994,7 @@ void bdrv_img_create(const char *filename, const char *fmt,
>            bs = bdrv_open(full_backing, NULL, backing_options, back_flags,
>                           &local_err);
>            g_free(full_backing);
>            if (!bs && size != -1) {
>>              /* Couldn't open BS, but we have a size, so it's nonfatal */
>>              warn_reportf_err(local_err,
>>                              "Could not verify backing image. "
>> -                            "This may become an error in future versions.\n");
>> +                            "This may become an error in future versions.");
>>              local_err = NULL;
>>          } else if (!bs) {
>>              /* Couldn't open bs, do not have size */
> 
> warn_reportf_err() is a convenience function to error_prepend(),
> warn_report() and free @local_err.

OK now I see.

Why warn_reportf_err() doesn't take a 'Error **err' instead, to set err
to NULL after freeing *err?

> 
> When @local_err holds a message like "pants on fire", the code before
> the patch prints something like
> 
>     qemu-system-x86_64: warning: Could not verify backing image. This may become an error in future versions.
>     pants on fire
> 
> The patch "improves" it to
> 
>     qemu-system-x86_64: warning: Could not verify backing image. This may become an error in future versions.pants on fire
> 
> General advice: this misuse of warn_reportf_err() is an excusable
> mistake, but when you *test* the error path, you can't *not* see that
> the actual message is crap.  Test your errors!
> 
> Actual improvement:
> 
>                warn_reportf_err(local_err, "Could not verify backing image: ");
>                error_printf("This may become an error in future versions.\n");
> 
> This should print
> 
>     qemu-system-x86_64: warning: Could not verify backing image: pants on fire
>     This may become an error in future versions.
> 


