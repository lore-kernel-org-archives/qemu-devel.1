Received: from eggs.gnu.org ([2001:4830:134:3::10]:43384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gCNYx-0007pl-A9
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gCNYs-0005nZ-9S
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:30:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gCNYq-0005E3-Cb
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:30:54 -0400
Date: Tue, 16 Oct 2018 12:30:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181016113044.GE2426@work-vm>
References: <20180727123112.13707-1-dgilbert@redhat.com>
	<d09b7607-a23b-7c05-9faf-7ec0000684af@ilande.co.uk>
	<20180727134453.GB2498@work-vm>
	<c8608e2e-35da-d095-193a-626d0d47c036@ilande.co.uk>
	<20180727151412.GC2498@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727151412.GC2498@work-vm>
Subject: Re: [Qemu-devel] [PATCH] macio/pmu: Fix missing vmsd terminator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, agraf@suse.de, david@gibson.dropbear.id.au


I noticed this hadn't got merged - who wants it?

Dave

* Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> * Mark Cave-Ayland (mark.cave-ayland@ilande.co.uk) wrote:
> > On 27/07/18 14:44, Dr. David Alan Gilbert wrote:
> > 
> > > * Mark Cave-Ayland (mark.cave-ayland@ilande.co.uk) wrote:
> > > > On 27/07/18 13:31, Dr. David Alan Gilbert (git) wrote:
> > > > 
> > > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > > 
> > > > > Fix missing terminator in VMStateDescription
> > > > > 
> > > > > Fixes: d811d61fbc6ca5f2be2185fd7cfa916e7ba613ce
> > > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > > ---
> > > > >    hw/misc/macio/pmu.c | 1 +
> > > > >    1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
> > > > > index e246b0fd41..27dfaf8a74 100644
> > > > > --- a/hw/misc/macio/pmu.c
> > > > > +++ b/hw/misc/macio/pmu.c
> > > > > @@ -686,6 +686,7 @@ static const VMStateDescription vmstate_pmu_adb = {
> > > > >            VMSTATE_TIMER_PTR(adb_poll_timer, PMUState),
> > > > >            VMSTATE_UINT8(adb_reply_size, PMUState),
> > > > >            VMSTATE_BUFFER(adb_reply, PMUState),
> > > > > +        VMSTATE_END_OF_LIST()
> > > > >        }
> > > > >    };
> > > > 
> > > > Gah, yes indeed it certainly looks like I missed this whilst working on the
> > > > PMU code :(
> > > > 
> > > > Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > > 
> > > > Just out of interest does a savevm/loadvm migration still succeed once this
> > > > has been added?
> > > 
> > > Have you got a suggested command line to test it with?
> > 
> > I'm effectively AFK until tomorrow now, but just quickly:
> > 
> > $ ./qemu-system-ppc -M mac99,via=pmu
> > 
> > Note that PMU support is new for 3.0 so there shouldn't be any backward
> > compatibility issue here.
> 
> [root@virtlab414 try-64]# ./ppc-softmmu/qemu-system-ppc -M mac99,via=pmu -nographic /home/vms/dummy1.qcow2 
> QEMU 2.12.50 monitor - type 'help' for more information
> (qemu) ss>> et_property: NULL phandle
> 
> >> =============================================================
> >> OpenBIOS 1.1 [Jun 18 2018 18:20]
> >> Configuration device id QEMU version 1 machine id 1
> >> CPUs: 1
> >> Memory: 128M
> >> UUID: 00000000-0000-0000-0000-000000000000
> >> CPU type PowerPC,G4
> milliseconds isn't unique.
> saWelcome to OpenBIOS v1.1 built on Jun 18 2018 18:20
> Trying hd:,\\:tbxi...
> savTrying hd:,\ppc\bootinfo.txt...
> Trying hd:,%BOOT...
> saveNo valid state has been set by load or init-program
> 
> 
> (qemu) 
>   ok
> 0 >   ok
> 0 > (qemu) 
> (qemu) savevm "frob"
> (qemu) loadvm "frob"
> (qemu) 
>   ok
> 0 > 2 2 + . 4  ok
> 
> Looks OK to me.
> 
> Dave
> 
> > 
> > ATB,
> > 
> > Mark.
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
