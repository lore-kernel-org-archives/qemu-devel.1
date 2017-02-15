Received: from eggs.gnu.org ([2001:4830:134:3::10]:46779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cdvrL-0002se-09
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 04:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cdvrJ-0006ea-6C
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 04:26:46 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:35325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cdvrJ-0006e5-05
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 04:26:45 -0500
Received: by mail-io0-x244.google.com with SMTP id m98so11711364iod.2
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 01:26:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <092e0dfc-7e59-ba5c-ab21-8f667635beaf@redhat.com>
References: <1486623844-13140-1-git-send-email-liqiang6-s@360.cn>
	<1486623844-13140-2-git-send-email-liqiang6-s@360.cn>
	<cfca49ad-7eec-5b04-7cdd-e52bd32f38ea@redhat.com>
	<CAKXe6SJbYjUCphByCAtyVJiUfLk-XUSJQa3+BjbwsPFMOT5w6A@mail.gmail.com>
	<092e0dfc-7e59-ba5c-ab21-8f667635beaf@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 15 Feb 2017 17:26:43 +0800
Message-ID: <CAKXe6S+QU+MgeVMuEv5gqkFqqDEePW7hbZByvXEfFMGtPjXZHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/2] ide: core: add cleanup function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: pbonzini@redhat.com, Qemu Developers <qemu-devel@nongnu.org>, Li Qiang <liqiang6-s@360.cn>

Hello,

2017-02-15 7:30 GMT+08:00 John Snow <jsnow@redhat.com>:

>
>
> On 02/09/2017 08:22 PM, Li Qiang wrote:
> > Hello John,
> >
> > 2017-02-10 3:42 GMT+08:00 John Snow <jsnow@redhat.com
> > <mailto:jsnow@redhat.com>>:
> >
> >
> >
> >     On 02/09/2017 02:04 AM, Li Qiang wrote:
> >     > As the pci ahci can be hotplug and unplug, in the ahci unrealize
> >     > function it should free all the resource once allocated in the
> >     > realized function. This patch adds two cleanup function.
> >     >
> >     > Signed-off-by: Li Qiang <liqiang6-s@360.cn <mailto:
> liqiang6-s@360.cn>>
> >     > ---
> >     >  hw/ide/core.c             | 21 +++++++++++++++++++++
> >     >  include/hw/ide/internal.h |  2 ++
> >     >  2 files changed, 23 insertions(+)
> >     >
> >     > diff --git a/hw/ide/core.c b/hw/ide/core.c
> >     > index 43709e5..8fe5896 100644
> >     > --- a/hw/ide/core.c
> >     > +++ b/hw/ide/core.c
> >     > @@ -2586,6 +2586,13 @@ void ide_register_restart_cb(IDEBus *bus)
> >     >      }
> >     >  }
> >     >
> >     > +void ide_unregister_restart_cb(IDEBus *bus)
> >     > +{
> >     > +    if (bus->dma->ops->restart_dma) {
> >     > +        qemu_del_vm_change_state_handler(bus->vmstate);
> >     > +    }
> >     > +}
> >     > +
> >
> >     Doesn't this conflict with qdev.c's idebus_unrealize call?
> >
> >
> > As far as I can see, No conflict. Let's get a confirmation.
> >
> > Hello Paolo,
> >
> > Does this patch have any conflict/affect with the qdev?
> >
> > Thanks.
> >
>
> They're both deleting the same VMstate handler, so as far as I can see
> this is a redundant call.
>
>
IIUC, the idebus_unrealize in qdev.c is for qdev model.
But the added is for qom model.
For example, if you use 'device_add ahci,id=ahci'/'device_del ahci' in the
qmp.

The qemu will call 'pci_ich9_ahci_realize'/'pci_ich9_uninit'.





> >
> >
> >     >  static IDEDMA ide_dma_nop = {
> >     >      .ops = &ide_dma_nop_ops,
> >     >      .aiocb = NULL,
> >     > @@ -2603,6 +2610,20 @@ void ide_init2(IDEBus *bus, qemu_irq irq)
> >     >      bus->dma = &ide_dma_nop;
> >     >  }
> >     >
> >     > +void ide_exit(IDEBus *bus)
> >     > +{
> >     > +    int i;
> >     > +
> >     > +    for (i = 0; i < 2; i++) {
> >     > +        IDEState *s = &bus->ifs[i];
> >     > +
> >     > +        timer_del(s->sector_write_timer);
> >     > +        timer_free(s->sector_write_timer);
> >     > +        qemu_vfree(s->smart_selftest_data);
> >     > +        qemu_vfree(s->io_buffer);
> >     > +    }
> >     > +}
> >     > +
> >     >  static const MemoryRegionPortio ide_portio_list[] = {
> >     >      { 0, 8, 1, .read = ide_ioport_read, .write = ide_ioport_write
> },
> >     >      { 0, 1, 2, .read = ide_data_readw, .write = ide_data_writew },
> >     > diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
> >     > index 88dc118..09b0404 100644
> >     > --- a/include/hw/ide/internal.h
> >     > +++ b/include/hw/ide/internal.h
> >     > @@ -607,8 +607,10 @@ int ide_init_drive(IDEState *s, BlockBackend
> >     *blk, IDEDriveKind kind,
> >     >                     uint32_t cylinders, uint32_t heads, uint32_t
> secs,
> >     >                     int chs_trans);
> >     >  void ide_init2(IDEBus *bus, qemu_irq irq);
> >     > +void ide_exit(IDEBus *bus);
> >     >  void ide_init_ioport(IDEBus *bus, ISADevice *isa, int iobase, int
> >     iobase2);
> >     >  void ide_register_restart_cb(IDEBus *bus);
> >     > +void ide_unregister_restart_cb(IDEBus *bus);
> >     >
> >     >  void ide_exec_cmd(IDEBus *bus, uint32_t val);
> >     >
> >     >
> >
>
