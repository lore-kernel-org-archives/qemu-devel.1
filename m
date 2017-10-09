Received: from eggs.gnu.org ([2001:4830:134:3::10]:43449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1TFb-0003vf-Fk
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1TFY-000454-9E
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:17:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e1TFY-00044C-23
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:17:20 -0400
Date: Mon, 9 Oct 2017 10:17:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171009101714.5b52d432.cohuck@redhat.com>
In-Reply-To: <1507124979-8880-3-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1507124979-8880-3-git-send-email-pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/5] s390x/css: Use AIS AIRQ injection
 only if adapter support AIS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, qemu-s390x@nongnu.org

On Wed,  4 Oct 2017 15:49:36 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> Testing to use Adapter Interrupt suppression or not depend on AIS
> being enabled in the kernel.
> To implement AIS emulation we must move this test inside the FLIC
> dedicated irq_inject function.
> 
> Furthermore, a test to verify that the adapter is subject to the AIS
> must be added.
> 
> Last, there is no need to crash QEMU if the injection failed, the
> guest may recover from it.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 901dc6a..6e74a5c 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -672,10 +672,12 @@ void css_adapter_interrupt(CssIoAdapterType type, uint8_t isc)
>      }
>  
>      trace_css_adapter_interrupt(isc);
> -    if (fs->ais_supported) {
> +    /* Use standard IRQ injection for adapters not supporting AIS */

I'd move that comment to the else branch.

> +    if (adapter->flags & S390_ADAPTER_SUPPRESSIBLE) {
> +        /* Use AIRQ injection for adapters subject to AIS */
>          if (fsc->inject_airq(fs, type, isc, adapter->flags)) {
>              error_report("Failed to inject airq with AIS supported");
> -            exit(1);
> +            /* Report error - guest will handle not receiving interrupts */

I'm not 100% sure that this is the right thing to do. I have always
operated under the assumption "if the hardware (host) accepts the I/O,
it owes you an interrupt". (Don't the other failed interrupt injection
paths do a hard stop as well? Is there any reasonable way for an
injection failure to be transient?)

>          }
>      } else {
>          s390_io_interrupt(0, 0, 0, io_int_word);
