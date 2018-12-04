Received: from eggs.gnu.org ([2001:4830:134:3::10]:46622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gU5HF-0000MN-10
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:37:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gU58V-0006Cm-EN
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:28:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:48191)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1gU58T-00068A-E8
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:28:51 -0500
Date: Tue, 4 Dec 2018 15:28:28 +0800
From: Yi Zhang <yi.z.zhang@linux.intel.com>
Message-ID: <20181204072827.GA74594@tiger-server>
References: <cover.1542699775.git.yi.z.zhang@linux.intel.com>
	<9619c036a6dc6cb4966f46d2405084f11666e14d.1542699775.git.yi.z.zhang@linux.intel.com>
	<982407816.37384656.1543482671950.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <982407816.37384656.1543482671950.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V5_resend 3/7] exec: switch
 qemu_ram_alloc_from_{file, fd} to the 'flags' parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, dan j williams <dan.j.williams@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, yu c zhang <yu.c.zhang@linux.intel.com>, imammedo@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com

On 2018-11-29 at 04:11:11 -0500, Pankaj Gupta wrote:
> 
> > 
> > As more flag parameters besides the existing 'share' are going to be
> > added to qemu_ram_alloc_from_{file,fd}(), let's swith 'share' to a
> > 'flags' parameters in advance, so as to ease the further additions.
> > 
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> > ---
> >  exec.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/exec.c b/exec.c
> > index 273f668..e92a7da 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -1810,6 +1810,7 @@ static void *file_ram_alloc(RAMBlock *block,
> >                              ram_addr_t memory,
> >                              int fd,
> >                              bool truncate,
> > +                            uint32_t flags,
> >                              Error **errp)
> >  {
> >      void *area;
> > @@ -1859,7 +1860,7 @@ static void *file_ram_alloc(RAMBlock *block,
> >          perror("ftruncate");
> >      }
> >  
> > -    area = qemu_ram_mmap(fd, memory, block->mr->align, block->flags);
> > +    area = qemu_ram_mmap(fd, memory, block->mr->align, flags);
> 
> I think this change can be squashed with patch2 unless I am not missing 
> anything here.

Yes, right, nothing just split the diffrent function in diffrent patch.
It's OK to squashed these 2 together. 
Thanks for the review. 

Yi.
> 
> >      if (area == MAP_FAILED) {
> >          error_setg_errno(errp, errno,
> >                           "unable to map backing store for guest RAM");
> > @@ -2278,7 +2279,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size,
> > MemoryRegion *mr,
> >      new_block->used_length = size;
> >      new_block->max_length = size;
> >      new_block->flags = ram_flags;
> > -    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
> > +    new_block->host = file_ram_alloc(new_block, size, fd, !file_size,
> > +            ram_flags, errp);
> >      if (!new_block->host) {
> >          g_free(new_block);
> >          return NULL;
> > --
> > 2.7.4
> > 
> > 
> > 
