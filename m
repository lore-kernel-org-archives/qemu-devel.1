Received: from eggs.gnu.org ([209.51.188.92]:49118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1glbjd-0007sr-5A
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:43:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1glbjb-0004Qf-6W
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:43:37 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:52393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1glbja-0004OV-Vv
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:43:35 -0500
Received: by mail-wm1-f44.google.com with SMTP id m1so11253084wml.2
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 07:43:31 -0800 (PST)
References: <20190118120143.21631-1-sgarzare@redhat.com>
	<20190118120143.21631-3-sgarzare@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a90f605d-8079-df2d-6ff1-83be4b3a490d@redhat.com>
Date: Mon, 21 Jan 2019 16:43:24 +0100
MIME-Version: 1.0
In-Reply-To: <20190118120143.21631-3-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>

On 18/01/19 13:01, Stefano Garzarella wrote:
> +static inline uint8_t inb(uint16_t port)
> +{
> +    uint8_t value;
> +
> +    asm volatile("outl %w1, %0" : : "a"(value), "Nd"(port));
> +    return value;
> +}
> +
> +static inline uint16_t inw(uint16_t port)
> +{
> +    uint16_t value;
> +
> +    asm volatile("outl %w1, %0" : : "a"(value), "Nd"(port));
> +    return value;
> +}
> +
> +static inline uint32_t inl(uint16_t port)
> +{
> +    uint32_t value;
> +
> +    asm volatile("outl %w1, %0" : : "a"(value), "Nd"(port));
> +    return value;
> +}
>

Almost:

diff --git a/pc-bios/optionrom/optrom.h b/pc-bios/optionrom/optrom.h
index c5c8caa..1e5e265 100644
--- a/pc-bios/optionrom/optrom.h
+++ b/pc-bios/optionrom/optrom.h
@@ -54,7 +54,7 @@ static inline uint8_t inb(uint16_t port)
 {
     uint8_t value;

-    asm volatile("outl %w1, %0" : : "a"(value), "Nd"(port));
+    asm volatile("inb %w1, %0" : "=a"(value) : "Nd"(port));
     return value;
 }

@@ -62,7 +62,7 @@ static inline uint16_t inw(uint16_t port)
 {
     uint16_t value;

-    asm volatile("outl %w1, %0" : : "a"(value), "Nd"(port));
+    asm volatile("inw %w1, %0" : "=a"(value) : "Nd"(port));
     return value;
 }

@@ -70,7 +70,7 @@ static inline uint32_t inl(uint16_t port)
 {
     uint32_t value;

-    asm volatile("outl %w1, %0" : : "a"(value), "Nd"(port));
+    asm volatile("inl %w1, %0" : "=a"(value) : "Nd"(port));
     return value;
 }


No need to repost.

Paolo
