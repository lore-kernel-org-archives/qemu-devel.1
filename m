Received: from eggs.gnu.org ([209.51.188.92]:55236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1ghzpc-0004Cb-Vd
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1ghzpb-0006Sm-PP
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:38:52 -0500
Received: from forwardcorp1o.cmail.yandex.net ([2a02:6b8:0:1a72::290]:50610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1ghzpa-0006R7-Vw
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:38:51 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20190110201418.GK2589@work-vm>
References: <20190110120120.9943-1-yury-kotov@yandex-team.ru>
	<20190110120120.9943-2-yury-kotov@yandex-team.ru>
	<20190110201418.GK2589@work-vm>
MIME-Version: 1.0
Date: Fri, 11 Jan 2019 19:38:46 +0300
Message-Id: <1917751547224726@sas1-fc7737ec834f.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "wrfsh@yandex-team.ru" <wrfsh@yandex-team.ru>

10.01.2019, 23:14, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A0RAM migration has a RAMBlock validation stage (flag RAM_SAVE_FLA=
G_MEM_SIZE).
>> =C2=A0In this stage QEMU checks further information about RAMBlock:
>> =C2=A01. Presence (by idstr),
>> =C2=A02. Length (trying to resize, when differs),
>> =C2=A03. Optional page size.
>>
>> =C2=A0This patch adds a check for RAMBlock's offset. Currently we chec=
k it during
>> =C2=A0RAM pages loading - every RAM page has an offset in its header. =
But there is a
>> =C2=A0case when we don't send RAM pages (see below).
>>
>> =C2=A0The following commits introduce a capability (ignore-external) t=
o skip some
>> =C2=A0RAM blocks from migration. In such case the migration stream con=
tains only
>> =C2=A0meta information about RAM blocks to validate them. So, the only=
 way to check
>> =C2=A0block's offset is to send it explicitly.
>>
>> =C2=A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>
> But why check that offsets match? THey aren't supposed to!
> Offset's are entirely private to each qemu and they're allowed to be
> different; the only requirement is that the length and name of each
> RAMBlock matches, then all the operations we do over the migration
> stream are relative to the start of the block.
>

Yes, you are right. It seems that instead I should check block->mr->addr.

>
> One example where they are validly different is where you hotplug some
> RAM, so for example:
>
> =C2=A0=C2=A0source qemu
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-M 4G
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hotplug PCI card
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hotplug 2G
>
> =C2=A0=C2=A0destination qemu
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-M 4G
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PCI card declared on the command li=
ne
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0extra 2G declared on the command li=
ne
>
> The offsets are different but we can migrate that case fine.
>
> Dave
>
>> =C2=A0---
>> =C2=A0=C2=A0migration/ram.c | 15 +++++++++++++--
>> =C2=A0=C2=A01 file changed, 13 insertions(+), 2 deletions(-)
>>
>> =C2=A0diff --git a/migration/ram.c b/migration/ram.c
>> =C2=A0index 7e7deec4d8..39629254e1 100644
>> =C2=A0--- a/migration/ram.c
>> =C2=A0+++ b/migration/ram.c
>> =C2=A0@@ -3171,6 +3171,7 @@ static int ram_save_setup(QEMUFile *f, voi=
d *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (migrat=
e_postcopy_ram() && block->page_size !=3D qemu_host_page_size) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0qemu_put_be64(f, block->page_size);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0+ qemu_put_be64(f, block->offset);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rcu_read_unlock();
>> =C2=A0@@ -4031,7 +4032,7 @@ static int ram_load(QEMUFile *f, void *opa=
que, int version_id)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0seq_iter++;
>>
>> =C2=A0- if (version_id !=3D 4) {
>> =C2=A0+ if (version_id < 4) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D -E=
INVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0@@ -4132,6 +4133,16 @@ static int ram_load(QEMUFile *f, void *op=
aque, int version_id)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0+ if (version_id >=3D 5) {
>> =C2=A0+ ram_addr_t offset;
>> =C2=A0+ offset =3D qemu_get_be64(f);
>> =C2=A0+ if (block->offset !=3D offset) {
>> =C2=A0+ error_report("Mismatched RAM block offset %s "
>> =C2=A0+ "%" PRId64 "!=3D %" PRId64,
>> =C2=A0+ id, offset, (uint64_t)block->offset);
>> =C2=A0+ ret =3D -EINVAL;
>> =C2=A0+ }
>> =C2=A0+ }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ram_control_l=
oad_hook(f, RAM_CONTROL_BLOCK_REG,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0block->idstr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
>> =C2=A0@@ -4363,5 +4374,5 @@ static SaveVMHandlers savevm_ram_handlers =
=3D {
>> =C2=A0=C2=A0void ram_mig_init(void)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_mutex_init(&XBZRLE.lock);
>> =C2=A0- register_savevm_live(NULL, "ram", 0, 4, &savevm_ram_handlers, =
&ram_state);
>> =C2=A0+ register_savevm_live(NULL, "ram", 0, 5, &savevm_ram_handlers, =
&ram_state);
>> =C2=A0=C2=A0}
>> =C2=A0--
>> =C2=A02.20.1
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Regards,
Yury
