Received: from eggs.gnu.org ([2001:4830:134:3::10]:48496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dON7I-00083z-Cz
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dON7C-0006Vs-6F
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:51:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dON7B-0006Ve-TA
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 07:51:06 -0400
Date: Fri, 23 Jun 2017 08:50:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170623115051.GE20956@localhost.localdomain>
References: <7d5904ae-e66c-5594-cfff-747578d91f4b@ilande.co.uk>
	<08da52ec-e4d2-d836-49bd-90baf21747fb@redhat.com>
	<1d8147a6-d55c-4951-68db-4c1cf502a4f3@ilande.co.uk>
	<9d24bf00-cf82-717a-eccd-f51e2c80dd6f@redhat.com>
	<eaa2cd40-0d64-6843-7e39-c0f94c7e797f@ilande.co.uk>
	<48c8f007-f388-59f5-9af8-f5eefe033e2a@redhat.com>
	<20170621113600.GA3928@thinpad.lan.raisama.net>
	<8135ff45-0341-1fd4-ada9-4527c6b61e5a@ilande.co.uk>
	<20170621132317.GD3928@thinpad.lan.raisama.net>
	<7b431646-019e-dce2-6345-bdbaba7ce821@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b431646-019e-dce2-6345-bdbaba7ce821@ilande.co.uk>
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
Cc: peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, Laszlo Ersek <lersek@redhat.com>

On Fri, Jun 23, 2017 at 09:12:01AM +0100, Mark Cave-Ayland wrote:
> On 21/06/17 14:23, Eduardo Habkost wrote:
> 
> >>>>> I now have a v7 patchset ready to go (currently hosted at
> >>>>> https://github.com/mcayland/qemu/tree/fwcfg7 for the curious). Laszlo,
> >>>>> I've currently left off your Tested-by tag since I'm not sure it's still
> >>>>> valid for less-than-trivial changes - if you're happy for me to re-add
> >>>>> it before I send the v7 patchset to the list, please let me know.
> >>>>
> >>>> I intend to test v7 when you post it.
> >>>
> >>> I still see the instance_init assert() in that branch (commit
> >>> 17d75643f880).  Is that correct?
> >>
> >> Yes that was the intention. In 17d75643f880 both the assert() and
> >> object_property_add_child() are moved into the instance_init() function,
> >> and then in the follow-up commit eddedb5 the assert() is removed from
> >> instance_init() and the object_resolve_path_type() check added into
> >> fw_cfg_init1() as part of its conversion into the
> >> fw_cfg_common_realize() function.
> > 
> > We can't move assert() + linking to instance_init even if it's
> > just temporary, as it makes device-list-properties crash.
> > 
> > Just linking in instance_init is also a problem, because
> > instance_init should never affect global QEMU state.
> > 
> > You could move linking to realize as well, but: just like you
> > already moved sysbus_add_io() calls outside realize, I believe
> > linking belongs outside realize too.  I need to re-read the
> > discussion threads to understand the motivation behind that.
> 
> Ultimately the question we're trying to answer is "has someone
> instantiated another fw_cfg device for this machine?" and the way it
> works currently is that fw_cfg_init_io() and fw_cfg_init_mem() attach
> the fw_cfg device to the /machine object and then check after realize
> whether a /machine/fw_cfg device already exists, aborting if it does.
> 
> So in the current implementation we're not actually concerned with the
> placement of fw_cfg within the model itself, and indeed with a fixed
> location in the QOM tree it's already completely wrong. If you take a
> look at the QOM tree for the sparc/sparc64/ppc machines you'll see that
> they really are very far from reality.
> 
> For me the use of object_resolve_path_type() during realize is a good
> solution since regardless of the location of the fw_cfg we can always
> detect whether we have more than one device instance.
> 
> However what seems unappealing about this is that while all existing
> users which use fw_cfg_init_io() and fw_cfg_init_mem() are fine, in the
> case where I am wiring up the device myself then for my sun4u example
> the code looks like this:
> 
> dev = qdev_create(NULL, TYPE_FW_CFG_IO);
> ...
> qdev_init_nofail(dev);
> memory_region_add_subregion(pci_address_space_io(ebus), BIOS_CFG_IOPORT,
>                             &FW_CFG_IO(dev)->comb_iomem);
> 
> Here you can see that the device is active because it is mapped into the
> correct IO address space, but notice I have forgotten to link it to the
> QOM /machine object myself. Hence I can instantiate and map as many
> instances as I like and never trigger the duplicate instance check which
> makes the check fairly ineffective.

This is a good point, but I have a question about that: will something
break if a machine decides to create two fw_cfg objects and map them to
different addresses?  If it won't break, I see no reason to try to
enforce a single instance in the device code.  If it will break, then a
check in realize is still a hack, but might be a good enough solution.

-- 
Eduardo
