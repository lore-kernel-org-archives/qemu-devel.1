Received: from eggs.gnu.org ([2001:4830:134:3::10]:49303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fbLGs-0008Oo-JT
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 03:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fbLGq-00008k-8K
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 03:35:14 -0400
Date: Fri, 6 Jul 2018 09:35:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180706093508.0c4bf0cf.cohuck@redhat.com>
In-Reply-To: <1530811543-6881-3-git-send-email-jjherne@linux.ibm.com>
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-3-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 02/15] s390-bios: decouple cio setup from
 virtio
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

On Thu,  5 Jul 2018 13:25:30 -0400
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
> 
> Move channel i/o setup code out to a separate function. This decouples cio
> setup from the virtio code path and allows us to make use of it for booting
> dasd devices.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/main.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 544851d..63117d1 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -99,6 +99,18 @@ static void menu_setup(void)
>      }
>  }
>  
> +/*
> + * Initialize the channel I/O subsystem so we can talk to our ipl/boot device.
> + */
> +static void cio_setup(void)

<bikeshed>Call this css_setup?</bikeshed>

> +{
> +    /*
> +     * Unconditionally enable mss support. In every sane configuration this
> +     * will succeed; and even if it doesn't, stsch_err() can handle it.
> +     */
> +    enable_mss_facility();
> +}
> +
>  static void virtio_setup(void)
>  {
>      Schib schib;
