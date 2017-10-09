Received: from eggs.gnu.org ([2001:4830:134:3::10]:43981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e1TIc-0005L8-4q
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e1TIW-00050f-U7
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:20:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e1TIW-0004zI-Gr
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:20:24 -0400
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-3-pasic@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d6d2d73d-65c9-7ae1-fd37-cb8e304781e7@redhat.com>
Date: Mon, 9 Oct 2017 10:20:20 +0200
MIME-Version: 1.0
In-Reply-To: <20171004154144.88995-3-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/8] s390x/css: IO instr handler ending
 control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On 04.10.2017 17:41, Halil Pasic wrote:
> CSS code needs to tell the IO instruction handlers located in how should

located in how?

> the emulated instruction be ended. Currently this is done by returning
> generic (POSIX) error codes, and mapping them to outcomes like condition
> codes. This makes bugs easy to create and hard to recognise.
> 
> As a preparation for moving a way form (mis)using generic error codes for
> flow control let us introduce a struct which tells the instruction
> handler function how to end the instruction, in a more straight-forward
> and less ambiguous way.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  include/hw/s390x/css.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index 0653d3c9be..66916b6546 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -75,6 +75,18 @@ typedef struct CMBE {
>      uint32_t reserved[7];
>  } QEMU_PACKED CMBE;
>  
> +/* IO instructions conclude according this */
> +typedef struct IOInstEnding {
> +        /*
> +         * General semantic of cc codes of IO instructions is (brief):
> +         * 0 -- produced expected result
> +         * 1 --  status conditions were present or produced alternate result
> +         * 2 -- ineffective, because busy with previously initiated function
> +         * 3 -- ineffective, not operational
> +         */
> +        int cc;
> +} IOInstEnding;

Why do you need a struct for this? Do you plan to extend it later? If
so, I think you should mention that in the patch description. If not,
please use a named enum or a "typedef unsigned int IOInstEnding" instead.

 Thomas
