Received: from eggs.gnu.org ([2001:4830:134:3::10]:53359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dNeZk-0005FA-Hr
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dNeZf-00065g-NO
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:17:36 -0400
Received: from chuckie.co.uk ([82.165.15.123]:41594
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dNeZf-00065A-GL
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:17:31 -0400
References: <1497877149-19253-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497877149-19253-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170619142852.GS5016@thinpad.lan.raisama.net>
	<7d5904ae-e66c-5594-cfff-747578d91f4b@ilande.co.uk>
	<08da52ec-e4d2-d836-49bd-90baf21747fb@redhat.com>
	<1d8147a6-d55c-4951-68db-4c1cf502a4f3@ilande.co.uk>
	<9d24bf00-cf82-717a-eccd-f51e2c80dd6f@redhat.com>
	<eaa2cd40-0d64-6843-7e39-c0f94c7e797f@ilande.co.uk>
	<48c8f007-f388-59f5-9af8-f5eefe033e2a@redhat.com>
	<20170621113600.GA3928@thinpad.lan.raisama.net>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <8135ff45-0341-1fd4-ada9-4527c6b61e5a@ilande.co.uk>
Date: Wed, 21 Jun 2017 13:17:06 +0100
MIME-Version: 1.0
In-Reply-To: <20170621113600.GA3928@thinpad.lan.raisama.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, imammedo@redhat.com, pbonzini@redhat.com

On 21/06/17 12:36, Eduardo Habkost wrote:

> On Wed, Jun 21, 2017 at 09:48:16AM +0200, Laszlo Ersek wrote:
>> On 06/21/17 08:58, Mark Cave-Ayland wrote:
>>> On 19/06/17 23:43, Laszlo Ersek wrote:
>>>
>>>> It looks good to me, but please await Eduardo's reply as well.
>>>>
>>>> In particular, it should be confirmed that object_resolve_path_type()
>>>> matches instances of *subclasses* as well (as I expect it would). Your
>>>> test results confirm that; let's make sure it is intentional behavior.
>>>> Eduardo (or someone else on the CC list), can you please comment on that?
>>>
>>> Thanks Laszlo. Eduardo, can you confirm this is the correct behaviour?
> 
> Sorry for taking so long to reply.  Yes, it should be the correct
> behavior.  It's how it's documented:
> 
> "This is similar to object_resolve_path.  However, when looking
> for a partial path only matches that implement the given type are
> considered.  This restricts the search and avoids spuriously
> flagging matches as ambiguous."
> 
> (Key part here is "implement the given type").
> 
> Approach used by commit f92063028a "hw/acpi/vmgenid: prevent more
> than one vmgenid device" looks good to me.

That is great news, thanks for confirming this.

>>>
>>> I now have a v7 patchset ready to go (currently hosted at
>>> https://github.com/mcayland/qemu/tree/fwcfg7 for the curious). Laszlo,
>>> I've currently left off your Tested-by tag since I'm not sure it's still
>>> valid for less-than-trivial changes - if you're happy for me to re-add
>>> it before I send the v7 patchset to the list, please let me know.
>>
>> I intend to test v7 when you post it.
> 
> I still see the instance_init assert() in that branch (commit
> 17d75643f880).  Is that correct?

Yes that was the intention. In 17d75643f880 both the assert() and
object_property_add_child() are moved into the instance_init() function,
and then in the follow-up commit eddedb5 the assert() is removed from
instance_init() and the object_resolve_path_type() check added into
fw_cfg_init1() as part of its conversion into the
fw_cfg_common_realize() function.

One last question which might avoid a future v8 revision: does the error
handling in eddedb5 for the fw_cfg_*_realize() functions look correct?

The existing check for fw_cfg_file_slots_allocate() uses a local_err
Error variable, whereas I've seen a mixture of callers using both this
approach and using the errp Error variable directly. Is there any reason
to prefer one over the other? Currently I'm also using local_err in
order to keep the fw_cfg_*_realize() functions consistent.


ATB,

Mark.
