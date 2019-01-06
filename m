Received: from eggsout.gnu.org ([209.51.188.92]:49445 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gg3r0-0004Nm-Br
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 03:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gg3qw-00083E-OF
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 03:32:16 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1gg3qw-00082f-Ij
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 03:32:14 -0500
Received: by mail-pf1-x443.google.com with SMTP id h3so20341997pfg.1
	for <qemu-devel@nongnu.org>; Sun, 06 Jan 2019 00:32:13 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190106013802.3645-1-eblake@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <657598d6-0cea-91dc-a975-f716522a49b9@twiddle.net>
Date: Sun, 6 Jan 2019 18:32:03 +1000
MIME-Version: 1.0
In-Reply-To: <20190106013802.3645-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] osdep: Make MIN/MAX evaluate arguments
 only once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: dirty.ice.hu@gmail.com, f4bug@amsat.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 1/6/19 11:38 AM, Eric Blake wrote:
> +/*
> + * Automatic type deduction, to be used as:
> + * QEMU_TYPEOF(expr) name = expr;
> + */
> +#if QEMU_GNUC_PREREQ(4, 9)
> +# define QEMU_TYPEOF(a) __auto_type
> +#else
> +# define QEMU_TYPEOF(a) typeof(a)
> +#endif

What's wrong with always using typeof?  This seems like it leaves potential odd
bugs affecting gcc-4.8.

> +#undef MIN
> +#define MIN(a, b)                            \
> +    ({                                       \
> +        QEMU_TYPEOF((a) + 0) _a = (a) + 0;   \
> +        QEMU_TYPEOF((b) + 0) _b = (b) + 0;   \

If you're promoting the type, why don't you want to promote to the common type
between A and B?  E.g.

  __typeof((a) + (b)) _a = (a), _b = (b);

After all, that's what the result type of (p ? _a : _b) will be.


r~
