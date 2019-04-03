Received: from eggs.gnu.org ([209.51.188.92]:53106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack@suse.cz>) id 1hBe6a-0001Uf-6i
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack@suse.cz>) id 1hBe6Z-0003z4-72
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:30:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:43120 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jack@suse.cz>) id 1hBe6Y-0003wE-Ts
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:30:55 -0400
Date: Wed, 3 Apr 2019 13:30:49 +0200
From: Jan Kara <jack@suse.cz>
Message-ID: <20190403113049.GF8836@quack2.suse.cz>
References: <20190403104018.23947-1-pagupta@redhat.com>
	<20190403104018.23947-5-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403104018.23947-5-pagupta@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 4/5] ext4: disable map_sync for async
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
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org, qemu-devel@nongnu.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, dan.j.williams@intel.com, zwisler@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com, jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net, hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com, lcapitulino@redhat.com, kwolf@redhat.com, imammedo@redhat.com, jmoyer@redhat.com, nilal@redhat.com, riel@surriel.com, stefanha@redhat.com, aarcange@redhat.com, david@redhat.com, david@fromorbit.com, cohuck@redhat.com, xiaoguangrong.eric@gmail.com

On Wed 03-04-19 16:10:17, Pankaj Gupta wrote:
> Virtio pmem provides asynchronous host page cache flush
> mechanism. We don't support 'MAP_SYNC' with virtio pmem 
> and ext4. 
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/file.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 69d65d49837b..86e4bf464320 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -360,8 +360,10 @@ static const struct vm_operations_struct ext4_file_vm_ops = {
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
>  	/*
> @@ -371,6 +373,13 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (!IS_DAX(file_inode(file)) && (vma->vm_flags & VM_SYNC))
>  		return -EOPNOTSUPP;
>  
> +	/* We don't support synchronous mappings with DAX files if
> +	 * dax_device is not synchronous.
> +	 */
> +	if (IS_DAX(file_inode(file)) && !dax_synchronous(dax_dev)
> +						&& (vma->vm_flags & VM_SYNC))
> +		return -EOPNOTSUPP;
> +
>  	file_accessed(file);
>  	if (IS_DAX(file_inode(file))) {
>  		vma->vm_ops = &ext4_dax_vm_ops;
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
