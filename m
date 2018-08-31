Received: from eggs.gnu.org ([208.118.235.92]:37282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fvhW6-0004kf-FT
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fvhKp-0002l0-Dv
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:11:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58420 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1fvhKp-0002kd-6Y
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:11:27 -0400
Date: Fri, 31 Aug 2018 13:11:21 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180831111121.n7zafn6peiwe6ojn@kamzik.brq.redhat.com>
References: <CABgNM92-PHWg3X41tCVfErmV9-Hnu5GYpz_pa9-iXfbScFUCZg@mail.gmail.com>
	<CD29DCF7-6537-406F-A127-6A2FFDDAAD79@caviumnetworks.com>
	<87k1ohxik4.fsf@trasno.org>
	<3BE04368-1463-419A-8A40-EFC8015049B9@caviumnetworks.com>
	<20180828172739.GA10175@work-vm>
	<19EED7A8-CE42-4C46-9CB3-01DEB63FCE79@caviumnetworks.com>
	<20180829131653.gk4yhjdi2pk5bdcd@kamzik.brq.redhat.com>
	<DC466FE6-98B4-485B-BE4D-C4E228B36107@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC466FE6-98B4-485B-BE4D-C4E228B36107@caviumnetworks.com>
Subject: Re: [Qemu-devel] [Query] Live Migration between machines with
 different processor ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jaggi, Manish" <Manish.Jaggi@cavium.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Juan Quintela <quintela@redhat.com>, "peter.maydell@linaro.org qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Auger Eric <eric.auger@redhat.com>


Manish,

Your mail reader doesn't appear to be providing any quoting, so I'm not
sure I found all your replies. I've tried to fix up the quoting in order
to reply here, but you should look into fixing your reader.

On Fri, Aug 31, 2018 at 09:52:12AM +0000, Jaggi, Manish wrote:
> On bleh-bleh, Andrew Jones wrote:
> > On bleh-bleh, Jaggi, Manish wrote:
> > > - So in cpu_post_load (Machine B) qemu can lookup whitelist and replace the MIDR with the one at Machine B.
> > > Sounds good?
> > > 
> > It shouldn't be necessary. With '-cpu host' QEMU should probably just read
> > all the ID registers from the host first, updating the guest's copy to
> > match the destination host's registers (we're using '-cpu host', the
> > registers should match the host - including MIDR.) If a user chooses to
> > migrate a guest that is using '-cpu host', then they need to know what
> > they are doing. If a whitelist of close-enough processors is possible to
> > create, then that whitelist should be managed and used at a higher layer
> > in the virt stack, not down in QEMU.
> 
> How would qemu know to that it has to patch? Could not understand your point here.
> IIUC qemu needs some parameter for this

QEMU would unconditionally update the guest's view of the invariant
registers after migration, when '-cpu host' is used. There's no need
for a parameter, as the update is unconditional.

> 
> > For example, openstack can determine
> > destination candidates using whatever policy it wants, including a close-
> > enough processor whitelist.
> > 
> > So, I propose blindly updating all invariant registers when migrating
> > a '-cpu host' guest and leaving it to the user to do these migrations
> > at their own risk
> > 
> yes good point updating all invariant is better, for the case where user is aware that host and destination have same cpu arch.
> I can prepare a RFC patch but cpu_post_load will need some flag to replace these values.,

I'm not sure what you mean by a flag, but I'll review the RFC when you
post it.

> > 
> > (when migrating to a truly identical host, the blind
> > update will not change anything. So it would be no worse than what we
> > do today.) One side note is that we're starting to give QEMU control
> > over what optional processor features are available to the guest, e.g.
> > SVE. So before blindly updating all ID registers we'd want to inform
> > KVM of the guest configuration in order for KVM to return appropriate
> > ID register values.
> > 
> Not sure how to handle this.

I think the sequence should look something like this:

  1) Guest running on Host A with processor a
  2) Stop guest and save its state for migration
  3) Migrate guest to Host B with processor b (b is "close enough" to a)
  4) Restore guest state after migration
     If guest is running with '-cpu host'
       4.a) Inform KVM of any configuration that impacts invariant registers
       4.b) Update the guest's view of all invariant registers to match the
            host
     EndIf
  5) Run guest

4.a and 4.b require new code both in QEMU and KVM. 4.a may require a new
KVM API, unless the existing API can be leveraged.

The definition of "close enough" is left to the users and/or higher layers
of the Virt stack.

Thanks,
drew
