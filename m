Received: from eggs.gnu.org ([209.51.188.92]:34722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gt5lt-0004P1-Tr
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 02:12:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gt5ls-0007zO-AJ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 02:12:53 -0500
Date: Mon, 11 Feb 2019 15:12:35 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190211071235.GE1011@xz-x1>
References: <20190206174328.9736-1-marcandre.lureau@redhat.com>
	<20190206174328.9736-4-marcandre.lureau@redhat.com>
	<20190207181415.07d0d7ae.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190207181415.07d0d7ae.cohuck@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/6] terminal3270: do not use backend
 timer sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:S390" <qemu-s390x@nongnu.org>

On Thu, Feb 07, 2019 at 06:14:15PM +0100, Cornelia Huck wrote:
> On Wed,  6 Feb 2019 18:43:25 +0100
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>=20
> > terminal3270 uses the front-end side of the chardev. It shouldn't
> > create sources from backend side context (with backend
> > functions).
> >=20
> > send_timing_mark_cb calls qemu_chr_fe_write_all() which should be
> > thread safe.
> >=20
> > This partially reverts changes from commit
> > 2c716ba1506769c9be2caa02f0f6d6e7c00f4304.
> >=20
> > CC: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/char/terminal3270.c | 15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
>=20
> I've verified that 3270 continues to work as before.
>=20
> Acked-by: Cornelia Huck <cohuck@redhat.com>

A pure question: is it broken before this patch?

Asked since I don't understand this patch and what it tries to fix...
E.g., in terminal_init(), qemu_chr_fe_set_handlers() is always passing
NULL as chardev context so AFAICT this patch changes nothing from
functional-wise for now.  Meanwhile, if we pass in some non-NULL into
it in the future, IMHO this patch would break it instead of fixing
anything... anything I've missed?

Thanks,

--=20
Peter Xu
