Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74268C55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:42:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1B820774
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJ5VZHE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1B820774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFdm-0003tT-Dl
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFco-00036s-OH
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFcm-0004mN-GM
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:41:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20591
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRFcm-0004ht-1I
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587562871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mSSAFQndrLCB1385PozquPFOuO18lakkpiYtYILwecQ=;
 b=XJ5VZHE1iAWb2bF93hi4FDvyOOkq/n8O0HkH7EeAWIMtGmGWOohG1BObXIKwqjbdfmk88E
 ypHGNHq4GzNwPrPXhN/jP/K50Wna+hjDxbpmQzr6XRvgl8myThaaV84MiYF/RXWGg2++bY
 SzIP1oVfQtsWpRY6xX8Pq1zfI6gmXPQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-BqfxIZXsOpmeEHMn_6q_IA-1; Wed, 22 Apr 2020 09:41:06 -0400
X-MC-Unique: BqfxIZXsOpmeEHMn_6q_IA-1
Received: by mail-wm1-f70.google.com with SMTP id n127so819671wme.4
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 06:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mSSAFQndrLCB1385PozquPFOuO18lakkpiYtYILwecQ=;
 b=q9O2lvjVovczLBLdOgYjyydPmxO4p3R0iH+5XL7PnIpO1rS9JfxQ8D8CatvyaJFsvH
 BPNTZ0xaaITZVAnrFItxDjURVKUf5hbw+hpK+QqvhcYOa2sGBAutYsiEPVXorvyZtzfv
 01gPx/KvLdcIlWphf75G/cQrQCdt92sBPKgbD3zDWzvYCvE4eT8SCi3wttPqYTYc/o4x
 05IQzkJoQkTf0qonElrynUmJc9JRYbosTQie47mHwQH6y6g+XFXSovPPeSXja/vourr1
 VS1ExcvoLyfa9Z2p9bVtWfSoAdIo1L6ZxpDdPzMzbkYr+Q+iVLZnN2uPrQaiBdzZe9RQ
 ZfGQ==
X-Gm-Message-State: AGi0PuaFuvxpzPX2opOpmjIWiQwMVhE2N9deO7hA7yVQUtpH4TrcY7OR
 moWEQnRN04DHm2CGS3wsCFs4UaB0cqLHqJs2kxN69ber9vLh22qqhRp7ZJ/x3JyAuhGNqb864LE
 ZNAIEhhdtM9vBUUE=
X-Received: by 2002:a5d:438c:: with SMTP id i12mr29770262wrq.14.1587562864600; 
 Wed, 22 Apr 2020 06:41:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypInHva+P0eFwo4yltABj6SQx6xdkUyYDE5d/9s4SoqObKrNj+4Sw49qUG9ZSV9uTjJYMU3Dow==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr29770232wrq.14.1587562864371; 
 Wed, 22 Apr 2020 06:41:04 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d5sm8349841wrp.44.2020.04.22.06.41.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 06:41:03 -0700 (PDT)
Subject: Re: [PATCH v2 14/14] qga: Fix qmp_guest_suspend_{disk, ram}() error
 handling
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200422130719.28225-1-armbru@redhat.com>
 <20200422130719.28225-15-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ccf97c71-744d-1d0a-f961-bb3d71c1c64a@redhat.com>
Date: Wed, 22 Apr 2020 15:41:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200422130719.28225-15-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 3:07 PM, Markus Armbruster wrote:
> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> 
> qmp_guest_suspend_disk() and qmp_guest_suspend_ram() pass @local_err
> first to check_suspend_mode(), then to acquire_privilege(), then to
> execute_async().  Continuing after errors here can only end in tears.
> For instance, we risk tripping error_setv()'s assertion.
> 
> Fixes: aa59637ea1c6a4c83430933f9c44c43e6c3f1b69
> Fixes: f54603b6aa765514b2519e74114a2f417759d727
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qga/commands-win32.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 9717a8d52d..5ba56327dd 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1322,9 +1322,16 @@ void qmp_guest_suspend_disk(Error **errp)
>   
>       *mode = GUEST_SUSPEND_MODE_DISK;
>       check_suspend_mode(*mode, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
>       acquire_privilege(SE_SHUTDOWN_NAME, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
>       execute_async(do_suspend, mode, &local_err);
>   
> +out:
>       if (local_err) {

https://www.mail-archive.com/qemu-devel@nongnu.org/msg695647.html is 
slightly different by removing the if() check.

>           error_propagate(errp, local_err);
>           g_free(mode);
> @@ -1338,9 +1345,16 @@ void qmp_guest_suspend_ram(Error **errp)
>   
>       *mode = GUEST_SUSPEND_MODE_RAM;
>       check_suspend_mode(*mode, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
>       acquire_privilege(SE_SHUTDOWN_NAME, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
>       execute_async(do_suspend, mode, &local_err);
>   
> +out:
>       if (local_err) {
>           error_propagate(errp, local_err);
>           g_free(mode);
> 


