Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79687C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:32:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FA920857
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7jx4ngx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FA920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhDt-0004ll-A4
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 08:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jOhCN-00041G-BH
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jOhCL-0006uU-AE
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:31:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46368
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jOhCK-0006ta-9d
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586953879;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAgrkkEk1C+Q61V3yoNxvQ8E992hoOuHOxNq6H+90Mo=;
 b=a7jx4ngxBaQl0j0T4kjnEd8xYprIli47XZudtmOlSXYpZCKB+oEOt86rwOVWrUvSZToZp7
 LyUeC9ciTZXbXO2s4/o3RMJNH3BnfJBrVXbisPRlF6WkV38nH3zO+8NZwy7ybqLAnFh8BN
 Ge87fSCJriJ7I+MblIJ2HYmdsQNlKr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-a6k97MPfPoWAPaDZJk8W2Q-1; Wed, 15 Apr 2020 08:31:17 -0400
X-MC-Unique: a6k97MPfPoWAPaDZJk8W2Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 593898017F5;
 Wed, 15 Apr 2020 12:31:16 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07DBC60BE0;
 Wed, 15 Apr 2020 12:31:06 +0000 (UTC)
Date: Wed, 15 Apr 2020 13:31:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: Replace GSource with AioContext for chardev
Message-ID: <20200415123104.GB1344391@redhat.com>
References: <20200409124601.toh6jpbfcwiwzb6z@r>
 <CAMxuvayJjHH_dqyoPCweQDysubzv=bKnJqgp9TxZNcNKnLTJhw@mail.gmail.com>
 <20200409132441.GS1202384@redhat.com>
 <87imi2zfy1.fsf@dusky.pond.sub.org>
 <20200414102753.GJ1338838@redhat.com>
 <802d831b-e13a-7256-77d8-03c7a064522a@redhat.com>
 <20200414121345.GB7747@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200414121345.GB7747@linux.fritz.box>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel <qemu-devel@nongnu.org>,
 Coiby Xu <coiby.xu@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 14, 2020 at 02:13:45PM +0200, Kevin Wolf wrote:
> Am 14.04.2020 um 12:54 hat Paolo Bonzini geschrieben:
> > On 14/04/20 12:27, Daniel P. Berrang=C3=A9 wrote:
> > > Ignoring back compat, what would be our ideal CLI syntax ?
> > >=20
> > > Current syntax is
> > >=20
> > >   -chardev socket,id=3Dcharnet1,path=3D/tmp/vhost1.sock
> > >   -netdev vhost-user,chardev=3Dcharnet1,id=3Dhostnet1=20
> > >=20
> > > Should we have an option that expresses a "SocketAddress" struct on t=
he
> > > CLI ?
> > >=20
> > >    -socket type=3Dunix,path=3D/tmp/vhost1.sock,id=3Dsock0
> > >    -netdev vhost-user,socket=3Dsock0,id=3Dhostnet1
> >=20
> > I think this should be just a "-object socket" that under the covers
> > creates a QIOChannel.  There are also ideas of switching "-chardev" to
> > "-object"; we could do the reverse of Marc-Andr=C3=A9's suggestion, and=
 have
> > "chardev=3D" take both a "chardev-foo" object or a QIOChannel object
> > (converting the latter to a socket-based chardev).
>=20
> Is this just an attempt to avoid nesting on the command line? Because I
> don't see much use in socket objects that need to be managed separately
> and require separate object-add/del commands.
>=20
> While dotted syntax can make SocketAddress specifications a bit lengthy,
> the obvious syntax is:
>=20
> -netdev vhost-user,socket.type=3Dunix,socket.path=3D/tmp/vhost1.sock,id=
=3Dhostnet1
>=20
> Assuming that this would be a QAPIfied -netdev, JSON is a readily
> available alternative syntax.

I'd be fine with this approach too.  I'm not bothered about the dotted
syntax being verbose, as that battle is already lost, and can only be
solved by switching to a different config approach, such as reading
an actual json file.  IOW, we'd not be making life worse than it already
is.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


