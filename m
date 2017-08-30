Received: from eggs.gnu.org ([2001:4830:134:3::10]:39966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dn0SQ-0006L3-Gi
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dn0SP-00041q-MA
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:42:50 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:38613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dn0SP-00041b-H6
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:42:49 -0400
Received: by mail-vk0-x241.google.com with SMTP id g21so1348424vke.5
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 03:42:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170824192730.8440-16-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-16-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 30 Aug 2017 03:42:48 -0700
Message-ID: <CAJ+F1CKEhTQ8JSNV9OHLDchn+wn3k1240grV3uw9nis0K6GWUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 15/32] vhost+postcopy: Register new
 regions with the ufd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, a.perevalov@samsung.com, "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, aarcange@redhat.com, Felipe Franciosi <felipe@nutanix.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>

Use "libvhost-user: " commit title tag/prefix?

On Thu, Aug 24, 2017 at 12:27 PM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> When new regions are sent to the client using SET_MEM_TABLE, register
> them with the userfaultfd.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 32 +++++++++++++++++++++++++++++=
+++
>  1 file changed, 32 insertions(+)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index e8accf11db..e6ab059a03 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -449,6 +449,38 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg=
)
>                     dev_region->mmap_addr);
>          }
>
> +        if (dev->postcopy_listening) {
> +            /* We should already have an open ufd need to mark each memo=
ry
> +             * range as ufd.
> +             * Note: Do we need any madvises? Well it's not been accesse=
d
> +             * yet, still probably need no THP to be safe, discard to be=
 safe?
> +             */
> +            struct uffdio_register reg_struct;
> +            reg_struct.range.start =3D (uintptr_t)dev_region->mmap_addr;
> +            reg_struct.range.len =3D dev_region->size + dev_region->mmap=
_offset;
> +            reg_struct.mode =3D UFFDIO_REGISTER_MODE_MISSING;
> +
> +            if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) =
{
> +                vu_panic(dev, "%s: Failed to userfault region %d "
> +                              "@%p + %zx: (ufd=3D%d)%s\n",
> +                         __func__, i,
> +                         dev_region->mmap_addr,
> +                         dev_region->size + dev_region->mmap_offset,
> +                         dev->postcopy_ufd, strerror(errno));
> +                continue;

panic is supposed to be unrecoverable errors, so I would suggest to return =
here

> +            }
> +            if (!(reg_struct.ioctls & ((__u64)1 << _UFFDIO_COPY))) {
> +                vu_panic(dev, "%s Region (%d) doesn't support COPY",
> +                         __func__, i);
> +                continue;
> +            }
> +            DPRINT("%s: region %d: Registered userfault for %llx + %llx\=
n",
> +                    __func__, i, reg_struct.range.start, reg_struct.rang=
e.len);
> +            /* TODO: Stash 'zero' support flags somewhere */
> +            /* TODO: Get address back to QEMU */
> +
> +        }
> +
>          close(vmsg->fds[i]);
>      }

This patch would be nicer if it compiles on !Linux / without userfault.


--=20
Marc-Andr=C3=A9 Lureau
