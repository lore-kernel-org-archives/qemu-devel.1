Received: from eggs.gnu.org ([2001:4830:134:3::10]:44820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fs9TI-0001IF-U4
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 12:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fs9TD-0001vT-LL
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 12:25:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fs9TA-0001st-Mo
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 12:25:27 -0400
References: <CAB3eZfu33DhKCvPBhd6CKb7XVRG9XnxDoOSXGTwQqnORCu06ZA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3c25b8a2-97d1-1868-7577-9f06f93c5607@redhat.com>
Date: Tue, 21 Aug 2018 11:25:21 -0500
MIME-Version: 1.0
In-Reply-To: <CAB3eZfu33DhKCvPBhd6CKb7XVRG9XnxDoOSXGTwQqnORCu06ZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] What does VM SIZE means when entering qemu-img
 info xx.qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lampahome <pahome.chen@mirlab.org>, QEMU Developers <qemu-devel@nongnu.org>

On 08/21/2018 02:44 AM, lampahome wrote:
> I have an qcow2 image and I mount it to /dev/nbd then write somethin.
> 
> Then I take internal snapshot in the qcow2.
> 
> I enter the command qemu-img info qcow2
> It shows:
> image: qcow2
> file format: qcow2
> virtual size: 30G
> disk size:4M
> xxxxx
> Snapshot list:
> ID, TAG, VM SIZE, DATE, VM CLOCK
> 1, snap1, 0, xxxx-xx-xx, 00:00:00
> 
> The field of "VM SIZE" is zero in my host machine.
> What does it mean and why is it an zero?

That field tracks how much space is occupied in the image by the machine 
state (RAM contents and device state) when using the HMP command on a 
running qemu instance to take a live snapshot.  But when you use 
'qemu-img snapshot -c' on an offline image, there is no machine state to 
be saved, so the field will always be 0 in that case.

Or, more officially, read docs/interop/qcow2.txt:

         32 - 35:    Size of the VM state in bytes. 0 if no VM state is 
saved.
                     If there is VM state, it starts at the first cluster
                     described by first L1 table entry that doesn't 
describe a
                     regular guest cluster (i.e. VM state is stored like 
guest
                     disk content, except that it is stored at offsets 
that are
                     larger than the virtual disk presented to the guest)


(And don't try to use qemu-img snapshot -c while there is a qemu process 
running the live guest, as you are liable to cause data corruption with 
two simultaneous writers.  Modern qemu should prevent you from 
attempting that due to file locking permission checks, but older qemu 
would happily let you shoot yourself in the foot - in fact, this is one 
of the reasons we added file locking permission checks)

That said, internal snapshots are not necessarily well-tested and 
well-supported - there are some performance drawbacks with using live 
internal snapshots (among other things, the guest is nonresponsive for 
the length of time it takes to migrate the guest state into the qcow2 
file, which can definitely be noticeable; and there have been bugs in 
the past where adding additional snapshots took additional time with 
quadratic growth patterns - while some of these things have been 
patched, it has not been a high priority, and you can't guarantee that 
such patches are backported to stable distros). Even internal snapshots 
taken while offline do not play nicely with backing chains between 
multiple files, where a lack of current sanity checking in qemu means it 
can be easy to corrupt your guest-visible state if you are not careful.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
