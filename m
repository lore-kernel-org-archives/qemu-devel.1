Received: from eggs.gnu.org ([2001:4830:134:3::10]:37359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eAJwL-0008E1-NI
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 14:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eAJwG-0004S1-Nz
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 14:10:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eAJwG-0004R6-Hb
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 14:10:00 -0400
References: <20171031152443.3670-1-michael.nawrocki@gtri.gatech.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8dbe8e3a-f8d4-3fb0-2ac8-e200ebde3dcb@redhat.com>
Date: Thu, 2 Nov 2017 19:09:54 +0100
MIME-Version: 1.0
In-Reply-To: <20171031152443.3670-1-michael.nawrocki@gtri.gatech.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Enable 8-byte wide MMIO for 16550 serial
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>, qemu-devel@nongnu.org
Cc: mst@redhat.com

On 31/10/2017 16:24, Mike Nawrocki wrote:
> 
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 376bd2f240..c16c19a406 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -1005,7 +1005,7 @@ static void serial_mm_write(void *opaque, hwaddr addr,
>                              uint64_t value, unsigned size)
>  {
>      SerialState *s = opaque;
> -    value &= ~0u >> (32 - (size * 8));
> +    value &= ~((uint64_t)0) >> (64 - (size * 8));
>      serial_ioport_write(s, addr >> s->it_shift, value, 1);
>  }

Couldn't this be simply "value &= 255"?  Otherwise looks good.

Paolo

> @@ -1014,16 +1014,22 @@ static const MemoryRegionOps serial_mm_ops[3] = {
>          .read = serial_mm_read,
>          .write = serial_mm_write,
>          .endianness = DEVICE_NATIVE_ENDIAN,
> +        .valid.max_access_size = 8,
> +        .impl.max_access_size = 8,
>      },
>      [DEVICE_LITTLE_ENDIAN] = {
>          .read = serial_mm_read,
>          .write = serial_mm_write,
>          .endianness = DEVICE_LITTLE_ENDIAN,
> +        .valid.max_access_size = 8,
> +        .impl.max_access_size = 8,
>      },
>      [DEVICE_BIG_ENDIAN] = {
>          .read = serial_mm_read,
>          .write = serial_mm_write,
>          .endianness = DEVICE_BIG_ENDIAN,
> +        .valid.max_access_size = 8,
> +        .impl.max_access_size = 8,
