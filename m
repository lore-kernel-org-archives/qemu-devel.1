Received: from eggs.gnu.org ([2001:4830:134:3::10]:33963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riemensberger@cadami.net>) id 1eXs4N-0004a7-WC
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 12:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riemensberger@cadami.net>) id 1eXs4K-0000xT-0P
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 12:15:43 -0500
Received: from dd7730.kasserver.com ([85.13.132.46]:58958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <riemensberger@cadami.net>)
	id 1eXs4J-0000qU-QS
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 12:15:39 -0500
References: <1515258013-85745-1-git-send-email-riemensberger@cadami.net>
From: Maximilian Riemensberger <riemensberger@cadami.net>
Message-ID: <53dd3c28-bd44-0f83-afd4-42530ba6e4c8@cadami.net>
Date: Sat, 6 Jan 2018 18:15:36 +0100
MIME-Version: 1.0
In-Reply-To: <1515258013-85745-1-git-send-email-riemensberger@cadami.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user/mmap.c: Avoid choosing NULL as
 start address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>

On 06.01.18 18:00, Maximilian Riemensberger wrote:
> mmap() is required by the linux kernel ABI and POSIX to return a
> non-NULL address when the implementation chooses a start address for th=
e
> mapping.
>=20
> The current implementation of mmap_find_vma_reserved() can return NULL
> as start address of a mapping which leads to subsequent crashes inside
> the guests glibc, e.g. output of qemu-arm-static --strace executing a
> test binary stx_test:
>=20
>     1879 mmap2(NULL,8388608,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYM=
OUS|0x20000,-1,0) =3D 0x00000000
>     1879 write(2,0xf6fd39d0,79) stx_test: allocatestack.c:514: allocate=
_stack: Assertion `mem !=3D NULL' failed.
>=20
> This patch fixes mmap_find_vma_reserved() by skipping NULL as start
> address while searching for a suitable mapping start address.

I should have added:

Fixes: 59e9d91c7ae1b655997aec61c08eec1685414117 ("linux-user: resolve res=
erved_va vma downwards")

Cheers,
	Max

>=20
> CC: Riku Voipio <riku.voipio@iki.fi>
> CC: Laurent Vivier <laurent@vivier.eu>
> CC: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Maximilian Riemensberger <riemensberger@cadami.net>
> ---
>  linux-user/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 4888f53..20cc5a7 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -221,7 +221,7 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong s=
tart, abi_ulong size)
>      addr =3D end_addr - qemu_host_page_size;
> =20
>      while (1) {
> -        if (addr > end_addr) {
> +        if (!addr || addr > end_addr) {
>              if (looped) {
>                  return (abi_ulong)-1;
>              }
>=20

--=20
----------------------------------------------------------------------
Cadami UG (haftungsbeschr=C3=A4nkt)
Waagstra=C3=9Fe 10, 85386 Eching (near Munich), Germany
Office:    c/o Wayra, Kaufingerstra=C3=9Fe 15, 80331 Munich, Germany

Contact:   +49-176-63360306, riemensberger@cadami.net, www.cadami.net

Gesch=C3=A4ftsf=C3=BChrer:         Andreas Dotzler, Michael Heindlmaier,
                         Thomas K=C3=BChn, Maximilian Riemensberger
Sitz der Gesellschaft:   Eching, HRB 219979 Amtsgericht M=C3=BCnchen
USt-IdNr.:               DE301293803
----------------------------------------------------------------------
