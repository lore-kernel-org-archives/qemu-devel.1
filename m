Received: from eggs.gnu.org ([2001:4830:134:3::10]:41661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dSmO6-0008Cg-Nb
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dSmO2-0007Bj-Q8
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:38:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dSmO2-0007BJ-JH
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:38:42 -0400
Date: Wed, 5 Jul 2017 17:38:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170705173838.0a5fb60f@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499268345-12552-1-git-send-email-thuth@redhat.com>
References: <1499268345-12552-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/ipl: Fix endianness problem with
 netboot_start_addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>

On Wed,  5 Jul 2017 17:25:45 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The start address has to be stored in big endian byte order
> in the iplb.ccw block for the guest.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/ipl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 4e6469d..cc36003 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -418,7 +418,7 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>              error_report_err(err);
>              vm_stop(RUN_STATE_INTERNAL_ERROR);
>          }
> -        ipl->iplb.ccw.netboot_start_addr = ipl->start_addr;
> +        ipl->iplb.ccw.netboot_start_addr = cpu_to_be64(ipl->start_addr);
>      }
>  }
>  

This seems to be the only iplb field to miss endianness handling.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
