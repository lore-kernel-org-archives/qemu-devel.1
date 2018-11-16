Received: from eggs.gnu.org ([2001:4830:134:3::10]:34131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gNaRN-0002o9-7c
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gNaRJ-0005fC-F2
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 04:29:27 -0500
Date: Fri, 16 Nov 2018 10:29:10 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181116092909.vlsynzuuivlzjoyf@kamzik.brq.redhat.com>
References: <1542365406-81310-1-git-send-email-peng.hao2@zte.com.cn>
	<1542365406-81310-7-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542365406-81310-7-git-send-email-peng.hao2@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH V7 6/6]  pvpanic : update pvpanic document
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: peter.maydell@linaro.org, philmd@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On Fri, Nov 16, 2018 at 06:50:06PM +0800, Peng Hao wrote:
> Add mmio support info in docs/specs/pvpanic.txt.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  docs/specs/pvpanic.txt | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.txt
> index c7bbacc..4e1f69d 100644
> --- a/docs/specs/pvpanic.txt
> +++ b/docs/specs/pvpanic.txt
> @@ -1,7 +1,7 @@
>  PVPANIC DEVICE
>  ==============
>  
> -pvpanic device is a simulated ISA device, through which a guest panic
> +pvpanic device is a simulated device, through which a guest panic
>  event is sent to qemu, and a QMP event is generated. This allows
>  management apps (e.g. libvirt) to be notified and respond to the event.
>  
> @@ -9,6 +9,13 @@ The management app has the option of waiting for GUEST_PANICKED events,
>  and/or polling for guest-panicked RunState, to learn when the pvpanic
>  device has fired a panic event.
>  
> +Some architectures do not support ioport, just like arm. So add mmio
> +support.

This isn't a commit message it's a document. We shouldn't be using the
word 'add'. Anyway I don't see any reason to put this sentence in the
document at all. It's clear to users of machine types without an ISA
bus that if they want to use this device they'll need a different
interface. Let's just tell them what interfaces this device has, like
what's done below.

> +
> +When pvpanic device is implemented as a ISA device, it supports IOPORT
> +mode. If pvpanic device supports MMIO mode, it will be implemented as
> +a SYSBUS device.

pvpanic _does_ support MMIO mode after this patch series. So the 'If'
doesn't make much sense. You could do something like "Since QEMU v3.1
pvpanic also supports MMIO mode..." though.

> +
>  ISA Interface
>  -------------
>  
> @@ -19,6 +26,13 @@ Software should set only bits both itself and the device recognize.
>  Currently, only bit 0 is recognized, setting it indicates a guest panic
>  has happened.
>  
> +SYSBUS Interface
> +--------------

Missing two '--'

> +
> +The SYSBUS interface is similar to the ISA interface except that it uses
> +MMIO. Pvpanic exposes a address space region 0x09070000--0x09070001 in 
                         ^an                    [0x9070000, 0x9070001]

Using the brackets indicates that the addresses are inclusive. I would
also write something like "For example, the arm virt machine could put
the pvpanic device at [0x9070000, 0x9070001]". That way users see this
is just an example and not guaranteed to stay the same nor need to be
the same for their machines.

And again /Pvpanic/pvpanic/. "pvpanic" is a device name, we shouldn't
change it, not even for grammar.

> +arm virt machine. Currently only the first byte is used.
> +
>  ACPI Interface
>  --------------
>  
> -- 
> 1.8.3.1
> 
> 

Thanks,
drew
