Received: from eggs.gnu.org ([2001:4830:134:3::10]:37627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAczn-0000Bp-Oc
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAczm-0002Y7-TK
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:35:27 -0400
References: <20181011131413.22208-1-philmd@redhat.com>
	<7762db82-6044-df69-a1b7-c05100a0e938@redhat.com>
	<4b664769-9830-e186-05c4-132a8cfc423b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8d285029-2b6f-a841-2489-c6761e62c02c@redhat.com>
Date: Thu, 11 Oct 2018 17:34:51 +0200
MIME-Version: 1.0
In-Reply-To: <4b664769-9830-e186-05c4-132a8cfc423b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev: Convert IOReadHandler to read an
 unsigned number of bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Prasad J Pandit <ppandit@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Clark <mjc@sifive.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Antony Pavlov <antonynpavlov@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, Alistair Francis <alistair@alistair23.me>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Zhang Chen <zhangckid@gmail.com>, "open list:PXA2XX" <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>, Samuel Thibault <samuel.thibault@ens-lyon.org>, "open list:X86" <xen-devel@lists.xenproject.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>, "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>, Thomas Huth <huth@tuxfamily.org>, Michael Walle <michael@walle.cc>, "open list:sPAPR" <qemu-ppc@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 11/10/2018 17:24, Philippe Mathieu-Daud=C3=A9 wrote:
>> On the other hand, fd_chr_read_poll is not an IOCanReadHandler, and th=
is
>> patch therefore probably doesn't compile?
> It does compile.
>=20
> fd_chr_update_read_handler() uses fd_chr_read_poll with io_add_watch_po=
ll():
>=20
> GSource *io_add_watch_poll(Chardev *chr,
>                         QIOChannel *ioc,
>                         IOCanReadHandler *fd_can_read,
>                         QIOChannelFunc fd_read,
>                         gpointer user_data,
>                         GMainContext *context);

Oh, that's somewhat weird.  It could just as well return a bool.

However, this made me notice that you need to change e.g. s->max_size's
declaration (in include/chardev/char-fd.h) from int to size_t, and
likewise for: 1) all users of s->max_size, such as len in fd_chr_read;
2) all the similar variables in other char backends.

So it's probably best to structure the series as follows:

1) change fd_can_read from IOCanReadHandler to a GSourceFunc (which
returns a boolean value), changing all "return s->foo" to "return s->foo
> 0;".  Then you can remove the > 0 from

    bool now_active =3D iwp->fd_can_read(iwp->opaque) > 0;

(Having the > 0 repeated in all backends is now a bit ugly, but there
are future cleanup opportunities here to move the qemu_chr_be_can_write
call to qemu_chr_be_can_write; this way most chardev backends can skip
defining a read_poll function.  But I digress).

2) assert in qemu_chr_be_can_write that the returned value is >=3D 0

3) for each backend, change the assigned variable from int to size_t

4) now the rest of your patch, touching all front-ends.  The assertion
from (2) now does not make sense anymore, since ->can_read returns an
unsigned value, but perhaps you can keep a "fail-safe" assertion that
(ssize_t)returned_value >=3D 0 to catch undesired overflows.

Paolo
