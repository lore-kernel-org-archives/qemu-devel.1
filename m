Received: from eggs.gnu.org ([2001:4830:134:3::10]:43689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fq8Bs-0002Uk-3M
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fq8Bo-0007A3-PN
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 22:39:09 -0400
References: <20180815025614.53588-1-eblake@redhat.com>
	<20180815025614.53588-3-eblake@redhat.com>
	<48010463-405e-bb08-f9c5-8263dcf3bb48@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4aa899d3-c622-6acf-128c-513f95c55ed5@redhat.com>
Date: Wed, 15 Aug 2018 21:39:02 -0500
MIME-Version: 1.0
In-Reply-To: <48010463-405e-bb08-f9c5-8263dcf3bb48@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: Add dd seek= option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: fullmanet@gmail.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On 08/15/2018 09:20 PM, Max Reitz wrote:
> On 2018-08-15 04:56, Eric Blake wrote:
>> For feature parity with dd, we want to be able to specify
>> the offset within the output file, just as we can specify
>> the offset for the input (in particular, this makes copying
>> a subset range of guest-visible bytes from one file to
>> another much easier).
> 
> In my opinion, we do not want feature parity with dd.  What we do want
> is feature parity with convert.

Well, convert is lacking a way to specify a subset of one file to move 
to a (possibly different) subset of the other.  I'm fine if we want to 
enhance convert to do the things that right now require a dd-alike 
interface (namely, limiting the copying to less than the full file, and 
choosing the offset at which to start [before this patch] or write to 
[with this patch]).

If convert were more powerful, I'd be fine dropping 'qemu-img dd' after 
a proper deprecation period.

> 
>> The code style for 'qemu-img dd' was pretty hard to read;
>> unfortunately this patch focuses only on adding the new
>> feature in the existing style rather than trying to improve
>> the overall flow, other than switching octal constants to
>> hex.  Oh well.
> 
> No, the real issue is that dd is still not implemented just as a
> frontend to convert.  Which it should be.  I'm not sure dd was a very
> good idea from the start, and now it should ideally be a frontend to
> convert.
> 
> (My full opinion on the matter: dd has a horrible interface.  I don't
> quite see why we replicated that inside qemu-img.  Also, if you want to
> use dd, why not use qemu-nbd + Linux nbd device + real dd?)

Because of performance: qemu-nbd + Linux nbd device + real dd is one 
more layer of data copying (each write() from dd goes to kernel, then is 
sent to qemu-nbd in userspace as a socket message before being sent back 
to the kernel to actually write() to the final destination) compared to 
just doing it all in one process (write() lands in the final destination 
with no further user space bouncing).  And because the additional steps 
to set it up are awkward (see my other email where I rant about losing 
the better part of today to realizing that 'dd ...; qemu-nbd -d 
/dev/nbd1' loses data if you omit conv=fdatasync).

> 
> ((That gave me a good idea.  Actually, it's probably not such a good
> idea, but I guess I'll do it in my spare time anyway.  A qemu-img fuse
> might be nice which represents an image as a raw image at some mount
> point.  Benefits over qemu-nbd: (1) You don't need root, (2) you don't
> need to type modprobe nbd.))

So the kernel->userspace translation would be happening via the FUSE 
interface instead of the NBD interface.  Data still bounces around just 
as much, but it might be a fun project.  Does fuse behave well when 
serving exactly one file at the mountpoint, rather than the more typical 
file system rooted in a directory?  NBD at least has the benefit of 
claiming to be a block device all along, rather than complicating the 
user interface with POSIX file system rules (which you'll be bending, 
because you are serving exactly one file instead of a system).

> 
>> Also, switch the test to use an offset of 0 instead of 1,
>> to test skip= and seek= on their own; as it is, this is
>> effectively quadrupling the test runtime, which starts
>> to make this test borderline on whether it should still
>> belong to './check -g quick'.  And I didn't bother to
>> reindent the test shell code for the new nested loop.
> 
> In my opinion, it should no longer belong to quick.  It takes 8 s on my
> tmpfs.  My border is somewhere around 2 or 3; and I haven't yet decided
> whether that's on tmpfs or SSD.

I took 4 iterations pre-patch, to 8 iterations after patch 1, to 32 
iterations with this patch; my observed times went from 1s to 2s to 7s 
on SSD ext4. Yeah, for v2, I'll drop it from quick.

>> @@ -4574,7 +4592,14 @@ static int img_dd(int argc, char **argv)
>>           size = dd.count * in.bsz;
>>       }
>>
>> -    qemu_opt_set_number(opts, BLOCK_OPT_SIZE, size, &error_abort);
>> +    if (dd.flags & C_SEEK && out.offset * out.bsz > INT64_MAX - size) {
> 
> What about overflows in out.offset * out.bsz?

I've had enough of my eyes bleeding on all the code repeatedly scaling 
things. For v2, I'm strongly considering a cleanup patch that reads all 
input, then scales all values into bytes, and THEN performs any 
additional math in a single unit, just so the additions become easier to 
reason about.

> 
>> +        error_report("Seek too large for '%s'", out.filename);
>> +        ret = -1;
>> +        goto out;
> 
> Real dd doesn't seem to error out (it just reports an error).  I don't
> know whether that makes any difference, though.

But where does the data get written if you can't actually seek that far 
into the file?

> 
> The test looks good to me.

Other than my creative indentation levels ;)

> 
> Max
> 
>> +    }
>> +    seek = out.offset * out.bsz;
>> +
>> +    qemu_opt_set_number(opts, BLOCK_OPT_SIZE, size + seek, &error_abort);
>>       end = size + in_pos;
>>
>>       ret = bdrv_create(drv, out.filename, opts, &local_err);
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
