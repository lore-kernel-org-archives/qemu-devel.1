Received: from eggs.gnu.org ([2001:4830:134:3::10]:51148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXYW5-0003fo-69
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:27:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXYW2-0003Hh-IO
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:27:33 -0500
References: <20181212220410.569069-1-eblake@redhat.com>
	<CAMRbyyuZ81fyHYTQSHPXhjYoLFz6nzsxc30PNJdWRkqm=14RRA@mail.gmail.com>
	<20181213104704.GD5171@redhat.com>
	<20181213140513.GD5427@linux.fritz.box>
	<CAMRbyytod-tELpdzmgp_mzwut=AuH4J1JsQ93QiFqz9RORV28g@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ac589e0c-0294-8ce1-977b-eecdfea42eb8@redhat.com>
Date: Thu, 13 Dec 2018 15:27:22 -0600
MIME-Version: 1.0
In-Reply-To: <CAMRbyytod-tELpdzmgp_mzwut=AuH4J1JsQ93QiFqz9RORV28g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC] qemu-io: Prefer stderr
 for error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 12/13/18 11:44 AM, Nir Soffer wrote:

>> The things is, qemu-io was never meant to be used by other
>> applications that need to process the results, it's a tool for testing
>> and debugging. If we had meant it to be used by other programs, we would
>> have given it a machine-friendly interface.
>>
>> The machine-friendly interface to the QEMU block layer is qemu-nbd.
>>
> 
> nbd is awesome, but much more complicated to use for testing. You need to:
> 
> 1. start qemu-nbd
> 2. wait until it is ready
> 3. use nbd client (we have one now), or connect the qemu-nbd to /dev/ndbX,
> which on
>    Fedora 28 leaves stale /dev/nbdX devices after disconnection
>    (I reported this few month ago here).

Is that true even when you use 'qemu-nbd -d /dev/nbdX' after you are done?

> 4. finally disconnect and wait until qemu-nbd terminates
> 
> qemu-io is so much easier to use, we need to make it more machine friendly.

Or rather, if there is something that a machine needs to drive, we 
should figure out if qemu-img can be taught to do it instead of hacking 
around the issue with qemu-io.  When it comes to extracting portions of 
a disk, qemu-img convert coupled with the raw driver's offset/length 
gets us quite a bit of functionality - even if it's clunky to come up 
with the command line, it can be programmed, and doesn't suffer from 
having to post-process arbitrary qemu-io output changes.

>> The human interface of qemu-io is honestly just not the right tool for
>> the job, and adding one-off tweaks to make it a little bit less horrible
>> to use for machines isn't the right approach because it's still not a
>> proper machine protocol.
>>
> 
> Add --output json?

Who's volunteering to do it? I've got too much else going on to spend 
time on such a project.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
