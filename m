Received: from eggs.gnu.org ([2001:4830:134:3::10]:53398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFdt3-0007P7-22
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 07:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFdc8-0001rM-MH
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 07:15:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gFdc7-0001dQ-6d
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 07:15:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id l26-v6so1126842wmh.3
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 04:15:19 -0700 (PDT)
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4c5a9147-a8ba-390c-9c75-a71559450f16@redhat.com>
Date: Thu, 25 Oct 2018 13:15:16 +0200
MIME-Version: 1.0
In-Reply-To: <20181025085256.20522-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] adlib: mark as insecure and deprecated.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Prasad J Pandit <ppandit@redhat.com>

On 25/10/18 10:52, Gerd Hoffmann wrote:
> We have a lovely, guest-triggerable buffer overflow in opl2 emulation.
> 
> Reproducer:
>      outw(0xff60, 0x220);
>      outw(0x1020, 0x220);
>      outw(0xffb0, 0x220);
> Result:
>      Will overflow FM_OPL->AR_TABLE[] (see hw/audio/fmopl.[ch])
> 
> The specs google finds (http://www.symphoniae.com/Yamaha/YSC/YM3812.pdf)
> are rather sparse, possibly incomplete (looks like scanned fax with a
> scrambled page at the end) and not really helpful in identifying which
> of the register writes sets some illegal value.
> 
> So, go tag the device as deprecated with a warning messge, to notify

"warning message"

> users and schedule it for removal according to our deprecation policy.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/audio/adlib.c     | 1 +
>   qemu-deprecated.texi | 4 ++++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
> index 97b876c..fb4a29c 100644
> --- a/hw/audio/adlib.c
> +++ b/hw/audio/adlib.c
> @@ -311,6 +311,7 @@ static void adlib_class_initfn (ObjectClass *klass, void *data)
>       set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
>       dc->desc = ADLIB_DESC;
>       dc->props = adlib_properties;
> +    dc->deprecation_reason = "insecure, buffer overflow in opl2 emulation";
>   }
>   
>   static const TypeInfo adlib_info = {
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 11b870c..7951a4f 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -116,6 +116,10 @@ The @option{[hub_id name]} parameter tuple of the 'hostfwd_add' and
>   The ``ivshmem'' device type is replaced by either the ``ivshmem-plain''
>   or ``ivshmem-doorbell`` device types.
>   
> +@subsection adlib (since 3.1)
> +
> +Has known buffer overflow.
> +
>   @section System emulator machines
>   
>   @subsection pc-0.10 and pc-0.11 (since 3.0)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
