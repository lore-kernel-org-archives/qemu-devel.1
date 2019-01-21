Received: from eggs.gnu.org ([209.51.188.92]:57816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1glcJg-0003yZ-Hf
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:20:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1glcJf-0005vi-OX
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:20:52 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:52069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1glcJf-0005v2-I7
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:20:51 -0500
Received: by mail-wm1-f50.google.com with SMTP id b11so11395227wmj.1
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 08:20:51 -0800 (PST)
Date: Mon, 21 Jan 2019 17:20:47 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190121162047.lryslxlzhkaiyrc3@steredhat>
References: <20190118120143.21631-1-sgarzare@redhat.com>
	<20190118120143.21631-3-sgarzare@redhat.com>
	<a90f605d-8079-df2d-6ff1-83be4b3a490d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a90f605d-8079-df2d-6ff1-83be4b3a490d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/5] linuxboot_dma: move common
 functions in a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>

On Mon, Jan 21, 2019 at 04:43:24PM +0100, Paolo Bonzini wrote:
> On 18/01/19 13:01, Stefano Garzarella wrote:
> > +static inline uint8_t inb(uint16_t port)
> > +{
> > +    uint8_t value;
> > +
> > +    asm volatile("outl %w1, %0" : : "a"(value), "Nd"(port));
> > +    return value;
> > +}
> > +
> > +static inline uint16_t inw(uint16_t port)
> > +{
> > +    uint16_t value;
> > +
> > +    asm volatile("outl %w1, %0" : : "a"(value), "Nd"(port));
> > +    return value;
> > +}
> > +
> > +static inline uint32_t inl(uint16_t port)
> > +{
> > +    uint32_t value;
> > +
> > +    asm volatile("outl %w1, %0" : : "a"(value), "Nd"(port));
> > +    return value;
> > +}
> >
> 
> Almost:
> 
> diff --git a/pc-bios/optionrom/optrom.h b/pc-bios/optionrom/optrom.h
> index c5c8caa..1e5e265 100644
> --- a/pc-bios/optionrom/optrom.h
> +++ b/pc-bios/optionrom/optrom.h
> @@ -54,7 +54,7 @@ static inline uint8_t inb(uint16_t port)
>  {
>      uint8_t value;
> 
> -    asm volatile("outl %w1, %0" : : "a"(value), "Nd"(port));
> +    asm volatile("inb %w1, %0" : "=a"(value) : "Nd"(port));
>      return value;
>  }
> 
> @@ -62,7 +62,7 @@ static inline uint16_t inw(uint16_t port)
>  {
>      uint16_t value;
> 
> -    asm volatile("outl %w1, %0" : : "a"(value), "Nd"(port));
> +    asm volatile("inw %w1, %0" : "=a"(value) : "Nd"(port));
>      return value;
>  }
> 
> @@ -70,7 +70,7 @@ static inline uint32_t inl(uint16_t port)
>  {
>      uint32_t value;
> 
> -    asm volatile("outl %w1, %0" : : "a"(value), "Nd"(port));
> +    asm volatile("inl %w1, %0" : "=a"(value) : "Nd"(port));
>      return value;
>  }
> 
> 
> No need to repost.

Oooh, many thanks to catch!

> 
> Paolo

-- 

Stefano Garzarella
Red Hat
