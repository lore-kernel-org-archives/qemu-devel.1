Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C0AC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 06:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2457222C8
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 06:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJNnm0qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2457222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV7dl-00018q-IR
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 02:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kV7co-0000e3-Ki
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 02:29:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kV7cj-0005xW-HJ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 02:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603261763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/qux8VEJaXd5pTjIEPJYOVBV+tvCja/sm7hpl6ixX1k=;
 b=YJNnm0qylS3dwCmHiI8JhzjLXXjRcW5o68AUbH0o+QQWDQblHj+Awm8OsH4HNbOgecpOdI
 FROAf/Tp67duvPhxqeCYRKt+x8QbdB5U4smxQopKb7QISdsrxmRmPf9b5q5qbqVawNEHc5
 sA2LqGfzKMkS/N8goCo4mBnwF44MNuE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-RRpYeOctPFejA7oY7Zk8pg-1; Wed, 21 Oct 2020 02:29:21 -0400
X-MC-Unique: RRpYeOctPFejA7oY7Zk8pg-1
Received: by mail-ej1-f72.google.com with SMTP id x12so1256670eju.22
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 23:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/qux8VEJaXd5pTjIEPJYOVBV+tvCja/sm7hpl6ixX1k=;
 b=sYdlYSv2MwqOMeadsrP83gE8lUhqs44PXRW+4IkjvafMPLKGH2EBPeCmpe7wHNOEm1
 iHuaLRfjSGMGuA5IAAZAf+eJCET5kDhXSqtCbdPtuOcC5wDIW8dbYXADI/E1Gq7itpXG
 61JWOfSJLxIMJJNkhlxjK6gOKCepQIZdEalZrdX/LeT39xzodqkqEO09msmufxeDitYz
 D9WB/DK/4yUYDZebx08/y98acUX1kcL1HqQcKPv5asFQC7znPiVe0GN/J1rXoqYoHj/n
 8+uv//eeYxIl5wlZ+nIvJXoL3HyC6aS8npUMH0GKL2/dt0zkjKJfrxpgxNoDCT5a1zxF
 dAJg==
X-Gm-Message-State: AOAM531lxLcOqRJkM8oZ3PuvrxnEbzx9TMRr0KuDY8dzo3D3F51+ElOF
 cJ+icW444b+a+UYfgAFK04WwiX/IY097BvuMogUvK6+HWg/w2YZejQf/sbV9qKlM/NdGvAGvOq7
 003bbV+ynY+aLCgk=
X-Received: by 2002:a17:906:8545:: with SMTP id
 h5mr1879324ejy.384.1603261759919; 
 Tue, 20 Oct 2020 23:29:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfLwTY0MkcvtHg0WK5RORibhukRD0Kv3MSTwIuGE+gpOPSmrrDn4bNN2oNvTBKAHMls8McoQ==
X-Received: by 2002:a17:906:8545:: with SMTP id
 h5mr1879308ejy.384.1603261759694; 
 Tue, 20 Oct 2020 23:29:19 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id n15sm1363563edv.34.2020.10.20.23.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 23:29:19 -0700 (PDT)
Subject: Re: [PATCH v2] net: remove an assert call in eth_get_gso_type
To: Peter Maydell <peter.maydell@linaro.org>, P J P <ppandit@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20201020140050.1623109-1-ppandit@redhat.com>
 <CAFEAcA_Bg12kvGAjg127_XpfeJdj9er-e2VEF9YnkNyVUDQ9OQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7e971323-0b9a-2c32-2e09-705249f3f2de@redhat.com>
Date: Wed, 21 Oct 2020 08:29:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Bg12kvGAjg127_XpfeJdj9er-e2VEF9YnkNyVUDQ9OQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Jason Wang <jasowang@redhat.com>, Gaoning Pan <pgn@zju.edu.cn>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter, Stefan,

On 10/20/20 5:05 PM, Peter Maydell wrote:
> On Tue, 20 Oct 2020 at 15:05, P J P <ppandit@redhat.com> wrote:
>>
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> eth_get_gso_type() routine returns segmentation offload type based on
>> L3 protocol type. It calls g_assert_not_reached if L3 protocol is
>> unknown, making the following return statement unreachable. Remove the
>> g_assert call, as it maybe triggered by a guest user.
>>
>> Reported-by: Gaoning Pan <pgn@zju.edu.cn>
>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>> ---
>>   net/eth.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> Update v2: add qemu_log()
>>    -> https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg05576.html
>>
>> diff --git a/net/eth.c b/net/eth.c
>> index 0c1d413ee2..fd76e349eb 100644
>> --- a/net/eth.c
>> +++ b/net/eth.c
>> @@ -16,6 +16,7 @@
>>    */
>>
>>   #include "qemu/osdep.h"
>> +#include "qemu/log.h"
>>   #include "net/eth.h"
>>   #include "net/checksum.h"
>>   #include "net/tap.h"
>> @@ -71,9 +72,7 @@ eth_get_gso_type(uint16_t l3_proto, uint8_t *l3_hdr, uint8_t l4proto)
>>               return VIRTIO_NET_HDR_GSO_TCPV6 | ecn_state;
>>           }
>>       }
>> -
>> -    /* Unsupported offload */
>> -    g_assert_not_reached();
>> +    qemu_log("Probably not GSO frame, unknown L3 protocol: %hd\n", l3_proto);
> 
> It's generally not a good idea to use qemu_log() without a
> particular mask, as then it will get printed if the user turns
> on any logging but not otherwise.
> 
> If the guest must have done something wrong to get us here:
>   use LOG_GUEST_ERROR
> If this is some functionality we ought to implement but have
> not, and so something will now be broken:
>   use LOG_UNIMP
> If the fallback for what happens in this situation is fine,
> and maybe it's just suboptimal performance, or an unusual
> case that might be interesting to know about but which
> we're handling within the spec:
>   consider a tracepoint instead

During the last 2 years I've been sending patches touching
various QEMU areas, but I never used qemu_log(). I always
used:
- qemu_log_mask(LOG_GUEST_ERROR/LOG_UNIMP, ...
- error_report/warn_report from "qemu/error-report.h"
- error_setg* from "qapi/error.h"
- trace events

$ git grep qemu_log\( | wc -l
661

This function seems used mostly by very old code.

It is declared in "qemu/log-for-trace.h" which looks like
an internal API.

Should we add a checkpatch rule to refuse new uses of qemu_log()?

Regards,

Phil.


