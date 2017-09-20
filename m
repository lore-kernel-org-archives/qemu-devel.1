Received: from eggs.gnu.org ([2001:4830:134:3::10]:48154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1duo1t-0001Rl-Gz
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 19:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1duo1r-0005YE-VB
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 19:03:41 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1duo1r-0005Ws-LC
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 19:03:39 -0400
Received: by mail-wm0-x243.google.com with SMTP id x17so3659054wmd.5
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 16:03:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <46de309a-ae79-e15c-6f34-c9b8cf458d6b@vivier.eu>
References: <d137f607-aa48-e388-02b2-1f1b104439e2@vivier.eu>
	<20170919230643.87425-1-carenas@gmail.com>
	<20170919230643.87425-2-carenas@gmail.com>
	<d8115e2d-7409-c6ea-3c8d-3aead5b5fa87@vivier.eu>
	<CAPUEspjdyJ8_cwGPZFOAKs3NE83kdwXV-Ji6TTFYJf7MFQxvBg@mail.gmail.com>
	<46de309a-ae79-e15c-6f34-c9b8cf458d6b@vivier.eu>
From: Carlo Arenas <carenas@gmail.com>
Date: Wed, 20 Sep 2017 16:03:37 -0700
Message-ID: <CAPUEspgH8kR+8MrGm610HerHeea_PvtHsBMJAk_UeREkVZ_hxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Sep 20, 2017 at 11:53 AM, Laurent Vivier <laurent@vivier.eu> wrote:

> > the test for optlen is replaced by passing optlen to the underlying
> > setsockopt call directly, who would do the test and return the right
> error.
>
> You can't do that, because sizeof(struct linger) may be different from
> sizeof(struct target_linger).
>

Good point, will correct it, but considering that was mostly what I changed
from =E9=99=88=E5=88=9A's code, could we merge his instead so I can rebase =
my changes on
top of it?

just out of curiosity, do you know any such architecture? I assumed that
for everything qemu will care, a struct with 2 ints would be 8 bytes long.


> > as an interesting note, I noticed when testing (in ubuntu artful x86_64=
)
> > that regardless of how you interpret the documentation, setsockopt won'=
t
> > fail just because the len is smaller than the size of the struct, and
>
> Right, see:
>
> http://elixir.free-electrons.com/linux/latest/source/net/core/sock.c#L830


Sorry; got confused and the one that doesn't fail is actually getsockopt:

http://elixir.free-electrons.com/linux/latest/source/net/core/sock.c#L1178

> therefore that code was not equivalent to the setsockopt it was trying
> > to emulate, and therefore this change doesn't only make the code simple=
r
> > but also more correct IMHO
> Next time add a revision history in your series explaining your changes
> (and don't reply to the previous patch series for the new series, it's
> better to start a new email thread).
>

Sorry about that, my original intent was to get the original submission to
add support of SO_LINGER to setsockopt out of patchwork limbo[1], hence the
threading and inherited CC

I see there is a lot more work to be done here though, specially when I
found out while trying to test my change for sparc that SOL_SOCKET was also
wrong[2]

is there any testing infrastructure that could be used here to make sure
that no regression is introduced?

Carlo

[1] https://patchwork.ozlabs.org/patch/565659/
[2] https://patchwork.ozlabs.org/patch/816043/
