Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049C4C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 06:34:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF97221473
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 06:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTXB/Qgx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF97221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQ3XS-0004OG-UI
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 02:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jQ3We-0003RF-Tb
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 02:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jQ3We-0008Jz-CX
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 02:33:56 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jQ3Wd-0008BS-Vi
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 02:33:56 -0400
Received: by mail-wr1-x442.google.com with SMTP id g13so5932647wrb.8
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 23:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=zTELs4rhAikcbI2ea6NV6tKNEQiSLEKwsXtjhwGawfo=;
 b=MTXB/QgxoUKIOM0hlJ3J91anHWC893FzOSvavSbveKPXW8nbI8dveVjWG9cEzV3aVP
 7NVkPF5SShLWNzi28+o4pMgHz+vapCIbbXVevmLtUgjoY6y/Tredx6DRPqNZSS5WM0+y
 Xlsmp5j7Jfs7h+28NT7O1ckGbPqtfSyrc2bPDVqxS7X4JkDZGistQ8W6kr1TJu8umEJ1
 LJbqo7oUSGRU2dcn5MWnqJyuVP+rgy/ouh6pB0kX1Ust/rfciCPQbfmeval2yEIK3Gts
 /GbqdjW5VKtYOsq+lKaY7KdG7Xmvi/OY24xNnjXkE6GWtQlcGs0qaudsU48ZLODyEKCi
 p/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=zTELs4rhAikcbI2ea6NV6tKNEQiSLEKwsXtjhwGawfo=;
 b=qk+94Tnz9lDPRAO5YZZQX8/R2oL61+MXNKMh7njcomRteBvftX5fAkvsNEft2zv7Eo
 +bOiwBiM87t3K7+WaaxarinhSSuuh4Q7fW7WNRt2F/xnkZ616BCF22IHmyR8slN6lcUG
 bknX44RCyYNeCSoI42y/lEYtFd+pHqWCKOSHzwaeSbSmTKe0m9VAK13kR/jmJCo3NxBA
 Nq9fx3SS+XRwpv2Dm0dp+onniT2N9PQWpcXx5BAJ0s4LAzL6qHZeEtxzL1gOREY8de6Z
 yfOcHx4urCoCW6BccUU+mnCPHqcZn+uPquVShbObatUQxxnGg37RlqKkRDmKnupCTLID
 vu4A==
X-Gm-Message-State: AGi0Puah/SGbq7UCmwA2XaSvxBKXDGEo1cwhjQW9hbmVvdrqUtOh5U7L
 2ofu+TCNJUWhhCOhxUBz5kw=
X-Google-Smtp-Source: APiQypLA6NSm9lOufXfBNj0Vo7QdIIWsWyZKrgqq86ezNWk1n2oCFArZSi+alUZhtnHZUCBYVeq7LQ==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr11585586wrp.183.1587278032150; 
 Sat, 18 Apr 2020 23:33:52 -0700 (PDT)
Received: from [192.168.86.37] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id h10sm41226986wrq.33.2020.04.18.23.33.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Apr 2020 23:33:51 -0700 (PDT)
Subject: Re: [PATCH v2] lockable: Replace locks with lock guard macros
To: Julia Suvorova <jusual@mail.ru>
References: <20200402065035.GA15477@simran-Inspiron-5558>
 <f0eec74a-387d-79ce-b23f-d7f16747f9ad@gmail.com>
 <CAMDeoFVipYBYCE_GTjytpXT_PvKt6xjTdtPyv=HyLYf4FkCDUQ@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <802550db-7e4d-549f-5358-a5ee25b969b4@gmail.com>
Date: Sun, 19 Apr 2020 09:34:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAMDeoFVipYBYCE_GTjytpXT_PvKt6xjTdtPyv=HyLYf4FkCDUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=marcel.apfelbaum@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Simran Singhal <singhalsimran0@gmail.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, rkagan@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Julia,

On 4/19/20 5:46 AM, Julia Suvorova wrote:
> On Sat, Apr 18, 2020 at 2:03 PM Marcel Apfelbaum
> <marcel.apfelbaum@gmail.com> wrote:
>> Hi Simran,
>>
>> On 4/2/20 9:50 AM, Simran Singhal wrote:
>>> Replace manual lock()/unlock() calls with lock guard macros
>>> (QEMU_LOCK_GUARD/WITH_QEMU_LOCK_GUARD).
>>>
>>> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
>>> ---
>>> Changes in v2:
>>>           -Drop changes in file hw/rdma/rdma_utils.c
>>>
>>>    hw/hyperv/hyperv.c     | 15 ++++++-------
>>>    hw/rdma/rdma_backend.c | 50 +++++++++++++++++++++---------------------
>>>    hw/rdma/rdma_rm.c      |  3 +--
>>>    3 files changed, 33 insertions(+), 35 deletions(-)
>>>
>>> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
>>> index 8ca3706f5b..4ddafe1de1 100644
>>> --- a/hw/hyperv/hyperv.c
>>> +++ b/hw/hyperv/hyperv.c
>>> @@ -15,6 +15,7 @@
>>>    #include "sysemu/kvm.h"
>>>    #include "qemu/bitops.h"
>>>    #include "qemu/error-report.h"
>>> +#include "qemu/lockable.h"
>>>    #include "qemu/queue.h"
>>>    #include "qemu/rcu.h"
>>>    #include "qemu/rcu_queue.h"
>>> @@ -491,7 +492,7 @@ int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandler handler, void *data)
>>>        int ret;
>>>        MsgHandler *mh;
>>>
>>> -    qemu_mutex_lock(&handlers_mutex);
>>> +    QEMU_LOCK_GUARD(&handlers_mutex);
>> It does not passes compilation:
>>       export ARCH=x86_64
>>       make docker-image-fedora V=1 NETWORK=1
>>       make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu NETWORK=1
> This is a problem with the macros themselves, not with this patch.
> This is fixed (concat '##' problem and warnings) in
>    [PATCH v5 0/2] Replaced locks with lock guard macros
> and the patch should be based on it.

Thanks for the pointer.
I'll wait for the fix to be merged then.

Thanks,
Marcel

>
> Best regards, Julia Suvorova.


