Received: from eggs.gnu.org ([209.51.188.92]:51834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h19Al-00041f-K1
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:27:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h19Ak-0007oP-RH
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:27:51 -0500
Date: Tue, 5 Mar 2019 13:27:43 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190305132743.03fbb4c3.cohuck@redhat.com>
In-Reply-To: <1551466776-29123-14-git-send-email-jjherne@linux.ibm.com>
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-14-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 13/16] s390-bios: Use control unit type
 to determine boot method
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

On Fri,  1 Mar 2019 13:59:33 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> The boot method is different depending on which device type we are
> booting from. Let's examine the control unit type to determine if we're
> a virtio device. We'll eventually add a case to check for a real dasd device
> here as well.
> 
> Since we have to call enable_subchannel() in main now, might as well
> remove that call from virtio.c : run_ccw().

Any reason you cannot add the enable_subchannel() in the previous
patch? Then you never need to introduce it in run_ccw() :)

> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/main.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 0670c14..ed79b7a 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -198,13 +198,24 @@ static void virtio_setup(void)
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
>  
> -    virtio_setup();
> -    zipl_load(); /* no return */
> +    cutype = cu_type(blk_schid);
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
