Received: from eggs.gnu.org ([2001:4830:134:3::10]:40182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dWoy8-0006Sp-4h
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 15:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dWoy5-0002pG-2B
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 15:12:40 -0400
Received: from chuckie.co.uk ([82.165.15.123]:47350
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dWoy4-0002lc-QL
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 15:12:36 -0400
References: <1500025208-14827-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1500025208-14827-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170714180907.GM6020@localhost.localdomain>
	<9584b0c7-96f4-f000-e53f-93accd8a39ad@redhat.com>
	<20170714185616.GQ6020@localhost.localdomain>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <c838ca67-24a3-aff3-2a42-0f106fa2d898@ilande.co.uk>
Date: Sun, 16 Jul 2017 20:12:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170714185616.GQ6020@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv9 3/3] fw_cfg: move QOM type defines and
 fw_cfg types into fw_cfg.h
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

On 14/07/17 19:56, Eduardo Habkost wrote:

>>> Why do you need the full struct declaration to be exposed in the
>>> header?
>>
>> Different board code wants to hook up "comb_iomem" manually to different
>> address spaces, so they need to access the field directly. This is the
>> ultimate goal of the entire exercise, IIRC.

Yes, that is correct (and I believe is mentioned in the cover letter, too).

>>> The memory regions are supposed to be visible as QOM
>>> children to the fw_cfg device, already.
>>
>> I don't understand this. How else can board code work with "comb_iomem"
>> than described above? If there is a way, I agree it would be preferable.
> 
> object_resolve_path_component(fw_cfg, "fwcfg[0]") and
> object_resolve_path_component(fw_cfg, "fwcfg.dma[0]") should
> return fw_cfg->comb_iomem and fw_cfg->dma_iomem, respectively.
> 
> I don't know why those names were chosen, though.  Probably it's
> a good idea to call object_property_add_child() manually with
> more appropriate names inside the fw_cfg code instead of letting
> memory_region_init() pick the child name.

That's interesting. I did a grep of the codebase for
object_resolve_path_component and struggled to find an instance where it
was being used to provide access to a MemoryRegion. Even if it's an
available feature, it's certainly not one that is widely known about.

In terms of the patch, is the v9 revision suitable for commit or does
this constitute a NACK?


ATB,

Mark.
