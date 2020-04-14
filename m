Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC45C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:29:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF77B2076B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhRQm0zL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF77B2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOIoW-0001GA-0S
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 06:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jOInh-0000G8-J4
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jOIne-0000RR-UN
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:28:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58528
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jOIne-0000RH-Pg
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586860094;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2irVPKA7ycxwvTsE4IaA8PQaoR3y2HXeBfG3ultCNE0=;
 b=LhRQm0zL0KSvxTcpKZ3jEKGBD696W9kK8uBayexRLrW7DAIEAq/NR3DakDZkS/ZOUNRCx7
 O67Y0CiF++zFAAbd4L/NTv9QZ8rvZBvAf1ZaT5uGqz+H4QL4aGfRD4ptDNrw7To9vr6yRD
 DpblpDoVF49EAw4exS9NE+NTBcvG+6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-NeahgfxpOPqltQ4VDbGKpw-1; Tue, 14 Apr 2020 06:28:06 -0400
X-MC-Unique: NeahgfxpOPqltQ4VDbGKpw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3035918B5FA5;
 Tue, 14 Apr 2020 10:28:05 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC049271B2;
 Tue, 14 Apr 2020 10:27:56 +0000 (UTC)
Date: Tue, 14 Apr 2020 11:27:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Replace GSource with AioContext for chardev
Message-ID: <20200414102753.GJ1338838@redhat.com>
References: <20200409124601.toh6jpbfcwiwzb6z@r>
 <CAMxuvayJjHH_dqyoPCweQDysubzv=bKnJqgp9TxZNcNKnLTJhw@mail.gmail.com>
 <20200409132441.GS1202384@redhat.com>
 <87imi2zfy1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87imi2zfy1.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Coiby Xu <coiby.xu@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 14, 2020 at 09:25:58AM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Thu, Apr 09, 2020 at 03:16:01PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> >> Hi
> >>=20
> >> On Thu, Apr 9, 2020 at 2:46 PM Coiby Xu <coiby.xu@gmail.com> wrote:
> >> >
> >> >
> >> > Hi,
> >> >
> >> > I'm now implementing vhost-user block device backend
> >> > https://patchew.org/QEMU/20200309100342.14921-1-coiby.xu@gmail.com/
> >> > and want to use chardev to help manage vhost-user client connections
> >> > and read socket message. However there are two issues that need to b=
e
> >> > addressed.
> >> >
> >> > Firstly, chardev isn't suitable for the case when exported drive is
> >> > run in an IOThread because for mow chardev use GSource to dispatch
> >> > socket fd events. So I have to specify which IOThread the exported
> >> > drive is using when launching vhost-user block device backend,
> >> > for example, the following syntax will be used,
> >> >
> >> >    -drive file=3Dfile.img,id=3Ddisk -device virtio-blk,drive=3Ddisk,=
iothread=3Diothread0 \
> >> >     -object vhost-user-blk-server,node-name=3Ddisk,chardev=3Dmon1,io=
thread=3Diothread0 \
> >> >     -object iothread,id=3Diothread0 \
> >> >     -chardev socket,id=3Dmon1,path=3D/tmp/vhost-user-blk_vhost.socke=
t,server,nowait
> >> >
> >> > then iothread_get_g_main_context(IOThread *iothread) has to be calle=
d
> >> > to run the gcontext in IOThread. If we use AioContext to dispatch so=
cket
> >> > fd events, we needn't to specify IOThread twice. Besides aio_poll is=
 faster
> >> > than g_main_loop_run.
> >> >
> >> > Secondly, socket chardev's async read handler (set through
> >> > qemu_chr_fe_set_handlers) doesn't take the case of socket short read
> >> > into consideration.  I plan to add one which will make use qio_chann=
el_yield.
> >> >
> >> > According to
> >> > [1] Improving the QEMU Event Loop - Linux Foundation Events
> >> > http://events17.linuxfoundation.org/sites/events/files/slides/Improv=
ing%20the%20QEMU%20Event%20Loop%20-%203.pdf
> >> >
> >> > "Convert chardev GSource to aio or an equivalent source" (p.30) shou=
ld have
> >> > been finished. I'm curious why the plan didn't continue. If it's des=
irable,
> >> > I'm going to finish the leftover work to resolve the aforementioned =
two issues.
> >>=20
> >> Converting all chardevs to Aio might be challenging, and doesn't bring
> >> much benefits imho.
> >>=20
> >> Perhaps a better approach would be to rely on a new chardev API to
> >> steal the chardev underlying fd or QIO... (mostly keeping -chardev for
> >> CLI/QMP compatibility reason - although breaking some chardev features
> >> that imho aren't compatible with all use cases, like replay, muxing,
> >> swapping etc). The chardev should probably be removed after that...
> >
> > Yeah, I feel like it was a mistake for us to wire up many of our featur=
es
> > to chardevs. We mostly did it because -chardev provides a pre-existing
> > syntax for TCP/UNIX sockets and we didn't want to invent new CLI args.
> > IMHO this was a mistake in retrospect.
> >
> > Unfortunately the -chardev API is absolutely terrible for any usage tha=
t
> > actually cares about the connection based semantics. Witness the horrib=
le
> > hacks we do for re-connect and re-try when failing to initially connect
> > in vhost-user net code.
> >
> > For features in QEMU where the only desirable chardev backend is one wi=
th
> > connection based, socket semantics, I think we would be better off usin=
g
> > the QIOChannel APIs directly and completely avoiding the chardev code.
>=20
> How do we get from here to there?

Ignoring back compat, what would be our ideal CLI syntax ?

Current syntax is

  -chardev socket,id=3Dcharnet1,path=3D/tmp/vhost1.sock
  -netdev vhost-user,chardev=3Dcharnet1,id=3Dhostnet1=20

Should we have an option that expresses a "SocketAddress" struct on the
CLI ?

   -socket type=3Dunix,path=3D/tmp/vhost1.sock,id=3Dsock0
   -netdev vhost-user,socket=3Dsock0,id=3Dhostnet1


IIUC, Marc-Andr=C3=A9 is suggesting that we carry on using -chardev, but
detect when it is a socket chardev, and then ignore chardev APIs and
create a QIOChannel.  I can see some appeal in this as it provides a
way to get all existing usage switched over, but I feel uneasy about
sticking with -chardev forever, if we're not actually using a chardev.

We could do the magic -chardev -> -socket conversion though, for a
short period of time to ease the transition.

We would have to

 1. Introduce the new -socket and add "socket=3D$id" to devices that need i=
t
 2. Deprecate -chardev with type !=3D socket, with no repacement intended
 3. Deprecate -chardev with type =3D=3D socket, translating to -socket
 ...wait 2 releases...
 4. Delete support for "chardev=3D$id" from devices with "socket=3D$id"

The hardest part is probably deciding exactly which set of devices can
be restricted to only sockets, and which must have the full range of
chardev backends available.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


