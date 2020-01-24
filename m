Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681BAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3335F2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZgsTwLe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3335F2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv2WR-00045i-7g
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 12:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iv2Vn-0003eX-3v
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iv2Vl-00084E-3F
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:12:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41572
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iv2Vl-00083f-06
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579885967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gz+LMc0YooVWIStROLe3nU4YKwYoYFc0bVtt52toLdA=;
 b=ZgsTwLe+Fpw6W4iZEIUgD07qqbQ7L6G3tzM8gfnC5tgcvm3lshc/iOYaAoeJEvc08jXcIC
 ffXIgLqvY0QlAw/hRcolkfF4qqVyTZENaCut5zW7G71rU5PrZGsgSYgFieWlC8wc3uO/7L
 vpnVDjZQs3RDRX+hVVeMx2n+vgMo8Wc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-gA8SLNlbNDG-_vuwVDnG4w-1; Fri, 24 Jan 2020 12:12:46 -0500
Received: by mail-wr1-f71.google.com with SMTP id z14so1732102wrs.4
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 09:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Gz+LMc0YooVWIStROLe3nU4YKwYoYFc0bVtt52toLdA=;
 b=ip2EM7kWuFVG00zLQ1LkNPksCnI2b9KIlpNGuEq2AOtPZSecJPQVyNbXC0FMbGZWpZ
 RZ937oceV1B7+8tlSDtO/LUhNDKXcD2hRNTQimAeNkfQTxxf3sfSO3h7DEVsuItZa/V1
 /ogHE6DuZ8NmBSXHcdf+ULapIfK9WeJztPbu9wzDA5KcRkn7oGRQBq3Vk0h7qaQcFAgX
 Tc2lMBpPaVLSZNYxqnr5braKvd/cy/YuEIR/VdujKvQTj/PKAlOZXtBTQ92dVoHyKsaK
 dXcj78cCMfYLX+9s354Q7B3tp3RQffBRmZetf8gxO4pAt4LA0+pvqW76+N53JZn3ywDt
 Yf5A==
X-Gm-Message-State: APjAAAUVWQvT9A55fIkCgGTbGbA0vBIZ1YpOeqKaPxUnSWogq3x7yroF
 NGKIg2flJmp2MtVRLPuYgSHvRH9ccR8dT+5ZrMIbs95XpGiGk2WJ+NuWyZiyFByVyVf48eybjdb
 0eac7YldV/4g1vzg=
X-Received: by 2002:a05:600c:211:: with SMTP id 17mr216775wmi.60.1579885963863; 
 Fri, 24 Jan 2020 09:12:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6nxyrn7Ztp/NvJac8uHdR1/E7Jl5Lc+xYCSNHey4tFc+cIutkeaZA2zOZVu1cL2Sud/AFeg==
X-Received: by 2002:a05:600c:211:: with SMTP id 17mr216680wmi.60.1579885962005; 
 Fri, 24 Jan 2020 09:12:42 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id z11sm8408988wrt.82.2020.01.24.09.12.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 09:12:41 -0800 (PST)
Subject: Re: [PATCH 2/8] tests/vm: increased max timeout for vm boot.
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
References: <20200124165335.422-1-robert.foley@linaro.org>
 <20200124165335.422-3-robert.foley@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <075d1da4-f59a-489e-4c64-63e76265d5c4@redhat.com>
Date: Fri, 24 Jan 2020 18:12:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200124165335.422-3-robert.foley@linaro.org>
Content-Language: en-US
X-MC-Unique: gA8SLNlbNDG-_vuwVDnG4w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: fam@euphon.net, peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Robert,

On 1/24/20 5:53 PM, Robert Foley wrote:
> Add change to increase timeout waiting for VM to boot.
> Needed for some emulation cases where it can take longer
> than 5 minutes to boot.
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> ---
>   tests/vm/basevm.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 991115e44b..86908f58ec 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -310,7 +310,7 @@ class BaseVM(object):
>       def print_step(self, text):
>           sys.stderr.write("### %s ...\n" % text)
>   
> -    def wait_ssh(self, seconds=300):
> +    def wait_ssh(self, seconds=600):
>           starttime = datetime.datetime.now()
>           endtime = starttime + datetime.timedelta(seconds=seconds)
>           guest_up = False
> 

I once suggested "When using TCG, wait longer for a VM to start"
https://www.mail-archive.com/qemu-devel@nongnu.org/msg550610.html

Cleber took some notes about 'kicking a expiring timer' but I can't find 
it. This might be related:
https://trello.com/c/MYdgH4mz/90-delayed-failures

Regards,

Phil.


