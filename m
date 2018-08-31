Received: from eggs.gnu.org ([2001:4830:134:3::10]:37894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvl5J-0005ig-0z
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 11:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvkvi-0000vI-7w
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 11:01:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50296 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fvkvi-0000ux-2y
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 11:01:46 -0400
References: <20180829153624.12299-1-david@redhat.com>
	<20180829153624.12299-15-david@redhat.com>
	<20180831103855.GC2376@work-vm>
	<6aabaa18-33f1-dea3-0824-74f78fcb2d0c@redhat.com>
	<20180831104302.GD2376@work-vm>
	<8d71de77-9fa8-4100-41be-8e1d689ba98b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e728135e-1996-207b-e7bb-df760cc7abff@redhat.com>
Date: Fri, 31 Aug 2018 10:01:15 -0500
MIME-Version: 1.0
In-Reply-To: <8d71de77-9fa8-4100-41be-8e1d689ba98b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 14/20] memory-device: ids of virtio
 based devices are special
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>

On 08/31/2018 06:18 AM, David Hildenbrand wrote:

>>>>> -                error_setg(errp, "address range conflicts with '%s'", d->id);
>>>>> +                error_setg(errp, "address range conflicts with '%s'",
>>>>> +                           id ? id : 0);
>>>>
>>>> What's that 'id ? id : 0' trick for?
>>>
>>> 0 -> "", then it actually makes sense :)
>>>

> 
> qemu-system-x86_64: -device pc-dimm,memdev=mem1,addr=0x140000000:
> address range conflicts with '(null)'
> 
> (I thought providing NULL would lead to a crash, but it is actually
> handled properly)

Well, glibc handles it. But POSIX says it is undefined, and there are 
other libc where it indeed crashes.  It's better to pass an explicit 
non-null placeholder than to rely on glibc turning NULL into "(null)".

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
