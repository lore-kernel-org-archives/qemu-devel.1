Received: from eggs.gnu.org ([2001:4830:134:3::10]:34217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4jyn-0005CO-5r
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4jym-0007dZ-Bq
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 04:45:33 -0400
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-3-pasic@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b4123d43-4f09-d4c8-a280-61d1d1c77035@redhat.com>
Date: Wed, 18 Oct 2017 10:45:28 +0200
MIME-Version: 1.0
In-Reply-To: <20171017140453.51099-3-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/7] s390x/css: IO instr handler ending
 control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On 17.10.2017 16:04, Halil Pasic wrote:
> CSS code needs to tell the IO instruction handlers located in how shoul=
d

locate in? ... sorry, I've got trouble to parse this sentence ...

> the emulated instruction be ended. Currently this is done by returning
> generic (POSIX) error codes, and mapping them to outcomes like conditio=
n
> codes. This makes bugs easy to create and hard to recognise.
>=20
> As a preparation for moving a way form (mis)using generic error codes f=
or

s/a way/away/ ?

> flow control let us introduce a type which tells the instruction
> handler function how to end the instruction, in a more straight-forward
> and less ambiguous way.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  include/hw/s390x/css.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index 69b374730e..7e0dbd162f 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -99,6 +99,22 @@ typedef struct CcwDataStream {
>      hwaddr cda;
>  } CcwDataStream;
> =20
> +/*
> + * IO instructions conclude according this. Currently we have only

Maybe rather "terminate like this" or "finish like this"? I'm not a
native speaker, but "conclude" sounds a little bit strange to me here.

> + * cc codes. Valid values are 0,1,2,3 and the generic semantic for
> + * IO instructions is described briefly. For more details consult the =
PoP.
> + */
> +typedef enum IOInstEnding {
> +    /* produced expected result */
> +    IOINST_CC_EXPECTED =3D 0,
> +    /* status conditions were present or produced alternate result */
> +    IOINST_CC_STATUS_PRESENT =3D 1,
> +    /* inst. ineffective because busy with previously initiated functi=
on */
> +    IOINST_CC_BUSY =3D 2,
> +    /* inst. ineffective because not operational */
> +    IOINST_CC_NOT_OPERATIONAL =3D 3
> +} IOInstEnding;
> +
>  typedef struct SubchDev SubchDev;
>  struct SubchDev {
>      /* channel-subsystem related things: */
>=20

With the patch description fixed:

Reviewed-by: Thomas Huth <thuth@redhat.com>
