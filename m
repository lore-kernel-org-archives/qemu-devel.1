Received: from eggs.gnu.org ([2001:4830:134:3::10]:36855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0V3p-00038T-Ch
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0V3n-0003e1-R1
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:05:45 -0400
References: <CAB3eZfsvnyyo0C4nU=Mucg51krnN9Q9ExKA0t4AEEA3DiOd2aA@mail.gmail.com>
	<ce6e31f1-0190-89ea-3aae-90ccdf81c585@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f7c8ab1d-c752-29ce-bcd1-64a5598a41b4@redhat.com>
Date: Thu, 13 Sep 2018 12:05:36 -0500
MIME-Version: 1.0
In-Reply-To: <ce6e31f1-0190-89ea-3aae-90ccdf81c585@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Can I only commit from active image to
 corresponding range of its backing file by qemu cmd?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, lampahome <pahome.chen@mirlab.org>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>

[adding Markus, because of an interesting observation about --image-opts 
vs. JSON null - search for [1] below]

On 9/13/18 8:22 AM, Max Reitz wrote:
> On 13.09.18 05:33, lampahome wrote:
>> I split data to 3 chunks and save it in 3 independent backing files like
>> below:
>> img.000 <-- img.001 <-- img.002
>> img.000 is the backing file of img.001 and 001 is the backing file of 002.
>> img.000 saves the 1st chunk of data and img.001 saves the 2nd chunk of
>> data, and img.002 saves the 3rd chunk of data.

How have you ensured that these three files are visiting different 
ranges of guest data?

It sounds like you are trying to keep the sizes of .000, .001, and .002 
constant, but updating their respective contents.  Rather unusual, but 
not necessarily a bad idea.

>>
>> Now I have img.003 stores cow data of 1st chunk and img.002 is the backing
>> file of img.003.
>> The backing chain is like this:
>>    img.000 <-- img.001 <-- img.002 <-- img.003
>>
>> So that means the data of img.003 saves the same range with img.000 but
>> different data.
>>
>> I know I can use *`qemu-img commit'* but it only commit the data from
>> img.003 to img.002.

Which, if the guest range covered by .000 and .002 are originally 
distinct, makes .002 grow in size for any changes that .003 has made 
relative to .000 or .001, rather than writing to the respective backing 
file.

>>
>> If I use *`qemu-img rebase -b img.000 img.003`*, the data of img.001 and
>> img.002 will merge into img.003.

Which makes .000 grow in size, because you didn't limit how much of .003 
gets committed.  But maybe it's possible to use the 'offset' and 'size' 
parameters to the raw format driver to make qemu-img see only a subset 
of img.003, at which point committing just that subset is easier.  Hmm - 
it might work for img.000, but not so easily for img.001 or img.002, 
because we don't have a clean way to copy from one source offset to a 
different destination offset.  Last month, I proposed a patch to enhance 
'qemu-img dd' to do that - but the argument was that 'qemu-img convert' 
should also be able to do it, with 'qemu-img dd' being a thin veneer 
over convert rather than doing everything itself, so there's still work 
to be done.

>>
>> What I want is only commit the data in img.003 into img.000 because the
>> data of the two image are the same range(1st chunk)
>>
>> Is there anyway to commit(or merge) data of active image into corresponding
>> backing file?
> 
> So img.000, img.001, and img.002 all contain data at completely
> different areas, and img.003 only contains data where img.000 contains
> data as well?
> 
> Say like so:
> 
> $ qemu-img create -f qcow2 img.000 3M
> $ qemu-img create -f qcow2 -b img.000 img.001
> $ qemu-img create -f qcow2 -b img.001 img.002
> $ qemu-img create -f qcow2 -b img.002 img.003

Missing -F qcow2 in those last three lines (you should always specify 
the backing format in the qcow2 metadata, otherwise you are setting 
yourself up for failures because probing is unsafe)

> $ qemu-io -c 'write -P 1 0M 1M' img.000
> $ qemu-io -c 'write -P 2 1M 1M' img.001
> $ qemu-io -c 'write -P 3 2M 1M' img.002
> $ qemu-io -c 'write -P 4 0M 1M' img.003

I'd modify this example to use:
  qemu-io -c 'write -P 4 0M 512k' -c 'write -P 4 1m 512k' \
    -c 'write -P 4 2m 512k' img.003

so that it becomes easier to see if we are ever committing more than 
desired.

> 
> (img.000 contains 1s from 0M to 1M;
>   img.001 contains 2s from 1M to 2M;
>   img.002 contains 3s from 2M to 3M;
>   img.003 contains 4s from 0M to 1M (the range of img.000))

Or, visually, with my tweak to img.003,

img.000     11----
img.001     --22--
img.002     ----33
img.003     4-4-4-
guest sees  414243

and your goal, if I'm understanding, is to do range-based commits so 
that you end up with:

img.000     41----
img.001     --42--
img.002     ----43
img.003     ------
guest sees  414243

> 
> In that case, rebase -u might be what you want, so the following should
> work (although it can easily corrupt your data if it isn't the case[1]):
> 
> $ qemu-img rebase -u -b img.000 img.003
> $ qemu-img commit img.003

No, that still copies anything that img.003 has changed from .001 or 
.002 into .000, making .000 grow in size (that is, your approach changed 
img.000 to read 41-4-4-).  If you can view just a subset of img.003, 
then you CAN commit just that subset into img.000 (but not into .001 or 
.002, because we don't yet have 'qemu-img commit --target-image-opts' to 
specify the 'offset=' argument to the raw driver).  So here's what I tried:

$ qemu-io -c 'r -P 4 0 512k' -c 'r -P 1 512k 512k' -c map --image-opts 
driver=raw,size=1m,file.driver=qcow2,file.file.driver=file,file.file.filename=img.003
read 524288/524288 bytes at offset 0
512 KiB, 1 ops; 0.0002 sec (1.719 GiB/sec and 3521.1268 ops/sec)
read 524288/524288 bytes at offset 524288
512 KiB, 1 ops; 0.0004 sec (1.218 GiB/sec and 2493.7656 ops/sec)
512 KiB (0x80000) bytes     allocated at offset 0 bytes (0x0)
512 KiB (0x80000) bytes not allocated at offset 512 KiB (0x80000)

Yep - that fancy --image-opts syntax let us use a raw wrapper around 
qcow2 to see just the first 1M of image.003.  Now:

$ qemu-img commit --image-opts -b img.000 
driver=raw,size=1m,file.driver=qcow2,file.file.driver=file,file.file.filename=img.003
qemu-img: Did not find 'img.000' in the backing chain of 
'driver=raw,size=1m,file.driver=qcow2,file.file.driver=file,file.file.filename=img.003'

Alas, since 'raw' does not have backing files on its own, qemu-img 
commit refuses to do anything (it will only commit into a known backing 
chain).  I know Max has a proposed series to make filters behave more 
sanely (so that the backing file of an original node is also seen to be 
the backing file of a filter node), but I don't know if that would 
completely help here (the fact that the raw format node is being used 
more as a filter is a bit different from normally using it as a format 
driver - maybe we want size/offset limitations to be an actual filter 
node, separate from the raw format driver?).

But I'm not giving up just yet - we can use qemu-img convert to create a 
temporary file that contains only the data we want committed:

$ qemu-img convert -O qcow2 -B img.000 --image-opts 
driver=raw,size=1m,file.driver=qcow2,file.file.driver=file,file.file.filename=img.003 
img.004

achieving:

img.000     11----
img.001     --22--
img.002     ----33
img.003     4-4-4-
guest sees  414243
img.004     4-

and now commit that:

$ qemu-img commit img.004

and double-check what img.000 now contains:

$ qemu-io -c 'r -P 4 0 512k' -c 'r -P 1 512k 512k' img.000
read 524288/524288 bytes at offset 0
512 KiB, 1 ops; 0.0001 sec (2.872 GiB/sec and 5882.3529 ops/sec)
read 524288/524288 bytes at offset 524288
512 KiB, 1 ops; 0.0002 sec (2.078 GiB/sec and 4255.3191 ops/sec)

so now we have achieved:

img.000     41----
img.001     --22--
img.002     ----33
img.003     4-4-4-
guest sees  414243
img.004     --

Which is not quite our end goal - we have not yet freed the storage in 
img.003, AND img.004 is still wasting storage space. We can delete 
img.004 now, but I know of no way to force img.003 to deallocate those 
clusters.  Attempting:

[1]
$ qemu-io -c 'discard 0 1m' --image-opts 
driver=qcow2,backing=,file.driver=file,file.filename=img.003
warning: Use of "backing": "" is deprecated; use "backing": null instead
discard 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0002 sec (4.399 GiB/sec and 4504.5045 ops/sec)

doesn't work, as 'discard' causes img.003 to now make things read as 
zero rather than deferring to the backing chain, even though I 
specifically told qemu to operate as if img.003 has no backing image 
(although it DOES reduce the disk space occupied by img.003, although 
not the file size - compare 'ls -l' and 'du' output before and after the 
attempt - which means the 'discard' DID end up punching a hole in the 
host file).

Also, that warning message is annoying.  We can't spell 'backing=null' 
because that tries to find a node named "null"; to avoid it, we'd have 
to support using --image-opts with JSON on the command line instead of 
dotted names, as in:

$ qemu-io -c 'discard 0 1m' --image-opts '{"driver":"qcow2", 
"backing":null, "file":{"driver":"file", "filename":"img.003"}}'

except THAT doesn't work yet (we haven't converted all our command line 
arguments to taking JSON yet). (end [1])

I guess I can avoid the warning message by using multiple steps for 
temporarily having no backing file:

$ qemu-img rebase -u -b '' img.003
$ qemu-io -c 'discard 0 1m' img.003
discard 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0002 sec (4.811 GiB/sec and 4926.1084 ops/sec)
$ qemu-img rebase -u -F qcow2 -b img.002 img.003

But whether I use the one-liner with --image-opts or the multi-step with 
explicit 'rebase -u'  I've botched things, because now I have:

img.000     41----
img.001     --22--
img.002     ----33
img.003     z-4-4-
guest sees  014243

To restore things back for further playing around, do
$ qemu-io -c 'w -P 4 0 512k' img.003

Hmm, another idea:
$ qemu-img rebase -f qcow2 -b img.002 -F qcow2 img.003

Nope, doesn't work - it doesn't do deduplication by removing clusters in 
img.003 that are identical to the clusters in the underlying backing 
chain (img.003 still contains '4-4-4-' instead of the desired '--4-4-'). 
So that sounds like yet another missing feature to add later.

> 
> (And then maybe
> $ qemu-img rebase -u -b img.002 img.003
> to return to the previous backing chain.)
> 
> Max
> 
> 
> [1] It will corrupt your data if img.001 or img.002 contain any data
> where img.003 also contains data; because then that data of img.003 will
> be hidden when viewed through img.001 and img.002.

Sorry - for all my experimenting, I could NOT find a reliable way to 
remove duplicated clusters out of img.003 once they were committed to 
img.000, nor a clean way to commit data from a subset of img.003 to the 
proper img.001 or img.002.  It is possible to manually use qemu-img map 
to learn which portions of img.003 should be copied, then use qemu-nbd 
to map both img.001 and img.003 to NBD devices, and use a series of dd 
commands to copy just those portions of the guest-visible data - but 
again, while that commits to the proper backing file, it does not 
discard the clusters from img.003.  Commit with "mode":"incremental" 
could be used to direct which portions of a file to commit, if you had 
an easy way to inject a bitmap describing that portion of the file, but 
we really don't have decent offline bitmap management via qemu-img yet.

So, while this thread has sparked some ideas for future improvements, 
the takeaway message for now is no, you really can't commit just a 
portion of one qcow2 image into another.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
