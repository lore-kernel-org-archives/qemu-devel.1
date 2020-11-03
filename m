Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7431C388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:39:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F33202224E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFoZdQ1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33202224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka35W-0003ih-LX
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1ka348-00036C-Ip
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:38:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1ka340-0007Ts-P3
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604435874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4zhfk+D55TAHPvP35uEcbc2HDi3PgLphb58WSR+HRQ=;
 b=NFoZdQ1m1OqcRHbnwgLjVX6owVWJDHWrioQNLUTx1lwjAUhfkvY3lZCEFKDJzK7fvGC40X
 iGOt5k8X2T4USzN4d3LTK2H77mRS9Yed9rWoh+BRzFVFd0Q9qnEFXfp+XtDDr+HFqzgYkB
 OrBTAr61oNm8yZFQQencOtDMevPaOqU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-Brdqs7G1P7CPinXgUGnQgw-1; Tue, 03 Nov 2020 15:37:53 -0500
X-MC-Unique: Brdqs7G1P7CPinXgUGnQgw-1
Received: by mail-wm1-f70.google.com with SMTP id f70so242534wme.7
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 12:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w4zhfk+D55TAHPvP35uEcbc2HDi3PgLphb58WSR+HRQ=;
 b=enkODtwRF6o3Ug0hPxW/DF3LXZc+RaZ2kt0ED/wuwYRcXbOmDnNoR5J1YNwNpOVTls
 hI3a3WBapEuRpbBoaHiCKAyx9In2D31EkBcVkThnc5bnIq6jXTrjlNh69cRbNs0e+z6N
 pqlcvPuHJjXkVMLwRUbM53x3xcT3+IiaP01ar5yZ5qyGV2W5IKOxy/kTp+N0/ve5Ab5K
 KiD5oYb1vYkHYbADTdzIQ0QEPnoyJYWw5lmXG3U3qKykFWINyWAGGfJEvb7MTJb+OLh7
 2YUEDtnkdOZRxxiiQLHff3AP/d8QVIjSzK7PiPp18yarh+tbQ4z9LeiN9S3IGIjMFBpe
 oFWw==
X-Gm-Message-State: AOAM532wvo6+YxmZNGyDhjpTWHoLb2wSmSZwEsn2Pecnnb9fC0rh1PFv
 IYSg7bxYAFmzyrspGvDKgC2BzZYijeCvLtaPgk6F31ka97POfoLs+h3qgOz9eI1zc/JsRYfpkav
 tCDXE7jQws1Yk1uQ=
X-Received: by 2002:a7b:cb8c:: with SMTP id m12mr1066665wmi.12.1604435871646; 
 Tue, 03 Nov 2020 12:37:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPPdF9lUTp6JJjoP94KdRdRER+tnHsmwrXwE+CT1O1OyOdlFb6DWea+ndoGqVeHserxa+9pQ==
X-Received: by 2002:a7b:cb8c:: with SMTP id m12mr1066640wmi.12.1604435871359; 
 Tue, 03 Nov 2020 12:37:51 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id k18sm27005084wrx.96.2020.11.03.12.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 12:37:50 -0800 (PST)
Subject: Re: [PATCH v8 07/11] hw/block/nvme: Support Zoned Namespace Command
 Set
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Keith Busch
 <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fam Zheng <fam@euphon.net>
References: <20201030023242.5204-1-dmitry.fomichev@wdc.com>
 <20201030023242.5204-8-dmitry.fomichev@wdc.com>
 <bcdfd825-980d-ea3d-30a5-b85c0dccd01d@redhat.com>
 <MN2PR04MB59511341E3622276A993FE7CE1110@MN2PR04MB5951.namprd04.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b8d2a80b-4f7f-56eb-39dd-1e40f73c5a9b@redhat.com>
Date: Tue, 3 Nov 2020 21:37:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <MN2PR04MB59511341E3622276A993FE7CE1110@MN2PR04MB5951.namprd04.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 8:48 PM, Dmitry Fomichev wrote:
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
...
>>>  typedef struct QEMU_PACKED NvmeCqe {
>>> -    uint32_t    result;
>>> -    uint32_t    rsvd;
>>> +    union {
>>> +        uint64_t     result64;
>>> +        uint32_t     result32;
>>> +    };
>>
>> When using packed structure you want to define all fields to
>> avoid alignment confusion (and I'm surprised the compiler doesn't
>> complain...). So this would be:
>>
>>        union {
>>            uint64_t     result64;
>>            struct {
>>                uint32_t    result32;
>>                uint32_t    rsvd32;
>>            };
>>        };
>>
> 
> IMO, the compiler doesn't complain because it's a union. Smaller
> variants in unions are "padded" to the size of the largest variant
> regardless of whether the struct is packed or not.
> 
>> But since the ZNS is still a technical proposal and not in the spec,
>> this doesn't look correct (the spec list this field as 32-bit).
>>
>> What do you think about adding NvmeCqeZNS?
>>
>> Maybe:
>>
>>   typedef struct QEMU_PACKED NvmeCqeZNS {
>>       uint64_t    result;
>>       uint16_t    sq_head;
>>       uint16_t    sq_id;
>>       uint16_t    cid;
>>       uint16_t    status;
>>   } NvmeCqeZNS;
>>
>> Or clever:
>>
>>   typedef union QEMU_PACKED NvmeCqeZNS {
>>       union {
>>           struct {
>>               uint64_t result;
>>               uint32_t dw2;
>>               uint32_t dw3;
>>           };
>>           NvmeCqe      cqe;
>>       };
>>   } NvmeCqeZNS;
>>
> 
> The 1.4 base spec changes Reserved DW1 in CQE to become the
> Command Specific DW1, so it would rather make sense to define
> a command-specific CQE for Zone Append -
> 
> In include/block/nvme.h:
> 
> typedef struct QEMU_PACKED NvmeCqe {
>      uint32_t    result;
> -    uint32_t    rsvd;
> +    uint32_t    dw1;
>      uint16_t    sq_head;
>      uint16_t    sq_id;
>      uint16_t    cid;
>      uint16_t    status;
> } NvmeCqe;
> 
> +/* Zone Append - specific CQE */
> +typedef struct QEMU_PACKED NvmeCqeZA {
> +    uint64_t    za_slba;
> +    uint16_t    sq_head;
> +    uint16_t    sq_id;
> +    uint16_t    cid;
> +    uint16_t    status;
> +} NvmeCqeZA;
> 
> ...
> 
> +    QEMU_BUILD_BUG_ON(sizeof(NvmeCqe) != sizeof(NvmeCqeZA));
> 
> This will go away with all CQE unions and it will also allow the returned SLBA
> value to be properly named. What do you think?

This is cleaner, I like it :)

> 
>> I wonder what part could go in hw/block/nvme-ns.h or "block/nvme-zns.h".
> 
> NvmeCqeZA could simply be defined in include/block/nvme.h next to NvmeCqe.
> The problem with adding include/block/nvme-zns.h is that it would be hard if
> not impossible to separate all ZNS-specific content from block/nvme.h and it
> would become necessary for developers to deal with two files that present
> different parts of ZNS definitions instead of just one.

Got it.

Regards,

Phil.

> 
> Best regards,
> Dmitry


