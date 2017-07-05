Received: from eggs.gnu.org ([2001:4830:134:3::10]:56332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dSjb4-00054T-Uk
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dSjb0-0004wx-0q
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:39:58 -0400
Received: from chuckie.co.uk ([82.165.15.123]:50983
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dSjaz-0004wl-PN
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:39:53 -0400
References: <74424b67-f20b-27c1-6c96-e2ee54bf5bd6@ilande.co.uk>
	<20170704204447.GA19979@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <b7dc6777-90b7-86ff-4405-4282eb73b8d6@ilande.co.uk>
Date: Wed, 5 Jul 2017 13:39:41 +0100
MIME-Version: 1.0
In-Reply-To: <20170704204447.GA19979@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Managing architectural restrictions with -device
 and libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 04/07/17 21:44, Daniel P. Berrange wrote:

> On Tue, Jul 04, 2017 at 07:25:41PM +0100, Mark Cave-Ayland wrote:
>> Hi all,
>>
>> I've been working on a patchset that brings the sun4u machine on
>> qemu-system-sparc64 much closer to a real Ultra 5, however due to
>> various design restrictions I need to be able to restrict how devices
>> are added to the machine with -device.
>>
>> On a real Ultra 5, the root PCI bus (sabre) has 2 PCI bridges (simba A
>> and simba B) with the onboard devices attached to simba A with 2 free
>> slots, and an initially empty simba B.
>>
>> Firstly, is it possible to restrict the machine so that devices cannot
>> be directly plugged into the root PCI bus, but only behind one of the
>> PCI bridges? There is also an additional restriction in that slot 0
>> behind simba A must be left empty to ensure that the ebus (containing
>> the onboard devices) is the first device allocated.
>>
>> Secondly, how does libvirt handle these type of restrictions? Is it able
>> to get the information from QEMU or is there some kind of libvirt
>> profile that needs to be updated? And do newer versions of libvirt have
>> the ability to attach devices behind PCI bridges using a GUI such as
>> virt-manager, or is that only something that can only be done by
>> directly editing the domain XML?
> 
> Libvirt has a bunch of code that provides different logic for various
> machine types when doing addressing & setting up default PCI controllers.
> Libvirt support for sparc machine types almost certainly broken since
> I'm not aware of anyone having looked at it forever. Probably best to
> re-ask your Q's on the libvir-list to get info from the people familiar
> with this, since I'm fuzzy on precise details of what you'd need todo.

Thanks for the information. From what you're saying above it seems like
we need to fix this on two levels: firstly in QEMU itself, and secondly
to determine some suitable logic for libvirt.

For me QEMU itself is the priority, however it does appear that some
people are using libvirt with SPARC, e.g. from this post on
debian-sparc: https://lists.debian.org/debian-sparc/2017/07/msg00000.html.

The other thing to bear in mind is that the machine model still needs at
least one more change (emulating a proper Sun HME nic) so it would be
good to get the model static before working on the libvirt logic.


ATB,

Mark.
