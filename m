Received: from eggs.gnu.org ([209.51.188.92]:33328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gj1pI-0001aT-SX
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gj1pH-0003I6-5B
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:58:48 -0500
Received: from forwardcorp1j.cmail.yandex.net ([2a02:6b8:0:1630::190]:55210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1gj1pG-0003GY-ES
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:58:47 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20190111182534.GH2738@work-vm>
References: <20190110120120.9943-1-yury-kotov@yandex-team.ru>
	<20190110120120.9943-2-yury-kotov@yandex-team.ru>
	<20190110201418.GK2589@work-vm>
	<1917751547224726@sas1-fc7737ec834f.qloud-c.yandex.net>
	<20190111182534.GH2738@work-vm>
MIME-Version: 1.0
Date: Mon, 14 Jan 2019 15:58:40 +0300
Message-Id: <2099501547470720@sas1-fc7737ec834f.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
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

11.01.2019, 21:25, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>>  10.01.2019, 23:14, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
>>  > * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>>  >>  RAM migration has a RAMBlock validation stage (flag RAM_SAVE_FLAG_MEM_SIZE).
>>  >>  In this stage QEMU checks further information about RAMBlock:
>>  >>  1. Presence (by idstr),
>>  >>  2. Length (trying to resize, when differs),
>>  >>  3. Optional page size.
>>  >>
>>  >>  This patch adds a check for RAMBlock's offset. Currently we check it during
>>  >>  RAM pages loading - every RAM page has an offset in its header. But there is a
>>  >>  case when we don't send RAM pages (see below).
>>  >>
>>  >>  The following commits introduce a capability (ignore-external) to skip some
>>  >>  RAM blocks from migration. In such case the migration stream contains only
>>  >>  meta information about RAM blocks to validate them. So, the only way to check
>>  >>  block's offset is to send it explicitly.
>>  >>
>>  >>  Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>>  >
>>  > But why check that offsets match? THey aren't supposed to!
>>  > Offset's are entirely private to each qemu and they're allowed to be
>>  > different; the only requirement is that the length and name of each
>>  > RAMBlock matches, then all the operations we do over the migration
>>  > stream are relative to the start of the block.
>>  >
>>
>>  Yes, you are right. It seems that instead I should check block->mr->addr.
>
> I don't think that's guaranteed to be the same either; for example
> a video buffer or ROM on a PCI card gets mapped into different parts of
> the guests physical address space depending on writes into the PCI
> bars. Some RAMBlocks dont even have a mapping associated with them.
>
> If you do want to add something here, please don't increment the version
> - unless we're desperate I want to keep the version number the same so
> that backwards migration works.
>
> Dave
>

Ok, thanks. I didn't know that. What do you think about addr checking only for
ignored RAMBlocks? So, only memory backends will be checked and their addrs must
be equal IIUC. Also, in this case there is no need to increment the version.

>>  >
>>  > One example where they are validly different is where you hotplug some
>>  > RAM, so for example:
>>  >
>>  >   source qemu
>>  >       -M 4G
>>  >       hotplug PCI card
>>  >       hotplug 2G
>>  >
>>  >   destination qemu
>>  >       -M 4G
>>  >       PCI card declared on the command line
>>  >       extra 2G declared on the command line
>>  >
>>  > The offsets are different but we can migrate that case fine.
>>  >
>>  > Dave
>>  >
>>  >>  ---
>>  >>   migration/ram.c | 15 +++++++++++++--
>>  >>   1 file changed, 13 insertions(+), 2 deletions(-)
>>  >>
>>  >>  diff --git a/migration/ram.c b/migration/ram.c
>>  >>  index 7e7deec4d8..39629254e1 100644
>>  >>  --- a/migration/ram.c
>>  >>  +++ b/migration/ram.c
>>  >>  @@ -3171,6 +3171,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>>  >>           if (migrate_postcopy_ram() && block->page_size != qemu_host_page_size) {
>>  >>               qemu_put_be64(f, block->page_size);
>>  >>           }
>>  >>  + qemu_put_be64(f, block->offset);
>>  >>       }
>>  >>
>>  >>       rcu_read_unlock();
>>  >>  @@ -4031,7 +4032,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>>  >>
>>  >>       seq_iter++;
>>  >>
>>  >>  - if (version_id != 4) {
>>  >>  + if (version_id < 4) {
>>  >>           ret = -EINVAL;
>>  >>       }
>>  >>
>>  >>  @@ -4132,6 +4133,16 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>>  >>                               ret = -EINVAL;
>>  >>                           }
>>  >>                       }
>>  >>  + if (version_id >= 5) {
>>  >>  + ram_addr_t offset;
>>  >>  + offset = qemu_get_be64(f);
>>  >>  + if (block->offset != offset) {
>>  >>  + error_report("Mismatched RAM block offset %s "
>>  >>  + "%" PRId64 "!= %" PRId64,
>>  >>  + id, offset, (uint64_t)block->offset);
>>  >>  + ret = -EINVAL;
>>  >>  + }
>>  >>  + }
>>  >>                       ram_control_load_hook(f, RAM_CONTROL_BLOCK_REG,
>>  >>                                             block->idstr);
>>  >>                   } else {
>>  >>  @@ -4363,5 +4374,5 @@ static SaveVMHandlers savevm_ram_handlers = {
>>  >>   void ram_mig_init(void)
>>  >>   {
>>  >>       qemu_mutex_init(&XBZRLE.lock);
>>  >>  - register_savevm_live(NULL, "ram", 0, 4, &savevm_ram_handlers, &ram_state);
>>  >>  + register_savevm_live(NULL, "ram", 0, 5, &savevm_ram_handlers, &ram_state);
>>  >>   }
>>  >>  --
>>  >>  2.20.1
>>  > --
>>  > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>
>>  Regards,
>>  Yury
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Regards,
Yury
