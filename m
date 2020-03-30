Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4A4C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 328C6206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnTIkjIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328C6206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jItZv-0006cQ-Bt
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 08:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jItZD-00066K-AK
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jItZC-0003DV-0Z
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:30:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:52857)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jItZB-0003D4-Tk
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585571457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LwaI2HhxiyOaN12FDKFzKWEkS0S5EKquGJoVFVQsxSY=;
 b=UnTIkjIxkggBL7HFj8C+jrbzarQ63dO1eUF7j1gXhr1ad7tWo892zSX9VVCAqCyB+GsnAF
 uKZFRfqJ6/8yg4EL51Cq4MKmY9rEKoCq2bNRmjouTzoil3maPwbXeu7lOdbsGXzhLyWl1I
 f6hK17xjj26P+dfFotrsJVuiiKtK82Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-ver5qiWWPtWLiNoet0Ouqg-1; Mon, 30 Mar 2020 08:30:53 -0400
X-MC-Unique: ver5qiWWPtWLiNoet0Ouqg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDB0A192D786;
 Mon, 30 Mar 2020 12:30:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 611AF60C85;
 Mon, 30 Mar 2020 12:30:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DDD5911385E2; Mon, 30 Mar 2020 14:30:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v5 3/4] qmp: Move dispatcher to a coroutine
References: <20200218154036.28562-1-kwolf@redhat.com>
 <20200218154036.28562-4-kwolf@redhat.com>
 <87d09965g3.fsf@dusky.pond.sub.org>
 <20200323174108.GD8049@linux.fritz.box>
Date: Mon, 30 Mar 2020 14:30:50 +0200
In-Reply-To: <20200323174108.GD8049@linux.fritz.box> (Kevin Wolf's message of
 "Mon, 23 Mar 2020 18:41:08 +0100")
Message-ID: <87mu7yvxc5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 18.03.2020 um 16:36 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>>=20
>> > This moves the QMP dispatcher to a coroutine and runs all QMP command
>> > handlers that declare 'coroutine': true in coroutine context so they
>> > can avoid blocking the main loop while doing I/O or waiting for other
>> > events.
>> >
>> > For commands that are not declared safe to run in a coroutine, the
>> > dispatcher drops out of coroutine context by calling the QMP command
>> > handler from a bottom half.
>> >
>> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>=20
>> Uh, what about @cur_mon?
>>=20
>> @cur_mon points to the current monitor while a command executes.
>> Initial value is null.  It is set in three places (not counting unit
>> tests), and all three save, set, do something that may use @cur_mon,
>> restore:
>>=20
>> * monitor_qmp_dispatch(), for use within qmp_dispatch()
>> * monitor_read(), for use within handle_hmp_command()
>> * qmp_human_monitor_command(), also for use within handle_hmp_command()
>>=20
>> Therefore, @cur_mon is null unless we're running within qmp_dispatch()
>> or handle_hmp_command().
>
> Can we make it NULL for coroutine-enabled handlers?

Sets up and arms a bear trap, I'm afraid.

We can rely on code review to ensure a handler we want to
coroutine-enable does not access @cur_mon.  But how can we ensure no
uses creep back?  Not even on error paths, where testing tends to be
ineffective?

@cur_mon goes back to Jan's commit 376253ece48 (March 2009).  Meant to
be merely a stop gap:

    For the case that monitor outputs so far happen without clearly
    identifiable context, the global variable cur_mon is introduced that
    shall once provide a pointer either to the current active monitor (whil=
e
    processing commands) or to the default one. On the mid or long term,
    those use case will be obsoleted so that this variable can be removed
    again.

It's been eleven years, and we haven't really gotten closer to getting
them "obsoleted".  I can't stop you if you want to try.  Myself, I'd
rather give up and eliminate the Monitor * parameter passing.

>> Example of use: error_report() & friends print "to current monitor if we
>> have one, else to stderr."  Makes sharing code between HMP and CLI
>> easier.  Uses @cur_mon under the hood.
>
> error_report() eventually prints to stderr both for cur_mon =3D=3D NULL a=
nd
> for QMP monitors. Is there an important difference between both cases?

This goes back to

commit 4ad417baa43424b6b988c52b83989fd95670c113
Author: Cole Robinson <crobinso@redhat.com>
Date:   Fri Mar 21 19:42:24 2014 -0400

    error: Print error_report() to stderr if using qmp

    monitor_printf will drop the requested output if cur_mon is qmp (for
    good reason). However these messages are often helpful for debugging
    issues with via libvirt.

    If we know the message won't hit the monitor, send it to stderr.

    Cc: Luiz Capitulino <lcapitulino@redhat.com>
    Cc: Markus Armbruster <armbru@redhat.com>
    Signed-off-by: Cole Robinson <crobinso@redhat.com>
    Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
    Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>

Use of error_report() in QMP context is wrong more often than not.
Still, spewing the message to stderr is less bad than throwing it away.

> There is error_vprintf_unless_qmp(), which behaves differently for both
> cases. However, it is only used in VNC code, so that code would have to
> keep coroutines disabled.

It has seen other users over the years.

error_printf_unless_qmp() is a convenient way to print hints for humans.
In HMP context, you reach the human by printing to @cur_mon.  Outside
monitor context, you reach the human by printing to stdout or stderr.
In QMP context, we're talking to a machine.

> Is cur_mon used much in other functions called by QMP handlers?

Marc-Andr=C3=A9 pointed to the file-descriptor passing stuff.

To be sure that's all, we'd have to review all uses of @cur_mon.

>> @cur_mon is thread-local.
>>=20
>> I'm afraid we have to save, clear and restore @cur_mon around a yield.
>
> That sounds painful enough that I'd rather avoid it.

I've seen coroutine implementations for C that provide coroutine-local
variables of sorts by managing a thread-local opaque pointer.


