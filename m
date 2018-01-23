Received: from eggs.gnu.org ([2001:4830:134:3::10]:57207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agx@sigxcpu.org>) id 1ee0QQ-00058O-Uk
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 10:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agx@sigxcpu.org>) id 1ee0QP-0007Ta-Uk
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 10:23:50 -0500
Date: Tue, 23 Jan 2018 16:23:39 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Message-ID: <20180123152339.GA23245@bogon.m.sigxcpu.org>
References: <20180123145222.2487-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180123145222.2487-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user/syscall: let recvfrom(struct
 sockaddr *) use abi_ulong
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Hi,
Thanks for having a look!

On Tue, Jan 23, 2018 at 11:52:22AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Currently recvfrom() is restricted to handle 32-bit pointers,
> remove this limit for 64-bit hosts.
>=20
> This fixes:
>=20
>   31572 socket(AF_NETLINK, SOCK_RAW, NETLINK_AUDIT) =3D 3
>   ...
>   31572 sendto(3, {{len=3D124, type=3D0x454 /* NLMSG_??? */, flags=3DNL=
M_F_REQUEST|NLM_F_ACK, seq=3D1, pid=3D0}, "op=3Dtest:message acct=3D\"?\"=
 exe=3D\"/tmp/nl-bad-addr\" hostname=3Dlocalhost addr=3D? terminal=3D/dev=
/pts/2 res=3Dsuccess\0\0\0"}, 124, 0, 0xfffffa3897d0, 0) =3D 124
>   31572 ppoll([{fd=3D3, events=3DPOLLIN}], 1, {tv_sec=3D0, tv_nsec=3D50=
0000000}, NULL, 0) =3D 1 ([{fd=3D3, revents=3DPOLLIN}], left {tv_sec=3D0,=
 tv_nsec=3D499993180})
>   31572 recvfrom(3, 0x112a50eb4, 8988, MSG_PEEK|MSG_DONTWAIT, 0xfffffa3=
897e0, 0x42) =3D -1 EFAULT (Bad address)
>=20
> Reported-by: Guido G=FCnther <agx@sigxcpu.org>
> Message-id: 20180123120541.GA14216@bogon.m.sigxcpu.org
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  linux-user/syscall.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 11c9116c4a..28805b1785 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -4032,7 +4032,7 @@ static abi_long do_recvfrom(int fd, abi_ulong msg=
, size_t len, int flags,
>      if (!host_msg)
>          return -TARGET_EFAULT;
>      if (target_addr) {
> -        if (get_user_u32(addrlen, target_addrlen)) {
> +        if (get_user_ual(addrlen, target_addrlen)) {
>              ret =3D -TARGET_EFAULT;
>              goto fail;
>          }
> @@ -4053,7 +4053,7 @@ static abi_long do_recvfrom(int fd, abi_ulong msg=
, size_t len, int flags,
>          }
>          if (target_addr) {
>              host_to_target_sockaddr(target_addr, addr, addrlen);
> -            if (put_user_u32(addrlen, target_addrlen)) {
> +            if (put_user_ual(addrlen, target_addrlen)) {
>                  ret =3D -TARGET_EFAULT;
>                  goto fail;
>              }

Ahh...I saw these and was wondering how this would work on
64bit. Unfortunately the patch doesn't change things:

    4824  recvfrom(3, 0x1401f8eb4, 8988, MSG_PEEK|MSG_DONTWAIT, 0xffffe10=
a8620, 0x42) =3D -1 EFAULT (Bad address)

If you want me to report qemu -strace or s.th. please let me know.
Cheers,
 -- Guido
