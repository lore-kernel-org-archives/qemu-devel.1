Received: from eggs.gnu.org ([2001:4830:134:3::10]:33786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Ciprian.Barbu@enea.com>) id 1cvJeS-0000Za-Al
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 04:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Ciprian.Barbu@enea.com>) id 1cvJeP-0004xV-6b
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 04:17:20 -0400
Received: from smtp-out10.electric.net ([185.38.180.44]:56380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Ciprian.Barbu@enea.com>)
	id 1cvJeO-0004wZ-VK
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 04:17:17 -0400
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
	<20170403081542.GA5036@noname.str.redhat.com>
	<33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
	<4d684062-be31-153e-3f94-b1193440c8e3@redhat.com>
From: ciprian.barbu <ciprian.barbu@enea.com>
Message-ID: <e2fb3ffd-006c-5908-9201-d3182edc4c04@enea.com>
Date: Tue, 4 Apr 2017 11:17:11 +0300
MIME-Version: 1.0
In-Reply-To: <4d684062-be31-153e-3f94-b1193440c8e3@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, pkrempa@redhat.com, Alexandru Avadanii <Alexandru.Avadanii@enea.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, svc-armband <armband@enea.com>

Hi,

On 03.04.2017 22:44, Eric Blake wrote:
> On 04/03/2017 07:39 AM, Max Reitz wrote:
>>>> As for just allowing the NBD server write access to the device... To me
>>>> that appears pretty difficult from an implementation perspective. We
>>>> assert that nobody can write without having requested write access and
>>>> we make sure that nobody can request write access without it being
>>>> allowed. Making an exception for NBD seems very difficult and would
>>>> probably mean we'd have to drop the assertion for write accesses altogether.
>>>
>>> Making an exception would simply be wrong.
>>
>> Indeed. That is why it would be so difficult.
>>
>> The question remains whether it is practical not to make an exception.
>> As far as I know, libvirt is only guaranteed to support older qemu
>> versions, not necessarily future ones. So we should be allowed to break
>> existing use cases here until libvirt is updated (assuming it is
>> possible for libvirt to express "guest device allows shared writes" as
>> an option for its next release).
>
> In general, we support:
>
> old qemu, old libvirt (well, as long as those versions are supported)
> old qemu, new libvirt
> new qemu, new libvirt
>
> but we do NOT make any guarantees of supporting
>
> new qemu, old libvirt

Sounds reasonable enough, I guess we didn't look at it this way.

>
> In other words, this may be a failure where new qemu requires extra care
> and thus a new libvirt for it to be useful.  It's not nice to break qemu
> back-compat if any other solution is possible (new qemu and old libvirt
> should work more often than not), but it is the one scenario that no one
> supports (whether here, upstream libvirt, or in downstream backports).
>
> Or, put another way, it's perfectly fine if we require that the use of
> qemu 2.9 requires that you also use libvirt 3.3.0 or newer (since we
> missed the boat on fixing libvirt 3.2 to pass shared-rw or any other
> handshaking we come up with), although it's also nice if we figure out
> how to make qemu work with what existing libvirt wants to do (the NBD
> export needs to be writable by the source pre-migration, and by the
> destination post-migration; so there is that aspect of two clients both
> wanting to write - but the destination doesn't need to write until after
> the source no longer has anything to write, so if we have a clean way to
> turn writes off for the source, then turn writes on for the destination,
> all before migrating which host is writing, that would be even cleaner).
>

Ok, this sounds like you are saying that there isn't much reasoning 
behind this usecase, and also we might be the only ones complaining 
about new qemu not working with an old libvirt.

I think we could do with a 'clean' (as clean as it gets) workaround, 
since it might be very difficult to bump libvirt in our Openstack 
environment, skipping one major versions and several minors. But we 
would be willing to do it as long as there are good chances it should 
work ok. In the mean time we are using a less clean workaround and we 
rely on you guys to help us find a good solution.

Thanks and regards,
/Ciprian
