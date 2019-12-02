Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529F1C432C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B97F214AF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B97F214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibjFc-00041Y-B1
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 05:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <longpeng2@huawei.com>) id 1ibjEn-0003aJ-6X
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:47:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <longpeng2@huawei.com>) id 1ibjEm-00075w-3d
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:47:29 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40862 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <longpeng2@huawei.com>)
 id 1ibjEl-00074v-Oq
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:47:28 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 1FDA555B4F6FC4535465;
 Mon,  2 Dec 2019 18:47:23 +0800 (CST)
Received: from [127.0.0.1] (10.177.246.209) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0;
 Mon, 2 Dec 2019 18:47:12 +0800
Subject: Re: vfio_pin_map_dma cause synchronize_sched wait too long
To: Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
References: <2e53a9f0-3225-d416-98ff-55bd337330bc@huawei.com>
 <34c53520-4144-fe71-528a-8df53e7f4dd1@redhat.com>
 <561fb205-16be-ae87-9cfe-61e6a3b04dc5@huawei.com>
 <42c907fd-6c09-fbb6-d166-60e6827edff5@redhat.com>
From: "Longpeng (Mike)" <longpeng2@huawei.com>
Message-ID: <8a14a25d-61ce-5fb3-edc2-2c69b18f8e36@huawei.com>
Date: Mon, 2 Dec 2019 18:47:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <42c907fd-6c09-fbb6-d166-60e6827edff5@redhat.com>
Content-Type: text/plain; charset="gbk"
X-Originating-IP: [10.177.246.209]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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

=D4=DA 2019/12/2 18:06, Paolo Bonzini =D0=B4=B5=C0:
> On 02/12/19 10:42, Longpeng (Mike) wrote:
>>> cond_resched in vfio_iommu_map.  Perhaps you could add one to=20
>>> vfio_pin_pages_remote and/or use vfio_pgsize_bitmap to cap the
>>> number of pages that it returns.
>> Um ... There's only one running task (qemu-kvm of the VM1) on that
>> CPU, so maybe the cond_resched() is ineffective ?
>=20
> Note that synchronize_sched() these days is just a synonym of
> synchronize_rcu, so this makes me wonder if you're running on an older
> kernel and whether you are missing this commit:
>=20

Yep. I'm running on an older kernel and I've missed this patchset. Thanks=
 a lot :)

>=20
> commit 92aa39e9dc77481b90cbef25e547d66cab901496
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Mon Jul 9 13:47:30 2018 -0700
>=20
>     rcu: Make need_resched() respond to urgent RCU-QS needs
>=20
>     The per-CPU rcu_dynticks.rcu_urgent_qs variable communicates an urg=
ent
>     need for an RCU quiescent state from the force-quiescent-state
> processing
>     within the grace-period kthread to context switches and to
> cond_resched().
>     Unfortunately, such urgent needs are not communicated to need_resch=
ed(),
>     which is sometimes used to decide when to invoke cond_resched(), fo=
r
>     but one example, within the KVM vcpu_run() function.  As of v4.15, =
this
>     can result in synchronize_sched() being delayed by up to ten second=
s,
>     which can be problematic, to say nothing of annoying.
>=20
>     This commit therefore checks rcu_dynticks.rcu_urgent_qs from within
>     rcu_check_callbacks(), which is invoked from the scheduling-clock
>     interrupt handler.  If the current task is not an idle task and is
>     not executing in usermode, a context switch is forced, and either w=
ay,
>     the rcu_dynticks.rcu_urgent_qs variable is set to false.  If the cu=
rrent
>     task is an idle task, then RCU's dyntick-idle code will detect the
>     quiescent state, so no further action is required.  Similarly, if t=
he
>     task is executing in usermode, other code in rcu_check_callbacks() =
and
>     its called functions will report the corresponding quiescent state.
>=20
>     Reported-by: Marius Hillenbrand <mhillenb@amazon.de>
>     Reported-by: David Woodhouse <dwmw2@infradead.org>
>     Suggested-by: Peter Zijlstra <peterz@infradead.org>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>=20
>=20
> Thanks,
>=20
> Paolo
>=20
>=20
> .
>=20


--=20
Regards,
Longpeng(Mike)


