Received: from eggs.gnu.org ([2001:4830:134:3::10]:60180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQZt7-0004zm-8k
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQZt6-0006PD-4c
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:58:13 -0400
References: <20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com> <20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606173140-mutt-send-email-mst@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <60c9b327-6503-0950-0720-3ccbb4637ad4@redhat.com>
Date: Wed, 6 Jun 2018 09:57:58 -0500
MIME-Version: 1.0
In-Reply-To: <20180606173140-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>, Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org

On 06/06/2018 09:43 AM, Michael S. Tsirkin wrote:
> On Wed, Jun 06, 2018 at 01:02:53PM +0200, Max Reitz wrote:
>> Yeah, but why make qcow2 that format?  That's what I completely fail to
>> understand.
> 
> Because why not? It's cheap to add it there and is much easier
> than teaching people about a new container format.

tar is not a new container format, but it is a new format to various 
toolchains - that said, if we popularize tar as the format for including 
a config file alongside a qcow2 image, it's not that hard to fix the 
stack to start passing that file around as the new preferred file type.

> 
> Eric Blake put it very well I think.  There are several things that
> several people would like to see addressed:
> 
> (1) A sensible list of guest visible aspects of the VM
>    preserving which across VM restarts we deem critical enough to support
>    starting guests.
>    At this point this includes at least architecture and machine type.

This part is true no matter where we store it. So as I see it, the 
question is now whether to store it in qcow2, or whether to store qcow2 
+ config in a tar file.

> 
> (2) A compact file format for serializing list (1)

tar files already serve this purpose (even if we don't like the current 
OVA specification for the config side, it at least proves that tar files 
are usable in this manner)

> 
> (3) Ability to store file (2) in a qcow2 image

As Dan pointed out, if we can FIRST popularize storing a config file + 
qcow2 in a tar file, THEN we can (for convenience) let qcow2 directly 
store the same config file, if it helps things (although if popularizing 
tar files works, we wouldn't need it in qcow2).

Maybe the step we want to take now is to add a new block driver to qemu 
that supports tar files including resize.  That is, where we currently do:

qcow2 -> posix file

we would instead popularize:

qcow2 -> tar driver -> posix file

where the tar driver takes care of finding the right subset within the 
overall tar file, AND makes it easy to resize (by updating tar metadata 
any time qcow2 wants to resize larger, and assuming qcow2 is the last 
member of the tar archive)

Perhaps we can even automate it so that the tar driver is automatically 
inserted even when not explicitly specified (after all, you can already 
start qemu by giving just the file name holding a qcow2 image, and qemu 
can figure out to use the qcow2 driver) - although we DO have to be 
careful of avoiding CVEs (probing image formats MUST NOT allow a guest 
to convert a raw image into something that qemu would treat as a tar, 
any more than it would misinterpret raw as qcow2)

> 
> 
> You are asking why store (2) in qcow2 image specifically. The answer is
> it's just one place where we can store it. The answer is we don't need
> to involve qemu-block at all for storing it in other places.

Then why start with qcow2? Let's start with tar files, and enhance 
qemu-block to make tar files containing qcow2 easier to use in qemu (and 
NOT with making qcow2 larger just to bypass tar files).

> 
> But for many people it will be handy to have it in the same file, and
> qcow2 is popular enough that many people will be well served if it's
> there.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
