Received: from eggs.gnu.org ([209.51.188.92]:53314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1ghFFY-0000i6-FS
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:54:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1ghFFX-0005sV-MR
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:54:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:14950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1ghFFV-0005pw-Ln
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:54:31 -0500
Date: Wed, 9 Jan 2019 09:54:19 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1413703615.61223613.1547045659656.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190109144215.GI15397@quack2.suse.cz>
References: <20190109135606.15401-1-pagupta@redhat.com>
	<20190109144215.GI15397@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/5] ext4: disable map_sync for virtio
 pmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, stefanha@redhat.com, dan j williams <dan.j.williams@intel.com>, riel@surriel.com, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, zwisler@kernel.org, vishal l verma <vishal.l.verma@intel.com>, dave jiang <dave.jiang@intel.com>, david@redhat.com, jmoyer@redhat.com, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, hch@infradead.org, mst@redhat.com, jasowang@redhat.com, lcapitulino@redhat.com, imammedo@redhat.com, eblake@redhat.com, willy@infradead.org, tytso@mit.edu, adilger kernel <adilger.kernel@dilger.ca>, darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net


> 
> On Wed 09-01-19 19:26:05, Pankaj Gupta wrote:
> > Virtio pmem provides asynchronous host page cache flush
> > mechanism. We don't support 'MAP_SYNC' with virtio pmem
> > and ext4.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ...
> > @@ -371,6 +373,13 @@ static int ext4_file_mmap(struct file *file, struct
> > vm_area_struct *vma)
> >  	if (!IS_DAX(file_inode(file)) && (vma->vm_flags & VM_SYNC))
> >  		return -EOPNOTSUPP;
> >  
> > +	/* We don't support synchronous mappings with guest direct access
> > +	 * and virtio based host page cache flush mechanism.
> > +	 */
> > +	if (IS_DAX(file_inode(file)) && virtio_pmem_host_cache_enabled(dax_dev)
> > +						&& (vma->vm_flags & VM_SYNC))
> > +		return -EOPNOTSUPP;
> > +
> 
> Shouldn't there rather be some generic way of doing this? Having
> virtio_pmem_host_cache_enabled() check in filesystem code just looks like
> filesystem sniffing into details is should not care about... Maybe just
> naming this (or having a wrapper) dax_dev_map_sync_supported()?

Thanks for the feedback.

Just wanted to avoid 'dax' in function name just to differentiate this with real dax.
But yes can add a wrapper: dax_dev_map_sync_supported()

Thanks,
Pankaj
