Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B38C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A4FA2078B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6PGGAqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4FA2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOim5-0005ky-Cg
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 10:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOil7-0004rs-H1
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOil5-0004ny-TP
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:11:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46633
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOil5-0004nb-N7
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586959879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3jrBAht1Ce6YLLdeW38nYWGAWVrwoBfP9pv9eg21dfU=;
 b=U6PGGAqcfXzR7+Y4J1hmMXljR03SsxEjljqgHlCZQl/gqW+GnOOfZgbxDsIEyojWjoWC5n
 ttHc/X0DRkGgLEb4F4M7OTl1BKa1qTmlHamDoIgndOM5Umb3xhgHO9p1ly0W+BJBLJZNL7
 i7u6gIZp5+9W/bv2hnwCxOXzX/eTq0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-FsdHH82hOOmeTY_R7dumCg-1; Wed, 15 Apr 2020 10:11:17 -0400
X-MC-Unique: FsdHH82hOOmeTY_R7dumCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 321F0DB66;
 Wed, 15 Apr 2020 14:11:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D48A860BEC;
 Wed, 15 Apr 2020 14:11:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A81811385C8; Wed, 15 Apr 2020 16:11:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Adalbert =?utf-8?Q?Laz=C3=A3r?= <alazar@bitdefender.com>
Subject: Re: [RFC PATCH v1 03/26] char-socket: fix the client mode when
 created through QMP
References: <20200415005938.23895-1-alazar@bitdefender.com>
 <20200415005938.23895-4-alazar@bitdefender.com>
 <CAJ+F1CLLpzdoNqwgMQh8j4Sd4_HGEmBt=x1wPsHXvgZ7O=8Kzg@mail.gmail.com>
 <15869512460.BE82bEee.22517@host>
Date: Wed, 15 Apr 2020 16:11:14 +0200
In-Reply-To: <15869512460.BE82bEee.22517@host> ("Adalbert =?utf-8?Q?Laz?=
 =?utf-8?Q?=C3=A3r=22's?= message of
 "Wed, 15 Apr 2020 14:47:26 +0300")
Message-ID: <87tv1kg7p9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adalbert Laz=C3=A3r <alazar@bitdefender.com> writes:

> On Wed, 15 Apr 2020 12:37:34 +0200, Marc-Andr=C3=A9 Lureau <marcandre.lur=
eau@gmail.com> wrote:
>> Hi
>>=20
>> On Wed, Apr 15, 2020 at 3:00 AM Adalbert Laz=C4=83r <alazar@bitdefender.=
com> wrote:
>> >
>> > qmp_chardev_open_socket() ignores the absence of the 'server' argument
>> > and always switches to listen/server mode.
>> >
>> > CC: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
>> > CC: Paolo Bonzini <pbonzini@redhat.com>
>> > Signed-off-by: Adalbert Laz=C4=83r <alazar@bitdefender.com>
>> > ---
>> >  chardev/char-socket.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>> > index 9b2deb0125..fd0106ab85 100644
>> > --- a/chardev/char-socket.c
>> > +++ b/chardev/char-socket.c
>> > @@ -1310,7 +1310,7 @@ static void qmp_chardev_open_socket(Chardev *chr=
,
>> >      SocketChardev *s =3D SOCKET_CHARDEV(chr);
>> >      ChardevSocket *sock =3D backend->u.socket.data;
>> >      bool do_nodelay     =3D sock->has_nodelay ? sock->nodelay : false=
;
>> > -    bool is_listen      =3D sock->has_server  ? sock->server  : true;
>> > +    bool is_listen      =3D sock->has_server  ? sock->server  : false=
;
>>=20
>> I don't understand what you mean. It defaults to server mode. We can't
>> change that.
>
> First of all, thanks for your comments.
>
> I understand that a chardev socket is either in client mode or in server
> mode.  If the 'server' parameter is not used, the socket is put in client
> mode. At least this is the behavior when the socket is created by parsing
> the command line. But, when created through QMP, without the 'server' par=
ameter,
> the socket is put in server mode.
>
> Until this moment, I did not think that we can use "server=3Dno" through =
QMP :))

Start here:

    $ socat "READLINE,history=3D$HOME/.qmp_history,prompt=3DQMP>" UNIX-CONN=
ECT:$HOME/work/images/test-qmp=20
    {"QMP": {"version": {"qemu": {"micro": 92, "minor": 2, "major": 4}, "pa=
ckage": "v5.0.0-rc2-30-g25b0509e28"}, "capabilities": ["oob"]}}
    QMP>{"execute": "qmp_capabilities"}
    {"return": {}}
    QMP>{"execute":"chardev-add", "arguments": {"id":"foo", "backend": {"ty=
pe": "socket", "data": {"addr": {"type": "inet", "data": {"host": "0.0.0.0"=
, "port": "2445"}}, "server": false}}}}
    {"error": {"class": "GenericError", "desc": "Failed to connect socket: =
Connection refused"}}

> So, yes. We may create the socket in client mode through QMP without this=
 patch.
>
>>=20
>> >      bool is_telnet      =3D sock->has_telnet  ? sock->telnet  : false=
;
>> >      bool is_tn3270      =3D sock->has_tn3270  ? sock->tn3270  : false=
;
>> >      bool is_waitconnect =3D sock->has_wait    ? sock->wait    : false=
;
>> >
>>=20
>>=20
>> --=20
>> Marc-Andr=C3=A9 Lureau
>>=20


