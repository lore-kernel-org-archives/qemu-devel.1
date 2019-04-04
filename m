Received: from eggs.gnu.org ([209.51.188.92]:50801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hBzHx-0000kt-Cw
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hBzHv-00041E-Gi
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:08:05 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20190404071421.4891-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <298ccbd7-9af5-8303-e42b-33dd1cb94b9e@redhat.com>
Date: Thu, 4 Apr 2019 12:07:50 +0200
MIME-Version: 1.0
In-Reply-To: <20190404071421.4891-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/input/pckbd: The i8042 device should
 not be user_creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-trivial@nongnu.org

On 04/04/19 09:14, Thomas Huth wrote:
> The i8042 PS/2 controller is part of the chipset on the motherboard.
> It is instantiated by the machine init code, and it does not make sense
> to allow the user to plug an additional i8042 in any of the free ISA slots.
> Thus let's mark the device with user_creatable = false.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/input/pckbd.c | 2 ++
>  1 file changed, 2 insertions(+)

user_creatable is not for devices that are not pluggable in real life;
it is for devices that crash QEMU (!) or always fail if plugged by the user.

So the question to ask is: would it make sense, and especially work, to
add an i8042 to machines that do have an ISA bridge (for example the Alpha?)

Paolo


> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
> index 47a606f5e3..af393818fc 100644
> --- a/hw/input/pckbd.c
> +++ b/hw/input/pckbd.c
> @@ -568,6 +568,8 @@ static void i8042_class_initfn(ObjectClass *klass, void *data)
>      dc->realize = i8042_realizefn;
>      dc->vmsd = &vmstate_kbd_isa;
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +    /* i8042 is a device on the motherboard, and not pluggable by the user */
> +    dc->user_creatable = false;
>  }
>  
>  static const TypeInfo i8042_info = {
> 
