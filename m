Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D0DC4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82ADE206C1
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 17:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQnqzRyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82ADE206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOllJ-0004Iu-FC
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 13:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOlkO-0003mh-Ox
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:55:04 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOlkN-0004dx-1S
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 13:55:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id w5so5203696wrp.8
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 10:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yQUOKdIlSVTudHSJHdqpZDQtd7oAf1RVItbdyqHPnSQ=;
 b=JQnqzRyAHmIGGwbFhozNbRw4mHDQvIHFWlqitQsD4NZSy2cobGyaYnRP7onPlArxK9
 jvSCXFfL6DNdpK7DewFIoRcCKwGVRQh+mRtINhR7f3FkOOyEr1ZiKOW+byYWQOAM1FYw
 SNufm0Bs0Eg0DLcE5WBYBSVbL1tO/4tmpbGoJHnQ6vnHSrVyES3bYqz0LiXczssVng9S
 v3EHXzXyMYZ6yAkiMbbB00RW+7gHgdwX6WbsAoYmx1eJI+UvIQqxOs/p7aCr9T+UvkLT
 8dN+BLFwtuo9Z1JWV0LlEGCWkuvZ71gF7ZfaIc79IxdVDZgvqNKHKc1lCeFVz0i62Uvu
 SZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yQUOKdIlSVTudHSJHdqpZDQtd7oAf1RVItbdyqHPnSQ=;
 b=j5IkaB3msWKxq73LlQ4ZYzGBhA4Xl64Cuhbw1SfbrAX+lLvDlKoTWPjiz/OoJ6xwam
 wlmobMAiPwpNE4jb+dFPMb2jOFiY4mZtZ66H8VqWXpUi+8QohffmORBlmVyPy3w7CHlc
 Gza5U5OtGT9FZVzMWmuRgQ3/PVieX/oFVHOBxlf8TrU/4Ty3nj/jFM+YwXcOpgvRA5nO
 Lqd+jb6WWXPiDBVW4wmiII7omsjSMkFYSCSJJPMbItBhMIAgBO5vKoOkEv1urj5GA8ns
 LQwh4HvxKpNmcWLPvFUIenRfU4/yHq/NtmMxqLQzTe1E9belKMqmMJwb5bs4Gd6bTja5
 RJEA==
X-Gm-Message-State: AOAM531RDLgqvuc7uOMDg3J9gkfU9lDtsBOv5qoCVOe6WbpBn9Kswv7p
 sSHiS5/7mntvqJatcIowCvw=
X-Google-Smtp-Source: ABdhPJzzn3d2fEFeYPqlxt2Ti97+NX1+Di1QJNy7177d9CQa9TBITNZgGcBfyAxcCFa1Gbk89jzDmw==
X-Received: by 2002:a5d:4247:: with SMTP id s7mr8977735wrr.167.1601747701640; 
 Sat, 03 Oct 2020 10:55:01 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id y14sm5738124wma.48.2020.10.03.10.55.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 10:55:01 -0700 (PDT)
Subject: Re: [PATCH 4/6] docs/devel/qom: Use *emphasis* for emphasis
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201003025424.199291-1-ehabkost@redhat.com>
 <20201003025424.199291-5-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ad515585-a26e-8465-7270-67278e6ea26a@amsat.org>
Date: Sat, 3 Oct 2020 19:55:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201003025424.199291-5-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.252,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/3/20 4:54 AM, Eduardo Habkost wrote:
> <emphasis> is not valid reST syntax.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  docs/devel/qom.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
> index a47e1b9a239..0c610e20d62 100644
> --- a/docs/devel/qom.rst
> +++ b/docs/devel/qom.rst
> @@ -174,17 +174,17 @@ dynamically cast it to an object that implements the interface.
>  Methods
>  =======
>  
> -A <emphasis>method</emphasis> is a function within the namespace scope of
> +A *method* is a function within the namespace scope of
>  a class. It usually operates on the object instance by passing it as a
>  strongly-typed first argument.
>  If it does not operate on an object instance, it is dubbed
> -<emphasis>class method</emphasis>.
> +*class method*.
>  
>  Methods cannot be overloaded. That is, the #ObjectClass and method name
>  uniquely identity the function to be called; the signature does not vary
>  except for trailing varargs.
>  
> -Methods are always <emphasis>virtual</emphasis>. Overriding a method in
> +Methods are always *virtual*. Overriding a method in
>  #TypeInfo.class_init of a subclass leads to any user of the class obtained
>  via OBJECT_GET_CLASS() accessing the overridden function.
>  The original function is not automatically invoked. It is the responsibility
> 


