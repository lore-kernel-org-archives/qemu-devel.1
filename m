Received: from eggs.gnu.org ([2001:4830:134:3::10]:48263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dQ76z-0006FS-JF
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dQ76t-00074H-Bf
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:10:05 -0400
Received: from chuckie.co.uk ([82.165.15.123]:58421
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dQ76t-00072M-4E
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:09:59 -0400
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
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <f6a0bc2b-bf91-4c49-aa41-7816da70252c@ilande.co.uk>
Date: Wed, 28 Jun 2017 08:09:35 +0100
MIME-Version: 1.0
In-Reply-To: <20170627004930.GI12152@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, Laszlo Ersek <lersek@redhat.com>

On 27/06/17 01:49, Eduardo Habkost wrote:

> On Sun, Jun 25, 2017 at 07:58:04PM +0100, Mark Cave-Ayland wrote:
>> On 23/06/17 19:50, Eduardo Habkost wrote:
>>
>>>> Really, please go back to the earlier discussion around fw_cfg_init1()
>>>> and you'll see my original point (which matches what you just voiced).
>>>
>>> Yep.  I was just not sure validation on realize was necessary or
>>> convenient.  It looks like we agree it is just convenient.
>>>
>>>
>>>>
>>>>> All that said, I don't have a strong argument against doing it on
>>>>> realize, except my gut feeling that this is not how qdev was
>>>>> designed[1].  If doing it on realize is the simplest way to do it, I
>>>>> won't be the one complaining.
>>>>>
>>>>> [1] I believe the original intent was to make every single device
>>>>>     user-creatable and define boards in a declarative way in config
>>>>>     files.  We are very far from that goal.
>>>>
>>>> I'm fine either way, I just wanted to accommodate Mark's preference,
>>>> because he seemed to strongly dislike having to call any helper
>>>> functions from board code, beyond initing and realizing the device.
>>>>
>>>> This is my recollection of the earlier discussion anyway.
>>>
>>> I think we are in agreement, then.  If there are no objections from
>>> others against doing object_property_add_child() on realize, I'm also OK
>>> with that.
>>
>> Just to clarify here that my objection wasn't so much about calling
>> helper functions from board code, it was that as the current patch
>> exposes the MemoryRegions in TYPE_FW_CFG_IO and TYPE_FW_CFG_MEM then as
>> per my example where the machine link is omitted then the check becomes
>> useless.
> 
> I don't understand this part.  When and why would the check become
> useless?

Well because when using the standard QEMU pattern of
qdev_create()...qdev_init_nofail() it is possible to realize the device
and wire up its MemoryRegions manually as I have done with the sun4u
(i.e. it will respond to accesses) multiple times without calling the
helper function and triggering the check. The ingenious part here is
that only the developers who aren't aware that they have to manually
call the helper function will be the ones who get caught out trying to
instantiate the device multiple times ;)

I'm also aware that with QOM we've got 2 conflicting ideas with fw_cfg:
on the one hand we're saying that QOM hierarchy should at some level
represent the topology of the machine, i.e. for sun4u the fw_cfg device
should appear under the ebus device. whereas at the moment we assume a
fixed path of FW_CFG_PATH.

Based upon this I been thinking along the following lines:

1) Alter fw_cfg_find() to use object_resolve_path_type("", TYPE_FW_CFG,
NULL)

This solves the issue of allowing the QOM tree to best represent the
device topology as it will allow fw_cfg_find() to locate the fw_cfg
device regardless of its location, and hence it can be placed as
appropriate for each machine.

2) Add a check at the top of fw_cfg_common_realize() along the lines of:

if (object_unattached(OBJECT(dev)) {
    error_setg(errp, "%s device must be explicitly added as a child "
               object before realize", TYPE_FW_CFG);
    return;
}

This makes it obvious to the developer that they MUST wire up the fw_cfg
device to the machine before realize, and then if more than one device
is instantiated we can still trigger the existing error from my v7 branch:

if (!object_resolve_path_type("", TYPE_FW_CFG, NULL)) {
    error_setg(errp, "at most one %s device is permitted", TYPE_FW_CFG);
    return;
}

I prefer this method because it is impossible for a developer to
accidentally realize the fw_cfg device without attaching it to the
machine first (i.e. fw_cfg_find() will always succeed if this is the
case if altered as per 1) above) and it can only be realized once. And
following the POLA the device can be wired up using
object_property_add_child() as per the numerous existing examples
throughout the QEMU codebase.

Now the minor issue with 2) is that I can't find an easy way to
determine if the device is unattached at realize time. I've tried
something like this:

if (!object_resolve_path_type("/machine/unattached",
    TYPE_FW_CFG, NULL)) {
   ...
   ...
}

However that doesn't work because as the rules differ between partial
and absolute path resolution, we end up resolving the container itself
as opposed to iterating down through the QOM tree. Is there an existing
solution for this or would I need to come up with something that
iterates over the container children to search for a TYPE_FW_CFG device
myself?


ATB,

Mark.
