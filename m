Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D951C2D0E5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8FC206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ap/heK3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8FC206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jItcF-0000Tt-Gj
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 08:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jItbM-0008A2-5N
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jItbJ-0004Vw-Sa
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:33:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45669)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jItbJ-0004Ub-Hi
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585571587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nc4wG0sBjgGi3UrNVX8TW70exIY8POyNjXhT0Hi9CYw=;
 b=ap/heK3rhKCfUagNneF/3x36/v5p2UAZqQe3xItDgqHmxbkvEoDw6EhTvDbTINhGE5rg9B
 UKpoiRqILqBvwAw0csvJvD0j+CaSomILe8iwNJh9gVSWKrV7gnY86J6MGQ4JD7GZdrMkVY
 ISQ6tUOa4yRUx7h3yFvVAz+ON+6HvF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-dvqYEnZ0OAu6SjpJjCGaCg-1; Mon, 30 Mar 2020 08:33:05 -0400
X-MC-Unique: dvqYEnZ0OAu6SjpJjCGaCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7F40A0CBF;
 Mon, 30 Mar 2020 12:33:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7861997B12;
 Mon, 30 Mar 2020 12:33:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 47ABA11385E2; Mon, 30 Mar 2020 14:33:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v5 3/4] qmp: Move dispatcher to a coroutine
References: <20200218154036.28562-1-kwolf@redhat.com>
 <20200218154036.28562-4-kwolf@redhat.com>
 <87d09965g3.fsf@dusky.pond.sub.org>
 <20200323174108.GD8049@linux.fritz.box>
 <CAJ+F1CJEey8T6DP1bxCPBKY9kbZmWKxGpFnD6LOmVy2te+1g8g@mail.gmail.com>
Date: Mon, 30 Mar 2020 14:33:03 +0200
In-Reply-To: <CAJ+F1CJEey8T6DP1bxCPBKY9kbZmWKxGpFnD6LOmVy2te+1g8g@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 23 Mar 2020
 19:03:01 +0100")
Message-ID: <87d08uvx8g.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Mar 23, 2020 at 6:41 PM Kevin Wolf <kwolf@redhat.com> wrote:
>>
>> Am 18.03.2020 um 16:36 hat Markus Armbruster geschrieben:
>> > Kevin Wolf <kwolf@redhat.com> writes:
>> >
>> > > This moves the QMP dispatcher to a coroutine and runs all QMP comman=
d
>> > > handlers that declare 'coroutine': true in coroutine context so they
>> > > can avoid blocking the main loop while doing I/O or waiting for othe=
r
>> > > events.
>> > >
>> > > For commands that are not declared safe to run in a coroutine, the
>> > > dispatcher drops out of coroutine context by calling the QMP command
>> > > handler from a bottom half.
>> > >
>> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> >
>> > Uh, what about @cur_mon?
>> >
>> > @cur_mon points to the current monitor while a command executes.
>> > Initial value is null.  It is set in three places (not counting unit
>> > tests), and all three save, set, do something that may use @cur_mon,
>> > restore:
>> >
>> > * monitor_qmp_dispatch(), for use within qmp_dispatch()
>> > * monitor_read(), for use within handle_hmp_command()
>> > * qmp_human_monitor_command(), also for use within handle_hmp_command(=
)
>> >
>> > Therefore, @cur_mon is null unless we're running within qmp_dispatch()
>> > or handle_hmp_command().
>>
>> Can we make it NULL for coroutine-enabled handlers?
>
> fwiw, I think /dev/fdset doesn't care about cur_mon. However, qmp
> handlers that use monitor_get_fd() usually depend on cur_mon.
>
> Note: I wonder if add-fd (fdsets) and getfd (monitor fds) deserve to co-e=
xist.

Beats me.

If one of them is more general, we could consider deprecating the other
one.


