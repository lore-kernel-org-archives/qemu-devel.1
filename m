Received: from eggs.gnu.org ([2001:4830:134:3::10]:46763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPoFG-0005qE-Ft
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPoFE-00034O-7I
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:05:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34638 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fPoFE-000349-23
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:05:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5808401EF05
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 12:05:51 +0000 (UTC)
Date: Mon, 4 Jun 2018 13:05:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180604120548.GF19749@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180604102752.32260-1-berrange@redhat.com>
	<8297e5b4-dca4-f080-fb87-4cf29a2bb857@redhat.com>
	<20180604135802.0106a89c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604135802.0106a89c@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vl: don't use RUN_STATE_PRECONFIG unless
 --preconfig is given
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michal Privoznik <mprivozn@redhat.com>

On Mon, Jun 04, 2018 at 01:58:02PM +0200, Igor Mammedov wrote:
> On Mon, 4 Jun 2018 12:33:04 +0200
> Max Reitz <mreitz@redhat.com> wrote:
>=20
> > On 2018-06-04 12:27, Daniel P. Berrang=C3=A9 wrote:
> > > The RUN_STATE_PRECONFIG state is not supposed to be reachable unles=
s the
> > > --preconfig argument is given to QEMU, but when it was introduced i=
n:
> > >=20
> > >   commit 047f7038f586d2150f16c6d9ba9cfd0479f0f6ac
> > >   Author: Igor Mammedov <imammedo@redhat.com>
> > >   Date:   Fri May 11 19:24:43 2018 +0200
> > >=20
> > >     cli: add --preconfig option
> > >=20
> > > The global 'current_run_state' variable was changed to have an init=
ial
> > > value of RUN_STATE_PRECONFIG regardless of whether --preconfig is g=
iven.
> That was intentional, see 8a36283e12 commit message which has it right.
> I should fix doc comment qapi/run-state.json though as it's misleading
> (I've meant it reachable for user, while doc comment applies to
> not only to user but to qemu internals as well).
> I'll post a patch to clarify doc comment.
>=20
> Idea behind PRECONFIG runstate is to start spitting PRELAUNCH
> runstate (which is historically ended up as a dump for almost everythin=
g)
> into smaller more manageable part.

I know it was intentional, but it is still undesirable, as it results in
need for bogus transitions to INMIGRATE, as well as the problems mentione=
d
by Michael and Max. IIUC this can all be solved by introducing a further
RUN_STATE_NONE to act as the initial value, avoiding the visibilty of
RUN_STATE_PRECONFIG unless actually requested. I've sent a further patch
that does this.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
