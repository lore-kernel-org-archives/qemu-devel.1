Received: from eggs.gnu.org ([2001:4830:134:3::10]:47842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cWIWk-00087c-Dj
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:01:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cWIWg-0001E1-Fk
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:01:58 -0500
Received: from mailout3.w1.samsung.com ([210.118.77.13]:33453)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1cWIWg-00010O-5C
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:01:54 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OKB00JU9SYYKR40@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:01:46 +0000 (GMT)
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <e3d95aa1-d112-c9fa-2810-a3d41ff79ebb@samsung.com>
Date: Wed, 25 Jan 2017 11:01:44 +0300
MIME-version: 1.0
In-reply-to: <20170106182823.1960-2-dgilbert@redhat.com>
Content-type: text/plain; charset=windows-1252; format=flowed
Content-transfer-encoding: 7bit
References: <20170106182823.1960-2-dgilbert@redhat.com>
	<CGME20170125080145eucas1p2a0b06b64d9687cc3d2efcbaf0bd925a1@eucas1p2.samsung.com>
Subject: Re: [Qemu-devel] [01/15] postcopy: Transmit and compare individual
 page sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dave Gilbert <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, amit.shah@redhat.com, aarcange@redhat.com

Hi David,

I checked you whole patch set with Andrea's kernel
git://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git

It works and really gives sufficient decreasing of the downtime.

I'm newby in qemu and here in the mailing list.

I have some remarks on current patch.

On both client and server side post copy capability should be enabled

migrate_set_capability postcopy-ram on

and serialization/deserialization relies on it.

  So if destination host
doesn't set post copy capability ram_load will skip reading of
remote_page_size and in case of multiple RAMBlocks the next read of len
will be incorrect. Hopefully usually len is 0, but it could be bigger 
and overrun buffer ;).
Maybe it's better to pass post copy capability attribute from host to 
destination to avoid
such assumption.


On 01/06/2017 09:28 PM, Dave Gilbert wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> When using postcopy with hugepages, we require the source
> and destination page sizes for any RAMBlock to match.
>
> Transmit them as part of the RAM information header and
> fail if there's a difference.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   migration/ram.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index a1c8089..39998f5 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1970,6 +1970,9 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>           qemu_put_byte(f, strlen(block->idstr));
>           qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr));
>           qemu_put_be64(f, block->used_length);
> +        if (migrate_postcopy_ram() && block->page_size != qemu_host_page_size) {
> +            qemu_put_be64(f, block->page_size);
> +        }
>       }
>   
>       rcu_read_unlock();
> @@ -2536,6 +2539,18 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>                               error_report_err(local_err);
>                           }
>                       }
> +                    /* For postcopy we need to check hugepage sizes match */
> +                    if (migrate_postcopy_ram() &&
> +                        block->page_size != qemu_host_page_size) {
> +                        uint64_t remote_page_size = qemu_get_be64(f);
> +                        if (remote_page_size != block->page_size) {
> +                            error_report("Mismatched RAM page size %s "
> +                                         "(local) %" PRId64 "!= %" PRId64,
> +                                         id, block->page_size,
> +                                         remote_page_size);
> +                            ret = -EINVAL;
> +                        }
> +                    }
>                       ram_control_load_hook(f, RAM_CONTROL_BLOCK_REG,
>                                             block->idstr);
>                   } else {


-- 
Best regards,
Alexey Perevalov
