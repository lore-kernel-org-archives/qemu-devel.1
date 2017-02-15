Received: from eggs.gnu.org ([2001:4830:134:3::10]:43217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ce5eI-0001ST-KJ
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ce5eE-000427-OX
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:53:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1ce5eE-00041J-G0
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:53:54 -0500
References: <1486623844-13140-1-git-send-email-liqiang6-s@360.cn>
	<1486623844-13140-2-git-send-email-liqiang6-s@360.cn>
	<cfca49ad-7eec-5b04-7cdd-e52bd32f38ea@redhat.com>
	<CAKXe6SJbYjUCphByCAtyVJiUfLk-XUSJQa3+BjbwsPFMOT5w6A@mail.gmail.com>
	<092e0dfc-7e59-ba5c-ab21-8f667635beaf@redhat.com>
	<CAKXe6S+QU+MgeVMuEv5gqkFqqDEePW7hbZByvXEfFMGtPjXZHQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6b658696-6ea2-0194-e0ad-78d04236301c@redhat.com>
Date: Wed, 15 Feb 2017 14:53:52 -0500
MIME-Version: 1.0
In-Reply-To: <CAKXe6S+QU+MgeVMuEv5gqkFqqDEePW7hbZByvXEfFMGtPjXZHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] ide: core: add cleanup function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: pbonzini@redhat.com, Qemu Developers <qemu-devel@nongnu.org>, Li Qiang <liqiang6-s@360.cn>



On 02/15/2017 04:26 AM, Li Qiang wrote:
> Hello,
> 
> 2017-02-15 7:30 GMT+08:00 John Snow <jsnow@redhat.com
> <mailto:jsnow@redhat.com>>:
> 
> 
> 
>     On 02/09/2017 08:22 PM, Li Qiang wrote:
>     > Hello John,
>     >
>     > 2017-02-10 3:42 GMT+08:00 John Snow <jsnow@redhat.com <mailto:jsnow@redhat.com>
>     > <mailto:jsnow@redhat.com <mailto:jsnow@redhat.com>>>:
>     >
>     >
>     >
>     >     On 02/09/2017 02:04 AM, Li Qiang wrote:
>     >     > As the pci ahci can be hotplug and unplug, in the ahci unrealize
>     >     > function it should free all the resource once allocated in the
>     >     > realized function. This patch adds two cleanup function.
>     >     >
>     >     > Signed-off-by: Li Qiang <liqiang6-s@360.cn
>     <mailto:liqiang6-s@360.cn> <mailto:liqiang6-s@360.cn
>     <mailto:liqiang6-s@360.cn>>>
>     >     > ---
>     >     >  hw/ide/core.c             | 21 +++++++++++++++++++++
>     >     >  include/hw/ide/internal.h |  2 ++
>     >     >  2 files changed, 23 insertions(+)
>     >     >
>     >     > diff --git a/hw/ide/core.c b/hw/ide/core.c
>     >     > index 43709e5..8fe5896 100644
>     >     > --- a/hw/ide/core.c
>     >     > +++ b/hw/ide/core.c
>     >     > @@ -2586,6 +2586,13 @@ void ide_register_restart_cb(IDEBus *bus)
>     >     >      }
>     >     >  }
>     >     >
>     >     > +void ide_unregister_restart_cb(IDEBus *bus)
>     >     > +{
>     >     > +    if (bus->dma->ops->restart_dma) {
>     >     > +        qemu_del_vm_change_state_handler(bus->vmstate);
>     >     > +    }
>     >     > +}
>     >     > +
>     >
>     >     Doesn't this conflict with qdev.c's idebus_unrealize call?
>     >
>     >
>     > As far as I can see, No conflict. Let's get a confirmation.
>     >
>     > Hello Paolo,
>     >
>     > Does this patch have any conflict/affect with the qdev?
>     >
>     > Thanks.
>     >
> 
>     They're both deleting the same VMstate handler, so as far as I can see
>     this is a redundant call.
> 
> 
> IIUC, the idebus_unrealize in qdev.c is for qdev model.
> But the added is for qom model.
> For example, if you use 'device_add ahci,id=ahci'/'device_del ahci' in
> the qmp.
> 
> The qemu will call 'pci_ich9_ahci_realize'/'pci_ich9_uninit'.
> 
> 
>  

I'm sorry, I still don't understand. Do you have some reproducer or case
where I can verify that this leaks?

It doesn't look as if you can hot-add or hot-remove an AHCI device right
now anyway, have you tested this?

Further, if the two calls AREN'T in conflict, I'd rather find some
cleanup mechanism that handles all the unrealize/uninit cases together
instead of having separate cleanup pathways.

--js
