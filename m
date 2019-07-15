Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFA4C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 12:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991CE206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 12:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="W12e9C6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991CE206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn0Dr-0000nN-Sc
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 08:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37722)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hn0Di-0000Nx-7N
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 08:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hn0Dg-0003Wy-Tu
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 08:36:42 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:40358)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1hn0Dg-0003W3-2U
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 08:36:40 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 4C68C2E048D;
 Mon, 15 Jul 2019 15:36:35 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 Wz8hnkiazD-aYUe1OpN; Mon, 15 Jul 2019 15:36:35 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1563194195; bh=AhW2frebZU++KtoXsWeAbJnFVgz6jRiI9cPpnjtKjV4=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=W12e9C6jMBq4/jrl5KeRG3qJu77XOXom7tBsYjH9cQeqNRXs5A4wvnjrDxCJWzog2
 hNbs3E0JzXNcrbB3tLnOW3tb3MnZkAbGH9LE4pRCS8NMxhhYNvlB2SyYvigPyHn7Ln
 7FZfZmMpDB5v7BLdpo8msGZOrRffPpycnGf3rEik=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1j.mail.yandex.net (localhost [::1])
 by mxbackcorp1j.mail.yandex.net with LMTP id oPNuVxC38R-0QnmrePP
 for <yury-kotov@yandex-team.ru>; Mon, 15 Jul 2019 15:36:24 +0300
Received: by iva8-147456c4bd40.qloud-c.yandex.net with HTTP;
 Mon, 15 Jul 2019 15:36:24 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>
In-Reply-To: <50b64ede-13c1-6887-aaef-75ced63aaeda@redhat.com>
References: <20190710092338.23559-1-yury-kotov@yandex-team.ru>
 <20190710092338.23559-3-yury-kotov@yandex-team.ru>
 <1262801563183599@vla1-1374b6242101.qloud-c.yandex.net>
 <50b64ede-13c1-6887-aaef-75ced63aaeda@redhat.com>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 15 Jul 2019 15:36:34 +0300
Message-Id: <1198471563194184@iva8-147456c4bd40.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 95.108.205.193
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] cpus: Fix throttling during vm_stop
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
Cc: Stefan Weil <sw@weilnetz.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "open list:Overall" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

15.07.2019, 14:00, "Paolo Bonzini" <pbonzini@redhat.com>:
> On 15/07/19 11:40, Yury Kotov wrote:
>> =C2=A0Hi,
>>
>> =C2=A010.07.2019, 12:26, "Yury Kotov" <yury-kotov@yandex-team.ru>:
>>> =C2=A0Throttling thread sleeps in VCPU thread. For high throttle perc=
entage
>>> =C2=A0this sleep is more than 10ms. E.g. for 60% - 15ms, for 99% - 99=
0ms.
>>> =C2=A0vm_stop() kicks all VCPUs and waits for them. It's called at th=
e end of
>>> =C2=A0migration and because of the long sleep the migration downtime =
might be
>>> =C2=A0more than 100ms even for downtime-limit 1ms.
>>> =C2=A0Use qemu_cond_timedwait for high percentage to wake up during v=
m_stop.
>>>
>>> =C2=A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>>> =C2=A0---
>>> =C2=A0=C2=A0cpus.c | 27 +++++++++++++++++++--------
>>> =C2=A0=C2=A01 file changed, 19 insertions(+), 8 deletions(-)
>>>
>>> =C2=A0diff --git a/cpus.c b/cpus.c
>>> =C2=A0index ffc57119ca..3c069cdc33 100644
>>> =C2=A0--- a/cpus.c
>>> =C2=A0+++ b/cpus.c
>>> =C2=A0@@ -74,6 +74,8 @@
>>>
>>> =C2=A0=C2=A0#endif /* CONFIG_LINUX */
>>>
>>> =C2=A0+static QemuMutex qemu_global_mutex;
>>> =C2=A0+
>>> =C2=A0=C2=A0int64_t max_delay;
>>> =C2=A0=C2=A0int64_t max_advance;
>>>
>>> =C2=A0@@ -776,7 +778,7 @@ static void cpu_throttle_thread(CPUState *c=
pu, run_on_cpu_data opaque)
>>> =C2=A0=C2=A0{
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0double pct;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0double throttle_ratio;
>>> =C2=A0- long sleeptime_ns;
>>> =C2=A0+ int64_t sleeptime_ns;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!cpu_throttle_get_percentage(=
)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
>>> =C2=A0@@ -784,11 +786,22 @@ static void cpu_throttle_thread(CPUState =
*cpu, run_on_cpu_data opaque)
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pct =3D (double)cpu_throttle_get_=
percentage()/100;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0throttle_ratio =3D pct / (1 - pct=
);
>>> =C2=A0- sleeptime_ns =3D (long)(throttle_ratio * CPU_THROTTLE_TIMESLI=
CE_NS);
>>> =C2=A0-
>>> =C2=A0- qemu_mutex_unlock_iothread();
>>> =C2=A0- g_usleep(sleeptime_ns / 1000); /* Convert ns to us for usleep=
 call */
>>> =C2=A0- qemu_mutex_lock_iothread();
>>> =C2=A0+ /* Add 1ns to fix double's rounding error (like 0.9999999...)=
 */
>>> =C2=A0+ sleeptime_ns =3D (int64_t)(throttle_ratio * CPU_THROTTLE_TIME=
SLICE_NS + 1);
>>> =C2=A0+
>>> =C2=A0+ while (sleeptime_ns >=3D SCALE_MS && !cpu->stop) {
>>> =C2=A0+ int64_t start, end;
>>> =C2=A0+ start =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>>> =C2=A0+ qemu_cond_timedwait(cpu->halt_cond, &qemu_global_mutex,
>>
>> =C2=A0Paolo, Richard, please tell me what you think.
>> =C2=A0I'm not sure is it correct to use qemu_cond_timedwait() here?
>> =C2=A0I see that qemu_cond_timedwait()/qemu_cond_wait() and
>> =C2=A0qemu_mutex_(un)lock_iothread() have a different behavior in some=
 cases.
>> =C2=A0But there are some similar using of qemu_cond_wait with halt_con=
d, so may be
>> =C2=A0it's ok to use qemu_cond_timedwait() here too.
>
> Back in the day, Windows didn't have condition variables and making the
> implementation robust and efficient was a mess---so there was no
> qemu_cond_timedwait. Semapshores are also a wee bit more scalable, so
> qemu_sem_timedwait was introduced.
>
> Now, I don't think it's an issue to add qemu_cond_timedwait.
>

Sorry, perhaps I was not accurate enough.

To fix the bug I changed the logic of cpu_throttle_thread() function.
Before this function called qemu_mutex_(un)lock_iothread which encapsulat=
es
work with qemu_global_mutex.

Now, this calls qemu_cond_timedwait(..., &qemu_global_mutex, ...) which a=
lso
unlocks/locks qemu_global_mutex. But, in theory, behavior of
qemu_mutex_(un)lock_iothread may differ from simple locking/unlocking of
qemu_global_mutex.

So, I'm not sure is such change is ok or not.

> Thanks,
>
> Paolo
>
>>> =C2=A0+ sleeptime_ns / SCALE_MS);
>>> =C2=A0+ end =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>>> =C2=A0+ sleeptime_ns -=3D end - start;
>>> =C2=A0+ }
>>> =C2=A0+ if (sleeptime_ns >=3D SCALE_US && !cpu->stop) {
>>> =C2=A0+ qemu_mutex_unlock_iothread();
>>> =C2=A0+ g_usleep(sleeptime_ns / SCALE_US);
>>> =C2=A0+ qemu_mutex_lock_iothread();
>>> =C2=A0+ }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0atomic_set(&cpu->throttle_thread_=
scheduled, 0);
>>> =C2=A0=C2=A0}
>>>
>>> =C2=A0@@ -1166,8 +1179,6 @@ static void qemu_init_sigbus(void)
>>> =C2=A0=C2=A0}
>>> =C2=A0=C2=A0#endif /* !CONFIG_LINUX */
>>>
>>> =C2=A0-static QemuMutex qemu_global_mutex;
>>> =C2=A0-
>>> =C2=A0=C2=A0static QemuThread io_thread;
>>>
>>> =C2=A0=C2=A0/* cpu creation */
>>> =C2=A0--
>>> =C2=A02.22.0
>>
>> =C2=A0Regards,
>> =C2=A0Yury

Regards,
Yury

