Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7B1C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A6B207FD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdAL5l1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A6B207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA9fW-0004El-4a
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 04:53:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jA9et-0003iy-Mz
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:52:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jA9es-00005w-5H
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:52:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41439
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jA9er-0008VL-Vm
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583488361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33sSzXqajwJjums6gwYug9k0hVkXC0e3J7xJ2uELV1g=;
 b=VdAL5l1i+UOCySimzFV600XHpNjj/wY/MqZyzhiy9UZvre8O1cqEaLYrcwrqD0+lkX3kPC
 kePOpC8FubJ3eco1o+PqqO0PtxisHVWO6PhLJGW1i1chQpoJivS5vDQZH6Q+7DdanbV10i
 7l+fprSEcdveX8jhtIgopZcY332DePA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-s7hkgLtsNvOcM610CO60TA-1; Fri, 06 Mar 2020 04:52:39 -0500
X-MC-Unique: s7hkgLtsNvOcM610CO60TA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8504E107ACCD;
 Fri,  6 Mar 2020 09:52:38 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 36B48272D3;
 Fri,  6 Mar 2020 09:52:34 +0000 (UTC)
Date: Fri, 6 Mar 2020 10:52:32 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 1/4] qapi: Add a 'coroutine' flag for commands
Message-ID: <20200306095232.GB7240@linux.fritz.box>
References: <20200121181122.15941-1-kwolf@redhat.com>
 <20200121181122.15941-2-kwolf@redhat.com>
 <87lfq0yp9v.fsf@dusky.pond.sub.org>
 <20200122101021.GB5268@linux.fritz.box>
 <87h7z2ddjj.fsf@dusky.pond.sub.org>
 <20200305160654.GC5363@linux.fritz.box>
 <87pndq7xnj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87pndq7xnj.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, David Alan Gilbert <dgilbert@redhat.com>,
 marcandre.lureau@gmail.com, stefanha@redhat.com,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 06.03.2020 um 08:25 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Am 05.03.2020 um 16:30 hat Markus Armbruster geschrieben:
> >> Kevin Wolf <kwolf@redhat.com> writes:
> >>=20
> >> > Am 22.01.2020 um 07:32 hat Markus Armbruster geschrieben:
> >> >> Kevin Wolf <kwolf@redhat.com> writes:
> >> >>=20
> >> >> > This patch adds a new 'coroutine' flag to QMP command definitions=
 that
> >> >> > tells the QMP dispatcher that the command handler is safe to be r=
un in a
> >> >> > coroutine.
> >> >>=20
> >> >> I'm afraid I missed this question in my review of v3: when is a han=
dler
> >> >> *not* safe to be run in a coroutine?
> >> >
> >> > That's a hard one to answer fully.
> >> >
> >> > Basically, I think the biggest problem is with calling functions tha=
t
> >> > change their behaviour if run in a coroutine compared to running the=
m
> >> > outside of coroutine context. In most cases the differences like hav=
ing
> >> > a nested event loop instead of yielding are just fine, but they are
> >> > still subtly different.
> >> >
> >> > I know this is vague, but I can assure you that problematic cases ex=
ist.
> >> > I hit one of them with my initial hack that just moved everything in=
to a
> >> > coroutine. It was related to graph modifications and bdrv_drain and
> >> > resulted in a hang. For the specifics, I would have to try and repro=
duce
> >> > the problem again.
> >>=20
> >> I'm afraid it's even more complicated.
> >>=20
> >> Monitors (HMP and QMP) run in the main loop.  Before this patch, HMP a=
nd
> >> QMP commands run start to finish, one after the other.
> >>=20
> >> After this patch, QMP commands may elect to yield.  QMP commands still
> >> run one after the other (the shared dispatcher ensures this even when =
we
> >> have multiple QMP monitors).
> >>=20
> >> However, *HMP* commands can now run interleaved with a coroutine-enabl=
ed
> >> QMP command, i.e. between a yield and its re-enter.
> >
> > I guess that's right. :-(
> >
> >> Consider an HMP screendump running in the middle of a coroutine-enable=
d
> >> QMP screendump, using Marc-Andr=E9's patch.  As far as I can tell, it
> >> works, because:
> >>=20
> >> 1. HMP does not run in a coroutine.  If it did, and both dumps dumped
> >> the same @con, then it would overwrite con->screndump_co.  If we ever
> >> decide to make HMP coroutine-capable so it doesn't block the main loop=
,
> >> this will become unsafe in a nasty way.
> >
> > At the same time, switching HMP to coroutines would give us an easy way
> > to fix the problem: Just use a CoMutex so that HMP and QMP commands
> > never run in parallel. Unless we actually _want_ to run both at the sam=
e
> > time for some commands, but I don't see why.
>=20
> As long as running QMP commands from *all* monitors one after the other
> is good enough, I can't see why running HMP commands interleaved is
> worth the risk.

There is one exception, actually: Obviously, human-monitor-command must
allow HMP commands to run in parallel.

> > While we don't have this, maybe it's worth considering if there is
> > another simple way to achieve the same thing. Could QMP just suspend al=
l
> > HMP monitors while it's executing a command? At first sight it seems
> > that this would work only for "interactive" monitors.
>=20
> I believe the non-"interactive" HMP code is used only by gdbstub.c.

monitor_init_hmp() is called from (based on my block branch):

* monitor_init(): This is interactive.
* qemu_chr_new_noreplay(): Interactive, too.
* gdbserver_start(): Non-interactive.

There is also qmp_human_monitor_command(), which manually creates a
MonitorHMP without going through monitor_init_hmp(). It does call
monitor_data_init(), though. There are no additional callers of
monitor_data_init() and I think I would have added it to every creation
of a Monitor object when I did the QMP/HMP split of the struct.

So GDB and human-monitor-command should be the two non-interactive
cases.

> I keep forgetting our GDB server stub creates an "HMP" monitor.
> Possibly because I don't understand why.  Alex, Philippe, can you
> enlighten me?

I think you can send HMP commands from within gdb with it:

(gdb) tar rem:1234
Remote debugging using :1234
[...]
(gdb) monitor info block
ide1-cd0: [not inserted]
    Attached to:      /machine/unattached/device[23]
    Removable device: not locked, tray closed

floppy0: [not inserted]
    Attached to:      /machine/unattached/device[16]
    Removable device: not locked, tray closed

sd0: [not inserted]
    Removable device: not locked, tray closed

So we do want stop it from processing requests while a QMP command is
running.

Kevin


