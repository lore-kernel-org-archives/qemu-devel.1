Received: from eggs.gnu.org ([2001:4830:134:3::10]:44014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4TK7-0002jq-Q2
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4TK2-0000Ku-ST
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 10:58:27 -0400
Date: Tue, 17 Oct 2017 16:58:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171017165817.5880e317.cohuck@redhat.com>
In-Reply-To: <20171017140453.51099-3-pasic@linux.vnet.ibm.com>
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-3-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/7] s390x/css: IO instr handler ending
 control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Tue, 17 Oct 2017 16:04:48 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> CSS code needs to tell the IO instruction handlers located in how should
> the emulated instruction be ended. Currently this is done by returning
> generic (POSIX) error codes, and mapping them to outcomes like condition
> codes. This makes bugs easy to create and hard to recognise.
> 
> As a preparation for moving a way form (mis)using generic error codes for

s/form/from/

> flow control let us introduce a type which tells the instruction
> handler function how to end the instruction, in a more straight-forward
> and less ambiguous way.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  include/hw/s390x/css.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index 69b374730e..7e0dbd162f 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -99,6 +99,22 @@ typedef struct CcwDataStream {
>      hwaddr cda;
>  } CcwDataStream;
>  
> +/*
> + * IO instructions conclude according this. Currently we have only

s/this/to this/

> + * cc codes. Valid values are 0,1,2,3 and the generic semantic for

blanks between numbers?

> + * IO instructions is described briefly. For more details consult the PoP.
> + */
> +typedef enum IOInstEnding {
> +    /* produced expected result */
> +    IOINST_CC_EXPECTED = 0,
> +    /* status conditions were present or produced alternate result */
> +    IOINST_CC_STATUS_PRESENT = 1,
> +    /* inst. ineffective because busy with previously initiated function */
> +    IOINST_CC_BUSY = 2,
> +    /* inst. ineffective because not operational */
> +    IOINST_CC_NOT_OPERATIONAL = 3
> +} IOInstEnding;

This looks a bit odd for some I/O instructions (STCRW, TPI, TSCH), but
is fine for the others. But as the PoP also defines the meanings as
above, it should be fine (and not confusing).

> +
>  typedef struct SubchDev SubchDev;
>  struct SubchDev {
>      /* channel-subsystem related things: */
