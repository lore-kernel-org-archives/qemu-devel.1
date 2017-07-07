Received: from eggs.gnu.org ([2001:4830:134:3::10]:38989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dTTip-000286-FD
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dTTim-0006m4-DC
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:55:03 -0400
Received: from chuckie.co.uk ([82.165.15.123]:55211
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dTTim-0006ln-6E
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:55:00 -0400
References: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1498745240-30658-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170703113940.0e0415a2@nial.brq.redhat.com>
	<0efc917e-16d3-f01b-6fd8-a3bb71580bf4@ilande.co.uk>
	<20170707133320.2e0d741d@nial.brq.redhat.com>
	<1b4f1872-2ea2-8c10-593f-e2adf013b234@ilande.co.uk>
	<20170707132619.GT12152@localhost.localdomain>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <b3616dc1-2d8e-3cce-cf40-b239d20c1d83@ilande.co.uk>
Date: Fri, 7 Jul 2017 14:54:49 +0100
MIME-Version: 1.0
In-Reply-To: <20170707132619.GT12152@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv7 5/6] fw_cfg: move qdev_init_nofail() from
 fw_cfg_init1() to callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, lersek@redhat.com

On 07/07/17 14:26, Eduardo Habkost wrote:

(cut)

>> However this causes us a problem: if you instantiate the fw_cfg yourself
>> with qdev_create()...qdev_init_nofail() then you can potentially access
>> the underlying MemoryRegions directly and wire up the device without
>> attaching it to the QOM tree. This is an invalid configuration but
>> wouldn't be detected with fw_cfg_find().
> 
> Why is it an invalid configuration?  All we need is that the
> device get wired correctly and that fw_cfg_find() find the device
> correctly.  Your patch 3/6 makes fw_cfg_find() work on any path,
> making fw_cfg_unattached_at_realize() unnecessary.

That's a good point actually. The fw_cfg_find() change came in fairly
recently but from memory that on its own wasn't enough to prevent
multiple fw_cfg devices in my local tests which is why added
fw_cfg_unattached_at_realize() (sadly I can't remember exactly which
test case failed).

So actually perhaps the reason I got sidetracked here was because I was
actually hitting the issue pointed out by Igor whereby with ambiguous
set to NULL you can miss detecting multiple instances?

>>
>> The correct way to handle this is to wire up the device yourself with
>> object_property_add_child() but then you find the situation whereby the
>> people who know that you have to call object_property_add_child() when
>> adding the fw_cfg device are the ones who don't need the error message.
>>
>> Therefore the solution was to enforce that the fw_cfg device has been
>> added to the QOM tree before realize because it solves all the problems:
>>
>> 1) The fw_cfg device can now be placed anywhere in the QOM tree, meaning
>> that the QOM tree can be a topologically correct representation of the
>> machine
> 
> While attaching the device explicitly is a good idea, we don't
> need to make it a fatal error.
> 
>>
>> 2) By enforcing that the fw_cfg device has been parented, we guarantee
>> that the fw_cfg_find() check is correct and it is impossible to access a
>> fw_cfg device that hasn't been wired up to the machine
> 
> This is solved by patch 3/6.
> 
>>
>> 3) Since these checks are done at realize time, we can provide nice
>> friendly messages back to the developer to tell them what needs to be fixed
> 
> I don't see what needs to be fixed.  It is not a bug to leave
> fw_cfg in /machine/unattached, as long as fw_cfg_find() works
> properly.

Yeah. I wonder if I've been leading myself astray down the wrong path
here? Let me do some more local tests without
fw_cfg_unattached_at_realize() and with an ambiguous argument in
fw_cfg_find().


ATB,

Mark.
