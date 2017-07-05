Received: from eggs.gnu.org ([2001:4830:134:3::10]:47314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dSl0Q-0003g5-Gr
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dSl0M-0003LC-Gp
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:10:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dSl0M-0003KE-7R
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:10:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F8AA8E753
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 14:10:09 +0000 (UTC)
Date: Wed, 5 Jul 2017 11:10:02 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170705141002.GX12152@localhost.localdomain>
References: <1499049848-18012-1-git-send-email-peterx@redhat.com>
	<1499049848-18012-3-git-send-email-peterx@redhat.com>
	<20170703145903.GL12152@localhost.localdomain>
	<87zickr56q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87zickr56q.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] vl: move global property,
 migrate init earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Tue, Jul 04, 2017 at 10:12:45AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
>=20
> > On Mon, Jul 03, 2017 at 10:44:06AM +0800, Peter Xu wrote:
> >> Currently drive_init_func() may call migrate_get_current() while the
> >> migrate object is still not ready yet at that time. Move the migrati=
on
> >> object init earlier, along with the global properties, right after
> >> acceleration init.
> >>=20
> >> This fixes a breakage for iotest 055, which caused an assertion fail=
ure.
> >>=20
> >> Reported-by: Max Reitz <mreitz@redhat.com>
> >> Reported-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >> Fixes: 3df663 ("migration: move only_migratable to MigrationState")
> >> Signed-off-by: Peter Xu <peterx@redhat.com>
> >> ---
> >>  vl.c | 24 ++++++++++++------------
> >>  1 file changed, 12 insertions(+), 12 deletions(-)
> >>=20
> >> diff --git a/vl.c b/vl.c
> >> index 0c497a3..2ae4313 100644
> >> --- a/vl.c
> >> +++ b/vl.c
> >> @@ -4414,6 +4414,18 @@ int main(int argc, char **argv, char **envp)
> >> =20
> >>      configure_accelerator(current_machine);
> >> =20
> >> +    /*
> >> +     * Register all the global properties, including accel properti=
es,
> >> +     * machine properties, and user-specified ones.
> >> +     */
> >> +    register_global_properties(current_machine);
> >> +
> >> +    /*
> >> +     * Migration object can only be created after global properties
> >> +     * are applied correctly.
> >> +     */
> >> +    migration_object_init();
> >> +
> >
> > So, things that might introduce bugs here are:
> > 1) Unexpected qdev_prop_register_global() calls between this place an=
d
> >    the original register_global_properties() call (that would now hap=
pen
> >    in a different order).
> > 2) register_global_properties() seeing a different global property li=
st
> >    because it is being called earlier.
> >    2.1) AccelClass::global_props is statically defined and will be th=
e
> >         same here. Not a problem.
> >    2.2) MachineClass::compat_props: same as above.
> >    2.3) user-provided global properties: we need to ensure all
> >         properties in the "global" QemuOpts section are already
> >         available at this point.
>=20
> This stuff is fragile.  There are lots of dependencies, all implicit,
> and once again we reorder things ever so slightly to keep them
> satisfied.  We could certainly use a more robust solution.

Yes, and we are working on it.  Items 2.1-2.3 are already grouped in
register_global_properties() to make ordering rules explicit.  The rest
of the qdev_prop_register_global() calls need to be either replaced with
something else or moved to register_global_properties() too.

--=20
Eduardo
