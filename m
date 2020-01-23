Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FA6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 09:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C4F7217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 09:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmO866wm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4F7217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuYmn-0004Cn-Oc
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 04:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuYmC-0003lq-7J
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 04:27:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuYmA-0002Gr-Cc
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 04:27:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39430
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuYmA-0002F9-2q
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 04:27:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579771665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7nxI08Gqml5d8dMaEfw0snx8SOC5BFNHrT2Vll8WtZk=;
 b=YmO866wmCmzD776hcu8ZnWLesuAlGo5zMJAX7PxRcpJvOsQWWAxDA6iwXWRA5fM4j43hJ5
 nb+WPdBT42JdJrJHGz88TfKkamWCg7ZkZY4JNmbNXX9CEZoQkxD/w9LoEyrQCKwiDUlq0b
 ko2ZOrfLilpUVAx8e7anhSO4j+4hAxY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128--_4EsxQaOzGrq8fb2J9qgw-1; Thu, 23 Jan 2020 04:27:42 -0500
Received: by mail-wr1-f72.google.com with SMTP id c17so1449749wrp.10
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 01:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7nxI08Gqml5d8dMaEfw0snx8SOC5BFNHrT2Vll8WtZk=;
 b=aftVMF6XoP/hvb60QZ2+Xi0ssL7gLD8l7KyPaHrpgjSQZ6P5G2JpNg2cNIAjVTeyaF
 l8l672ka2lfYjicn+4tvFrgnbgTh2M0+iFoMyQVStrBADOzc9rMgoXPbMhJaeEF0Fu2W
 VriizvS/Jjzr5hXz37v2B+dWbPfbaVMwwKTNaPSM0lmrryLfO5sNUx7KBPbQRusIeHOI
 yxQbpzwsajjvlFjBc+6nJsLWmycSFleM4K9rHR2VPe/u7VworP2a2D2TFsXNkkln9eM9
 yknftLdZYhU8URhhP5zrtyxyaZiWLQN9cuyMwZExqUVKs5CtAyJ2UgCGl4lLBFZQOQ6q
 /ziQ==
X-Gm-Message-State: APjAAAWsbzKtpMLQVWziMPfSlIyO9KkCx5Y3gKPpp293AtA/iCxXRKp+
 qtnfpDuWjluv1B7H5okiRNkLh/5w7hh5mU0qHZ5+9nBkTyAkZMglKc42DlLVGozyDtslbR3D9iE
 cGCbtmsQWz8DB8us=
X-Received: by 2002:a5d:6551:: with SMTP id z17mr16603567wrv.269.1579771661442; 
 Thu, 23 Jan 2020 01:27:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqzSkDjQ1fHxEpACRR2eTDutioxDojfwIhA+guX5BrvbHdqfgFD20w48T+MqIo/Bv3notNASqQ==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr16603536wrv.269.1579771661105; 
 Thu, 23 Jan 2020 01:27:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059?
 ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
 by smtp.gmail.com with ESMTPSA id w83sm1798236wmb.42.2020.01.23.01.27.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 01:27:40 -0800 (PST)
Subject: Re: [PATCH] target/i386: Add the 'model-id' for Skylake -v3 CPU models
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
References: <20200123090116.14409-1-kchamart@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <86d289ba-9311-937c-2e4c-77308b887f87@redhat.com>
Date: Thu, 23 Jan 2020 10:27:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200123090116.14409-1-kchamart@redhat.com>
Content-Language: en-US
X-MC-Unique: -_4EsxQaOzGrq8fb2J9qgw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: berrange@redhat.com, ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/01/20 10:01, Kashyap Chamarthy wrote:
> This fixes a confusion in the help output.  (Although, if you squint
> long enough at the '-cpu help' output, you _do_ notice that
> "Skylake-Client-noTSX-IBRS" is an alias of "Skylake-Client-v3";
> similarly for Skylake-Server-v3.)
> 
> Without this patch:
> 
>     $ qemu-system-x86 -cpu help
>     ...
>     x86 Skylake-Client-v1     Intel Core Processor (Skylake)
>     x86 Skylake-Client-v2     Intel Core Processor (Skylake, IBRS)
>     x86 Skylake-Client-v3     Intel Core Processor (Skylake, IBRS)
>     ...
>     x86 Skylake-Server-v1     Intel Xeon Processor (Skylake)
>     x86 Skylake-Server-v2     Intel Xeon Processor (Skylake, IBRS)
>     x86 Skylake-Server-v3     Intel Xeon Processor (Skylake, IBRS)
>     ...
> 
> With this patch:
> 
>     $ ./qemu-system-x86 -cpu help
>     ...
>     x86 Skylake-Client-v1     Intel Core Processor (Skylake)
>     x86 Skylake-Client-v2     Intel Core Processor (Skylake, IBRS)
>     x86 Skylake-Client-v3     Intel Core Processor (Skylake, IBRS, no TSX)
>     ...
>     x86 Skylake-Server-v1     Intel Xeon Processor (Skylake)
>     x86 Skylake-Server-v2     Intel Xeon Processor (Skylake, IBRS)
>     x86 Skylake-Server-v3     Intel Xeon Processor (Skylake, IBRS, no TSX)
>     ...
> 
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
>  target/i386/cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 41f28cebf946c7dd77a066eac55623a7370730d5..821cab7f2a4eda43631359a95f7b3bb301b9788f 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2905,6 +2905,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
>                  .props = (PropValue[]) {
>                      { "hle", "off" },
>                      { "rtm", "off" },
> +                    { "model-id",
> +                      "Intel Core Processor (Skylake, IBRS, no TSX)" },
>                      { /* end of list */ }
>                  }
>              },
> @@ -3028,6 +3030,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
>                  .props = (PropValue[]) {
>                      { "hle", "off" },
>                      { "rtm", "off" },
> +                    { "model-id",
> +                      "Intel Xeon Processor (Skylake, IBRS, no TSX)" },
>                      { /* end of list */ }
>                  }
>              },
> 

Queued, thanks.

Paolo


