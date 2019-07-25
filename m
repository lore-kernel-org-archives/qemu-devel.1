Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F233C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 06:00:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66AD1206DD
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 06:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AD1206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqWnl-0005lT-EO
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 02:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38158)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dovgaluk@ispras.ru>) id 1hqWnZ-0005Ip-GM
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 02:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1hqWnY-0002k4-Ie
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 02:00:17 -0400
Received: from mail.ispras.ru ([83.149.199.45]:39442)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1hqWnY-0002jd-BQ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 02:00:16 -0400
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 6F9C854006A;
 Thu, 25 Jul 2019 09:00:15 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'Paolo Bonzini'" <pbonzini@redhat.com>,
 "'Pavel Dovgalyuk'" <pavel.dovgaluk@gmail.com>, <qemu-devel@nongnu.org>
References: <156395778867.510.17588721322993616668.stgit@pasha-Precision-3630-Tower>
 <156395785017.510.9244716077158313815.stgit@pasha-Precision-3630-Tower>
 <55b86868-36a1-def1-8ef0-ca00ab273645@redhat.com>
In-Reply-To: <55b86868-36a1-def1-8ef0-ca00ab273645@redhat.com>
Date: Thu, 25 Jul 2019 09:00:18 +0300
Message-ID: <000701d542ae$3cbfc080$b63f4180$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: ru
Thread-Index: AdVCLBZ0byq/XMXPTnWJtlKsxh7B/AAgg7yw
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: Re: [Qemu-devel] [PATCH for-4.2 10/14] util/qemu-timer: refactor
 deadline calculation for external timers
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com,
 crosthwaite.peter@gmail.com, armbru@redhat.com, mreitz@redhat.com,
 alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com,
 kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com,
 artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 24/07/19 10:44, Pavel Dovgalyuk wrote:
> > -int64_t qemu_clock_deadline_ns_all(QEMUClockType type)
> > +int64_t virtual_clock_deadline_ns(void)
> >  {
> >      int64_t deadline = -1;
> > +    int64_t delta;
> > +    int64_t expire_time;
> > +    QEMUTimer *ts;
> >      QEMUTimerList *timer_list;
> > -    QEMUClock *clock = qemu_clock_ptr(type);
> > +    QEMUClock *clock = qemu_clock_ptr(QEMU_CLOCK_VIRTUAL);
> > +
> > +    if (!clock->enabled) {
> > +        return -1;
> > +    }
> > +
> >      QLIST_FOREACH(timer_list, &clock->timerlists, list) {
> > -        deadline = qemu_soonest_timeout(deadline,
> > -                                        timerlist_deadline_ns(timer_list));
> > +        qemu_mutex_lock(&timer_list->active_timers_lock);
> > +        ts = timer_list->active_timers;
> > +        /* Skip all external timers */
> > +        while (ts && (ts->attributes & QEMU_TIMER_ATTR_EXTERNAL)) {
> > +            ts = ts->next;
> > +        }
> > +        if (!ts) {
> > +            qemu_mutex_unlock(&timer_list->active_timers_lock);
> > +            continue;
> > +        }
> > +        expire_time = ts->expire_time;
> > +        qemu_mutex_unlock(&timer_list->active_timers_lock);
> > +
> > +        delta = expire_time - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > +        if (delta <= 0) {
> > +            delta = 0;
> > +        }
> > +        deadline = qemu_soonest_timeout(deadline, delta);
> >      }
> >      return deadline;
> >  }
> >
> 
> Why would this change be exclusive to QEMU_CLOCK_VIRTUAL?  I don't think
> it's useful to remove the argument.  Otherwise, the patch makes sense.

Ok, I'll rewrite this one and keep the argument.

Pavel Dovgalyuk


