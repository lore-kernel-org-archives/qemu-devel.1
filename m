Received: from eggs.gnu.org ([209.51.188.92]:60786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go9HT-0002zY-PK
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go95Z-0002Bx-E6
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:44:46 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1go95Y-00029s-U5
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:44:45 -0500
Received: by mail-ot1-x342.google.com with SMTP id n8so14989331otl.6
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 07:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 15:44:21 +0000
Message-ID: <CAFEAcA8zBxFFvBc3taTE3Q=JFdG9VgcCXnZ3=MNE7u8VyvKyrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/31] More work towards libslirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On Sun, 27 Jan 2019 at 12:13, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> The following changes since commit ad7a21e81231ae64540310384fb0f87ac8758b=
02:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-re=
quest' into staging (2019-01-25 17:22:20 +0000)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 10163f695fe66f9d3d099a33752996dae70be98c:
>
>   slirp: API is extern C (2019-01-27 13:03:59 +0100)
>
> ----------------------------------------------------------------
> More work towards libslirp

This fails to build on almost all hosts:

x86-64 linux ubuntu:

/home/petmay01/linaro/qemu-for-merges/slirp/misc.c: In function =E2=80=98fo=
rk_exec=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/slirp/misc.c:139:5: error:
implicit declaration of function =E2=80=98g_spawn_async_with_fds=E2=80=99; =
did you
mean =E2=80=98g_spawn_async_with_pipes=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
     g_spawn_async_with_fds(NULL /* cwd */,
     ^~~~~~~~~~~~~~~~~~~~~~
     g_spawn_async_with_pipes
/home/petmay01/linaro/qemu-for-merges/slirp/misc.c:139:5: error:
nested extern declaration of =E2=80=98g_spawn_async_with_fds=E2=80=99
[-Werror=3Dnested-externs]
cc1: all warnings being treated as errors
/home/petmay01/linaro/qemu-for-merges/rules.mak:69: recipe for target
'slirp/misc.o' failed

Note that g_spawn_async_with_fds() is one of the glib routines
which we have a version of in glib-compat.h to cope with older
glib versions -- have you removed the #include of that and
not provided the equivalent code for slirp?


On OpenBSD there are lots of compiler errors, eg:

In file included from slirp/slirp.h:51:0,
                 from slirp/arp_table.c:25:
slirp/ip6.h: In function 'in6_equal':
slirp/ip6.h:37:5: warning: implicit declaration of function 'memcmp'
[-Wimplicit-function-declaration]
     return memcmp(a, b, sizeof(*a)) =3D=3D 0;
     ^
slirp/ip6.h: In function 'in6_compute_ethaddr':
slirp/ip6.h:102:5: warning: implicit declaration of function 'memcpy'
[-Wimplicit-function-declaration]
     memcpy(&eth[2], &ip.s6_addr[16 - (ETH_ALEN - 2)], ETH_ALEN - 2);
     ^
slirp/ip6.h:102:5: warning: incompatible implicit declaration of
built-in function 'memcpy'
slirp/arp_table.c: In function 'arp_table_add':
slirp/arp_table.c:49:13: warning: incompatible implicit declaration of
built-in function 'memcpy'
             memcpy(arptbl->table[i].ar_sha, ethaddr, ETH_ALEN);
             ^
slirp/arp_table.c:56:5: warning: incompatible implicit declaration of
built-in function 'memcpy'
     memcpy(arptbl->table[arptbl->next_victim].ar_sha,  ethaddr, ETH_ALEN);
     ^
slirp/arp_table.c: In function 'arp_table_search':
slirp/arp_table.c:74:9: warning: implicit declaration of function
'memset' [-Wimplicit-function-declaration]
         memset(out_ethaddr, 0xff, ETH_ALEN);
         ^
slirp/arp_table.c:74:9: warning: incompatible implicit declaration of
built-in function 'memset'
slirp/arp_table.c:80:13: warning: incompatible implicit declaration of
built-in function 'memcpy'
             memcpy(out_ethaddr, arptbl->table[i].ar_sha,  ETH_ALEN);
             ^

In most of QEMU memcpy and friends are provided via
osdep.h -- if you don't want to include that you need
to replicate chunks of its functionality.

Linux s390 host fails similarly (memcpy, memcmp, strlen, etc all
not declared).

thanks
-- PMM
