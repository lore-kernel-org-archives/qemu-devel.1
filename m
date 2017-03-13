Received: from eggs.gnu.org ([2001:4830:134:3::10]:57527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hwertz10@gmail.com>) id 1cnVCw-0004u2-PV
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hwertz10@gmail.com>) id 1cnVCv-0003en-OA
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:00:38 -0400
Received: from mail-ua0-x230.google.com ([2607:f8b0:400c:c08::230]:33060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hwertz10@gmail.com>) id 1cnVCv-0003bi-JL
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:00:37 -0400
Received: by mail-ua0-x230.google.com with SMTP id u30so159462843uau.0
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 12:00:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_=nPsgaN0pPuS=sUU_VdvXf3X83YV27jMO2yF3ddyL6Q@mail.gmail.com>
References: <CAOuPqTEAw67784gswB_Xz+S1LwfmWhSqXK0DgFt05jb=hm2H5w@mail.gmail.com>
	<CAFEAcA_=nPsgaN0pPuS=sUU_VdvXf3X83YV27jMO2yF3ddyL6Q@mail.gmail.com>
From: Henry Wertz <hwertz10@gmail.com>
Date: Mon, 13 Mar 2017 14:00:34 -0500
Message-ID: <CAOuPqTEBik4WC6qDN2ts+H_uqY=0d9Q97==ZGJVA0DJWa+AMoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Small patch for getdents syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>

On Mar 13, 2017 5:49 AM, "Peter Maydell" <peter.maydell@linaro.org> wrote:
>
> On 8 March 2017 at 00:40, Henry Wertz <hwertz10@gmail.com> wrote:
> > I have a trivial, 1-line patch for getdents function; due to
> >...
> There is a theoretically better way to handle the 64-bit
> guest on 32-bit host case: since here you know that the
> guest dirent struct is bigger than the host dirent
> struct you could read them directly into the guest buffer
> and then convert in-place rather than having to malloc
> a temporary buffer. The conversion code is a little
> bit awkward though because you have to make sure you don't
> overwrite host data you haven't read yet, so I think
> you would need to start at the end of the buffer and
> work backwards. This is basically fixing the #else
> part of this code to work for guest > host as well
> as for guest == host.

That does sound like it'd be better (avoiding one unnecessary malloc at
least.)

>
> However, since 64-bit-on-32 is not exactly a very common
> use case these days I think your patch is an OK fix for
> things.
I'd guess this use might (slightly) increase if more x86 binary software
begins to be shipped x86-64 instead.  That said, this particular code path
may still barely be used; I would have expected most (especially 64-bit)
software would call getdents64 instead of getdents, and was surprised to
find aapt uses getdents instead.

> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

>
> PS: we prefer 'unified' format diffs; git format-patch
> should produce those by default.
>
> thanks
> -- PMM

OK I'll make sure to do that next time.

Thanks!

-- Henry Wertz
