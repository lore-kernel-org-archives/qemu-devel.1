Received: from eggs.gnu.org ([2001:4830:134:3::10]:49712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffUfL-0006zT-6p
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 14:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffUfH-0007gB-Vx
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 14:25:39 -0400
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-13-git-send-email-jjherne@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <85af7ded-45e2-5eef-a0b0-a34b2e393993@redhat.com>
Date: Tue, 17 Jul 2018 20:25:31 +0200
MIME-Version: 1.0
In-Reply-To: <1530811543-6881-13-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC 12/15] s390-bios: Use control
 unit type to determine boot method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On 05.07.2018 19:25, Jason J. Herne wrote:
> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
> 
> The boot method is different depending on which device type we are
> booting from. Let's examine the control unit type to determine if we're
> a virtio device. We'll eventually add a case to check for a real dasd device
> here as well.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/main.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 20c30c6..e4236c0 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -204,9 +204,16 @@ int main(void)
>      cio_setup();
>      boot_setup();
>      find_boot_device();
> +    enable_subchannel(blk_schid);
>  
> -    virtio_setup();
> -    zipl_load(); /* no return */
> +    switch (cu_type(blk_schid)) {
> +    case 0x3832:  /* Virtio device */

Could we please get some #defines for the magic numbers?

 Thomas
