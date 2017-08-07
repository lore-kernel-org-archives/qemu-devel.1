Received: from eggs.gnu.org ([2001:4830:134:3::10]:43959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dea5V-0000Xs-WE
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 00:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dea5S-0007aH-R6
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 00:56:22 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54571)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dea5S-0007ZP-IE
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 00:56:18 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <1e52da76-269f-020e-c9cf-adaaef30b59c@samsung.com>
Date: Mon, 07 Aug 2017 07:49:11 +0300
MIME-version: 1.0
In-reply-to: <20170628190047.26159-24-dgilbert@redhat.com>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<CGME20170628190250epcas2p1f018e6169b78276f65cf4cc9fbeb14a3@epcas2p1.samsung.com>
	<20170628190047.26159-24-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [RFC 23/29] vub+postcopy: madvises
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

On 06/28/2017 10:00 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Clear the area and turn off THP.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   contrib/libvhost-user/libvhost-user.c | 32 ++++++++++++++++++++++++++++++--
>   1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index 0658b6e847..ceddeac74f 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -451,11 +451,39 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
>           }
>   
>           if (dev->postcopy_listening) {
> +            int ret;
>               /* We should already have an open ufd need to mark each memory
>                * range as ufd.
> -             * Note: Do we need any madvises? Well it's not been accessed
> -             * yet, still probably need no THP to be safe, discard to be safe?
>                */
> +
> +            /* Discard any mapping we have here; note I can't use MADV_REMOVE
> +             * or fallocate to make the hole since I don't want to lose
> +             * data that's already arrived in the shared process.
> +             * TODO: How to do hugepage
> +             */
Hi, David, frankly saying, I stuck with my solution, and I have also 
another issues,
but here I could suggest solution for hugepages. I think we could 
transmit a received pages
bitmap in VHOST_USER_SET_MEM_TABLE (VhostUserMemoryRegion), but it will 
raise a compatibility issue,
or introduce special message type for that and send it before 
VHOST_USER_SET_MEM_TABLE.
So it will be  possible to do fallocate on received bitmap basis, just 
skip already copied pages.
If you wish, I could send patches, rebased on yours, for doing it.

> +            ret = madvise((void *)dev_region->mmap_addr,
> +                          dev_region->size + dev_region->mmap_offset,
> +                          MADV_DONTNEED);
> +            if (ret) {
> +                fprintf(stderr,
> +                        "%s: Failed to madvise(DONTNEED) region %d: %s\n",
> +                        __func__, i, strerror(errno));
> +            }
> +            /* Turn off transparent hugepages so we dont get lose wakeups
> +             * in neighbouring pages.
> +             * TODO: Turn this backon later.
> +             */
> +            ret = madvise((void *)dev_region->mmap_addr,
> +                          dev_region->size + dev_region->mmap_offset,
> +                          MADV_NOHUGEPAGE);
> +            if (ret) {
> +                /* Note: This can happen legally on kernels that are configured
> +                 * without madvise'able hugepages
> +                 */
> +                fprintf(stderr,
> +                        "%s: Failed to madvise(NOHUGEPAGE) region %d: %s\n",
> +                        __func__, i, strerror(errno));
> +            }
>               struct uffdio_register reg_struct;
>               /* Note: We might need to go back to using mmap_addr and
>                * len + mmap_offset for * huge pages, but then we do hope not to


-- 
Best regards,
Alexey Perevalov
