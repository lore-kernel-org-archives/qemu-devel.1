Received: from eggs.gnu.org ([2001:4830:134:3::10]:57478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1emn5u-00032R-Ku
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 15:58:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1emn5t-0004A3-RV
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 15:58:58 -0500
References: <20180215212552.26997-1-marcandre.lureau@redhat.com>
	<20180215212552.26997-6-marcandre.lureau@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <7208f722-3738-4d4f-539c-6c0dd822b084@redhat.com>
Date: Fri, 16 Feb 2018 15:58:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180215212552.26997-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/6] ahci-test: fix opts leak of skip tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, "open list:IDE" <qemu-block@nongnu.org>



On 02/15/2018 04:25 PM, Marc-Andr=C3=A9 Lureau wrote:
> Fixes the following ASAN report:
>=20
> Direct leak of 128 byte(s) in 8 object(s) allocated from:
>     #0 0x7fefce311850 in malloc (/lib64/libasan.so.4+0xde850)
>     #1 0x7fefcdd5ef0c in g_malloc ../glib/gmem.c:94
>     #2 0x559b976faff0 in create_ahci_io_test /home/elmarco/src/qemu/tes=
ts/ahci-test.c:1810
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/ahci-test.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/ahci-test.c b/tests/ahci-test.c
> index 7aa5af428c..1bd3cc7ca8 100644
> --- a/tests/ahci-test.c
> +++ b/tests/ahci-test.c
> @@ -1822,6 +1822,7 @@ static void create_ahci_io_test(enum IOMode type,=
 enum AddrMode addr,
>      if ((addr =3D=3D ADDR_MODE_LBA48) && (offset =3D=3D OFFSET_HIGH) &=
&
>          (mb_to_sectors(test_image_size_mb) <=3D 0xFFFFFFF)) {
>          g_test_message("%s: skipped; test image too small", name);
> +        g_free(opts);
>          g_free(name);
>          return;
>      }
>=20

Whupps.

Thanks.

Reviewed-by: John Snow <jsnow@redhat.com>

And, feel free to stage this in whomever's branch, it won't conflict
with anything:

Acked-by: John Snow <jsnow@redhat.com>
