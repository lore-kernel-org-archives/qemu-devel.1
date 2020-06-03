Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA843C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A7620679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bE9GzoPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A7620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUWn-0001AC-NY
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgUVR-0007hW-Vr
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:36:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43538
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jgUVQ-0005lu-9I
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591194995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jShcf6r14QddKNgr+dD5dhGl+o2Cd2OLCwje7MJIWkg=;
 b=bE9GzoPXYt722kHENreU+AYN3I1GZ9CyGZOwhvATmUM+TLPQ8ZjvbmqPJsyxfrBQcR+SR6
 BpdjIdb+YOmxNgBdqF9wvO9WfTDrob9xMqDuX/tFB9Hvh1gEmFbaQuJ772A6GeVTvLX/k1
 sGf+nDOXk1U1P6DXrF3e38Cl4BIdlaI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-8-D7DFelMiKYM4cX37_6bg-1; Wed, 03 Jun 2020 10:36:31 -0400
X-MC-Unique: 8-D7DFelMiKYM4cX37_6bg-1
Received: by mail-wm1-f69.google.com with SMTP id v23so953282wmj.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 07:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=jShcf6r14QddKNgr+dD5dhGl+o2Cd2OLCwje7MJIWkg=;
 b=G1cTKK2W9m+BBSqCs35gdsO7UMDqU0njFkxTe4GhTjksfeh85vJ/16h6rFW1DTGHlj
 fKUlFef38FcythtJilhI7d6UNuO/Ksq39mNxqYJtcW0k7LtgjhegYHtTGzx8rrgh0meu
 7tQ7vaYmEtuyAkIB2XYfD7nr3BNj6ISpezFO7PJyzju51YYaeqE641NA0R/8dsU6DtJu
 UGNZXQdlWIRdZiQoQlScRQ8zErxJGu0+JM4AmeRHSvgoWNqdwf4SunR7iopwe3+DI95u
 qtx4Y5luct0CEH/7/xje+r0DZcr+eSEVHPV41gCrnwLXZWUsJu010ExUVnAC7AgSccZx
 M4UQ==
X-Gm-Message-State: AOAM530yFtjvY94IwlXnWuu4IQOreW5bO/IQ+hUXWR1e4KSAejtQlJOo
 9sCDvH+DDaYqH3KvxksjfyIgNPx1pRWzhcDevP1OL0yrDv+H3jWdpMVjnO7nfbuw38GjWmorBQ5
 vmE9goq8uQYyNe8I=
X-Received: by 2002:adf:c6c5:: with SMTP id c5mr22074362wrh.13.1591194990106; 
 Wed, 03 Jun 2020 07:36:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPutnxG1HHD8y19dFBrP6wucJatLWt1wRleaIoIPFcdgVbjmkKG2Ls4DhLT5gM07jYZ24Ntw==
X-Received: by 2002:adf:c6c5:: with SMTP id c5mr22074348wrh.13.1591194989915; 
 Wed, 03 Jun 2020 07:36:29 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t8sm3139950wmi.46.2020.06.03.07.36.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 07:36:29 -0700 (PDT)
Subject: Re: [PATCH] util/oslib-posix : qemu_init_exec_dir implementation for
 MacOS
To: Justin Hibbits <chmeeedalf@gmail.com>
References: <CA+XhMqwH6btbKFD0Ei47e+QHN2eBPG5H2PTS92MAje2Tij4Y=A@mail.gmail.com>
 <76587685-fa03-6dd6-5ca3-caeaf3c7504b@redhat.com>
 <20200603090921.64351a28@titan.knownspace>
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
Message-ID: <4e3b6904-5dfe-0608-88e9-2e051265fcd2@redhat.com>
Date: Wed, 3 Jun 2020 16:36:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200603090921.64351a28@titan.knownspace>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:12:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>,
 qemu-devel@nongnu.org, John Arbuckle <programmingkidx@gmail.com>,
 David CARLIER <devnexen@gmail.com>, Izik Eidus <izik@veertu.com>,
 pbonzini@redhat.com, Mikhail Gusarov <dottedmag@dottedmag.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/20 4:09 PM, Justin Hibbits wrote:
> On Wed, 3 Jun 2020 08:08:42 +0200
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> Cc'ing more developers.
>>
>> On 5/26/20 10:40 PM, David CARLIER wrote:
>>> From b24a6702beb2a4e2a9c1c03b69c6d1dd07d4cf08 Mon Sep 17 00:00:00
>>> 2001 From: David Carlier <devnexen@gmail.com>
>>> Date: Tue, 26 May 2020 21:35:27 +0100
>>> Subject: [PATCH] util/oslib: current process full path resolution
>>> on MacOS
>>>
>>> Using existing libproc to fill the path.
>>>
>>> Signed-off-by: David Carlier <devnexen@gmail.com>
>>> ---
>>>  util/oslib-posix.c | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
>>> index 062236a1ab..96f0405ee6 100644
>>> --- a/util/oslib-posix.c
>>> +++ b/util/oslib-posix.c
>>> @@ -55,6 +55,10 @@
>>>  #include <sys/sysctl.h>
>>>  #endif
>>>
>>> +#ifdef __APPLE__
>>> +#include <libproc.h>
>>> +#endif
>>> +
>>>  #include "qemu/mmap-alloc.h"
>>>
>>>  #ifdef CONFIG_DEBUG_STACK_USAGE
>>> @@ -366,6 +370,15 @@ void qemu_init_exec_dir(const char *argv0)
>>>              p = buf;
>>>          }
>>>      }
>>> +#elif defined(__APPLE__)
>>> +    {
>>> +        uint32_t len;
>>> +        len = proc_pidpath(getpid(), buf, sizeof(buf) - 1);
>>> +        if (len > 0) {
>>> +            buf[len] = 0;
>>> +            p = buf;
>>> +        }
>>> +    }
>>>  #endif
>>>      /* If we don't have any way of figuring out the actual
>>> executable location then try argv[0].  */
>>>   
>>
> 
> Apologies, I don't have context for this.  Why was I CC'd on this?

I did after finding this patch of yours:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg639033.html

> 
> Does proc_pidpath() not NUL-terminate its written string?  And, given
> from my quick google search, it looks like this function is private and
> subject to change, so can you guarantee that the returned length is the
> *written* length, not the full string length?  If not, you could be
> overwriting other arbitrary data.
> 
> - Justin
> 


