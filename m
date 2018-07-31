Received: from eggs.gnu.org ([2001:4830:134:3::10]:48795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkZKm-0003ri-59
	for Qemu-devel@nongnu.org; Tue, 31 Jul 2018 14:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkZKg-0002DZ-QW
	for Qemu-devel@nongnu.org; Tue, 31 Jul 2018 14:25:24 -0400
References: <20180731180033.GA1455@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e6627b0e-3939-7b4e-3482-6a6be49e6b58@redhat.com>
Date: Tue, 31 Jul 2018 13:25:16 -0500
MIME-Version: 1.0
In-Reply-To: <20180731180033.GA1455@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu NBD client behaviour when device size is not
 a multiple of 512
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, qemu-block <qemu-block@nongnu.org>, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>

On 07/31/2018 01:00 PM, Richard W.M. Jones wrote:
> 
> Hi Eric.  Is this a bug?
> 
>    $ nbdkit -fv random size=1023
> 
> (You can choose any size which is not a multiple of 512.)
> 
>    $ qemu-img convert nbd:localhost:10809 /var/tmp/test
>    qemu-img: error while reading sector 0: Invalid argument

Or more directly:

$ qemu-io -r -f raw --trace=nbd_\* nbd://localhost:10809
...
422833@1533060368.492178:nbd_receive_negotiate_size_flags Size is 1023, 
export flags 0x3
qemu-io> r -v 0 1023
422833@1533060426.523422:nbd_send_request Sending request to server: { 
.from = 0, .len = 1024, .handle = 94749973992480, .flags = 0x0, .type = 
0 (read) }
422833@1533060426.523632:nbd_receive_simple_reply Got simple reply: { 
.error = 22 (EINVAL), handle = 94749973992480 }
read failed: Invalid argument

Yep. Looks likes the client code is trying to enforce 512-byte 
alignment, and qemu rounds ALL disk sizes up to the next sector boundary 
(even when the actual disk is unaligned).  I'll have to patch things to 
not round past image end on the final partial sector.

Note that with qemu as server:

$ truncate --size=1023 file
$ qemu-nbd -f raw -x '' file

the client now sees:

423068@1533060754.229106:nbd_opt_go_info_block_size Block sizes are 
0x200, 0x1000, 0x2000000
...
423068@1533060754.229156:nbd_receive_negotiate_size_flags Size is 1024, 
export flags 0x1ed

where qemu as server is 0-padding the source file in all read requests; 
and that probably explains why I haven't noticed the problem with 
unaligned images in the client before (since qemu as NBD server doesn't 
advertise unaligned images).  What's more, a write request to the tail 
of the partial sector (when not using a read-only connection) succeeds, 
and resizes the file in the process (at least, on protocols that support 
live resizing); but I wouldn't count on it behaving sanely for all 
protocols.

What SHOULD happen is that if qemu as server advertises a block size, it 
should truncate the advertised image size DOWN (not round up).  I'm also 
not sure why qemu as server is advertising 512-byte blocks when backed 
by a file - it should be able to advertise 1-byte blocks.  Likewise, 
qemu as client should pay attention to the size advertised by the 
server: if it is not sector-aligned and the server did not advertise 
block size, then assume that byte alignment works; if the server DID 
advertise block size (greater than 1) then qemu should round the image 
size down (as obeying the advertised block size implies that the partial 
sector at the end is inaccessible without violating NBD protocol - 
although the NBD protocol also states that servers SHOULD advertise a 
size that is a multiple of the block size).

At any rate, you've given me plenty to work with for fixing things, 
although it probably won't make it into 3.0-rc3 and I don't know if 
we'll have an -rc4.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
