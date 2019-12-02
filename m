Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959A5C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C0212070B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffiU6S1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0212070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibicP-0007ij-F3
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 05:07:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ibibY-0007GL-9i
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:06:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ibibX-0003Vl-6c
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:06:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47906
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ibibX-0003Vb-2n
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575281214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LWf99ClocJTrdl7yyjr79cgOtm906wplocGScS3IZvg=;
 b=ffiU6S1ErmegOAUEmDCxDQ/IDjASADt4rDq4m5wxQtzmOFNISy/cndNj9saemfp8SJCA5u
 xD/An3hJM8kqhn3Ory7jZE+QpkIIFwlcxfgIq7V0jyt5TZ9pdXIF+Rs6fPiTgn5Nti93i8
 axS3airsA2yqxPk1JLFtYOO8TPGwKr4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-RUKpC6H2M1Wlo87KYAfIuw-1; Mon, 02 Dec 2019 05:06:51 -0500
Received: by mail-wr1-f70.google.com with SMTP id z10so3658424wrt.21
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 02:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LWf99ClocJTrdl7yyjr79cgOtm906wplocGScS3IZvg=;
 b=OyV+z+grZK28IGB9Kr39u/RxW/7PpBGmdlonQNXMl8DjhhNQQ6VEae7Q9r10gsCVrE
 OuJW3IR5Ku7sU2ZGAmVh/IErxSbu15tYr8x3x7D8ktLRteQF6SekIK4K5ZZDtn1466sm
 FU4hOjnOmkT0zrobefW80PZKYlvHGhPvgVJiuk5thJ3oSszzCwmzrDhDHA7HwlBYBivK
 SMZMSqvtyOLmyBYlcdwiuIkAoAkiqhgvBmsucKJco0tpv+oeYYd/Vg1Pk/Q7Xp90RBPK
 SGSyshImiG/7sDHXKJB34PMKLVk8fXrUdYQOe55JNF+CqP5M9hRwqARiEOIarQNXN5k3
 oHLA==
X-Gm-Message-State: APjAAAVvZdIqLN44zJBQYObT4ycDFV2KHbSSXSR9y5usK+dQJMbHvVDA
 hFFIghoFCYa6blU9hiGf/Usl3eaJCdqCHG9T3Jck8ss7wg0rjQp2kXSVxX9j25VrLEyhotgRTPQ
 KgMTG1KR5valgaD4=
X-Received: by 2002:a05:6000:160d:: with SMTP id
 u13mr12421023wrb.22.1575281210539; 
 Mon, 02 Dec 2019 02:06:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqzhhcWugDGw+DX0hPY8W0LFXNpfNFg/3a/6ZsSrTvg2/gVh4gPEEBjHkxYw0bKDu8FVVN2YaA==
X-Received: by 2002:a05:6000:160d:: with SMTP id
 u13mr12420998wrb.22.1575281210224; 
 Mon, 02 Dec 2019 02:06:50 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a?
 ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
 by smtp.gmail.com with ESMTPSA id n14sm11013440wmi.26.2019.12.02.02.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 02:06:49 -0800 (PST)
Subject: Re: vfio_pin_map_dma cause synchronize_sched wait too long
To: "Longpeng (Mike)" <longpeng2@huawei.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <2e53a9f0-3225-d416-98ff-55bd337330bc@huawei.com>
 <34c53520-4144-fe71-528a-8df53e7f4dd1@redhat.com>
 <561fb205-16be-ae87-9cfe-61e6a3b04dc5@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <42c907fd-6c09-fbb6-d166-60e6827edff5@redhat.com>
Date: Mon, 2 Dec 2019 11:06:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <561fb205-16be-ae87-9cfe-61e6a3b04dc5@huawei.com>
Content-Language: en-US
X-MC-Unique: RUKpC6H2M1Wlo87KYAfIuw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
 Gonglei <arei.gonglei@huawei.com>, Huangzhichao <huangzhichao@huawei.com>,
 "Longpeng\(Mike\)" <longpeng.mike@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/12/19 10:42, Longpeng (Mike) wrote:
>> cond_resched in vfio_iommu_map.  Perhaps you could add one to 
>> vfio_pin_pages_remote and/or use vfio_pgsize_bitmap to cap the
>> number of pages that it returns.
> Um ... There's only one running task (qemu-kvm of the VM1) on that
> CPU, so maybe the cond_resched() is ineffective ?

Note that synchronize_sched() these days is just a synonym of
synchronize_rcu, so this makes me wonder if you're running on an older
kernel and whether you are missing this commit:


commit 92aa39e9dc77481b90cbef25e547d66cab901496
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Mon Jul 9 13:47:30 2018 -0700

    rcu: Make need_resched() respond to urgent RCU-QS needs

    The per-CPU rcu_dynticks.rcu_urgent_qs variable communicates an urgent
    need for an RCU quiescent state from the force-quiescent-state
processing
    within the grace-period kthread to context switches and to
cond_resched().
    Unfortunately, such urgent needs are not communicated to need_resched(),
    which is sometimes used to decide when to invoke cond_resched(), for
    but one example, within the KVM vcpu_run() function.  As of v4.15, this
    can result in synchronize_sched() being delayed by up to ten seconds,
    which can be problematic, to say nothing of annoying.

    This commit therefore checks rcu_dynticks.rcu_urgent_qs from within
    rcu_check_callbacks(), which is invoked from the scheduling-clock
    interrupt handler.  If the current task is not an idle task and is
    not executing in usermode, a context switch is forced, and either way,
    the rcu_dynticks.rcu_urgent_qs variable is set to false.  If the current
    task is an idle task, then RCU's dyntick-idle code will detect the
    quiescent state, so no further action is required.  Similarly, if the
    task is executing in usermode, other code in rcu_check_callbacks() and
    its called functions will report the corresponding quiescent state.

    Reported-by: Marius Hillenbrand <mhillenb@amazon.de>
    Reported-by: David Woodhouse <dwmw2@infradead.org>
    Suggested-by: Peter Zijlstra <peterz@infradead.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>


Thanks,

Paolo


