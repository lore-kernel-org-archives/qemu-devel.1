Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0C3C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4829320663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwbYg91p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4829320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCPmK-000650-GK
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 11:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jCPlf-0004cP-ML
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jCPle-0004UM-17
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:29:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45792
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jCPld-0004U1-NJ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584026940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FpoM4a0s4GbmSqM3DdAEXmQOUs6euMRHeyQKl+IkM7w=;
 b=dwbYg91pVNhNem5R/JjhbfNGQilRtZ2VUMtmMOrj798uJjYwkme89zUHEkoX9jbSjAt5ef
 RIinRSvyXooU8OO8e3mXxNqeLb7j7DfDMz7BCNUOjSlO09dbtJW6SGrwG2nd+Si4s9+XzG
 2CnTOHVdrCaZo56cx1c0oSbKRiFJt5o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-92UrJ-jdMEWPl_WoQNcZ0Q-1; Thu, 12 Mar 2020 11:28:58 -0400
X-MC-Unique: 92UrJ-jdMEWPl_WoQNcZ0Q-1
Received: by mail-wm1-f72.google.com with SMTP id a13so2321503wme.7
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 08:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FpoM4a0s4GbmSqM3DdAEXmQOUs6euMRHeyQKl+IkM7w=;
 b=Vn3bzH/8BFNpVAziKAJaecsxsrY34q3IIlwBGnvasZsySjOyfPDG6gCG10n8mogtpT
 AaE/yJiAv8+BH3hVMcnb+YYnrDleYoErApT/91MlC76d62cjDj/Gk8HFVztRuCbPIXXl
 kWbzTHpNKhqfvhL54C2aVnbcFDBgdfU83LHMDB7mD0rsikWOow8gvaK6FhPFeERdKBRM
 4s5Cq1jPtjQ7NneXM+aJiI1i8jQW5MR+MVe/nrXdP4N6D3Pt5/yFGwQvM22IDZ8+PHfU
 MRR84NEDNoLcoYp6sJMCAul+RfOsjaTbqQRNo93xeqhqgmKF8BZ6Aq7rdQUtbFMd6cCq
 nJXQ==
X-Gm-Message-State: ANhLgQ0F+o6SKmoTvMFPblNzspjp72/Kt2B2n77aw7PLNzoC2GK+g5qj
 l0Q5v+XQF57HdDdT9fqnCn3JjOWp0ndOafjheTAW75WaMBOxRYxE1F5eii3o0C814DjxqhaWPno
 Z5X5tJoAVmGnYHnw=
X-Received: by 2002:a5d:474d:: with SMTP id o13mr11376284wrs.162.1584026936659; 
 Thu, 12 Mar 2020 08:28:56 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtleXzM45HsnuAxSJkrDSJBZ5mnmrF0Svcoj2oFSa6cY7K/FbjtIVdKGIBtSVJYuu3t7rjlHQ==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr11376263wrs.162.1584026936464; 
 Thu, 12 Mar 2020 08:28:56 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.173.186])
 by smtp.gmail.com with ESMTPSA id e26sm11211273wmk.9.2020.03.12.08.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2020 08:28:55 -0700 (PDT)
Subject: Re: [RFC] cpus: avoid get stuck in pause_all_vcpus
To: "Longpeng(Mike)" <longpeng2@huawei.com>, rth@twiddle.net
References: <20200310091443.1326-1-longpeng2@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ed76f64-1a24-a278-51f3-19515e65ff39@redhat.com>
Date: Thu, 12 Mar 2020 16:28:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310091443.1326-1-longpeng2@huawei.com>
Content-Language: en-US
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
Cc: Peter Maydell <peter.maydell@linaro.org>, arei.gonglei@huawei.com,
 huangzhichao@huawei.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "qemu-devel @ nongnu . org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/03/20 10:14, Longpeng(Mike) wrote:
> From: Longpeng <longpeng2@huawei.com>
> 
> We find an issue when repeat reboot in guest during migration, it cause the
> migration thread never be waken up again.
> 
> <main loop>                        |<migration_thread>
>                                    |
> LOCK BQL                           |
> ...                                |
> main_loop_should_exit              |
>  pause_all_vcpus                   |
>   1. set all cpus ->stop=true      |
>      and then kick                 |
>   2. return if all cpus is paused  |
>      (by '->stopped == true'), else|
>   3. qemu_cond_wait [BQL UNLOCK]   |
>                                    |LOCK BQL
>                                    |...
>                                    |do_vm_stop
>                                    | pause_all_vcpus
>                                    |  (A)set all cpus ->stop=true
>                                    |     and then kick
>                                    |  (B)return if all cpus is paused
>                                    |     (by '->stopped == true'), else
>                                    |  (C)qemu_cond_wait [BQL UNLOCK]
>   4. be waken up and LOCK BQL      |  (D)be waken up BUT wait for  BQL
>   5. goto 2.                       |
>  (BQL is still LOCKed)             |
>  resume_all_vcpus                  |
>   1. set all cpus ->stop=false     |
>      and ->stopped=false           |
> ...                                |
> BQL UNLOCK                         |  (E)LOCK BQL
>                                    |  (F)goto B. [but stopped is false now!]
>                                    |Finally, sleep at step 3 forever.
> 
> 
> Note: This patch is just for discuss this issue, I'm looking forward to
>       your suggestions, thanks!

Thanks Mike,

the above sketch is really helpful.

I think the problem is not that pause_all_vcpus() is not pausing hard
enough; the problem is rather than resume_all_vcpus(), when used outside
vm_start(), should know about the race and do nothing if it happens.

Fortunately resume_all_vcpus does not release the BQL so it should be
enough to test once; translated to code, this would be the patch to fix it:

diff --git a/cpus.c b/cpus.c
index b4f8b84b61..1eb7533a91 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1899,6 +1899,10 @@ void resume_all_vcpus(void)
 {
     CPUState *cpu;

+    if (!runstate_is_running()) {
+        return;
+    }
+
     qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
     CPU_FOREACH(cpu) {
         cpu_resume(cpu);


Thanks,

Paolo


