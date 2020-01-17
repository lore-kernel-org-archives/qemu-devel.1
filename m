Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D12C33CB3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 06:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7E420730
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 06:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLFP6GrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7E420730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isLIy-0003OY-Vz
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 01:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isLIM-0002mC-JE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 01:39:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isLIL-0002Rq-Gx
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 01:39:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57144
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isLIL-0002R4-C7
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 01:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579243188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fALnl7TDEr0GoLH1P5P31ot/dOE0oVxMVC2leM/ugFA=;
 b=jLFP6GrJtmaXSjL7WOlSEL3CGPlkxr9vTX9d1hQ+5hDQ/v2s2B/bRF6uCOt2IF9jVx5pwU
 oQbulMNMuYksOmKdGqF4erFljjMEbPeiY7TT14sWaEyHSUibwPC7s4x2Nq4NYr8UwgN9/n
 SWYCR3AJvAfIptES38WgdC2P171mnlU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-2pMG7kCxNyiZ9VcOV_bchw-1; Fri, 17 Jan 2020 01:39:47 -0500
Received: by mail-wr1-f72.google.com with SMTP id c17so10092554wrp.10
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 22:39:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fALnl7TDEr0GoLH1P5P31ot/dOE0oVxMVC2leM/ugFA=;
 b=UQV2PYKXJItgVAdcKqpbqEuxQYcHeG6ptyQnavezFgqsWxsjMc7LZ/jUbI+CPHBh6w
 7wgdXPIbRv4vVGHDJMH/NoJG/8tcKmi6u+r5Imlnl8jLPj2TBhJSRqI/07MXTugtO05e
 ERGbPYpL3xUGMmvkHYYuAtYkH8EJ5GGhkbit+I9yMhcZX5afvPAmU5SGYIzCLOH1/krz
 2EoSj8dd8DCyTml0TaYqJ9dtZOaQgCiGXr4zyRDyag3t8KNUZukh5SKqEX/Kd5OlctpT
 +t/qRq4V46Al1nl7l1vExEHjJXb34B/pAON/0afiyK8wnFVhz3hba8Zu7zU/biCIFtjZ
 B7VA==
X-Gm-Message-State: APjAAAU/et4LTO/VjVvYCriX43JO/UOZsRBIEqelFFA1AYzuzX4rhRRv
 UuXPAjDX3WkdthW2WYGeGrxbzzDhuaKVAPCTrxalua57mt+fCzZp0FBmzSTYC13KKSjjbFnF38p
 w5OAGhrVAbmmeT5w=
X-Received: by 2002:a1c:1dd7:: with SMTP id d206mr2997868wmd.5.1579243185960; 
 Thu, 16 Jan 2020 22:39:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjKjnZb6PPM1Da3vSCPswnJHAIA8mo+xSzvohctBSRrAGQFvC1NunPSxaeqHjC+hDP0pNCBA==
X-Received: by 2002:a1c:1dd7:: with SMTP id d206mr2997857wmd.5.1579243185752; 
 Thu, 16 Jan 2020 22:39:45 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id c17sm32460697wrr.87.2020.01.16.22.39.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 22:39:45 -0800 (PST)
Subject: Re: [PATCH v2 4/5] linux-user: Add x86_64 vsyscall page to
 /proc/self/maps
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200116194341.402-1-richard.henderson@linaro.org>
 <20200116194341.402-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5bc5e687-b120-ec47-724f-dc3044399712@redhat.com>
Date: Fri, 17 Jan 2020 07:39:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116194341.402-5-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: 2pMG7kCxNyiZ9VcOV_bchw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 8:43 PM, Richard Henderson wrote:
> The page isn't (necessarily) present in the host /proc/self/maps,
> and even if it might be it isn't present in page_flags, and even
> if it was it might not have the same set of page permissions.
> 
> The easiest thing to do, particularly when it comes to the
> "[vsyscall]" note at the end of line, is to special case it.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 171c0caef3..eb867a5296 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7005,6 +7005,15 @@ static int open_self_maps(void *cpu_env, int fd)
>           }
>       }
>   
> +#ifdef TARGET_X86_64
> +    /*
> +     * We only support execution from the vsyscall page.
> +     * This is as if CONFIG_LEGACY_VSYSCALL_XONLY=y from v5.3.
> +     */
> +    dprintf(fd, "ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0"
> +                "          [vsyscall]\n");

Can we add a definition for 0xffffffffff600000ull in the previous patch, 
and use it with TARGET_PAGE_MASK here?

> +#endif
> +
>       free(line);
>       fclose(fp);
>   
> 


