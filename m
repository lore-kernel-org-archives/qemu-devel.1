Received: from eggs.gnu.org ([209.51.188.92]:48555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hF1FV-0008Iu-QJ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hF1FS-0005gg-QG
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:50:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hF1FS-0005gF-GX
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:50:02 -0400
Date: Fri, 12 Apr 2019 19:49:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190412184956.GT2906@work-vm>
References: <20190412122028.7067-1-yury-kotov@yandex-team.ru>
	<fff20c68-d4db-3a56-ba39-dc487d6f80e5@redhat.com>
	<20190412172309.GF25308@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190412172309.GF25308@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Add 'inline-fd:' protocol for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, yc-core@yandex-team.ru

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Fri, Apr 12, 2019 at 12:13:51PM -0500, Eric Blake wrote:
> > On 4/12/19 7:20 AM, Yury Kotov wrote:
> > > Hi,
> > >=20
> > > I've added 'inline-fd:' proto to simplify migration to/from fd.
> > > I thought about modifying the existing 'fd:' proto but I'm not sure=
 it's a
> > > good idea to change it's contract.
> > >=20
> > > Existing 'fd:' proto works with previously added fd by getfd or add=
-fd commands.
> > > If client doesn't want to work with this fd before or after migrati=
on then it's
> > > easier to send an fd with the migrate-* command. Also, client shoul=
dn't maintain
> > > this fd.
> >=20
> > While the sentiment of making it easier by having fewer QMP commands
> > might be worthwhile, I'm worried about whether this scales. Having ju=
st
> > a limited set of commands that take an fd over SCM rights, and every
> > other command wired to automagically work with existing named fds,
> > scales a lot easier than having to teach individual commands how to t=
ake
> > an fd inline.
>=20
> Yeah I tend to agree - we use FD passing extensively across QMP/HMP
> and all these commands are written to interact with "getfd". I think
> it would be a step backwards to introduce a special case with
> migration that doesn't use "getfd".

Yes, agreed - as you spotted passing fd's gets a bit hairy, and hence
it's best to keep it to a few places.

Lets figure out the right way of fixing the double-close you spotted
rather than adding new schemes.

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
