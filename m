Received: from eggs.gnu.org ([2001:4830:134:3::10]:58283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f98DP-0004I9-Fz
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f98DO-0003pG-Iv
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:59:03 -0400
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:43074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f98DO-0003oe-Dq
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 07:59:02 -0400
Received: by mail-ot0-x236.google.com with SMTP id d9-v6so5502455oth.10
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 04:59:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180419111108.GM10259@redhat.com>
References: <CAOuPqTF3nG157ShF-hW+poXbr25zODOz8pj+o9XdY=ZgU8qpFQ@mail.gmail.com>
	<CAFEAcA9d=oEKfnW0Jr2vrSD8mu0xPbUYk6PAk7dxUqXjJUTooQ@mail.gmail.com>
	<20180419111108.GM10259@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Apr 2018 12:58:40 +0100
Message-ID: <CAFEAcA-ZurVeZG3=WQJnBaLQF8CoTM7dXNCX08W7iqCZ8XuByw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] getdents patch for 64-bit app on 32-bit
 host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Henry Wertz <hwertz10@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 19 April 2018 at 12:11, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wr=
ote:
> If we can't even get something common like dirents working with 64-bit
> guest on 32-bit host, should we refuse to even build 64-bit linux-user
> emulation on a 32-bit host ?  There must be many other similar cases
> where the 64-bit guest syscall is going have insufficient space in the
> host 32-bit syscall structs.

Most of those are OK because you know in advance the size of
the structures, so you can tell the host the buffer length
is smaller, giving you room for the conversion.

Note also that this only happens for NR_getdents, not NR_getdents64,
because in the latter case the structs are always the same size.
So an AArch64 guest would be fine.

Thinking about the getdents problem, I was wondering if we could
manage to calculate a suitable host buffer size based on the worst
case. dirent for a 32-bit host is 12 bytes, and for a 64-bit host
is 24 bytes (plus potentially extra for the name strings). So
we will need an extra 12 bytes per record. The worst case is
when the names are all short enough to fit in the padding inside
the structure, which means bufsize / 24 records in the buffer;
so if we provide the host with a buffer size of bufsize / 24 * 12
 =3D=3D bufsize / 2 then we know the host can't give us back more
records than we can fit in the guest buffer. We would then need
to do some annoying special casing to handle the "host syscall
returns EINVAL because it can't fit a record into bufsize / 2,
but it would fit into bufsize". I think you'd probably have to
loop round gradually giving the host getdents more buffers
until you got to bufsize - 12 (or live with passing the guest
back an unnecessarily pessimistic EINVAL).

But I've just realised that all that is entirely unnecessary,
because the right thing to do here is to say "for the 64-on-32
case, use the "implement getdents in terms of getdents64" codepath".
This will have no buffer overrun problems, because the dirent64
struct is the same size on every host and always larger than the
dirent struct for any architecture. I'll cook up a patch...

(One reason we do still provide the 64-on-32 emulation setups are
that if you have a fairly simple guest binary it can work well
enough -- the classic use case here is gcc test suite binaries,
most of which barely use any of the syscall interface. But there's
also a fair bit of inertia :-))

thanks
-- PMM
