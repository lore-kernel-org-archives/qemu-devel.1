Received: from eggs.gnu.org ([2001:4830:134:3::10]:54983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1duip1-0007pp-TC
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1duip0-0002HS-QR
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:30:03 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1duip0-0002Ea-KP
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:30:02 -0400
Received: by mail-wm0-x243.google.com with SMTP id x17so3038393wmd.5
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 10:30:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d8115e2d-7409-c6ea-3c8d-3aead5b5fa87@vivier.eu>
References: <d137f607-aa48-e388-02b2-1f1b104439e2@vivier.eu>
	<20170919230643.87425-1-carenas@gmail.com>
	<20170919230643.87425-2-carenas@gmail.com>
	<d8115e2d-7409-c6ea-3c8d-3aead5b5fa87@vivier.eu>
From: Carlo Arenas <carenas@gmail.com>
Date: Wed, 20 Sep 2017 10:29:59 -0700
Message-ID: <CAPUEspjdyJ8_cwGPZFOAKs3NE83kdwXV-Ji6TTFYJf7MFQxvBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/3] linux-user: add SO_LINGER to setsockopt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, gang.chen.5i5j@gmail.com, riku.voipio@iki.fi, rth@twiddle.net

On Wed, Sep 20, 2017 at 1:39 AM, Laurent Vivier <laurent@vivier.eu> wrote:
>
> Why did you remove "optname = SO_LINGER" and "if (optlen !=
> sizeof(struct target_linger))"?
>

the optname assignment is not really needed, since it is only used for the
setsockopt call and that call is clearer using SO_LINGER directly, so to
avoid hard to see bugs like :

  http://lists.nongnu.org/archive/html/qemu-devel/2016-01/msg00980.html

the test for optlen is replaced by passing optlen to the underlying
setsockopt call directly, who would do the test and return the right error.

as an interesting note, I noticed when testing (in ubuntu artful x86_64)
that regardless of how you interpret the documentation, setsockopt won't
fail just because the len is smaller than the size of the struct, and
therefore that code was not equivalent to the setsockopt it was trying to
emulate, and therefore this change doesn't only make the code simpler but
also more correct IMHO

Carlo
