Received: from eggs.gnu.org ([2001:4830:134:3::10]:38126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gChsF-0004HU-0o
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gChsA-0007j8-Sy
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:12:14 -0400
Date: Wed, 17 Oct 2018 10:12:04 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181017091204.GC22755@stefanha-x1.localdomain>
References: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
	<f47b81dbce734e9806f9516eba8ca588e6321c2f.1539764043.git.artem.k.pisarenko@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <f47b81dbce734e9806f9516eba8ca588e6321c2f.1539764043.git.artem.k.pisarenko@gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/4] Introduce attributes
 to qemu timer subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, "open list:Block I/O path" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2018 at 02:24:19PM +0600, Artem Pisarenko wrote:
> Attributes are simple flags, associated with individual timers for their =
whole lifetime.
> They intended to be used to mark individual timers for special handling b=
y various qemu features operating at qemu core level.

I'm worried that this sentence suggests various parts of QEMU will stash
state in ts->attributes.  That's messy and they shouldn't do this.  Make
the field private to qemu-timer.c.

Attributes should only affect qemu-timer.c behavior.  Other parts of
QEMU should not act differently based on timer attributes (i.e. checking
bits).  If they need to do that then it suggests something isn't
properly encapsulated in qemu-timer.c.

> diff --git a/include/block/aio.h b/include/block/aio.h
> index f08630c..fce9d48 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -388,6 +388,31 @@ struct LinuxAioState *aio_setup_linux_aio(AioContext=
 *ctx, Error **errp);
>  struct LinuxAioState *aio_get_linux_aio(AioContext *ctx);
> =20
>  /**
> + * aio_timer_new_with_attrs:
> + * @ctx: the aio context
> + * @type: the clock type
> + * @scale: the scale
> + * @attributes: 0, or one to multiple OR'ed QEMU_TIMER_ATTR(id) values t=
o assign

Further down in this patch the notation is QEMU_TIMER_ATTR_<id>, which I
think is clearer because QEMU_TIMER_ATTR(id) looks like a (non-existent)
macro.  Please use the QEMU_TIMER_ATTR_<id> notation consistently.

> +/**
> + * QEMU Timer attributes:
> + *
> + * An individual timer may be assigned with one or multiple attributes w=
hen
> + * initialized.
> + * Attribute is a static flag, meaning that timer has corresponding prop=
erty.
> + * Attributes are defined in QEMUTimerAttrBit enum and encoded to bit se=
t,
> + * which used to initialize timer, stored to 'attributes' member and can=
 be
> + * retrieved externally with timer_get_attributes() call.
> + * Values of QEMUTimerAttrBit aren't used directly,
> + * instead each attribute in bit set accessed with QEMU_TIMER_ATTR_<id> =
macro,
> + * where <id> is a unique part of attribute identifier.
> + *
> + * No attributes defined currently.
> + */
> +
> +typedef enum {
> +    QEMU_TIMER_ATTRBIT__NONE
> +} QEMUTimerAttrBit;
> +
> +#define QEMU_TIMER_ATTR__NONE (1 << QEMU_TIMER_ATTRBIT__NONE)

What is the purpose of this bit?  I guess it's just here as a
placeholder because no real bits have been defined yet.  Hopefully the
next patch removes it (/* This placeholder is removed in the next patch
*/ would be a nice way to document this for reviewers).

The enum isn't needed and makes debugging harder since the bit number is
implicit in the enum ordering.  This alternative is clearer and more
concise:

  #define QEMU_TIMER_ATTR_foo BIT(n)

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbxvzkAAoJEJykq7OBq3PIq+4H/iWNavNJhzOyNgMl2CBf45AQ
dKVjn5/KiqfHzzkAMdd2rFyMMKi8SXz7CS+e/0n6n8YY1DZShmGSsMSzM2OHXmqh
IkKfEC3D3lK9wcHqDhWRZ7vw3QHlutCq0BlAnJTGBki/PTaH9XJJ4kXqfKlhO5gw
htFpU/SCWBqEvBLYax49kkq0ksUxVZC39xyAapJl46iJkbIoBhQsYZPb44vWbkZJ
hQafg+7CYBwmPRhjMXYg2e90BbNwL3lCgqBaCp5FHV/C0zSmK2eJ9B5HJIqm/W8+
ggcVuxDhOaYrjM5eU+im65Xh1JMs+sCqMUC9zQbPTWDILV7eDgdlJsHgC8wDv4Y=
=trVN
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
