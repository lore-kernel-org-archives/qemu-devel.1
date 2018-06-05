Received: from eggs.gnu.org ([2001:4830:134:3::10]:43669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQ7J8-0001ug-Ak
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 04:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQ7J5-0007I7-3x
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 04:27:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58720 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fQ7J4-0007H6-VY
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 04:27:07 -0400
Date: Tue, 5 Jun 2018 10:27:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180605102703.6fdee3c5@redhat.com>
In-Reply-To: <20180605010413.GF3184@localhost.localdomain>
References: <1528143278-247932-1-git-send-email-imammedo@redhat.com>
	<20180605010413.GF3184@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vl.c: make default main_loop_wait()
 timeout independed of slirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, ldoktor@redhat.com, jan.kiszka@siemens.com, mreitz@redhat.com, mprivozn@redhat.com, pbonzini@redhat.com

On Mon, 4 Jun 2018 22:04:13 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Jun 04, 2018 at 10:14:38PM +0200, Igor Mammedov wrote:
> > Since commit (047f7038f58 cli: add --preconfig option) QEMU is
> > stuck with indefinite timeout in os_host_main_loop_wait()
> > at RUN_STATE_PRECONFIG even if --preconfig option wasn't used
> > when it's started with -nodefaults CLI option like this:
> >=20
> >   ./s390x-softmmu/qemu-system-s390x -nodefaults
> >=20
> > It's caused by the fact that slirp_pollfds_fill() bails out early
> > and slirp_update_timeout() won't be called to update timeout
> > to a reasonable value (1 sec) so timeout would be left with
> > infinite value (0xFFFFFFFF).
> >=20
> > Default infinite timeout though doen't make sense and reducing
> > it to 1 second as in slirp_update_timeout() won't affect host. =20
>=20
> I don't get this part.  Why default infinite timeout doesn't make
> sense?  Why would a 1 second timeout make sense?
I've meant that there is no reason for infinite timeuot,
and 1sec is good as any other finite one.
Hence we can unify timeout with/without -nodefaults, by moving 1sec
constant from slirp to main_loop_wait() and simplify code a bit.
=20
>=20
> > Fix issue by simplifying default timeout to the same 1sec as it
> > is in slirp_update_timeout() and cleanup the later. It makes
> > default timeout the same regardless of slirp_pollfds_fill()
> > exited early or not (i.e. -nodefaults won't have any effect on
> > main_loop_wait() anymore, which would provide more consistent
> > behavior between both variants of startup).
> >=20
> > Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > PS:
> > it doesn't fix issue reported by Max where
> >   "echo foo | $QEMU"
> > is also broken due to commit 047f7038f58, but there is antoher fix
> > on the list to fix that (either Michal's or Daniel's). =20
> [...]
>=20
