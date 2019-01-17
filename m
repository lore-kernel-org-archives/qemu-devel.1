Received: from eggs.gnu.org ([209.51.188.92]:36002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zub@linux.fjfi.cvut.cz>) id 1gkGic-0002ww-WE
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 18:05:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zub@linux.fjfi.cvut.cz>) id 1gkGib-0001t8-Vj
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 18:05:02 -0500
Received: from mailgw1.ipv6.fjfi.cvut.cz ([2001:718:2:1900::3]:58840
	helo=mailgw1.fjfi.cvut.cz)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zub@linux.fjfi.cvut.cz>)
	id 1gkGib-0001jS-CT
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 18:05:01 -0500
Date: Fri, 18 Jan 2019 00:04:48 +0100 (CET)
From: David Kozub <zub@linux.fjfi.cvut.cz>
In-Reply-To: <e2e14237-32be-8e3d-242c-c19e98d04d60@redhat.com>
Message-ID: <alpine.LRH.2.21.1901172312550.8075@linux.fjfi.cvut.cz>
References: <alpine.LRH.2.21.1901051827350.16856@linux.fjfi.cvut.cz>
	<20190107091618.GD27089@stefanha-x1.localdomain>
	<e2e14237-32be-8e3d-242c-c19e98d04d60@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] Emulation of TCG OPAL self-encrypting drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, kwolf@redhat.com

On Wed, 16 Jan 2019, John Snow wrote:

> I can answer some questions about the ATA layer, but I'm not well read
> on OPAL or the interrelationship between the two.
>
> We don't have an ATA-style passthrough in QEMU right now and nobody has
> ever asked! Would you mind elaborating for me what kind of setup you're
> looking to accomplish and maybe I can give you some better hints?
>
> --js

Hi John,

I'm thinking about adding OPAL support into grub. And I thought being able 
to do the development with qemu would make the development much easier.

While I read the OPAL spec, I can't say I understand it. But as far as I 
know, the relationship between OPAL and ATA is not too complicated. The 
OPAL spec itself is written in interface-agnostic way. It just defines 
there should be two interface commands ("Trusted Commands"), described as 
"IF-SEND" and "IF-RECV". (See [1], 1.4.1 Global Terminology and 2.3.1 Host 
<-> TPer Communication Infrastructure) and the OPAL spec essentially 
defines the paylods for these.

The actual definition of what "Trused Commands" are for ATA comes from 
"TCG Storage Interface Interactions Specification (SIIS)"[3], specifically 
"4.2 Mapping of IF-SEND and IF-RECV". (Well, it's not that simple, as 
there are other things like error handling.)

Of course, OPAL affects other commands, like reads and writes, based on 
the OPAL state (see [1], 5.7 Locking Template).

Furthermore, there is the "shadow MBR" feature, which, when enabled (and 
not marked as done), makes the disk present a different content at the 
beginning. (This is typically used to store a program that can be booted, 
asks for password, unlocks the disk, sets the "mbr done" flag to hide the 
shadow MBR and reboots to the real OS. - see e.g. 5.7.2.5.3 Done in [1].)

Here are the specs relevant for OPAL v2:
[1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Architecture_Core_Spec_v2.01_r1.00.pdf
[2] https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage-Opal_SSC_v2.01_rev1.00.pdf
[3] https://trustedcomputinggroup.org/wp-content/uploads/TCG_SWG_SIIS_v1.08_r1.00.pdf

Implementing the spec (for what an "OPAL" disk need to support, I think 
[2] is the important document) seems like a big task.

So I'm thinking ATA passthrough might be a more attainable goal. This way 
I could use a real OPAL drive w/o needing a spare controller for PCI 
passthrough. And with some more fiddling, I could even connect this to 
userspace (I was thinking of ATA over Ethernet). This could be useful for 
other development/fiddling scenarios too.

But I don't know much about ATA. Would it be sufficient to just do an 
SG_IO IOCTL on the target block device for each ide_exec_cmd? How do 
things like NCQ fit into this?

Best regards,
David
