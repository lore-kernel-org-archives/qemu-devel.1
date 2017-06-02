Received: from eggs.gnu.org ([2001:4830:134:3::10]:48660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGhIz-0002xx-GF
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGhIv-0002KT-S3
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:47:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dGhIv-0002JS-L6
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:47:29 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <87d1ar504h.fsf@dusky.pond.sub.org>
	<c666d24d-c8fc-ea77-af25-7f528aee0a81@redhat.com>
	<20170601192206.3z6yki3sji5efrjc@aurel32.net>
	<2178962.Og9WLNWV2W@np-p-burton>
	<20170602041857.GA4056@pxdev.xzpeter.org>
Date: Fri, 02 Jun 2017 09:47:20 +0200
In-Reply-To: <20170602041857.GA4056@pxdev.xzpeter.org> (Peter Xu's message of
	"Fri, 2 Jun 2017 12:18:57 +0800")
Message-ID: <87r2z2kf07.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] msi: remove return code for msi_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Paul Burton <paul.burton@imgtec.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

Peter Xu <peterx@redhat.com> writes:

> On Thu, Jun 01, 2017 at 03:06:29PM -0700, Paul Burton wrote:
>> Hi Aurelien/Paolo/Marcel,
>> 
>> On Thursday, 1 June 2017 12:22:06 PDT Aurelien Jarno wrote:
>> > On 2017-06-01 16:23, Paolo Bonzini wrote:
>> > > On 01/06/2017 10:27, Marcel Apfelbaum wrote:
>> > > > On 31/05/2017 11:28, Paolo Bonzini wrote:
>> > > >> No, for now I'd rather just go and remove msi_nonbroken.  When someone
>> > > >> reports a bug, we can add back "msi_broken".
>> > > > 
>> > > > Hi,
>> > > > I agree with the direction, but I am concerned msi_nonbroken is there
>> > > > for a reason.
>> > > > We might break some (obscure/not in use) machine.
>> > > > Maybe we should CC all arch machine maintainers/contributors to give
>> > > > them a chance to object...
>> > > 
>> > > Yeah, Alpha, MIPS and SH are those that support PCI.  Adding Richard and
>> > > Aurelien, do your platforms support MSI on real hardware but not in QEMU?
>> > 
>> > SH clearly doesn't support MSI.
>> > 
>> > The oldest MIPS board also do not support MSI, but I guess the Boston
>> > board might support it. I am adding Paul Burton in Cc: who probably
>> > knows about that.
>> > 
>> > Aurelien
>> 
>> Indeed, real Boston hardware does support MSI (or rather, the Xilinx AXI 
>> Bridge for PCI Express IP used on Boston does) & we make use of it in Linux.
>> 
>> Thanks,
>>     Paul
>
> Does this mean that we'd better still keep the msi_nonbroken bit?

If we still need the "monkey-patch MSI-capable devices to hide board
bugs" logic, it should become opt-in rather than opt-out, i.e. broken
boards set msi_broken (with a suitable comment), non-broken boards don't
touch it.

> Anyway, maybe we can first merge Paolo's fix on edu device:
>
>   [PATCH] edu: fix memory leak on msi_broken platforms
>
> Then we can see whether we still need the rest of the changes.
>
> Thanks,
