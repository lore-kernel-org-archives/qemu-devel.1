Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FF7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843212075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbEIxcaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843212075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97I0-00040t-Qj
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 09:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k97HR-0003aQ-34
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k97HO-0000rd-OO
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598017225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=E57I4DgHEuBwwE9TmksZ7b9D1QQfNk8H0m0nXPWDNT4=;
 b=fbEIxcaO7BHo1XZLyacNihsSt3BcQgmB4yTGRjDFX9+dB9fhFNr4w6EaaFS+FkduG4g49k
 /vJre56vLiN/a6Btzho4Tytp3z5NMCgnICN8dh1+wu0CSxfSZTK0l4vBpTQkZKnfkAyYWs
 iUcjRBHIQCULH7rHq5zTemKGcnCJhq0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-Sw68hRLINMae5jQQCjZgoA-1; Fri, 21 Aug 2020 09:40:24 -0400
X-MC-Unique: Sw68hRLINMae5jQQCjZgoA-1
Received: by mail-wm1-f71.google.com with SMTP id p23so997688wmc.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 06:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=E57I4DgHEuBwwE9TmksZ7b9D1QQfNk8H0m0nXPWDNT4=;
 b=OPgF1mSCuy2rmTEVkDRa9B4YIuULObZ+zbXFYCf2ImdEDqb7AW8Sp4olJK3gLQKxDS
 RzBki0TsEoaGICD+5VodcLEm55DnmNqgQiw/kKr+QOUT2x0X5Z1ErTcUQSTZiq8dGh5n
 F7Wydaa8pEtg6XgWlXwjhl/juJNwsBbeJ73sl1O2RDlu4waz9kXLQUasYpXbO48WZep+
 wTTUweInIQ2d6Kl17Hx/Hn8V1THykrJPFVvwz4zVyaVCitJrWAFf59q3QVTG+aTMjBha
 l6XHuBwQgwCgXAdIRm61dL4hmBtsyA9dh0tPZfsBS11bQlN8226jf4P/aFlP3cj92mv+
 WYDw==
X-Gm-Message-State: AOAM530055PMVC0Lfr4XLK6Oc52EaiKzHRYgvEslcswB8Q5Z/dMRQXGa
 khub48iZHXXB/A4a4m6pJOqPiw4oe33h64wP5oj1H3Tc1mXqqai70dAdlJ5NW0UIeOb6Vo/AU35
 x3mXzhzmvpkYeZjU=
X-Received: by 2002:a7b:c923:: with SMTP id h3mr1900957wml.29.1598017219805;
 Fri, 21 Aug 2020 06:40:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKVtNgFipp5y80Jf62xzdaGiFhV6EgOwHTqemqf87xtpZKuSUO53zzXRJFZLrs5eMr+cwKqA==
X-Received: by 2002:a7b:c923:: with SMTP id h3mr1900935wml.29.1598017219597;
 Fri, 21 Aug 2020 06:40:19 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id f6sm6733614wme.32.2020.08.21.06.40.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 06:40:18 -0700 (PDT)
Subject: Re: [PATCH] virtiofsd: add -o allow_directio|no_directio option
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
References: <20200821034126.8004-1-zhangjiachen.jaycee@bytedance.com>
 <20200821115829.GJ348677@redhat.com>
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
Message-ID: <7371d876-37d8-63b6-679e-656a98d8ecb3@redhat.com>
Date: Fri, 21 Aug 2020 15:40:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821115829.GJ348677@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Yongji Xie <xieyongji@bytedance.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 1:58 PM, Daniel P. Berrangé wrote:
> On Fri, Aug 21, 2020 at 11:41:26AM +0800, Jiachen Zhang wrote:
>> Due to the commit 65da4539803373ec4eec97ffc49ee90083e56efd, the O_DIRECT
>> open flag of guest applications will be discarded by virtiofsd. While
>> this behavior makes it consistent with the virtio-9p scheme when guest
>> applications using direct I/O, we no longer have any chance to bypass
>> the host page cache.
>>
>> Therefore, we add a flag 'allow_directio' to lo_data. If '-o no_directio'
>> option is added, or none of '-o no_directio' or '-o allow_directio' is
>> added, the 'allow_directio' will be set to 0, and virtiofsd discards
>> O_DIRECT as before. If '-o allow_directio' is added to the stariting
>> command-line, 'allow_directio' will be set to 1, so that the O_DIRECT
>> flags will be retained and host page cache can be bypassed.
>>
>> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
>> ---
>>  tools/virtiofsd/helper.c         |  4 ++++
>>  tools/virtiofsd/passthrough_ll.c | 20 ++++++++++++++------
>>  2 files changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
>> index 3105b6c23a..534ff52c64 100644
>> --- a/tools/virtiofsd/helper.c
>> +++ b/tools/virtiofsd/helper.c
>> @@ -180,6 +180,10 @@ void fuse_cmdline_help(void)
>>             "                               (0 leaves rlimit unchanged)\n"
>>             "                               default: min(1000000, fs.file-max - 16384)\n"
>>             "                                        if the current rlimit is lower\n"
>> +           "    -o allow_directio|no_directio\n"
>> +           "                               retain/discard O_DIRECT flags passed down\n"
>> +           "                               to virtiofsd from guest applications.\n"
>> +           "                               default: no_directio\n"
>>             );
> 
> The standard naming convention from existing options is to use
> $OPTNAME and no_$OPTNAME.
> 
> IOW, don't use the "allow_" prefix. The options should be just
> "directio" and "no_directio"

As we have 'max_idle_threads' (and not maxidlethreads), can we
use 'direct_io' instead?

> 
> Regards,
> Daniel
> 


