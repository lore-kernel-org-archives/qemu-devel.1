Received: from eggs.gnu.org ([2001:4830:134:3::10]:38533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eD5yA-0007KR-80
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 04:51:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eD5y5-0003m3-Bd
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 04:51:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eD5y5-0003k4-5M
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 04:51:21 -0500
Date: Fri, 10 Nov 2017 10:51:16 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171110105116.2a470f57.cohuck@redhat.com>
In-Reply-To: <15d59e1d-e42f-3068-ddc5-e991a5f21879@linux.vnet.ibm.com>
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510075479-17224-7-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171109202308.06a8bc45.cohuck@redhat.com>
	<15d59e1d-e42f-3068-ddc5-e991a5f21879@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/7] s390x/pci: move the memory region
 write from pcistg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com

On Fri, 10 Nov 2017 17:40:12 +0800
Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:

> =E5=9C=A8 2017/11/10 =E4=B8=8A=E5=8D=883:23, Cornelia Huck =E5=86=99=E9=
=81=93:
> > On Tue,  7 Nov 2017 18:24:38 +0100
> > Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
> > =20
> >> Let's move the memory region write from pcistg into a dedicated
> >> function.
> >> This allows us to prepare a later patch searching for subregions
> >> inside of the memory region. =20
> > OK, so here is the memory region write. Do we have any sleeping
> > endianness bugs in there for when we wire up tcg? I'm not sure how this
> > plays with the bswaps (see patch 1).
> >
> > But maybe I've just gotten lost somewhere. =20
> I think there's no error. For PCI bars' MRs, we got the little-endian data
> that is exactly fit to the byte ordering of pcilg instruction. For PCI=20
> config
> space, the data has been swapped according to the cpu byte ordering.

Host or target cpu?

> So we use zpci_swap_endian() to swap the data back to the little-endian
> ordering.

That swap is unconditional. If we were running on a little-endian host,
it would be wrong, wouldn't it?

> > =20
> >> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> >> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> >> ---
> >>   hw/s390x/s390-pci-inst.c | 27 +++++++++++++++++----------
> >>   1 file changed, 17 insertions(+), 10 deletions(-)
