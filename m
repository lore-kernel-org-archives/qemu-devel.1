Received: from eggs.gnu.org ([209.51.188.92]:49908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gi1V1-0007lX-Au
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gi1V0-0007Ji-CD
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:25:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gi1V0-0007Iw-3r
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:25:42 -0500
Date: Fri, 11 Jan 2019 18:25:35 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190111182534.GH2738@work-vm>
References: <20190110120120.9943-1-yury-kotov@yandex-team.ru>
	<20190110120120.9943-2-yury-kotov@yandex-team.ru>
	<20190110201418.GK2589@work-vm>
	<1917751547224726@sas1-fc7737ec834f.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1917751547224726@sas1-fc7737ec834f.qloud-c.yandex.net>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] migration: add RAMBlock's offset
 validation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> 10.01.2019, 23:14, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> > * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> >> =A0RAM migration has a RAMBlock validation stage (flag RAM_SAVE_FLAG=
_MEM_SIZE).
> >> =A0In this stage QEMU checks further information about RAMBlock:
> >> =A01. Presence (by idstr),
> >> =A02. Length (trying to resize, when differs),
> >> =A03. Optional page size.
> >>
> >> =A0This patch adds a check for RAMBlock's offset. Currently we check=
 it during
> >> =A0RAM pages loading - every RAM page has an offset in its header. B=
ut there is a
> >> =A0case when we don't send RAM pages (see below).
> >>
> >> =A0The following commits introduce a capability (ignore-external) to=
 skip some
> >> =A0RAM blocks from migration. In such case the migration stream cont=
ains only
> >> =A0meta information about RAM blocks to validate them. So, the only =
way to check
> >> =A0block's offset is to send it explicitly.
> >>
> >> =A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> >
> > But why check that offsets match? THey aren't supposed to!
> > Offset's are entirely private to each qemu and they're allowed to be
> > different; the only requirement is that the length and name of each
> > RAMBlock matches, then all the operations we do over the migration
> > stream are relative to the start of the block.
> >
>=20
> Yes, you are right. It seems that instead I should check block->mr->add=
r.

I don't think that's guaranteed to be the same either;  for example
a video buffer or ROM on a  PCI card gets mapped into different parts of
the guests physical address space depending on writes into the PCI
bars.  Some RAMBlocks dont even have a mapping associated with them.

If you do want to add something here, please don't increment the version
- unless we're desperate I want to keep the version number the same so
that backwards migration works.

Dave

> >
> > One example where they are validly different is where you hotplug som=
e
> > RAM, so for example:
> >
> > =A0=A0source qemu
> > =A0=A0=A0=A0=A0=A0-M 4G
> > =A0=A0=A0=A0=A0=A0hotplug PCI card
> > =A0=A0=A0=A0=A0=A0hotplug 2G
> >
> > =A0=A0destination qemu
> > =A0=A0=A0=A0=A0=A0-M 4G
> > =A0=A0=A0=A0=A0=A0PCI card declared on the command line
> > =A0=A0=A0=A0=A0=A0extra 2G declared on the command line
> >
> > The offsets are different but we can migrate that case fine.
> >
> > Dave
> >
> >> =A0---
> >> =A0=A0migration/ram.c | 15 +++++++++++++--
> >> =A0=A01 file changed, 13 insertions(+), 2 deletions(-)
> >>
> >> =A0diff --git a/migration/ram.c b/migration/ram.c
> >> =A0index 7e7deec4d8..39629254e1 100644
> >> =A0--- a/migration/ram.c
> >> =A0+++ b/migration/ram.c
> >> =A0@@ -3171,6 +3171,7 @@ static int ram_save_setup(QEMUFile *f, void=
 *opaque)
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (migrate_postcopy_ram() && block->p=
age_size !=3D qemu_host_page_size) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0qemu_put_be64(f, block->pa=
ge_size);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> >> =A0+ qemu_put_be64(f, block->offset);
> >> =A0=A0=A0=A0=A0=A0}
> >>
> >> =A0=A0=A0=A0=A0=A0rcu_read_unlock();
> >> =A0@@ -4031,7 +4032,7 @@ static int ram_load(QEMUFile *f, void *opaq=
ue, int version_id)
> >>
> >> =A0=A0=A0=A0=A0=A0seq_iter++;
> >>
> >> =A0- if (version_id !=3D 4) {
> >> =A0+ if (version_id < 4) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ret =3D -EINVAL;
> >> =A0=A0=A0=A0=A0=A0}
> >>
> >> =A0@@ -4132,6 +4133,16 @@ static int ram_load(QEMUFile *f, void *opa=
que, int version_id)
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0ret =3D -EINVAL;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0}
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> >> =A0+ if (version_id >=3D 5) {
> >> =A0+ ram_addr_t offset;
> >> =A0+ offset =3D qemu_get_be64(f);
> >> =A0+ if (block->offset !=3D offset) {
> >> =A0+ error_report("Mismatched RAM block offset %s "
> >> =A0+ "%" PRId64 "!=3D %" PRId64,
> >> =A0+ id, offset, (uint64_t)block->offset);
> >> =A0+ ret =3D -EINVAL;
> >> =A0+ }
> >> =A0+ }
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ra=
m_control_load_hook(f, RAM_CONTROL_BLOCK_REG,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0block->ids=
tr);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
> >> =A0@@ -4363,5 +4374,5 @@ static SaveVMHandlers savevm_ram_handlers =3D=
 {
> >> =A0=A0void ram_mig_init(void)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0qemu_mutex_init(&XBZRLE.lock);
> >> =A0- register_savevm_live(NULL, "ram", 0, 4, &savevm_ram_handlers, &=
ram_state);
> >> =A0+ register_savevm_live(NULL, "ram", 0, 5, &savevm_ram_handlers, &=
ram_state);
> >> =A0=A0}
> >> =A0--
> >> =A02.20.1
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
> Regards,
> Yury
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
