Received: from eggs.gnu.org ([2001:4830:134:3::10]:60831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPehK-000562-0m
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 20:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPehG-0000Ko-VZ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 20:49:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dPehG-0000K7-NB
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 20:49:38 -0400
From: "Eduardo Habkost" <ehabkost@redhat.com>
Date: Mon, 26 Jun 2017 21:49:30 -0300
Message-ID: <20170627004930.GI12152@localhost.localdomain>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <120b9dac-982b-1e3b-662f-e60110b3d730@ilande.co.uk>
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
Cc: Laszlo Ersek <lersek@redhat.com>, peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, imammedo@redhat.com, pbonzini@redhat.com

On Sun, Jun 25, 2017 at 07:58:04PM +0100, Mark Cave-Ayland wrote:
> On 23/06/17 19:50, Eduardo Habkost wrote:
> 
> >> Really, please go back to the earlier discussion around fw_cfg_init1()
> >> and you'll see my original point (which matches what you just voiced).
> > 
> > Yep.  I was just not sure validation on realize was necessary or
> > convenient.  It looks like we agree it is just convenient.
> > 
> > 
> >>
> >>> All that said, I don't have a strong argument against doing it on
> >>> realize, except my gut feeling that this is not how qdev was
> >>> designed[1].  If doing it on realize is the simplest way to do it, I
> >>> won't be the one complaining.
> >>>
> >>> [1] I believe the original intent was to make every single device
> >>>     user-creatable and define boards in a declarative way in config
> >>>     files.  We are very far from that goal.
> >>
> >> I'm fine either way, I just wanted to accommodate Mark's preference,
> >> because he seemed to strongly dislike having to call any helper
> >> functions from board code, beyond initing and realizing the device.
> >>
> >> This is my recollection of the earlier discussion anyway.
> > 
> > I think we are in agreement, then.  If there are no objections from
> > others against doing object_property_add_child() on realize, I'm also OK
> > with that.
> 
> Just to clarify here that my objection wasn't so much about calling
> helper functions from board code, it was that as the current patch
> exposes the MemoryRegions in TYPE_FW_CFG_IO and TYPE_FW_CFG_MEM then as
> per my example where the machine link is omitted then the check becomes
> useless.

I don't understand this part.  When and why would the check become
useless?

> 
> I can see that device_set_realized() will always set the device parent
> to /machine/unattached before calling the realize function if the device
> doesn't have a parent. So is it even possible to add the device via
> object_property_add_child() to the machine during realize? Or could it
> be done by making /machine/fw_cfg an alias to its real location in the
> QOM tree at realize time without breaking the object_resolve_path_type()
> check?

Well, if we can't do object_property_add_child() on ->instance_init()
and doing it on ->realize() would require a more complex solution
involving QOM links, I believe the simplest solution is to provide a
helper function.

> 
> The other interesting option to explore is that since fw_cfg already has
> a machine_ready notifier, the check could be moved there similar to as
> done in hw/core/machine.c's error_on_sysbus_device() if the check
> shouldn't be present in realize. That still doesn't answer the question
> as to how to enforce that the device is correctly linked to the machine
> though.

I think both manually mapping+linking from board code or calling a
helper function from board code would be acceptable.

-- 
Eduardo
