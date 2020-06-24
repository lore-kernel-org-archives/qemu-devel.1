Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02156C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 09:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C0D206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 09:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTBVYjYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C0D206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo1QX-0003ZS-W9
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 05:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jo1Pn-0002Ek-Gl
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 05:09:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49302
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jo1Pl-0000oC-Bn
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 05:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592989792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V4G79XXaPbMP6iIqWMaILK9YCnZFxIVlrSd7WBud8l4=;
 b=jTBVYjYwp8pTLSg3kbKFYfaQrh7ONdEyhjaMiZB4M/KVRdC5efHO2jb0fBbpwyi5e2+Dn/
 +40WR7CmvlKhRDX1UAgZRA5mzrfajB7CShqJpjWEl2aW3L24ZylCwyhW+/SU759jpypsZ1
 hdsVzaFdR7D4Z6P1GmFm3/FWWXW9RBI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-dub9nynYPsugXnyGXq0HzA-1; Wed, 24 Jun 2020 05:09:50 -0400
X-MC-Unique: dub9nynYPsugXnyGXq0HzA-1
Received: by mail-wm1-f72.google.com with SMTP id a21so1893300wmd.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 02:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=V4G79XXaPbMP6iIqWMaILK9YCnZFxIVlrSd7WBud8l4=;
 b=SUz2GKb+ifAr6Z8F47LyjMx6MiGfBS+q6AhGaMt1Bk8Xrme1KQMJhel3fXTDMwIT5F
 15nF+ifz7Yh6PkzCAYOZAi4GIoYVLeAThEV77fDHAB/R1eLohQdJGnsY7Ncaf1yKVczn
 s9d2pwppPCymVz5UoAl2egLy5CAt7miM0otlTM01fe65sUP2gIdetXDxMGyk0KSn8jJG
 dehdlgACD4vFwimZqshGV5n7G0MYqeOFRjbmCvN995Q4BZ2DUGh5ia5GolfS2MSzBXCS
 34jH/NhgbnAs6F9tLbLAvQMIUldWYMmyHuADA+cN1PAXPYxgEH4R0popAWp4wPDBNHM0
 WBFw==
X-Gm-Message-State: AOAM531Jaw347mWOzgawmaN9zjzG77+a3kpDYcbaxVK1cRLcoffOWlZf
 2gY4gZaBrXG0g1O4IMz9VxvQHL1RkMsfhDyUF2d2XxlXPYpGuS0JdehffjjG1c8AtFLoIExQwU6
 pGQsWlZQYz6cHLU4=
X-Received: by 2002:adf:ed47:: with SMTP id u7mr26852710wro.201.1592989789634; 
 Wed, 24 Jun 2020 02:09:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0mxeLzhyF0fsbjxxhGnC8Ou9lTw8GTQqjlwbLqDLaT9FPmsRkmSpCGb075A4eWmDUJUvWpw==
X-Received: by 2002:adf:ed47:: with SMTP id u7mr26852678wro.201.1592989789219; 
 Wed, 24 Jun 2020 02:09:49 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v7sm26486136wrp.45.2020.06.24.02.09.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 02:09:48 -0700 (PDT)
Subject: Re: [PATCH] trivial: Remove extra character in configure help
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>
References: <20200624083337.912846-1-dinechin@redhat.com>
 <20200624085956.GE774096@redhat.com>
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
Message-ID: <fc86d142-a63a-d976-c924-49ff96cb72a5@redhat.com>
Date: Wed, 24 Jun 2020 11:09:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200624085956.GE774096@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/20 10:59 AM, Daniel P. Berrangé wrote:
> On Wed, Jun 24, 2020 at 10:33:37AM +0200, Christophe de Dinechin wrote:
>> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
>> ---
>>  configure | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index ba88fd1824..c7a6a5adfe 100755
>> --- a/configure
>> +++ b/configure
>> @@ -1787,7 +1787,7 @@ Advanced options (experts only):
>>    --block-drv-ro-whitelist=L
>>                             set block driver read-only whitelist
>>                             (affects only QEMU, not qemu-img)
>> -  --enable-trace-backends=B Set trace backend
>> +  --enable-trace-backends= Set trace backend
> 
> This is just following the style of the option above. "B" is a
> placeholder for the desired backend(s).

I agree this is confusing, since then the filename is NAME, not N.

Maybe clearer to replace B -> BACKEND, L -> LIST, ...?

> 
>>                             Available backends: $trace_backend_list
>>    --with-trace-file=NAME   Full PATH,NAME of file to store traces
>>                             Default:trace-<pid>
> 
> 
> Regards,
> Daniel
> 


