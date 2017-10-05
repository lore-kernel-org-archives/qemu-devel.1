Received: from eggs.gnu.org ([2001:4830:134:3::10]:52294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1e00Kb-0001dT-Nv
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 03:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1e00KX-00070s-Os
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 03:12:29 -0400
References: <CAHpsRN-XzxjJZb=rb0iHMv4Afv=2H3N5U7p4+NNJFPkxgSLMXg@mail.gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <43071208-759c-6476-0cb0-c4e7e0daaf77@redhat.com>
Date: Thu, 5 Oct 2017 09:12:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAHpsRN-XzxjJZb=rb0iHMv4Afv=2H3N5U7p4+NNJFPkxgSLMXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] linux-user: Add random
 ioctls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marco A L Barbosa <malbarbo@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 05/10/2017 00:06, Marco A L Barbosa wrote:
> I don't know how (and if it is necessary) to add buf field to
> rand_pool_info struct. See
> https://github.com/torvalds/linux/blob/5924bbecd0267d87c24110cbe2041b50=
75173a25/include/uapi/linux/random.h#L17

I doesn't look really trivial...

To manage the buf field you must read buf_size and it cannot be done in=20
a generic way: you must define a function to translate the buffer, use=20
IOCTL_SPECIAL() with RNDADDENTROPY and RNDGETPOOL.

You should send your patch using "git send-email" or "git publish"=20
instead of adding it in you email client.

> Signed-off-by: Marco A L Barbosa <malbarbo@gmail.com
> <mailto:malbarbo@gmail.com>>
> ---
> =C2=A0linux-user/ioctls.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 7=
 +++++++
> =C2=A0linux-user/syscall.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0linux-user/syscall_defs.h=C2=A0 | 9 +++++++++
> =C2=A0linux-user/syscall_types.h | 4 ++++
> =C2=A04 files changed, 21 insertions(+)
>=20
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index e6997ff230..9240a83f30 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -173,6 +173,13 @@
> =C2=A0=C2=A0 IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval))=
)
> =C2=A0=C2=A0 IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespe=
c)))
> =C2=A0
> +=C2=A0 IOCTL(RNDGETENTCNT, IOC_R, MK_PTR(TYPE_INT))
> +=C2=A0 IOCTL(RNDADDTOENTCNT, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rand_pool_=
info)))

..., MK_PTR(TYPE_INT)

> +=C2=A0 IOCTL(RNDGETPOOL, IOC_R, MK_PTR(TYPE_INT))

... MK_PTR(MK_STRUCT(STRUCT_rand_pool_info))

Thanks,
Laurent
