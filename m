Received: from eggs.gnu.org ([2001:4830:134:3::10]:52638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fdY27-0003OY-1Z
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <loseweigh@gmail.com>) id 1fdY25-0004SM-Rk
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:37:07 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:37893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <loseweigh@gmail.com>) id 1fdY25-0004S1-N2
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:37:05 -0400
Received: by mail-it0-x243.google.com with SMTP id v71-v6so5856097itb.3
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 02:37:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180711115344.633eba9e.cohuck@redhat.com>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
	<20180702161404.GA2339@rkaganb.sw.ru>
	<449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com>
	<20180703095825.GC30904@rkaganb.sw.ru>
	<d5db37d0-5eaf-8942-8ab7-d73057a67e6f@oracle.com>
	<20180709130035.GA6271@rkaganb.sw.ru>
	<9136094e-a510-4201-7c71-d1c49226fa5f@oracle.com>
	<20180710045101-mutt-send-email-mst@kernel.org>
	<CADGSJ20H1S88S6AsYoLMns3XH+YVKh006Dqu808X7Ug+2Mgdnw@mail.gmail.com>
	<20180711115344.633eba9e.cohuck@redhat.com>
From: Siwei Liu <loseweigh@gmail.com>
Date: Thu, 12 Jul 2018 02:37:03 -0700
Message-ID: <CADGSJ20A=sbwQQ-_YQEVwoCXwTvosCEnD2iKa0kS6ZGvbgy4rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v3 0/3] Use of unique
 identifier for pairing virtio and passthrough devices...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, si-wei liu <si-wei.liu@oracle.com>, Roman Kagan <rkagan@virtuozzo.com>, Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Netdev <netdev@vger.kernel.org>

On Wed, Jul 11, 2018 at 2:53 AM, Cornelia Huck <cohuck@redhat.com> wrote:
> On Tue, 10 Jul 2018 17:07:37 -0700
> Siwei Liu <loseweigh@gmail.com> wrote:
>
>> On Mon, Jul 9, 2018 at 6:54 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Mon, Jul 09, 2018 at 06:11:53PM -0700, si-wei liu wrote:
>> >> The plan is to enable group ID based matching in the first place rather than
>> >> match by MAC, the latter of which is fragile and problematic.
>> >
>> > It isn't all that fragile - hyperv used same for a while, so if someone
>> > posts working patches with QEMU support but before this grouping stuff,
>> > I'll happily apply them.
>>
>> I wouldn't box the solution to very limited scenario just because of
>> matching by MAC, the benefit of having generic group ID in the first
>> place is that we save the effort of maintaining legacy MAC based
>> pairing that just adds complexity anyway. Currently the VF's MAC
>> address cannot be changed by either PF or by the guest user is a
>> severe limitation due to this. The other use case is that PT device
>> than VF would generally have different MAC than the standby virtio. We
>> shouldn't limit itself to VF specific scenario from the very
>> beginning.
>
> So, this brings me to a different concern: the semantics of
> VIRTIO_NET_F_STANDBY.
>
> * The currently sole user seems to be the virtio-net Linux driver.
> * The commit messages, code comments and Documentation/ all talk about
>   matching by MAC.
> * I could not find any proposed update to the virtio spec. (If there
>   had been an older proposal with a different feature name, it is not
>   discoverable.)

No, there was no such spec patch at all when the Linux patch was
submitted, hence match by MAC is the only means to pair device due to
lack of QEMU support.

Q: Does it work?
A: Well, it works for some.
Q: Does it work well to support all scenarios?
A: No, not as it claims to.
Q: Can it do better job to support all scenarios?
A: Yes, do pairing with the failover group ID instead.
Q: Does pairing still need to be MAC based if using failover group ID?
A: It depends, it's up to the implementation to verify MAC address
depending on the need (e.g. VF failover versus PT device replacement),
though MAC matching is no longer positioned as a requirement for
pairing or grouping.

There's no such stickiness for matching by MAC defined anywhere. The
semantics of VIRTIO_NET_F_STANDBY feature are mostly a failover
concept that the standby device should be used when the primary is not
present. We now have added the group ID on QEMU. I don't see why
bothering to get rid of the limitation: it's never been exposed. No
existing users. No API/ABI defined at all.

>
> VIRTIO_NET_F_STANDBY is a host <-> guest interface. As there's no
> official spec, you can only go by the Linux implementation, and by that
> its semantics seem to be 'match by MAC', not 'match by other criteria'.
>
> How is this supposed to work in the long run?

That group ID thing should work for all OS. Not just Linux.

I will change all the references to MAC matching in my upcoming patch.
Thank you for the note.

-Siwei
