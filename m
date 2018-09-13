Received: from eggs.gnu.org ([2001:4830:134:3::10]:53385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0Stf-0002CB-60
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0StZ-0007fE-9N
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:47:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g0StZ-0007eo-3J
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:47:01 -0400
References: <CAB3eZfv6QFAABhzxCKjVY_36j9th_3sbcbzaOQTGkm0mhJ-BoQ@mail.gmail.com>
	<314d0a84-c0b5-3bbb-168d-360f5027a913@redhat.com>
	<CAB3eZfsXekOx=rE_8dj59MUc9Qf5+37_iPzPq7wWHsCpuSjTNQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cd6350f4-d8b9-217e-fcb6-19b84f4ad7c9@redhat.com>
Date: Thu, 13 Sep 2018 09:46:58 -0500
MIME-Version: 1.0
In-Reply-To: <CAB3eZfsXekOx=rE_8dj59MUc9Qf5+37_iPzPq7wWHsCpuSjTNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] What kind of situation to use internal or external
 snapshot?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lampahome <pahome.chen@mirlab.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9/12/18 8:33 PM, lampahome wrote:
>>
>> In general, we've spent more resources developing external snapshots. So
>> if you want the most support and the fastest response on resolving any
>> issues that you may encounter, external snapshots are the way to go.
>>
>>
> So internal snapshot is hard to use than external snapshot?

Ease of use is subjective; but in general, when more of the tooling has 
been optimized for external snapshots, you'll find that performing the 
same task using only internal snapshots may cause longer guest 
downtimes, less efficient host storage usage, or harder sequences of 
commands to manage, because no one has had a priority of providing 
patches to bring it up to par with external snapshots.

> Is that because external snapshot is easier to roll back to any snapshot?

Again, ease of use is subjective.  Actually, at the moment, if you use 
libvirt, it's easier to revert to an internal snapshot (a single libvirt 
command) than an external snapshot (where you have to manually rewrite 
domain XML), although work is being done to get libvirt to be able to 
roll back to external snapshots.  But that's more a problem of libvirt 
integration to qemu, and not something inherent to one or the other form 
of qcow2 snapshots.

There are other things, though, such as reading the contents of an 
external backing file while a guest is live, that have no counterpart 
with internal snapshots (we have not yet come up with a way to export 
the contents of an internal snapshot while the guest is running - you 
can only do it while the image with internal snapshots is offline).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
