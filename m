Received: from eggs.gnu.org ([2001:4830:134:3::10]:49585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fbNfa-0002Me-VA
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fbNfW-0002AV-Ts
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:08:54 -0400
Date: Fri, 6 Jul 2018 12:08:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180706120841.11cbdfa8.cohuck@redhat.com>
In-Reply-To: <1530811543-6881-16-git-send-email-jjherne@linux.ibm.com>
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-16-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 15/15] s390-bios: Use sense ccw to ensure
 consistent device state at boot time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On Thu,  5 Jul 2018 13:25:43 -0400
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> If a vfio-ccw device is left in an error state (example: pending unit
> check) then it is possible for that state to persist for a vfio-ccw device even
> after the enable subchannel that we do to bring the device online. If this state
> is allowed to persist then even simple I/O operations will needlessly fail. A
> basic sense ccw is used to clear this error state for the boot device.

Another thing: What about unsolicited interrupts? I.e., you enable the
subchannel, and then it becomes pending with unsolicited status. Do you
have any handling for that (or plan to add it)?

We could ignore that for virtio devices, but probably not for dasds.

> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/cio.c  | 13 +++++++++++++
>  pc-bios/s390-ccw/cio.h  | 13 +++++++++++++
>  pc-bios/s390-ccw/main.c |  5 +++++
>  3 files changed, 31 insertions(+)

> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 2bccfa7..e0ce59b 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -201,12 +201,17 @@ static void virtio_setup(void)
>  
>  int main(void)
>  {
> +    SenseData sd;
> +
>      sclp_setup();
>      cio_setup();
>      boot_setup();
>      find_boot_device();
>      enable_subchannel(blk_schid);
>  
> +    /* Clear any outstanding device error conditions */
> +    basic_sense(blk_schid, &sd);

Hmm. Could an error condition reassert itself after it was cleared?
Probably not worth spending too much time on, though.

> +
>      switch (cu_type(blk_schid)) {
>      case 0x3990:  /* Real DASD device */
>          dasd_ipl(blk_schid); /* no return */
