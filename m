Received: from eggs.gnu.org ([2001:4830:134:3::10]:53030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0pOW-0001zy-PN
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0pOU-00064G-Qy
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:48:28 -0400
References: <CAB3eZfsvnyyo0C4nU=Mucg51krnN9Q9ExKA0t4AEEA3DiOd2aA@mail.gmail.com>
	<ce6e31f1-0190-89ea-3aae-90ccdf81c585@redhat.com>
	<f7c8ab1d-c752-29ce-bcd1-64a5598a41b4@redhat.com>
	<56133002-7a79-bf6a-8835-fba043638224@redhat.com>
	<31456c31-7a74-7df2-40d3-2a5841f39996@redhat.com>
	<9af35c5f-1d84-c336-a565-c2e1acb8704e@redhat.com>
	<CAB3eZfu6gM-ikoW7C=Ce82kMVO1OFdU_RXaUxpKm0bqYAL=o-w@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <92a1b736-422c-1878-98bf-fab68aa7ef3e@redhat.com>
Date: Fri, 14 Sep 2018 09:48:04 -0500
MIME-Version: 1.0
In-Reply-To: <CAB3eZfu6gM-ikoW7C=Ce82kMVO1OFdU_RXaUxpKm0bqYAL=o-w@mail.gmail.com>
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
To: lampahome <pahome.chen@mirlab.org>, Max Reitz <mreitz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 9/13/18 9:19 PM, lampahome wrote:
> Sorry, I need to explain what case I want to do
> 
> Todo: I want to *backup a block device into qcow2 format image.*
> I met a problem which is the *file size limit of filesystem* ex: Max is
> 16TB for any file in ext4, but the block device maybe 32TB or more.
> 
> I figure out one way is to *divide data of device into 1TB chunk* and save
> every chunk into qcow2 image cuz I don't change filesystem, and  connect
> with backing chain.

A better way would be to use a different filesystem that does not have 
those limits, or even better to just directly use a raw block device 
with the size you need instead of worrying about storing a file system 
on top of the block device just to introduce artificial size limitations 
into the mix.  LVM is great for that.

> *(That's what I said range is different)*
> Ex: 1st chunk of device will save into image.000
> 2nd chunk of device will save into image.001
> Nth chunk of device will save into image.(N-1)
> ...etc
> 
> I can see all block device data when I mount image.(N-1) by qemu-nbd cuz
> the chunk doesn't overlap and all chunks connect by backing chain.

How exactly did you create those images?  I'm trying to verify the steps 
you used to split the image. I know the concept of the split, but 
without seeing actual commands used, I don't know that you actually 
accomplished the split in the manner desired.  (It's okay if a 
reproduction uses smaller scales for speed, such as splitting a 32M 
image across 1M qcow2 files - the point remains that seeing the actual 
steps used may offer additional insights into your usage scenario).

Or are you trying to ask if it is possible to create such a fragmented 
design with current tools?  (The answer that we've given you is that no, 
it is not easy to do, because no one has needed it so far).  There's no 
way to tell a running qemu that writes to offsets 0-1M go into one file, 
while writes to offsets 1M to 2M go into another - ALL writes go into 
the currently active layer, regardless of the offset represented by the 
write.

It would be possible to come up with a new driver (or to add yet another 
mode to the existing quorum driver) that DOES allow runtime 
concatenation of multiple subsidiary devices, in order to present a 
linear view of those images as a single guest device.  To an extent, 
that's what 'qemu-img convert image1 image2 imageout' is doing, except 
that qemu-img is doing it via manual hacks, rather than something baked 
into the internal qemu block layer (we'd need it in the qemu block layer 
for it to work with a running guest with random access, rather than just 
a one-time conversion pass).  But no one has submitted patches for that yet.

> 
> Now I want to do next thing: *Incremental backup*
> When I modify data of 1st chunk, what I thought is to write new 1st chunk
> to new image *image.N* and let *imgae.(N-1)* be the backing file of
> *image.N* .
> That's cuz I want to store the data before modified to roll back anytime.

Qemu DOES support incremental backups via persistent bitmaps coupled 
with NBD exports.  See 
https://bugzilla.redhat.com/show_bug.cgi?id=1207657#c27 for a 
demonstration of all the steps involved, but it is quite possible to 
create an NBD export of a point-in-time incremental of a running guest, 
where you can then query over NBD which portions of the backup represent 
deltas from your earlier point in time (by using a bitmap to track which 
clusters were written from the earlier point in time), and where you can 
read the data from NBD in ANY manner you see fit (including reading 
dirty clusters from 0-1M to write into backup file .000, reading dirty 
clusters from 1M-2M to write into backup file .001, and so on).  So if 
you want to split your backing file into ranges (which I already 
questioned as to how you plan to do that, given that the subsequent 
writes are not split), you can at least create incremental backups that 
are also split.

> 
> So now I have two *version of block device(like concept of snapshot)*:
> One is image.000 to image.(N-1). I can access the data before modify by
> mount image.(N-1) through qemu-nbd
> The other one is image.000 to image.N.  I can access the data after modify
> by mount image.N through qemu-nbd(cuz the visible 1st chunk are in the
> image.N)
> 
> Consider about the situation:
> 000   A - - - - - - - -  <<<<<---  store the 1st chunk of block device
> 001   - B - - - - - - -
> 002   - - C - - - - - - (1st state of block device)
> 003   A' - - - - - - - - <<<<<--- store the 1st chunk of block device, but
> data is different
> 004   - - - D - - - - - (2nd state of block device)
> 005   - - - - E - - - -  (3rd state of block device)
> 
> The original problem is If I want to remove the 2nd state(003 and 004) but
> I need to keep the data of 003 and 004.
> If I just commit 003, the A' of 003 must be committed into 002 cuz 002 is
> the backing file of 003.
> I try to figure out some way to let it only commit from 003 into 000.
> 

I'm not quite following your diagram. My naive read (probably wrong) is 
that you are trying to present a 9M image (scaled M to G or T as 
appropriate) to the guest, as represented by the 9 characters, but that 
the initial image only populated 3M of the 9 with guest-visible contents 
represented by ABC------.  So you want to split that into files 000 
containing offsets 0-1M (A--------), 001 containing offsets 1M-2M 
(-B-------), and 002 containing offsets 2M-3M (--C------).  Then you 
want to run the guest, which does some modifications in offsets 0-1M 
(I'll write it as "a" instead of "A'", you could also have chosen a 
different letter except that your example already uses "D" elsewhere), 
so the guest now sees (aBC------), and you want to store that 
incremental backup in file 003, containing just (a--------).  But that's 
where I got confused - my original assumption was that 003 represented 
offsets 3M-4M (---X-----), but you are now showing it as representing 
offsets 0-1M.  It's also not clear which files in your list have which 
other files as backing files.

So, since I got confused, it may help if you spend more time giving even 
more details diagramming your data splits, with exact filenames that you 
are trying to manipulate, over multiple points in time.

Or, if you really do want to use the quorum block driver to implement a 
new block driver that concatenates multiple subsidiary drivers into a 
linear range, then it would indeed become possible to direct writes into 
a specific file.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
