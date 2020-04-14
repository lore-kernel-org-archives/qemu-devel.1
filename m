Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A276C2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517EF20767
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7hfBccx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517EF20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOFyK-0001xa-Fb
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 03:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOFxZ-00014z-9S
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOFxX-0007Kp-QK
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:26:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23113
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOFxX-0007IX-MH
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586849174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UI7VY/+zR2XVHCEjX835lS5VnXisM5MkifmQS9MTDNE=;
 b=B7hfBccxpeByzYAhZCbfQZI0Lr9YwwX8BnfZMB/HvYbN3JGlTQ0+mbwZj444TdUJOK3WG+
 aauolIQydSpV2F/11riqzwj1IQ+p7JDe4E8+4FCoYV8kPWStoXRPuFR2h5ObCHYZR5rjka
 3AaQ81vsC9SXtKyPxmzqyD4+iewtVvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-y42YrLU-M9O7KkiqR3beRQ-1; Tue, 14 Apr 2020 03:26:07 -0400
X-MC-Unique: y42YrLU-M9O7KkiqR3beRQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11B6C149C0;
 Tue, 14 Apr 2020 07:26:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6578996B93;
 Tue, 14 Apr 2020 07:26:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A6D0B11385C8; Tue, 14 Apr 2020 09:25:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: Replace GSource with AioContext for chardev
References: <20200409124601.toh6jpbfcwiwzb6z@r>
 <CAMxuvayJjHH_dqyoPCweQDysubzv=bKnJqgp9TxZNcNKnLTJhw@mail.gmail.com>
 <20200409132441.GS1202384@redhat.com>
Date: Tue, 14 Apr 2020 09:25:58 +0200
In-Reply-To: <20200409132441.GS1202384@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Thu, 9 Apr 2020 14:24:41 +0100")
Message-ID: <87imi2zfy1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Coiby Xu <coiby.xu@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Apr 09, 2020 at 03:16:01PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>=20
>> On Thu, Apr 9, 2020 at 2:46 PM Coiby Xu <coiby.xu@gmail.com> wrote:
>> >
>> >
>> > Hi,
>> >
>> > I'm now implementing vhost-user block device backend
>> > https://patchew.org/QEMU/20200309100342.14921-1-coiby.xu@gmail.com/
>> > and want to use chardev to help manage vhost-user client connections
>> > and read socket message. However there are two issues that need to be
>> > addressed.
>> >
>> > Firstly, chardev isn't suitable for the case when exported drive is
>> > run in an IOThread because for mow chardev use GSource to dispatch
>> > socket fd events. So I have to specify which IOThread the exported
>> > drive is using when launching vhost-user block device backend,
>> > for example, the following syntax will be used,
>> >
>> >    -drive file=3Dfile.img,id=3Ddisk -device virtio-blk,drive=3Ddisk,io=
thread=3Diothread0 \
>> >     -object vhost-user-blk-server,node-name=3Ddisk,chardev=3Dmon1,ioth=
read=3Diothread0 \
>> >     -object iothread,id=3Diothread0 \
>> >     -chardev socket,id=3Dmon1,path=3D/tmp/vhost-user-blk_vhost.socket,=
server,nowait
>> >
>> > then iothread_get_g_main_context(IOThread *iothread) has to be called
>> > to run the gcontext in IOThread. If we use AioContext to dispatch sock=
et
>> > fd events, we needn't to specify IOThread twice. Besides aio_poll is f=
aster
>> > than g_main_loop_run.
>> >
>> > Secondly, socket chardev's async read handler (set through
>> > qemu_chr_fe_set_handlers) doesn't take the case of socket short read
>> > into consideration.  I plan to add one which will make use qio_channel=
_yield.
>> >
>> > According to
>> > [1] Improving the QEMU Event Loop - Linux Foundation Events
>> > http://events17.linuxfoundation.org/sites/events/files/slides/Improvin=
g%20the%20QEMU%20Event%20Loop%20-%203.pdf
>> >
>> > "Convert chardev GSource to aio or an equivalent source" (p.30) should=
 have
>> > been finished. I'm curious why the plan didn't continue. If it's desir=
able,
>> > I'm going to finish the leftover work to resolve the aforementioned tw=
o issues.
>>=20
>> Converting all chardevs to Aio might be challenging, and doesn't bring
>> much benefits imho.
>>=20
>> Perhaps a better approach would be to rely on a new chardev API to
>> steal the chardev underlying fd or QIO... (mostly keeping -chardev for
>> CLI/QMP compatibility reason - although breaking some chardev features
>> that imho aren't compatible with all use cases, like replay, muxing,
>> swapping etc). The chardev should probably be removed after that...
>
> Yeah, I feel like it was a mistake for us to wire up many of our features
> to chardevs. We mostly did it because -chardev provides a pre-existing
> syntax for TCP/UNIX sockets and we didn't want to invent new CLI args.
> IMHO this was a mistake in retrospect.
>
> Unfortunately the -chardev API is absolutely terrible for any usage that
> actually cares about the connection based semantics. Witness the horrible
> hacks we do for re-connect and re-try when failing to initially connect
> in vhost-user net code.
>
> For features in QEMU where the only desirable chardev backend is one with
> connection based, socket semantics, I think we would be better off using
> the QIOChannel APIs directly and completely avoiding the chardev code.

How do we get from here to there?


