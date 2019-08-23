Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D85C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 08:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89E121848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 08:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="WX9nAkm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89E121848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i14wI-0006mI-Op
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 04:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i14uv-0006JW-IL
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 04:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i14us-0001xj-Ky
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 04:27:27 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:37392)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1i14us-0001wt-0C
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 04:27:26 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id D03652E0C42;
 Fri, 23 Aug 2019 11:27:21 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 8s3gNY86uY-RLc03W6a; Fri, 23 Aug 2019 11:27:21 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1566548841; bh=gpJrc9DsMgHEQsv6iDyFoTPgniTejP+dJY3hVzMGVCo=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=WX9nAkm9VL0JM/dILnpdnTtqDg61GrnNfAGdC4mO8sQV5bZeC4LidQy7jGIX3MN9o
 ShTSoezxmWKrtmv5jHnyGQpO/rXDfj26eOsGsV7prLnTWWSp3MP+6mcFuaOpPmnmus
 SJKpHNebSaWHXCP1Ps0aUyAzuQM8EyVBaIYzHI0w=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1j.mail.yandex.net (localhost [::1])
 by mxbackcorp1j.mail.yandex.net with LMTP id yTBrYSRS2K-UsQcuLoE
 for <yury-kotov@yandex-team.ru>; Fri, 23 Aug 2019 11:27:11 +0300
Received: by iva8-147456c4bd40.qloud-c.yandex.net with HTTP;
 Fri, 23 Aug 2019 11:27:11 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>,
 Dr. David Alan Gilbert <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>
In-Reply-To: <6193fef9-244a-fbd7-5506-160d841145fa@redhat.com>
References: <20190723134215.25095-1-yury-kotov@yandex-team.ru>
 <2013231565163716@vla1-1374b6242101.qloud-c.yandex.net>
 <3137561565860372@sas1-fc7737ec834f.qloud-c.yandex.net>
 <82eb0ad0-d4ee-bfc8-0087-d8910f6cf504@redhat.com>
 <6193fef9-244a-fbd7-5506-160d841145fa@redhat.com>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Fri, 23 Aug 2019 11:27:21 +0300
Message-Id: <462641566548831@iva8-147456c4bd40.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.45.199.163
Subject: Re: [Qemu-devel] [PATCH v4 0/3] High downtime with 95+ throttle pct
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:Overall" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

19.08.2019, 20:11, "Paolo Bonzini" <pbonzini@redhat.com>:
> On 19/08/19 18:39, Paolo Bonzini wrote:
>> =C2=A0On 15/08/19 11:13, Yury Kotov wrote:
>>> =C2=A0Ping ping
>>
>> =C2=A0Hi,
>>
>> =C2=A0sorry for the delay, I was waiting for the 4.1 release.
>>
>> =C2=A0I would like to make a small change so that preemption of QEMU d=
oes not
>> =C2=A0result in overly long sleeps. The following patch on top of your=
s computes
>> =C2=A0the throttle-end time just once. Of course you can still be unlu=
cky if
>> =C2=A0you are preempted at the wrong time, but the window becomes much=
 smaller.

Thanks for your suggestion! I'll use it in the v5.

>
> The new unit test is hanging for me on aarch64-softmmu.
>

Ok, I'll try to fix it in v5.

> Paolo
>
>> =C2=A0diff --git a/cpus.c b/cpus.c
>> =C2=A0index d091dbd..d7e2145 100644
>> =C2=A0--- a/cpus.c
>> =C2=A0+++ b/cpus.c
>> =C2=A0@@ -781,7 +781,7 @@ static void cpu_throttle_thread(CPUState *cp=
u, run_on_cpu_data opaque)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0double pct;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0double throttle_ratio;
>> =C2=A0- int64_t sleeptime_ns;
>> =C2=A0+ int64_t sleeptime_ns, end;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!cpu_throttle_get_percentage()=
) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
>> =C2=A0@@ -792,18 +792,17 @@ static void cpu_throttle_thread(CPUState *=
cpu, run_on_cpu_data opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Add 1ns to fix double's roundin=
g error (like 0.9999999...) */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sleeptime_ns =3D (int64_t)(throttl=
e_ratio * CPU_THROTTLE_TIMESLICE_NS + 1);
>>
>> =C2=A0- while (sleeptime_ns >=3D SCALE_MS && !cpu->stop) {
>> =C2=A0- int64_t start, end;
>> =C2=A0- start =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>> =C2=A0- qemu_cond_timedwait(cpu->halt_cond, &qemu_global_mutex,
>> =C2=A0- sleeptime_ns / SCALE_MS);
>> =C2=A0- end =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>> =C2=A0- sleeptime_ns -=3D end - start;
>> =C2=A0- }
>> =C2=A0- if (sleeptime_ns >=3D SCALE_US && !cpu->stop) {
>> =C2=A0- qemu_mutex_unlock_iothread();
>> =C2=A0- g_usleep(sleeptime_ns / SCALE_US);
>> =C2=A0- qemu_mutex_lock_iothread();
>> =C2=A0+ end =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + sleeptime_ns;
>> =C2=A0+ while (sleeptime_ns > 0 && !cpu->stop) {
>> =C2=A0+ if (sleeptime_ns > SCALE_MS) {
>> =C2=A0+ qemu_cond_timedwait(cpu->halt_cond, &qemu_global_mutex,
>> =C2=A0+ sleeptime_ns / SCALE_MS);
>> =C2=A0+ } else {
>> =C2=A0+ qemu_mutex_unlock_iothread();
>> =C2=A0+ g_usleep(sleeptime_ns / SCALE_US);
>> =C2=A0+ qemu_mutex_lock_iothread();
>> =C2=A0+ }
>> =C2=A0+ sleeptime_ns =3D end - qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0atomic_set(&cpu->throttle_thread_s=
cheduled, 0);
>> =C2=A0=C2=A0}

Regards,
Yury

