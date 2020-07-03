Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92B9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7731720708
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJ3aVrfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7731720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPPS-0001XK-Ef
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jrPOR-0000DU-Oc
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 13:22:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32118
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jrPOQ-0003zm-2p
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 13:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593796949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z99jpI8h1TeJZSnRuiI8KpXSTQSOZGJfNPacK3k9QBE=;
 b=eJ3aVrfb4Yhu+WUtdpSlTivppC5xuQKqHWFzjjR4/dvhXCIgEcq9Tw1FCgdpChu8cYZmCW
 bWVM9IjinK7GkG699zsYr7ky/i0/F/MTplAEJv/uk8GJ7Rh/00Sx3OlzXV+vcI6LNWA6AZ
 4Ixmv7GJeRwBOShECtvGotatJw0BAzI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-tZKHpKtjOaGX24MHWT6a3A-1; Fri, 03 Jul 2020 13:22:27 -0400
X-MC-Unique: tZKHpKtjOaGX24MHWT6a3A-1
Received: by mail-wm1-f69.google.com with SMTP id h6so35736042wmb.7
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 10:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z99jpI8h1TeJZSnRuiI8KpXSTQSOZGJfNPacK3k9QBE=;
 b=Q4am8xCfMa55nPwtbtgRN7fX4nMo4/Q+ucYXoDeZIga7qr/BMRj7/Ydg0lnXRFXwUz
 gYwibEZoaWMzv02Wql2eDf3WE/gTc0daV8aXmOZX8b+Zy0MMPWQE+w/UY9qNVLlgAGhC
 KsXzhLyeaSt17AVOFITAwGzygg3Z99OsCdbFWWlFKJ5WhaCPAzsFgAamnS9zIBGpzqdY
 wDt3vNw+zygKcge+XOfHr5ImwDm5w30+JXoPaDS73X7vlqT0AZiJsP9ffN1uMMKlCnrO
 NZ0sDPTr3NjBKqwX4OWy9f+9B5fdO+N+i2SASVoYvhc9cCr5zHYy502NyIYOthzXiaUQ
 dBiw==
X-Gm-Message-State: AOAM530mJbBYkrNpzjkUbDj3v2DAaFPYBZRrUEU3BHI5kcPQj1EevwWh
 FyKJnYcf2he7TPph+c9kcOA/GZDqlyGsZub2RF5XX0jzkih0Fb7isZFKxU3um28A69gLR//54rR
 frf4Zcdc8taC1A38=
X-Received: by 2002:adf:e60e:: with SMTP id p14mr36741695wrm.31.1593796946828; 
 Fri, 03 Jul 2020 10:22:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztnhdhWTBsEffENrF56voW8iZyR/Jh/QXytJxfAW2gbVNT1ubjaShau6FgX3Rqtr4bUsTEvw==
X-Received: by 2002:adf:e60e:: with SMTP id p14mr36741674wrm.31.1593796946638; 
 Fri, 03 Jul 2020 10:22:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5cf9:fc14:deb7:51fc?
 ([2001:b07:6468:f312:5cf9:fc14:deb7:51fc])
 by smtp.gmail.com with ESMTPSA id y7sm14510793wrt.11.2020.07.03.10.22.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 10:22:26 -0700 (PDT)
Subject: Re: [PATCH] softmmu/vl: Remove the check for colons in -accel
 parameters
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200618074001.13642-1-thuth@redhat.com>
 <1a135eb1-8ea6-80f2-85d7-40c8da92c1d1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <264c1ba9-4b05-1559-f5f7-63e3b4f98ea6@redhat.com>
Date: Fri, 3 Jul 2020 19:22:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1a135eb1-8ea6-80f2-85d7-40c8da92c1d1@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/07/20 07:34, Thomas Huth wrote:
> On 18/06/2020 09.40, Thomas Huth wrote:
>> The new -accel option does not accept colons in the parameters anymore
>> (since it does not convert the parameters to -machine accel=...
>> parameters
>> anymore). Thus we can now remove the check for colons in -accel:
>>
>> $ qemu-system-x86_64 -accel kvm:tcg
>> qemu-system-x86_64: -accel kvm:tcg: invalid accelerator kvm:tcg
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   softmmu/vl.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>> index f669c06ede..273acfcf6b 100644
>> --- a/softmmu/vl.c
>> +++ b/softmmu/vl.c
>> @@ -3485,11 +3485,6 @@ void qemu_init(int argc, char **argv, char **envp)
>>                       g_slist_free(accel_list);
>>                       exit(0);
>>                   }
>> -                if (optarg && strchr(optarg, ':')) {
>> -                    error_report("Don't use ':' with -accel, "
>> -                                 "use -M accel=... for now instead");
>> -                    exit(1);
>> -                }
>>                   break;
>>               case QEMU_OPTION_usb:
>>                   olist = qemu_find_opts("machine");
>>
> 
> Ping?
> 
>  Thomas
> 

Queued, thanks.

Paolo


