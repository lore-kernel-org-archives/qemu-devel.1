Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E434C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3878620899
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkFrkPAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3878620899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNa8-000577-Hx
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrNVU-0000Px-Og
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:21:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26990
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrNVS-0004u5-UN
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593789698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TXGOyAfRTueLFIWhliljfrW+qNfpuAQPHew1HnIPaNk=;
 b=UkFrkPAdmde3RtTa37he7Rh8LXDy2ia845Yd693iSjRLunPOvZcGJV3Qoj6HF9ThKYlbuC
 fOe0CeiCJND7TUy7i1JVOA+xDqUI6lACphuWlzh73r9Tm3/LnhH9o8sMJWyXeLHyl4Ok9p
 kOkpY++tcsAX+Bnk2K0T9g7oPN2Tc54=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-HRFaJNNzO2Ghx9R26PX7Ow-1; Fri, 03 Jul 2020 11:21:36 -0400
X-MC-Unique: HRFaJNNzO2Ghx9R26PX7Ow-1
Received: by mail-wr1-f70.google.com with SMTP id s16so18821977wrv.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 08:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=TXGOyAfRTueLFIWhliljfrW+qNfpuAQPHew1HnIPaNk=;
 b=o73cVucJJoZK+dChqPf8hiT21dvTpfsUymnikb0Gn9oe7OL1FzQpySQ0JjleHG7cfI
 kiyNtdQI3HvBd6uI2A26MGdV+jKpMT11IZxq/L7knzlLEB1Wyo1SyBeMrOxOpBgHv1It
 m3RyKGGP+slx8KTm/S7KZNg0boLpy1FmmsYQvHW3VcKSu5Z8RbpE3FeKgGQbwTSCUwgY
 O1gsnc/7pePBrG5pNt0+r82ko0X7pFBCzugZKmYh6RIHnU4u2JTXxTJCktjhGCsYKvxv
 X3NDT9NppXEhQlryUcUE0ra76vp9lNMdSMFvsfigfZbYu3nJbrMu7ogNE7G14Kjcj3fj
 BdAQ==
X-Gm-Message-State: AOAM530O4/qjfvdHd1jODShL4XLwivNARhV8HkfzMWcWxGycchu4mD11
 xQgUCg2rja9D8YlIwUe6163J9Xed6yBGCOjkFnpsbh5zPJWVIJzd7ey3ZiPl7BfRuYV2jPazzGe
 bqF7mFGxEb4PK0SE=
X-Received: by 2002:a1c:1dc7:: with SMTP id d190mr36204811wmd.36.1593789695600; 
 Fri, 03 Jul 2020 08:21:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFdDJ3SlmdZXCYJZQ98o2MkMtKS8AShRntjj2Lc1HWtgAZFM1sq2gkyQyYaLFVu7ecUfNKZg==
X-Received: by 2002:a1c:1dc7:: with SMTP id d190mr36204795wmd.36.1593789695352; 
 Fri, 03 Jul 2020 08:21:35 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id t16sm15509973wru.9.2020.07.03.08.21.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 08:21:34 -0700 (PDT)
Subject: Re: [PATCH v3 4/9] osdep.h: Always include <sys/signal.h> if it exists
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org
References: <20200703145614.16684-1-peter.maydell@linaro.org>
 <20200703145614.16684-5-peter.maydell@linaro.org>
 <2b801122-1ee2-d62d-a5dc-30f7c770b54d@redhat.com>
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
Message-ID: <2f546897-94d8-253b-f3e0-b4d228efd74c@redhat.com>
Date: Fri, 3 Jul 2020 17:21:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2b801122-1ee2-d62d-a5dc-30f7c770b54d@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
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
Cc: David Carlier <devnexen@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 5:15 PM, Thomas Huth wrote:
> On 03/07/2020 16.56, Peter Maydell wrote:
>> From: David CARLIER <devnexen@gmail.com>
>>
>> Regularize our handling of <sys/signal.h>: currently we include it in
>> osdep.h, but only for OpenBSD, and we include it without an ifdef
>> guard in a couple of C files.  This causes problems for Haiku, which
>> doesn't have that header.
>>
>> Instead, check in configure whether sys/signal.h exists, and if it
>> does then always include it from osdep.h.
>>
>> Signed-off-by: David Carlier <devnexen@gmail.com>
>> [PMM: Expanded commit message]
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  configure                   | 8 ++++++++
>>  include/qemu/osdep.h        | 2 +-
>>  hw/xen/xen-legacy-backend.c | 1 -
>>  util/oslib-posix.c          | 1 -
>>  4 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/configure b/configure
>> index ddc53d873ef..d131f760d8f 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3212,6 +3212,11 @@ if ! check_include "ifaddrs.h" ; then
>>    have_ifaddrs_h=no
>>  fi
>>  
>> +have_sys_signal_h=no
>> +if check_include "sys/signal.h" ; then
>> +  have_sys_signal_h=yes
>> +fi
>> +
>>  ##########################################
>>  # VTE probe
>>  
>> @@ -7398,6 +7403,9 @@ fi
>>  if test "$have_broken_size_max" = "yes" ; then
>>      echo "HAVE_BROKEN_SIZE_MAX=y" >> $config_host_mak
>>  fi
>> +if test "$have_sys_signal_h" = "yes" ; then
>> +    echo "CONFIG_SYS_SIGNAL=y" >> $config_host_mak
>> +fi
> 
> I'd maybe rather name it HAVE_SYS_SIGNAL_H, but I guess that's just a
> matter of taste.

Agreed, if possible.
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 


