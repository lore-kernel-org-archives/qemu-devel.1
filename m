Received: from eggs.gnu.org ([2001:4830:134:3::10]:42093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dQDiE-000650-9W
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:12:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dQDiB-0001ba-4H
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:12:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55779)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dQDiA-0001bE-R8
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:12:55 -0400
Date: Wed, 28 Jun 2017 16:12:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170628161247.168c4acb@nial.brq.redhat.com>
In-Reply-To: <f6a0bc2b-bf91-4c49-aa41-7816da70252c@ilande.co.uk>
References: <20170621113600.GA3928@thinpad.lan.raisama.net>
	<8135ff45-0341-1fd4-ada9-4527c6b61e5a@ilande.co.uk>
	<20170621132317.GD3928@thinpad.lan.raisama.net>
	<7b431646-019e-dce2-6345-bdbaba7ce821@ilande.co.uk>
	<20170623115051.GE20956@localhost.localdomain>
	<a5f86c32-c89b-98ff-dbdb-7457a2074f1a@redhat.com>
	<20170623161043.GA10204@localhost.localdomain>
	<60e57713-c9ce-2bf4-db6e-23686fcc955b@redhat.com>
	<20170623185000.GA3038@localhost.localdomain>
	<120b9dac-982b-1e3b-662f-e60110b3d730@ilande.co.uk>
	<20170627004930.GI12152@localhost.localdomain>
	<f6a0bc2b-bf91-4c49-aa41-7816da70252c@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv6 3/5] fw_cfg: move assert() and linking of
 fw_cfg device to the machine into instance_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <ehabkost@redhat.com>, peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, Laszlo Ersek <lersek@redhat.com>

On Wed, 28 Jun 2017 08:09:35 +0100
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:

> On 27/06/17 01:49, Eduardo Habkost wrote:
> 
> > On Sun, Jun 25, 2017 at 07:58:04PM +0100, Mark Cave-Ayland wrote:  
> >> On 23/06/17 19:50, Eduardo Habkost wrote:
> >>  
> >>>> Really, please go back to the earlier discussion around fw_cfg_init1()
> >>>> and you'll see my original point (which matches what you just voiced).  
> >>>
> >>> Yep.  I was just not sure validation on realize was necessary or
> >>> convenient.  It looks like we agree it is just convenient.
> >>>
> >>>  
> >>>>  
> >>>>> All that said, I don't have a strong argument against doing it on
> >>>>> realize, except my gut feeling that this is not how qdev was
> >>>>> designed[1].  If doing it on realize is the simplest way to do it, I
> >>>>> won't be the one complaining.
> >>>>>
> >>>>> [1] I believe the original intent was to make every single device
> >>>>>     user-creatable and define boards in a declarative way in config
> >>>>>     files.  We are very far from that goal.  
> >>>>
> >>>> I'm fine either way, I just wanted to accommodate Mark's preference,
> >>>> because he seemed to strongly dislike having to call any helper
> >>>> functions from board code, beyond initing and realizing the device.
> >>>>
> >>>> This is my recollection of the earlier discussion anyway.  
> >>>
> >>> I think we are in agreement, then.  If there are no objections from
> >>> others against doing object_property_add_child() on realize, I'm also OK
> >>> with that.  
> >>
> >> Just to clarify here that my objection wasn't so much about calling
> >> helper functions from board code, it was that as the current patch
> >> exposes the MemoryRegions in TYPE_FW_CFG_IO and TYPE_FW_CFG_MEM then as
> >> per my example where the machine link is omitted then the check becomes
> >> useless.  
> > 
> > I don't understand this part.  When and why would the check become
> > useless?  
> 
> Well because when using the standard QEMU pattern of
> qdev_create()...qdev_init_nofail() it is possible to realize the device
> and wire up its MemoryRegions manually as I have done with the sun4u
> (i.e. it will respond to accesses) multiple times without calling the
> helper function and triggering the check. The ingenious part here is
> that only the developers who aren't aware that they have to manually
> call the helper function will be the ones who get caught out trying to
> instantiate the device multiple times ;)
> 
> I'm also aware that with QOM we've got 2 conflicting ideas with fw_cfg:
> on the one hand we're saying that QOM hierarchy should at some level
> represent the topology of the machine, i.e. for sun4u the fw_cfg device
> should appear under the ebus device. whereas at the moment we assume a
> fixed path of FW_CFG_PATH.
> 
> Based upon this I been thinking along the following lines:
> 
> 1) Alter fw_cfg_find() to use object_resolve_path_type("", TYPE_FW_CFG,
> NULL)
I'd make use of the 3rd argument &ambiguous and assert on it
 
> This solves the issue of allowing the QOM tree to best represent the
> device topology as it will allow fw_cfg_find() to locate the fw_cfg
> device regardless of its location, and hence it can be placed as
> appropriate for each machine.
looks reasonable, that's what we were doing in a bunch of other cases


> 2) Add a check at the top of fw_cfg_common_realize() along the lines of:
> 
> if (object_unattached(OBJECT(dev)) {
>     error_setg(errp, "%s device must be explicitly added as a child "
>                object before realize", TYPE_FW_CFG);
>     return;
> }
that would be never trigger as ancestor's DEVICE.realize() always sets
parent if it wasn't set manually before child's realize is called.

in other words it's guarantied that device has parent by the time
realize() is run by device_set_realized()


> This makes it obvious to the developer that they MUST wire up the fw_cfg
> device to the machine before realize, and then if more than one device
> is instantiated we can still trigger the existing error from my v7 branch:
> 
> if (!object_resolve_path_type("", TYPE_FW_CFG, NULL)) {
>     error_setg(errp, "at most one %s device is permitted", TYPE_FW_CFG);
>     return;
> }
reuse fw_cfg_find() here?

> I prefer this method because it is impossible for a developer to
> accidentally realize the fw_cfg device without attaching it to the
> machine first (i.e. fw_cfg_find() will always succeed if this is the
> case if altered as per 1) above) and it can only be realized once. And
> following the POLA the device can be wired up using
> object_property_add_child() as per the numerous existing examples
> throughout the QEMU codebase.
> 
> Now the minor issue with 2) is that I can't find an easy way to
> determine if the device is unattached at realize time. I've tried
> something like this:
> 
> if (!object_resolve_path_type("/machine/unattached",
>     TYPE_FW_CFG, NULL)) {
>    ...
>    ...
> }
> 
> However that doesn't work because as the rules differ between partial
> and absolute path resolution, we end up resolving the container itself
> as opposed to iterating down through the QOM tree. Is there an existing
> solution for this or would I need to come up with something that
> iterates over the container children to search for a TYPE_FW_CFG device
> myself?
> 
> 
> ATB,
> 
> Mark.
> 
> 
