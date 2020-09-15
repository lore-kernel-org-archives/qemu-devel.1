Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D29C2D0E3
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2943F20684
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/giRKGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2943F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAXf-0005gA-7Q
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIAPy-0004FO-Fw
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:50:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47213
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIAPv-0004Pj-OL
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600174237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B7ClyBqplSCQ5Ng/VKG370wPST8TNTL3QKFAlebyLdk=;
 b=S/giRKGSS7HnUFCUYBKmtqcrc7EuyCjmBQXi7Ei8+l/iX/loRR8zyEdWtyDhUtzfZ7ROhR
 dT7aUwOK/nI2+xWa2ddoxwAQ9pVhnICLElotyoxlVcBO6EuDot9Fln1PLJ0lvWZ1Zb/1Ds
 cntCG1Nu4PUPY68qMuESkudcdzLAgBI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-6tSCMgLzN9KROiRMocHdzA-1; Tue, 15 Sep 2020 08:50:35 -0400
X-MC-Unique: 6tSCMgLzN9KROiRMocHdzA-1
Received: by mail-wm1-f72.google.com with SMTP id t10so1123542wmi.9
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 05:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=B7ClyBqplSCQ5Ng/VKG370wPST8TNTL3QKFAlebyLdk=;
 b=OT2mdbDHhmzONxNkNmiEswk8CcetkPrFmD0vyYqbO/CJ+LcYF4zC2cViFPR3xop8ob
 R5zg5OOkCca3mxEnQsnuvtN3irCScST/wGFehI4zOGyX5vzKrVc5c+Dri2a72G8d/Czf
 +5xHwLZXVQagIqtrIpvHQSaNoa1qURyONDB7NUQUySz/umB7qfvc+r9UCOfQcZGsNHEp
 QXiT6HCYZJrP9YlUw/MdwlaU9IutV3/33jc0OxjZ6EAODnSxHF+x2wtIV6PMsDWAs5V6
 m+KPLEqwSH9O8ZN/RRnVh+LnMcfIzGtZzBzZDvOBE8kMEb6J9F3897wPcr+fd7yKSWX6
 hJiw==
X-Gm-Message-State: AOAM533SNBTu5WU59fSd6O/arvxeMgJCbE83oH0AmmYlshud9nKC+Wov
 GuGDu7ggjKCwdJlgXj7zKmSndmHhQ2pt5omB6QxNf92OJICrjG2Fi2HN3e8SwmrnhHGuW3vKw7r
 26cE6Eo6DD1mDd+4=
X-Received: by 2002:a05:600c:210c:: with SMTP id
 u12mr4914808wml.185.1600174234690; 
 Tue, 15 Sep 2020 05:50:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHe2THeyGJIdpBvZdoxIqo1sxqCOcjv9h+Qra+MBI5+wjQ65dPZUp4kkSdjYZOB4ljPykEJw==
X-Received: by 2002:a05:600c:210c:: with SMTP id
 u12mr4914780wml.185.1600174234413; 
 Tue, 15 Sep 2020 05:50:34 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id g143sm24537875wme.0.2020.09.15.05.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 05:50:33 -0700 (PDT)
Subject: Re: [PATCH] qga/commands-win32: Fix problem with redundant protype
 declaration
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20200915114757.55635-1-thuth@redhat.com>
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
Message-ID: <c173b806-918d-3899-a58d-c082353823e9@redhat.com>
Date: Tue, 15 Sep 2020 14:50:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915114757.55635-1-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:29:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Marc-André

On 9/15/20 1:47 PM, Thomas Huth wrote:
> When compiling QEMU with MSYS2 on Windows, there is currently the
> following error:
> 
> ../qga/commands-win32.c:62:24: error: redundant redeclaration of
>  'CM_Get_DevNode_PropertyW' [-Werror=redundant-decls]
>    62 | CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
>       |                        ^~~~~~~~~~~~~~~~~~~~~~~~
> In file included from ../qga/commands-win32.c:26:
> C:/tools/msys64/mingw64/x86_64-w64-mingw32/include/cfgmgr32.h:840:26: note:
>  previous declaration of 'CM_Get_DevNode_PropertyW' was here
>   840 |   CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(DEVINST dnDevInst,
>    const DEVPROPKEY *PropertyKey, DEVPROPTYPE *PropertyType, PBYTE PropertyBuffer,
>    PULONG PropertyBufferSize, ULONG ulFlags);
> 
> Seems like this protype is sometimes available in the cfgmgr32.h
> header, and sometimes not.

This prototype is declared Since Windows Vista, but per
commit 4ac80866476 ("qga: drop < Vista compatibility")
it should be always true... So I'm confused.

Maybe we should build with:

  QEMU_BUILD_BUG_ON(_WIN32_WINNT < 0x0600); /* Vista */

Commit 56cdca1d7a6 ("build-sys: build with Vista API by default")
defines it if missing... Maybe that's where this problem comes
from? (On too old includes we force them as Vista).

> Let's silence the compiler warning here
> to let the build pass with -Werror, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  I can take this through my "testing" tree together with some other
>  MSYS2 patches if there are no objections.
> 
>  qga/commands-win32.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 48d8bbe649..0c3c05484f 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -57,8 +57,10 @@ DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverDate, 0xa8b865dd, 0x2e3d,
>  DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x2e3d,
>      0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 3);
>      /* DEVPROP_TYPE_STRING */
> -/* The following shoud be in cfgmgr32.h, but it isn't */
> +/* The CM_Get_DevNode_PropertyW prototype is only sometimes in cfgmgr32.h */
>  #ifndef CM_Get_DevNode_Property
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wredundant-decls"
>  CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
>      DEVINST          dnDevInst,
>      CONST DEVPROPKEY * PropertyKey,
> @@ -68,6 +70,7 @@ CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
>      ULONG            ulFlags
>  );
>  #define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW
> +#pragma GCC diagnostic pop
>  #endif
>  
>  #ifndef SHTDN_REASON_FLAG_PLANNED
> 
	


