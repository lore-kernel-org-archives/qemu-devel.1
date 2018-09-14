Received: from eggs.gnu.org ([2001:4830:134:3::10]:44217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0ozN-0000wi-O9
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0ozJ-00060z-CE
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:22:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g0ozJ-0005zf-3c
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:22:25 -0400
References: <CAB3eZfv6QFAABhzxCKjVY_36j9th_3sbcbzaOQTGkm0mhJ-BoQ@mail.gmail.com>
	<314d0a84-c0b5-3bbb-168d-360f5027a913@redhat.com>
	<CAB3eZfsXekOx=rE_8dj59MUc9Qf5+37_iPzPq7wWHsCpuSjTNQ@mail.gmail.com>
	<cd6350f4-d8b9-217e-fcb6-19b84f4ad7c9@redhat.com>
	<CAB3eZfubzAKOnuJKOvBFHb7qvTau7iOKfMZa83xirV50itDCtQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <54a315e2-4216-2929-e65b-18a62f6fddee@redhat.com>
Date: Fri, 14 Sep 2018 09:22:23 -0500
MIME-Version: 1.0
In-Reply-To: <CAB3eZfubzAKOnuJKOvBFHb7qvTau7iOKfMZa83xirV50itDCtQ@mail.gmail.com>
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

On 9/13/18 10:58 PM, lampahome wrote:
> In general case, what's difference between internal and external snapshot?

You may find my KVM forum presentation from 2015 useful:
http://events17.linuxfoundation.org/sites/events/files/slides/2015-qcow2-expanded.pdf

Internal snapshots use reference counting to share clusters between the 
snapshot and the live image; reads are always from a cluster in the 
current image, and writing to a shared cluster decreases the refcount on 
the existing cluster and writes the new data to a new cluster (using 
copy-on-write to widen any short writes up to cluster boundaries with 
the rest of the cluster populated from the shared cluster).  External 
snapshots use sparse allocation, where writes always go to the current 
image (using copy-on-write to widen any short writes up to cluster 
boundaries with the rest of the cluster populated from the backing 
file), and reads defer to the backing image if the cluster is not 
present in the current image.  There are slight differences in the 
amount of overall qcow2 metadata stored for the two approaches, but in 
general, if your original image has 1G data allocated, then you create 
the snapshot (either internally or externally), then the guest writes 
512M more all to regions of the storage that were used prior to the 
snapshot, then the overall storage used by either approach is 
approximately 1.5G.  Reverting to an internal snapshot is a matter of 
switching which L1/L2 tables are active.  Reverting to an external 
snapshot is going back to the file that became the backing file at the 
time you created the new overlay.

> I mean in some user situation.

There a pros and cons to both approaches, but my personal take is that 
there are more benefits for using external snapshots, especially if you 
want quick answers from the list in supporting particular issues you 
might encounter.

> 
> Ex: If I want to all snapshots in only one qcow2, I should use internal
> snapshot.

If your file is big enough for that, then yes, that's one reason to use 
internal snapshots. But in your other email, you're already mentioning 
that you are already having issues with trying to host a 32T guest image 
in a single file - if you add internal snapshots to that file, the host 
storage consumption by that file can easily exceed the amount of storage 
visible to the guest through any one of those snapshots.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
