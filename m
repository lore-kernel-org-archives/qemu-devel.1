Received: from eggs.gnu.org ([2001:4830:134:3::10]:41068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eeHXm-00037N-RW
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 04:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eeHXj-000764-Lo
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 04:40:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eeHXj-00075X-F4
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 04:40:31 -0500
References: <20180123175409.9349-1-joserz@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ffd8116d-4ba8-d2c7-c18a-bc9f60439a57@redhat.com>
Date: Wed, 24 Jan 2018 10:40:14 +0100
MIME-Version: 1.0
In-Reply-To: <20180123175409.9349-1-joserz@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] kvm-all: Partially reverts 4fe6d78b2e
 to remove the cleanup call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-devel@nongnu.org, mst@redhat.com
Cc: anton@samba.org, danielhb@linux.vnet.ibm.com, ghammer@redhat.com

On 23/01/2018 18:54, Jose Ricardo Ziviani wrote:
> This commit partially reverts the commit 4fe6d78b2e because of issues
> reported in the virtio.
> 
> Examples:
> 
> $ qemu-system-ppc64 -cpu POWER8 -nographic -vga none -m 4G \
>   -M pseries,accel=kvm -netdev type=user,id=net0 \
>   -device virtio-net-pci,netdev=net0 -drive file=../disk.qcow2,if=virtio
> 
> Populating /vdevice/nvram@71000001
> Populating /vdevice/v-scsi@71000002
>        SCSI: Looking for devices
>           8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
> Populating /pci@800000020000000
>                      00 0000 (D) : 1af4 1000    virtio [ net ]
> Aborted
> 
> $ qemu-system-x86_64 -m 4G -enable-kvm -drive file=util.qcow2,if=virtio
> 
> Running QEMU with GTK 2.x is deprecated, and will be removed
> in a future release. Please switch to GTK 3.x instead
> [1]    5282 abort
> 
> Reference http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg05457.html
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  accel/kvm/kvm-all.c | 4 ----
>  1 file changed, 4 deletions(-)

Michael, please send a revert for all three of Gal's patches.

Thanks,

Paolo

> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 071f4f57c0..f290f487a5 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -812,10 +812,6 @@ static void kvm_mem_ioeventfd_del(MemoryListener *listener,
>      if (r < 0) {
>          abort();
>      }
> -
> -    if (e->cleanup) {
> -        e->cleanup(e);
> -    }
>  }
>  
>  static void kvm_io_ioeventfd_add(MemoryListener *listener,
> 
