Received: from eggs.gnu.org ([2001:4830:134:3::10]:45277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvGvf-0000US-Bt
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 01:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvGve-0007b4-8C
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 01:55:11 -0400
Date: Fri, 22 Sep 2017 13:54:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170922055459.GG1397@lemon.lan>
References: <20170914144032.14945-1-eblake@redhat.com>
	<20170914144032.14945-4-eblake@redhat.com>
	<20170920095711.GA4058@lemon.lan>
	<0c239541-da93-33d0-1c0e-88e29de89e2c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c239541-da93-33d0-1c0e-88e29de89e2c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/20] file-posix: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed, 09/20 08:47, Eric Blake wrote:
> On 09/20/2017 04:57 AM, Fam Zheng wrote:
> > On Thu, 09/14 09:40, Eric Blake wrote:
> >> We are gradually moving away from sector-based interfaces, towards
> >> byte-based.  Update the file protocol driver accordingly.  In mapping
> >> mode, note that the entire file is reported as allocated, so we can
> >> take a shortcut and skip lseek().
> >>
> >> Signed-off-by: Eric Blake <eblake@redhat.com>
> >>
> 
> >>
> >> -    ret = find_allocation(bs, start, &data, &hole);
> >> +    if (!mapping) {
> >> +        *pnum = bytes;
> >> +        *file = bs;
> >> +        return BDRV_BLOCK_DATA | BDRV_BLOCK_OFFSET_VALID |
> >> +            (offset & BDRV_BLOCK_OFFSET_MASK);
> >> +    }
> > 
> > I may be missing something, because the last time I tried to understand the
> > rationale behind "mapping" was already some time ago: shouldn't we still
> > distinguish hole and data? What will omitting BDRV_BLOCK_ZERO help?
> 
> Hmm, the commit message is slightly off (in part, because I switched the
> sense of the bool flag between series revisions, but did not properly
> update the commit text to match).  In mapping mode, we want to return as
> much information as possible (the client is something like 'qemu-img
> map'), including where the holes lie.  But when we are NOT in mapping
> mode, we care more about learning which portions of the file are
> described in the current layer of the backing chain, rather than
> delegating to another layer, regardless of whether the read will see
> data or zeroes.  By the time we are at the POSIX file protocol layer, we
> know that every byte in the file system/block device has a 1:1 mapping
> to the bytes that the guest will read (we do not delegate to any backing
> file), so we can simply report the entire remainder of the file as
> allocated without worrying about holes.

Thanks, it would be good if this explanation can be added to the comment of
"mapping" parameter, so it's easy to understand the actual intention in the
future.

> 
> Here's where the mapping flag was added and semantics documented (in
> series 3; whereas the current email is series 4):
> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg03542.html
> 
> So what I really need to do is fix the commit message to read:
> 
> In mapping mode, we must report as much information as possible about
> where holes can be found; but when we don't care about mapping, the user
> is more interested in how much of the guest view will come from the
> current layer rather than delegating to some other BDS, and we can take
> the shortcut that all of the remainder of the file fits that
> description, and therefore take a shortcut and skip lseek() for a larger
> *pnum result.
> 
> (the same comment probably applies to several other patches in the series)
> 

Fam
