Received: from eggs.gnu.org ([2001:4830:134:3::10]:55986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dZfBh-0001vn-8B
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dZfBe-0005Jf-2R
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:22:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dZfBd-0005JH-PV
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:22:22 -0400
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-15-dgilbert@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <726dd083-341b-aa13-37d2-b66479f6039a@redhat.com>
Date: Mon, 24 Jul 2017 17:22:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170628190047.26159-15-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 14/29] vhost+postcopy: Register new regions
 with the ufd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com



On 06/28/2017 09:00 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> When new regions are sent to the client using SET_MEM_TABLE, register
> them with the userfaultfd.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   contrib/libvhost-user/libvhost-user.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index 6de339fb7a..be7470e3a9 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -450,6 +450,39 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
>                      dev_region->mmap_addr);
>           }
>   
> +        if (dev->postcopy_listening) {
> +            /* We should already have an open ufd need to mark each memory
> +             * range as ufd.
> +             * Note: Do we need any madvises? Well it's not been accessed
> +             * yet, still probably need no THP to be safe, discard to be safe?
> +             */
> +            struct uffdio_register reg_struct;
> +            /* Note: We might need to go back to using mmap_addr and
> +             * len + mmap_offset for * huge pages, but then we do hope not to
> +             * see accesses in that area below the offset
> +             */
> +            reg_struct.range.start = (uintptr_t)(dev_region->mmap_addr +
> +                                                 dev_region->mmap_offset);
> +            reg_struct.range.len = dev_region->size;
> +            reg_struct.mode = UFFDIO_REGISTER_MODE_MISSING;
> +
> +            if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
> +                vu_panic(dev, "%s: Failed to userfault region %d: (ufd=%d)%s\n",
> +                         __func__, i, strerror(errno), dev->postcopy_ufd);
Aren't the two last args swapped?

> +                continue;
> +            }
> +            if (!(reg_struct.ioctls & ((__u64)1 << _UFFDIO_COPY))) {
> +                vu_panic(dev, "%s Region (%d) doesn't support COPY",
> +                         __func__, i);
> +                continue;
> +            }
> +            DPRINT("%s: region %d: Registered userfault for %llx + %llx\n",
> +                    __func__, i, reg_struct.range.start, reg_struct.range.len);
> +            /* TODO: Stash 'zero' support flags somewhere */
> +            /* TODO: Get address back to QEMU */
> +
> +        }
> +
>           close(vmsg->fds[i]);
>       }
>   
> 
