Received: from eggs.gnu.org ([209.51.188.92]:45334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack@suse.cz>) id 1hIwOm-0000dc-1b
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack@suse.cz>) id 1hIwOl-0008U1-0X
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:27:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:55360 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jack@suse.cz>) id 1hIwOk-0008Tb-Q8
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:27:50 -0400
Date: Tue, 23 Apr 2019 16:27:48 +0200
From: Jan Kara <jack@suse.cz>
Message-ID: <20190423142748.GE9910@quack2.suse.cz>
References: <20190423080612.15361-1-pagupta@redhat.com>
	<20190423080612.15361-6-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423080612.15361-6-pagupta@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 5/6] ext4: disable map_sync for async
 flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org, qemu-devel@nongnu.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, dan.j.williams@intel.com, zwisler@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com, jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net, hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com, lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com, jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com, stefanha@redhat.com, aarcange@redhat.com, david@redhat.com, david@fromorbit.com, cohuck@redhat.com, xiaoguangrong.eric@gmail.com, pbonzini@redhat.com, yuval.shaia@oracle.com, kilobyte@angband.pl

On Tue 23-04-19 13:36:11, Pankaj Gupta wrote:
> Dont support 'MAP_SYNC' with non-DAX files and DAX files
> with asynchronous dax_device. Virtio pmem provides 
> asynchronous host page cache flush mechanism. We don't
> support 'MAP_SYNC' with virtio pmem and ext4.
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/ext4/file.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 69d65d49837b..4b2ccaf1932e 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -360,15 +360,16 @@ static const struct vm_operations_struct ext4_file_vm_ops = {
>  static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct inode *inode = file->f_mapping->host;
> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +	struct dax_device *dax_dev = sbi->s_daxdev;
>  
> -	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
> +	if (unlikely(ext4_forced_shutdown(sbi)))
>  		return -EIO;
>  
> -	/*
> -	 * We don't support synchronous mappings for non-DAX files. At least
> -	 * until someone comes with a sensible use case.
> +	/* We don't support synchronous mappings for non-DAX files and
> +	 * for DAX files if underneath dax_device is not synchronous.
>  	 */
> -	if (!IS_DAX(file_inode(file)) && (vma->vm_flags & VM_SYNC))
> +	if (!daxdev_mapping_supported(vma, dax_dev))
>  		return -EOPNOTSUPP;
>  
>  	file_accessed(file);
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
