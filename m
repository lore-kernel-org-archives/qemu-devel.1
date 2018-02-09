Received: from eggs.gnu.org ([2001:4830:134:3::10]:57794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ekCw2-0002BS-VZ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:58:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ekCvz-0001kJ-St
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:58:07 -0500
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:46110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ekCvz-0001jR-HB
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:58:03 -0500
Received: from player758.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id D78F9195803
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 18:58:01 +0100 (CET)
Date: Fri, 9 Feb 2018 18:57:49 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180209185749.7ecbd272@bahia.lan>
In-Reply-To: <3c73d37f-36f6-e487-7add-34c18310bda7@redhat.com>
References: <20180208180019.13683-1-antonios.motakis@huawei.com>
	<20180208180019.13683-4-antonios.motakis@huawei.com>
	<20180209161326.653f3468@bahia.lan>
	<3c73d37f-36f6-e487-7add-34c18310bda7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] 9pfs: stat_to_qid: use device as input
 to qid.path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: antonios.motakis@huawei.com, qemu-devel@nongnu.org, veaceslav.falico@huawei.com, Eduard.Shishkin@huawei.com, andy.wangguoli@huawei.com, Jani.Kokkonen@huawei.com, cota@braap.org, berrange@redhat.com

On Fri, 9 Feb 2018 10:06:05 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 02/09/2018 09:13 AM, Greg Kurz wrote:
> > On Thu, 8 Feb 2018 19:00:18 +0100
> > <antonios.motakis@huawei.com> wrote:
> >   
> >> From: Antonios Motakis <antonios.motakis@huawei.com>
> >>
> >> To support multiple devices on the 9p share, and avoid
> >> qid path collisions we take the device id as input
> >> to generate a unique QID path. The lowest 48 bits of
> >> the path will be set equal to the file inode, and the
> >> top bits will be uniquely assigned based on the top
> >> 16 bits of the inode and the device id.  
> 
> >> +/* stat_to_qid needs to map inode number (64 bits) and device id (32 bits)
> >> + * to a unique QID path (64 bits). To avoid having to map and keep track
> >> + * of up to 2^64 objects, we map only the 16 highest bits of the inode plus
> >> + * the device id to the 16 highest bits of the QID path. The 48 lowest bits
> >> + * of the QID path equal to the lowest bits of the inode number.
> >> + *
> >> + * This takes advantage of the fact that inode number are usually not
> >> + * random but allocated sequentially, so we have fewer items to keep
> >> + * track of.
> >> + */
> >> +static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
> >> +                                uint64_t *path)
> >> +{
> >> +    QppEntry lookup = {
> >> +        .dev = stbuf->st_dev,
> >> +        .ino_prefix = (uint16_t) (stbuf->st_ino >> 48)
> >> +    }, *val;
> >> +    uint32_t hash = qpp_hash(lookup);
> >> +
> >> +    val = qht_lookup(&pdu->s->qpp_table, qpp_lookup_func, &lookup, hash);
> >> +
> >> +    if (!val) {
> >> +        if (pdu->s->qp_prefix_next == 0) {
> >> +            /* we ran out of prefixes */
> >> +            return -ENFILE;  
> > 
> > Not sure this errno would make sense for guest syscalls that don't open
> > file descriptors... Maybe ENOENT ?
> > 
> > Cc'ing Eric for insights.  
> 
> Actually, it makes sense to me:
> 
> ENFILE 23 Too many open files in system
> 
> You only get here if the hash table filled up, which means there are 
> indeed too many open files (even if this syscall wasn't opening a file). 
>   In fact, ENFILE is usually associated with running into ulimit 
> restrictions, and come to think of it, you are more likely to hit your 
> ulimit than you are to run into a hash collision (so this code may be 
> very hard to reach in practice, but if you do reach it, it behaves 
> similarly to what you were more likely to hit in the first place).
> 
> ENOENT implies the file doesn't exist - but here, the file exists but we 
> can't open it because we're out of resources for tracking it.
> 

Only the host knows that the file exists actually. If stat_to_qid() for
this path returns ENOENT, then the file shouldn't be visible in the
guest.

I say "shouldn't" instead of "isn't" because I now realize that
v9fs_do_readdir(), which is used to implement getdents() in the
guest, sends a degraded QID, hand-crafted without calling
stat_to_qid() at all... :-\

        /*
         * Fill up just the path field of qid because the client uses
         * only that. To fill the entire qid structure we will have
         * to stat each dirent found, which is expensive
         */
        size = MIN(sizeof(dent->d_ino), sizeof(qid.path));
        memcpy(&qid.path, &dent->d_ino, size);
        /* Fill the other fields with dummy values */
        qid.type = 0;
        qid.version = 0;


Antonios, your patchset should probably also address this.

The problem is that the dirent we get from v9fs_co_readdir()
only has the inode number, so I guess we must build a dummy
struct stat with:

    stbuf.st_ino = dent->d_ino
    stbuf.st_dev = st_dev of the parent directory

The st_dev of the parent directory could be obtained in
v9fs_readdir() and passed to v9fs_do_readdir(). Another
solution could be to cache the QID in the V9fsFidState
of the parent directory when it is open.

Also, if we hit a collision while reading the directory, I'm
afraid the remaining entries won't be read at all. I'm not
sure this is really what we want.

> Also, POSIX permits returning specific errno codes that aren't otherwise 
> listed for a syscall if the usual semantics of that errno code are 
> indeed the reason for the failure (you should prefer to fail with errno 
> codes documented by POSIX where possible, but POSIX does not limit you 
> to just that set).
> 

Ok, then ENFILE wouldn't be that bad in the end. 

Thanks for your POSIX expertise :)

Cheers,

--
Greg
