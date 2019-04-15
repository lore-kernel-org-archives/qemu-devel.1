Received: from eggs.gnu.org ([209.51.188.92]:41917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hFz98-0005Qq-MT
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hFz97-0005dr-IX
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:47:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hFz97-0005di-8u
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:47:29 -0400
Date: Mon, 15 Apr 2019 11:47:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190415104725.GI5718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190410092652.22616-1-yury-kotov@yandex-team.ru>
	<20190411120421.GP3641@redhat.com>
	<219131554985898@iva6-8a76e93b6298.qloud-c.yandex.net>
	<20190411123911.GR3641@redhat.com>
	<226271554987011@iva6-8a76e93b6298.qloud-c.yandex.net>
	<243191555321803@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415101101.GF5718@redhat.com>
	<251681555323421@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415102520.GG5718@redhat.com>
	<259551555324396@vla1-1374b6242101.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <259551555324396@vla1-1374b6242101.qloud-c.yandex.net>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: Fix handling fd protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>, Juan Quintela <quintela@redhat.com>

On Mon, Apr 15, 2019 at 01:33:21PM +0300, Yury Kotov wrote:
> 15.04.2019, 13:25, "Daniel P. Berrang=C3=A9" <berrange@redhat.com>:
> > On Mon, Apr 15, 2019 at 01:17:06PM +0300, Yury Kotov wrote:
> >> =C2=A015.04.2019, 13:11, "Daniel P. Berrang=C3=A9" <berrange@redhat.=
com>:
> >> =C2=A0> On Mon, Apr 15, 2019 at 12:50:08PM +0300, Yury Kotov wrote:
> >> =C2=A0>> =C2=A0Hi,
> >> =C2=A0>>
> >> =C2=A0>> =C2=A0Just to clarify. I see two possible solutions:
> >> =C2=A0>>
> >> =C2=A0>> =C2=A01) Since the migration code doesn't receive fd, it is=
n't responsible for
> >> =C2=A0>> =C2=A0closing it. So, it may be better to use migrate_fd_pa=
ram for both
> >> =C2=A0>> =C2=A0incoming/outgoing and add dupping for migrate_fd_para=
m. Thus, clients must
> >> =C2=A0>> =C2=A0close the fd themselves. But existing clients will ha=
ve a leak.
> >> =C2=A0>
> >> =C2=A0> We can't break existing clients in this way as they are corr=
ectly
> >> =C2=A0> using the monitor with its current semantics.
> >> =C2=A0>
> >> =C2=A0>> =C2=A02) If we don't duplicate fd, then at least we should =
remove fd from
> >> =C2=A0>> =C2=A0the corresponding list. Therefore, the solution is to=
 fix qemu_close to find
> >> =C2=A0>> =C2=A0the list and remove fd from it. But qemu_close is cur=
rently consistent with
> >> =C2=A0>> =C2=A0qemu_open (which opens/dups fd), so adding additional=
 logic might not be
> >> =C2=A0>> =C2=A0a very good idea.
> >> =C2=A0>
> >> =C2=A0> qemu_close is not appropriate place to deal with something s=
peciifc
> >> =C2=A0> to the montor.
> >> =C2=A0>
> >> =C2=A0>> =C2=A0I don't see any other solution, but I might miss some=
thing.
> >> =C2=A0>> =C2=A0What do you think?
> >> =C2=A0>
> >> =C2=A0> All callers of monitor_get_fd() will close() the FD they get=
 back.
> >> =C2=A0> Thus monitor_get_fd() should remove it from the list when it=
 returns
> >> =C2=A0> it, and we should add API docs to monitor_get_fd() to explai=
n this.
> >> =C2=A0>
> >> =C2=A0Ok, it sounds reasonable. But monitor_get_fd is only about out=
going migration.
> >> =C2=A0But what about the incoming migration? It doesn't use monitor_=
get_fd but just
> >> =C2=A0converts input string to int and use it as fd.
> >
> > The incoming migration expects the FD to be passed into QEMU by the m=
gmt
> > app when it is exec'ing the QEMU binary. It doesn't interact with the
> > monitor at all AFAIR.
> >
>=20
> Oh, sorry. This use case is not obvious. We used add-fd to pass fd for
> migrate-incoming and such way has described problems.

That's a bug in your usage of QEMU IMHO, as the incoming code is not
designed to use add-fd.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
