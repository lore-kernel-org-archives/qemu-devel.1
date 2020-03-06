Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD68EC3F2D5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 07:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87DB5208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 07:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVt6H9C1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DB5208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA7NA-0006ei-RX
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 02:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jA7MS-0006Ar-Mr
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 02:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jA7MR-0006w7-3w
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 02:25:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29963
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jA7MQ-0006rG-Sz
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 02:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583479530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LB9xvf82J1ob4BEcwh3Uro+BKLuMDFp2I5RxQI68aro=;
 b=QVt6H9C1JQj5bFeZzvc77NsBLLlSpa3L1aJ1qqkkpyWIqvn6o02fAK/uyLj/8KQZQ6Bnij
 NYn6D/7+YrrvrrzgBLEGpI4dPHDxasH7DDcJW+YQf4gb8D3dsyzvDRqG09bMhR41QThIy/
 qZJcfRJjqxGeYN5B0nq8rwBb/Ha3E/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-7dDDL_OBM7W3SHfLf1s5-w-1; Fri, 06 Mar 2020 02:25:26 -0500
X-MC-Unique: 7dDDL_OBM7W3SHfLf1s5-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 735A01007273;
 Fri,  6 Mar 2020 07:25:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5700E5C28C;
 Fri,  6 Mar 2020 07:25:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CA61F11386A6; Fri,  6 Mar 2020 08:25:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 1/4] qapi: Add a 'coroutine' flag for commands
References: <20200121181122.15941-1-kwolf@redhat.com>
 <20200121181122.15941-2-kwolf@redhat.com>
 <87lfq0yp9v.fsf@dusky.pond.sub.org>
 <20200122101021.GB5268@linux.fritz.box>
 <87h7z2ddjj.fsf@dusky.pond.sub.org>
 <20200305160654.GC5363@linux.fritz.box>
Date: Fri, 06 Mar 2020 08:25:20 +0100
In-Reply-To: <20200305160654.GC5363@linux.fritz.box> (Kevin Wolf's message of
 "Thu, 5 Mar 2020 17:06:54 +0100")
Message-ID: <87pndq7xnj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, David Alan Gilbert <dgilbert@redhat.com>,
 marcandre.lureau@gmail.com, stefanha@redhat.com,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 05.03.2020 um 16:30 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>>=20
>> > Am 22.01.2020 um 07:32 hat Markus Armbruster geschrieben:
>> >> Kevin Wolf <kwolf@redhat.com> writes:
>> >>=20
>> >> > This patch adds a new 'coroutine' flag to QMP command definitions t=
hat
>> >> > tells the QMP dispatcher that the command handler is safe to be run=
 in a
>> >> > coroutine.
>> >>=20
>> >> I'm afraid I missed this question in my review of v3: when is a handl=
er
>> >> *not* safe to be run in a coroutine?
>> >
>> > That's a hard one to answer fully.
>> >
>> > Basically, I think the biggest problem is with calling functions that
>> > change their behaviour if run in a coroutine compared to running them
>> > outside of coroutine context. In most cases the differences like havin=
g
>> > a nested event loop instead of yielding are just fine, but they are
>> > still subtly different.
>> >
>> > I know this is vague, but I can assure you that problematic cases exis=
t.
>> > I hit one of them with my initial hack that just moved everything into=
 a
>> > coroutine. It was related to graph modifications and bdrv_drain and
>> > resulted in a hang. For the specifics, I would have to try and reprodu=
ce
>> > the problem again.
>>=20
>> I'm afraid it's even more complicated.
>>=20
>> Monitors (HMP and QMP) run in the main loop.  Before this patch, HMP and
>> QMP commands run start to finish, one after the other.
>>=20
>> After this patch, QMP commands may elect to yield.  QMP commands still
>> run one after the other (the shared dispatcher ensures this even when we
>> have multiple QMP monitors).
>>=20
>> However, *HMP* commands can now run interleaved with a coroutine-enabled
>> QMP command, i.e. between a yield and its re-enter.
>
> I guess that's right. :-(
>
>> Consider an HMP screendump running in the middle of a coroutine-enabled
>> QMP screendump, using Marc-Andr=C3=A9's patch.  As far as I can tell, it
>> works, because:
>>=20
>> 1. HMP does not run in a coroutine.  If it did, and both dumps dumped
>> the same @con, then it would overwrite con->screndump_co.  If we ever
>> decide to make HMP coroutine-capable so it doesn't block the main loop,
>> this will become unsafe in a nasty way.
>
> At the same time, switching HMP to coroutines would give us an easy way
> to fix the problem: Just use a CoMutex so that HMP and QMP commands
> never run in parallel. Unless we actually _want_ to run both at the same
> time for some commands, but I don't see why.

As long as running QMP commands from *all* monitors one after the other
is good enough, I can't see why running HMP commands interleaved is
worth the risk.

> While we don't have this, maybe it's worth considering if there is
> another simple way to achieve the same thing. Could QMP just suspend all
> HMP monitors while it's executing a command? At first sight it seems
> that this would work only for "interactive" monitors.

I believe the non-"interactive" HMP code is used only by gdbstub.c.

I keep forgetting our GDB server stub creates an "HMP" monitor.
Possibly because I don't understand why.  Alex, Philippe, can you
enlighten me?

Aside: I figure the distribution of work between monitor_init(),
monitor_init_hmp() and monitor_init_qmp() could be improved.

>> 2. graphic_hw_update() is safe to call even while another
>> graphic_hw_update() runs.  qxl_render_update() appears to ensure that
>> with the help of qxl->ssd.lock.
>>=20
>> 3. There is no 3[*].
>>=20
>> My point is: this is a non-trivial argument.  Whether a QMP command
>> handler is safe to run in a coroutine depends on how it interacts with
>> all the stuff that can run interleaved with it.  Typically includes
>> itself via its HMP buddy.
>
> If the handler doesn't yield, it's still trivial. So I think my original
> statement that with the existing QMP handlers, the problem is with code
> that behaves different between coroutine and non-coroutine calls, is
> still true because that is the only code that could possibly yield with
> existing QMP command handlers.
>
> Of course, you're right that handlers that actually can yield need to be
> careful that they can deal with whatever happens until they are
> reentered. And that seems to include HMP handlers.
>
> Kevin


