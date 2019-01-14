Received: from eggs.gnu.org ([209.51.188.92]:49406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gizPa-0006WU-7I
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gizPZ-0005bB-Dk
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:24:06 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gizPZ-0005Zs-9A
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:24:05 -0500
Received: by mail-oi1-x242.google.com with SMTP id i6so17431601oia.6
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 02:24:05 -0800 (PST)
MIME-Version: 1.0
References: <q186f8$1u3$1@blaine.gmane.org>
	<CAFEAcA9F+57RZzRTga8BvY_zCf13WX8d3NF6HA8kChtcw9_v6w@mail.gmail.com>
	<CAJs94EZbyyxoXROG8=y7sfrQhmLhNj-mbyz6DSryYOJgqkTpzw@mail.gmail.com>
	<CAJs94EZORmm69g-O7ttVrtNW_gpDqs9h_HoxA2Qp_c0yFijZeg@mail.gmail.com>
In-Reply-To: <CAJs94EZORmm69g-O7ttVrtNW_gpDqs9h_HoxA2Qp_c0yFijZeg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jan 2019 10:23:53 +0000
Message-ID: <CAFEAcA91Gx-XEUhSDQqgxOjmRTNjn=2NZ9-xDO3bJNQ=3oFxKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu-user-linux: how could I measure performance
 for aarch64 and arm?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Sun, 13 Jan 2019 at 07:31, Matwey V. Kornilov
<matwey.kornilov@gmail.com> wrote:
>
> =D0=BF=D1=82, 11 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 22:24, Matwey V.=
 Kornilov <matwey.kornilov@gmail.com>:
> > Indeed, qemu-arm from master runs for 4 minutes where 2.11 runs for 2
> > hours for me. It is impressive improvement.
>
> I've managed to bisected the first good (fast) commit:
>
> commit 2a53535af471f4bee9d6cb5b363746b8d5ed21dd
> Author: Luke Shumaker <lukeshu@parabola.nu>
> Date:   Thu Dec 28 13:08:13 2017 -0500
>
>     linux-user: init_guest_space: Try to make ARM space+commpage continuo=
us
>
> Though I am not sure, how does it help.

Oh, right, you were running into that bug:
https://bugs.launchpad.net/qemu/+bug/1740219

The problem was that we were not putting things in the right
place in memory for 32-bit Arm guest binaries in particular,
which could mean that we spent a long time trying a lot of
placements for memory mappings that failed instead of getting
an arrangement that worked first time. This meant startup
time for the guest binary was pretty slow. I guess your
application does a lot of exec()ing of new processes?

thanks
-- PMM
