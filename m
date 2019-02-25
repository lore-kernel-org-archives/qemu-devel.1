Received: from eggs.gnu.org ([209.51.188.92]:50323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyGwx-0006Xn-6C
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyGww-0002IC-D2
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:09:43 -0500
Date: Mon, 25 Feb 2019 15:09:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190225140935.GE6320@linux.fritz.box>
References: <1551095970-14645-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1551095970-14645-1-git-send-email-thuth@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] block/nvme: Remove QEMU_PACKED from
 naturally aligned NVMeRegs struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Am 25.02.2019 um 12:59 hat Thomas Huth geschrieben:
> The QEMU_PACKED is causing a compiler warning/error with GCC 9:
>=20
>   CC      block/nvme.o
> block/nvme.c: In function =E2=80=98nvme_create_queue_pair=E2=80=99:
> block/nvme.c:209:22: error: taking address of packed member of
>  =E2=80=98struct <anonymous>=E2=80=99 may result in an unaligned pointe=
r value
>  [-Werror=3Daddress-of-packed-member]
>   209 |     q->sq.doorbell =3D &s->regs->doorbells[idx * 2 * s->doorbel=
l_scale];
>=20
> All members of the struct are naturally aligned, so there should
> not be the need for QEMU_PACKED here, and the following QEMU_BUILD_BUG_=
ON
> also ensures that there is no padding. Thus simply remove the QEMU_PACK=
ED
> here.
>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/1817525
> Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks, applied to the block branch.

Though I'm not sure why a compiler should warn if packed and non-packed
result in the exact same layout anyway...

Kevin
