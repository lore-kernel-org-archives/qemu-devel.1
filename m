Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA2BC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293182073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqq6gKeD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293182073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jACFz-00049w-5Y
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 07:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jACFI-0003FX-Vb
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:38:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jACFH-0000sZ-GI
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:38:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25253
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jACFH-0000ow-2i
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583498305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJF4PujMFMSJcup7eJdzN1z3Czc2koUdcpdIXMbVXHQ=;
 b=bqq6gKeD43BCM/KXddb1Tse0trHkvCHi295H+G84rYnren74rCiRTqGh2aGnXunfUgu0b0
 uDs0q9Q33C/6P226Gy0wGmbN31vjVC27PJRM5l5pyAuSGGWbT7bzgQ1R8r+glAM5yE3Eao
 IUvbyPfEbJW8jnxNo+zkfN+PqusIl6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-cKLCMVbiNOOYYla35daIaw-1; Fri, 06 Mar 2020 07:38:24 -0500
X-MC-Unique: cKLCMVbiNOOYYla35daIaw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C82A800D50;
 Fri,  6 Mar 2020 12:38:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75722272CC;
 Fri,  6 Mar 2020 12:38:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 04EFA11386A6; Fri,  6 Mar 2020 13:38:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 1/4] qapi: Add a 'coroutine' flag for commands
References: <20200121181122.15941-1-kwolf@redhat.com>
 <20200121181122.15941-2-kwolf@redhat.com>
 <87lfq0yp9v.fsf@dusky.pond.sub.org>
 <20200122101021.GB5268@linux.fritz.box>
 <87h7z2ddjj.fsf@dusky.pond.sub.org>
 <20200305160654.GC5363@linux.fritz.box>
 <87pndq7xnj.fsf@dusky.pond.sub.org>
 <20200306095232.GB7240@linux.fritz.box>
Date: Fri, 06 Mar 2020 13:38:18 +0100
In-Reply-To: <20200306095232.GB7240@linux.fritz.box> (Kevin Wolf's message of
 "Fri, 6 Mar 2020 10:52:32 +0100")
Message-ID: <87blp94q11.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-block@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 David Alan Gilbert <dgilbert@redhat.com>, marcandre.lureau@gmail.com,
 stefanha@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 06.03.2020 um 08:25 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>>=20
>> > Am 05.03.2020 um 16:30 hat Markus Armbruster geschrieben:
>> >> Kevin Wolf <kwolf@redhat.com> writes:
>> >>=20
>> >> > Am 22.01.2020 um 07:32 hat Markus Armbruster geschrieben:
>> >> >> Kevin Wolf <kwolf@redhat.com> writes:
>> >> >>=20
>> >> >> > This patch adds a new 'coroutine' flag to QMP command definition=
s that
>> >> >> > tells the QMP dispatcher that the command handler is safe to be =
run in a
>> >> >> > coroutine.
>> >> >>=20
>> >> >> I'm afraid I missed this question in my review of v3: when is a ha=
ndler
>> >> >> *not* safe to be run in a coroutine?
>> >> >
>> >> > That's a hard one to answer fully.
>> >> >
>> >> > Basically, I think the biggest problem is with calling functions th=
at
>> >> > change their behaviour if run in a coroutine compared to running th=
em
>> >> > outside of coroutine context. In most cases the differences like ha=
ving
>> >> > a nested event loop instead of yielding are just fine, but they are
>> >> > still subtly different.
>> >> >
>> >> > I know this is vague, but I can assure you that problematic cases e=
xist.
>> >> > I hit one of them with my initial hack that just moved everything i=
nto a
>> >> > coroutine. It was related to graph modifications and bdrv_drain and
>> >> > resulted in a hang. For the specifics, I would have to try and repr=
oduce
>> >> > the problem again.
>> >>=20
>> >> I'm afraid it's even more complicated.
>> >>=20
>> >> Monitors (HMP and QMP) run in the main loop.  Before this patch, HMP =
and
>> >> QMP commands run start to finish, one after the other.
>> >>=20
>> >> After this patch, QMP commands may elect to yield.  QMP commands stil=
l
>> >> run one after the other (the shared dispatcher ensures this even when=
 we
>> >> have multiple QMP monitors).
>> >>=20
>> >> However, *HMP* commands can now run interleaved with a coroutine-enab=
led
>> >> QMP command, i.e. between a yield and its re-enter.
>> >
>> > I guess that's right. :-(
>> >
>> >> Consider an HMP screendump running in the middle of a coroutine-enabl=
ed
>> >> QMP screendump, using Marc-Andr=C3=A9's patch.  As far as I can tell,=
 it
>> >> works, because:
>> >>=20
>> >> 1. HMP does not run in a coroutine.  If it did, and both dumps dumped
>> >> the same @con, then it would overwrite con->screndump_co.  If we ever
>> >> decide to make HMP coroutine-capable so it doesn't block the main loo=
p,
>> >> this will become unsafe in a nasty way.
>> >
>> > At the same time, switching HMP to coroutines would give us an easy wa=
y
>> > to fix the problem: Just use a CoMutex so that HMP and QMP commands
>> > never run in parallel. Unless we actually _want_ to run both at the sa=
me
>> > time for some commands, but I don't see why.
>>=20
>> As long as running QMP commands from *all* monitors one after the other
>> is good enough, I can't see why running HMP commands interleaved is
>> worth the risk.
>
> There is one exception, actually: Obviously, human-monitor-command must
> allow HMP commands to run in parallel.

Yes.

>> > While we don't have this, maybe it's worth considering if there is
>> > another simple way to achieve the same thing. Could QMP just suspend a=
ll
>> > HMP monitors while it's executing a command? At first sight it seems
>> > that this would work only for "interactive" monitors.
>>=20
>> I believe the non-"interactive" HMP code is used only by gdbstub.c.
>
> monitor_init_hmp() is called from (based on my block branch):
>
> * monitor_init(): This is interactive.
> * qemu_chr_new_noreplay(): Interactive, too.
> * gdbserver_start(): Non-interactive.
>
> There is also qmp_human_monitor_command(), which manually creates a
> MonitorHMP without going through monitor_init_hmp(). It does call
> monitor_data_init(), though. There are no additional callers of
> monitor_data_init() and I think I would have added it to every creation
> of a Monitor object when I did the QMP/HMP split of the struct.
>
> So GDB and human-monitor-command should be the two non-interactive
> cases.

Yes.

>> I keep forgetting our GDB server stub creates an "HMP" monitor.
>> Possibly because I don't understand why.  Alex, Philippe, can you
>> enlighten me?
>
> I think you can send HMP commands from within gdb with it:
>
> (gdb) tar rem:1234
> Remote debugging using :1234
> [...]
> (gdb) monitor info block
> ide1-cd0: [not inserted]
>     Attached to:      /machine/unattached/device[23]
>     Removable device: not locked, tray closed
>
> floppy0: [not inserted]
>     Attached to:      /machine/unattached/device[16]
>     Removable device: not locked, tray closed
>
> sd0: [not inserted]
>     Removable device: not locked, tray closed

Argh!

Any idea where we define GDB command "monitor"?

> So we do want stop it from processing requests while a QMP command is
> running.

Then a slow QMP command can interfere with debugging.

Perhaps we can synchronize just the "monitor" command.


