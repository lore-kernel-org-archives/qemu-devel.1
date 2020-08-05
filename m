Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CC2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 14:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472D92332F
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 14:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2QdHDQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472D92332F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Kh2-0003cV-EG
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 10:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3Kg1-000391-DP
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 10:45:58 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3Kfz-0002w3-Q0
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 10:45:57 -0400
Received: by mail-wm1-x342.google.com with SMTP id 9so6042431wmj.5
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p17Q4g0ysQUspCqNbzn616daTJ2bh1JlSViUjj/s5W8=;
 b=L2QdHDQefIYBg9s9deIuJvBSj/DM/KD6lAsDh7TcCSOLZsg13ebuYZT4PFzOm41wig
 iv6QLbGpY1HUxbieZBG/EeTg8wXMkmC8ZnD2xSQ1Xs1ipYO0lzDQJSniRkRsxNz5yxYf
 K9VCKYXxn8ssLPDOFtuK+Z+gzAURXxTZPnsIfTv5UFHGt70NXpkbJmykyEPwONDSJett
 O4e6XEwUQd6aT+zpysFWlBWLZXKLrPsWxeJE1o24p38332tRAXpf2PRA6w8gVCyoRqwG
 TMZBhrMpQmaoqDkVdibYbqg7a+3gLbzG0bbufrqgWcCryCc/Uta3/8i2c2MwDwawEwTj
 tGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=p17Q4g0ysQUspCqNbzn616daTJ2bh1JlSViUjj/s5W8=;
 b=EMyl0e2PsEphyuNNk2kXHQK7Yv59fN6gcIcfbqcuFhwU8Umo7k+//8KI5Eubggp/H4
 H/LSVTh6VtsSzw2eCLfv1B1pYc9z281PGlvCpp+C9tNYJNvx6aHmSwxV6ds+oZKp/U1z
 YPnI5kh8Ig2LVAoZYZFCEgw8cKK7UOkyQvq5G13LW2ThN7MNPKr4jLBQeyU3VVM34Blm
 E0lyHXmScpFD0gUmZaW98BedKM+LwowcAOiawLFNFGRAjtijXuAOC7xQLx2zBmGxDkEi
 Y+EScuRhGNtxbZz1i31Coy/vPsZnf4pNSrEonw0xwYaEykaGHxyjlbWZNkYZc6UxqxCQ
 vJ1Q==
X-Gm-Message-State: AOAM532epHshBG4WkbVO8N9DVfQxeEK2F52AWXAP15Svo0m5Q/Bdxqae
 i0f6idf1CWGJBz852Kp0Clw=
X-Google-Smtp-Source: ABdhPJxU6SJ8+5t4qUO/v6iqJ/vz58Yj2GSqdHrJU59S1yJ/2jPFYQp7JIiRatwFU5vfLAbh+ynGVA==
X-Received: by 2002:a1c:770c:: with SMTP id t12mr3850538wmi.65.1596638753844; 
 Wed, 05 Aug 2020 07:45:53 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 124sm2967415wmd.31.2020.08.05.07.45.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 07:45:52 -0700 (PDT)
Subject: Re: [PATCH-for-5.2] memory: Display bigger regions first in 'info
 mtree' output
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Xu <peterx@redhat.com>
References: <20200727174543.4219-1-f4bug@amsat.org>
 <20200727180931.GA89946@xz-x1.hitronhub.home>
 <48c43451-9c89-2706-8d56-91c60e6eaa77@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <f4b1f4e8-9bfa-b450-089e-c3966b9326ea@amsat.org>
Date: Wed, 5 Aug 2020 16:45:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <48c43451-9c89-2706-8d56-91c60e6eaa77@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/20 4:21 PM, Philippe Mathieu-Daudé wrote:
> Hi Peter,
> 
> On 7/27/20 8:09 PM, Peter Xu wrote:
>> On Mon, Jul 27, 2020 at 07:45:43PM +0200, Philippe Mathieu-Daudé wrote:
>>> When different regions have the same address, we currently
>>> sort them by the priority. Also sort them by the region
>>> size.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  softmmu/memory.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/softmmu/memory.c b/softmmu/memory.c
>>> index af25987518..c28dcaf4d6 100644
>>> --- a/softmmu/memory.c
>>> +++ b/softmmu/memory.c
>>> @@ -2960,7 +2960,8 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
>>>          QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
>>>              if (new_ml->mr->addr < ml->mr->addr ||
>>>                  (new_ml->mr->addr == ml->mr->addr &&
>>> -                 new_ml->mr->priority > ml->mr->priority)) {
>>> +                 (MR_SIZE(new_ml->mr->size) > MR_SIZE(ml->mr->size) ||
>>> +                  new_ml->mr->priority > ml->mr->priority))) {
>>>                  QTAILQ_INSERT_BEFORE(ml, new_ml, mrqueue);
>>>                  new_ml = NULL;
>>>                  break;
>>
>> Note that this change could make the outcome unpredictable... Assuming two
>> memory regions:
>>
>>   mr1: addr=0, size=0x1000, pri=2
>>   mr2: addr=0, size=0x2000, pri=1
>>
>> Then assuming submr_print_queue only contains these two mrs.  Then when
>> submr_print_queue has mr1 at head, then when we insert mr2 we'll think it
>> should be inserted before mr1 (because mr2's size bigger), so the result will be:
>>
>>   mr2:...
>>   mr1:...
>>
>> If submr_print_queue has mr2 at head, then when we insert mr1 we'll think it
>> should be inserted before mr2 (because mr1's priority higher).  We'll instead
>> get:
>>
>>   mr1:...
>>   mr2:...
>>
>> Phil, could I ask what's the case to be fixed?
> 
> What I want is sort regions of same priority by bigger size first,
> the smaller size last (as a leaf of the tree, the leaf is the MR
> that handles the memory access).

As example as easier to understand, this is the change I expect:

 memory-region: io
   0000000000000000-000000000000ffff (prio 0, i/o): io
+    0000000000000000-0000000000000007 (prio 0, i/o): dma-chan
       0000000000000000-0000000000000003 (prio 0, i/o): acpi-evt
       0000000000000004-0000000000000005 (prio 0, i/o): acpi-cnt
       0000000000000008-000000000000000b (prio 0, i/o): acpi-tmr
-    0000000000000000-0000000000000007 (prio 0, i/o): dma-chan
     0000000000000008-000000000000000f (prio 0, i/o): dma-cont
     0000000000000020-0000000000000021 (prio 0, i/o): pic
     0000000000000040-0000000000000043 (prio 0, i/o): pit

For me it doesn't seem natural to look after 0x8 if there is another
region mapped at 0x0. Now it is easier to see 'dma-chan' is
masking the acpi events.

Note I'd expect 'acpi-tmr' to be after 'dma-cont' to also realize
it is masked.

FYI the resulting flatview:

(qemu) info mtree -f
FlatView #2
 AS "I/O", root: io
 Root memory region: io
  0000000000000000-0000000000000007 (prio 0, i/o): dma-chan
  0000000000000008-000000000000000f (prio 0, i/o): dma-cont

> 
> Maybe this patch is not complete. I'll follow Peter Maydell suggestion
> to split the compare() function out to make it more readable.
> This qtailq is only used for the monitor 'mtree' command, right?
> I understand the flatview uses something else.
> 
> Regards,
> 
> Phil.
> 

