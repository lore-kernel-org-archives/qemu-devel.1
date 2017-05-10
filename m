Received: from eggs.gnu.org ([2001:4830:134:3::10]:53834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d8QnK-0001nm-3w
	for qemu-devel@nongnu.org; Wed, 10 May 2017 08:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d8QnH-0006hv-1J
	for qemu-devel@nongnu.org; Wed, 10 May 2017 08:32:42 -0400
References: <20170506004106.3291-1-f4bug@amsat.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <7f51d88d-0dea-5d64-7c6d-530365e29923@redhat.com>
Date: Wed, 10 May 2017 14:32:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170506004106.3291-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] syscall: fix compiler warnings (clang 5)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 06/05/2017 02:41, Philippe Mathieu-Daud=C3=A9 wrote:
> static code analyzer complain:
>=20
> linux-user/syscall.c:5575:9: warning: Dereference of undefined pointer =
value
>     if (*host_rt_dev_ptr !=3D 0) {
>         ^~~~~~~~~~~~~~~~
>=20
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  linux-user/syscall.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index cec8428589..c541e22693 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -5526,7 +5526,7 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie,=
 uint8_t *buf_temp,
>      int target_size;
>      void *argptr;
>      abi_ulong *target_rt_dev_ptr;
> -    unsigned long *host_rt_dev_ptr;
> +    unsigned long *host_rt_dev_ptr =3D NULL;
>      abi_long ret;
>      int i;
> =20
> @@ -5572,7 +5572,7 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie,=
 uint8_t *buf_temp,
>      unlock_user(argptr, arg, 0);
> =20
>      ret =3D get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));

I think we should "assert(host_rt_dev_ptr)" here. It's a bug if
host_rt_dev_ptr is not set.

The "for" loop scans the structure to find the rt_dev field, and we
should always enter in the first "if", so "host_rt_dev_ptr" is always set=
.

> -    if (*host_rt_dev_ptr !=3D 0) {
> +    if (host_rt_dev_ptr !=3D NULL && *host_rt_dev_ptr !=3D 0) {
>          unlock_user((void *)*host_rt_dev_ptr,
>                      *target_rt_dev_ptr, 0);
>      }
>=20

Laurent
