Received: from eggs.gnu.org ([2001:4830:134:3::10]:44664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnINw-0001fC-Of
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 01:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnINt-0007Wd-LC
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 01:51:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dnINt-0007WT-Ei
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 01:51:21 -0400
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-2-pasic@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b5d3ac95-3811-c39a-c4d7-bb85dc4580e8@redhat.com>
Date: Thu, 31 Aug 2017 07:51:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170830163609.50260-2-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/9] s390x/css: fix cc handling for XSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 30.08.2017 18:36, Halil Pasic wrote:
> The function ioinst_handle_xsch is presenting cc 2 when it's supposed t=
o
> present cc 1 and the other way around, because css_do_xsch has the erro=
r
> codes mixed up. Fixing the error codes also fixes the priority.
>=20
> Let us fix this.

(Nit: In case you respin, I'd suggest to remove the last sentence. You
already used "fix" two times in the previous one)

> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reported-by: Pierre Morel<pmorel@linux.vnet.ibm.com>

Space missing -------------^

> ---
>  hw/s390x/css.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 1880b1a0ff..a50fb0727e 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1281,12 +1281,12 @@ int css_do_xsch(SubchDev *sch)
>          (!(s->ctrl &
>             (SCSW_ACTL_RESUME_PEND | SCSW_ACTL_START_PEND | SCSW_ACTL_S=
USP))) ||
>          (s->ctrl & SCSW_ACTL_SUBCH_ACTIVE)) {
> -        ret =3D -EINPROGRESS;
> +        ret =3D -EBUSY;
>          goto out;
>      }
> =20
>      if (s->ctrl & SCSW_CTRL_MASK_STCTL) {
> -        ret =3D -EBUSY;
> +        ret =3D -EINPROGRESS;
>          goto out;
>      }

Using both, EBUSY and EINPROGRESS as error codes sounds very confusing
to me here ... what's the difference between busy and in-progress? So
while you're at it, maybe you could replace the code for CC 2 ("CANCEL
SUBCHANNEL not applicable") with a different error code?

 Thomas
