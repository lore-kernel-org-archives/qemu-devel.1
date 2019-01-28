Received: from eggs.gnu.org ([209.51.188.92]:58285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goAo0-00070I-JZ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goAnz-00071I-S9
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:34:44 -0500
Date: Mon, 28 Jan 2019 18:34:16 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190128183416.084884aa.cohuck@redhat.com>
In-Reply-To: <9742e9c6-627d-2c00-b666-f669b264bbb4@linux.ibm.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-4-cohuck@redhat.com>
	<74c910bf-d34b-b798-db9d-da29787f0a9e@linux.ibm.com>
	<9742e9c6-627d-2c00-b666-f669b264bbb4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/5] vfio-ccw: add capabilities chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Fri, 25 Jan 2019 16:00:18 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> On 01/25/2019 11:19 AM, Eric Farman wrote:
> >=20
> >=20
> > On 01/21/2019 06:03 AM, Cornelia Huck wrote: =20
> >> Allow to extend the regions used by vfio-ccw. The first user will be
> >> handling of halt and clear subchannel.
> >>
> >> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >> ---
> >> =C2=A0 drivers/s390/cio/vfio_ccw_ops.c=C2=A0=C2=A0=C2=A0=C2=A0 | 181 +=
+++++++++++++++++++++++----
> >> =C2=A0 drivers/s390/cio/vfio_ccw_private.h |=C2=A0 38 ++++++ =20
> ...snip...
> >> diff --git a/drivers/s390/cio/vfio_ccw_private.h=20
> >> b/drivers/s390/cio/vfio_ccw_private.h
> >> index e88237697f83..20e75f4f3695 100644
> >> --- a/drivers/s390/cio/vfio_ccw_private.h
> >> +++ b/drivers/s390/cio/vfio_ccw_private.h
> >> @@ -3,9 +3,11 @@
> >> =C2=A0=C2=A0 * Private stuff for vfio_ccw driver
> >> =C2=A0=C2=A0 *
> >> =C2=A0=C2=A0 * Copyright IBM Corp. 2017
> >> + * Copyright Red Hat, Inc. 2019
> >> =C2=A0=C2=A0 *
> >> =C2=A0=C2=A0 * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> >> =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> >> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
Cornelia Huck <cohuck@redhat.com>
> >> =C2=A0=C2=A0 */
> >> =C2=A0 #ifndef _VFIO_CCW_PRIVATE_H_
> >> @@ -19,6 +21,38 @@
> >> =C2=A0 #include "css.h"
> >> =C2=A0 #include "vfio_ccw_cp.h"
> >> +#define VFIO_CCW_OFFSET_SHIFT=C2=A0=C2=A0 40
> >> +#define VFIO_CCW_OFFSET_TO_INDEX(off)=C2=A0=C2=A0=C2=A0 (off >> VFIO_=
CCW_OFFSET_SHIFT)
> >> +#define VFIO_CCW_INDEX_TO_OFFSET(index)=C2=A0=C2=A0=C2=A0 ((u64)(inde=
x) <<=20
> >> VFIO_CCW_OFFSET_SHIFT)
> >> +#define VFIO_CCW_OFFSET_MASK=C2=A0=C2=A0=C2=A0 (((u64)(1) << VFIO_CCW=
_OFFSET_SHIFT)=20
> >> - 1)
> >> +
> >> +/* capability chain handling similar to vfio-pci */
> >> +struct vfio_ccw_private;
> >> +struct vfio_ccw_region;
> >> +
> >> +struct vfio_ccw_regops {
> >> +=C2=A0=C2=A0=C2=A0 size_t=C2=A0=C2=A0=C2=A0 (*read)(struct vfio_ccw_p=
rivate *private, char __user=20
> >> *buf,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 si=
ze_t count, loff_t *ppos);
> >> +=C2=A0=C2=A0=C2=A0 size_t=C2=A0=C2=A0=C2=A0 (*write)(struct vfio_ccw_=
private *private,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 const char __user *buf, size_t count, loff_t *ppos); =20
>=20
> Oops.  Per my recommendation on v1, you change these to "ssize_t" in=20
> patch 5.  Might as well just do that here.

Seems to have slipped into the wrong patch during rebase. Will fix.
