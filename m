Received: from eggs.gnu.org ([209.51.188.92]:56125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqcjL-00074F-NT
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:48:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqci0-0003td-V1
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:46:41 -0500
Date: Mon, 4 Feb 2019 12:46:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190204124630.78e488e0.cohuck@redhat.com>
In-Reply-To: <1548768562-20007-14-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-14-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/15] s390-bios: Use control unit type to
 determine boot method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Tue, 29 Jan 2019 08:29:20 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> The boot method is different depending on which device type we are
> booting from. Let's examine the control unit type to determine if we're
> a virtio device. We'll eventually add a case to check for a real dasd device
> here as well.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/main.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index fa90aa3..5ee02c3 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -200,13 +200,24 @@ static void virtio_setup(void)
>  
>  int main(void)
>  {
> +    uint16_t cutype;
> +
>      sclp_setup();
>      css_setup();
>      boot_setup();
>      find_boot_device();
> +    enable_subchannel(blk_schid);

You even enable the subchannel here already -- no need to do that in
run_ccw again ;)

>  
> -    virtio_setup();
> -    zipl_load(); /* no return */
> +    cutype = cu_type(blk_schid) ;

extra ' '

> +    switch (cutype) {
> +    case CU_TYPE_VIRTIO:
> +        virtio_setup();
> +        zipl_load(); /* no return */
> +        break;
> +    default:
> +        print_int("Attempting to boot from unexpected device type", cutype);
> +        panic("");
> +    }
>  
>      panic("Failed to load OS from hard disk\n");
>      return 0; /* make compiler happy */
