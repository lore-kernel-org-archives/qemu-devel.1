Received: from eggs.gnu.org ([2001:4830:134:3::10]:48835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxs0h-0004JA-DB
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxs0c-0007yj-Ax
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:22:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cxs0c-0007yB-37
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:22:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490945793-21276-1-git-send-email-peterx@redhat.com>
	<20170331191601-mutt-send-email-mst@kernel.org>
	<20170401012942.GK3981@pxdev.xzpeter.org>
Date: Tue, 11 Apr 2017 11:22:38 +0200
In-Reply-To: <20170401012942.GK3981@pxdev.xzpeter.org> (Peter Xu's message of
	"Sat, 1 Apr 2017 09:29:42 +0800")
Message-ID: <87bms3cn8h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/5] x86/vIOMMU: move init back to
 machine init phase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Fri, Mar 31, 2017 at 07:17:34PM +0300, Michael S. Tsirkin wrote:
>> On Fri, Mar 31, 2017 at 03:36:28PM +0800, Peter Xu wrote:
>> > At the very beginning, the x86 vIOMMUs are created via "-M iommu=on".
>> > We moved one step further a year ago to have the vIOMMUs just like a
>> > general device, so that we can init them with far more specific
>> > parameters with "-device" interface.
>> > 
>> > However, gradually we found that problem starts to occur due to this.
>> > The main issue is that the DMA address space of any PCI device is
>> > postponed to be init after device realization, while some devices'
>> > realizations would depend on this address space. That looks like a
>> > dead lock. We have patches and solutions for different single problem,
>> > but, maybe it's time we can consider to solve the root cause this
>> > time, of course after 2.9 release.
>> > 
>> > This series tries to solve the root cause, and move vIOMMU inits back
>> > to machine init for x86 platforms. Then, we'll have solid DMA address
>> > space for each device even during realization.
>> > 
>> > Please kindly review. Thanks.
>> 
>> I think it's a clean way to do it at a high level.
>> However I would like to set a tag in the class
>> rather than listing specific devices.
>> Also, init order should be consistent for all machines
>> not just q35.
>
> I agree that we may finally need a tag if we want to have a general
> solution for device init ordering. However I was thinking maybe for
> x86 IOMMUs we should even move the init earlier than an ordered device
> list, considering the integrated devices are created during machine
> init, and it's before the general device init loop.
>
> Actually, iiuc that's also following how the real hardware works -
> since the IOMMU unit (now we only have the root vIOMMU) belongs to
> north bridge, so imho in emulation codes we'd better follow how the
> hardware works if possible (I believe in hardware IOMMUs should be
> inited along with north bridge).
>
> (btw, maybe I should mark at least the first patch as RFC...)

No objection to fixing yet another initialization order problem by
making it yet another special case, but I think we should really, really
sit down and try to come up with a *generic* way to express
initialization order constraints.  This is a modelling problem: we need
to model how physical hardware resets.  As long as we don't, we're
damned to tinker with this rickety tower of special cases.
