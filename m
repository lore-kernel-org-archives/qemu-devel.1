Received: from eggs.gnu.org ([2001:4830:134:3::10]:34501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIrm8-0006FH-3U
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIrm5-0005X6-07
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:22:36 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:38129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dIrm4-0005Wv-M7
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:22:32 -0400
Received: by mail-wm0-x236.google.com with SMTP id n195so24833093wmg.1
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 00:22:32 -0700 (PDT)
Date: Thu, 8 Jun 2017 08:22:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170608072228.GA2232@stefanha-x1.localdomain>
References: <20170607130619.1545-1-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20170607130619.1545-1-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH RFC] block: add throttle block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, berto@igalia.com


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 04:06:19PM +0300, Manos Pitsidianakis wrote:
> +#define QEMU_OPT_IOPS_TOTAL "iops-total"
> +#define QEMU_OPT_IOPS_TOTAL_MAX "iops-total-max"
> +#define QEMU_OPT_IOPS_TOTAL_MAX_LENGTH "iops-total-max-length"
> +#define QEMU_OPT_IOPS_READ "iops-read"
> +#define QEMU_OPT_IOPS_READ_MAX "iops-read-max"
> +#define QEMU_OPT_IOPS_READ_MAX_LENGTH "iops-read-max-length"
> +#define QEMU_OPT_IOPS_WRITE "iops-write"
> +#define QEMU_OPT_IOPS_WRITE_MAX "iops-write-max"
> +#define QEMU_OPT_IOPS_WRITE_MAX_LENGTH "iops-write-max-length"
> +#define QEMU_OPT_BPS_TOTAL "bps-total"
> +#define QEMU_OPT_BPS_TOTAL_MAX "bps-total-max"
> +#define QEMU_OPT_BPS_TOTAL_MAX_LENGTH "bps-total-max-length"
> +#define QEMU_OPT_BPS_READ "bps-read"
> +#define QEMU_OPT_BPS_READ_MAX "bps-read-max"
> +#define QEMU_OPT_BPS_READ_MAX_LENGTH "bps-read-max-length"
> +#define QEMU_OPT_BPS_WRITE "bps-write"
> +#define QEMU_OPT_BPS_WRITE_MAX "bps-write-max"
> +#define QEMU_OPT_BPS_WRITE_MAX_LENGTH "bps-write-max-length"
> +#define QEMU_OPT_IOPS_SIZE "iops-size"
> +#define QEMU_OPT_THROTTLE_GROUP_NAME "throttle-group"

Please reuse include/qemu/throttle-options.h.

> +static QemuMutex throttle_groups_lock;
> +static QTAILQ_HEAD(, ThrottleGroup) throttle_groups =3D
> +    QTAILQ_HEAD_INITIALIZER(throttle_groups);

Please reuse block/throttle-groups.c.  I think throttle-groups.c doesn't
actually need BlockBackend so you can make the code more general.

Define the necessary state:

  typedef struct ThrottleGroupMember {
    /* Protected by AioContext lock.  */
    CoQueue      throttled_reqs[2];

    /* Nonzero if the I/O limits are currently being ignored; generally
     * it is zero.  */
    unsigned int io_limits_disabled;

    /* The following fields are protected by the ThrottleGroup lock.
     * See the ThrottleGroup documentation for details.
     * throttle_state tells us if I/O limits are configured. */
    ThrottleState *throttle_state;
    ThrottleTimers throttle_timers;
    unsigned       pending_reqs[2];
    QLIST_ENTRY(ThrottleGroupMember) round_robin;
  } ThrottleGroupMember;

Then refactor throttle-groups.c to use ThrottleGroupMember instead of
BlockBackend(Public).

> diff --git a/include/block/throttle.h b/include/block/throttle.h
> new file mode 100644
> index 0000000000..fed24f02a6
> --- /dev/null
> +++ b/include/block/throttle.h

What is the purpose of this header?

Header files in include/* are "public" APIs that other parts of QEMU can
use.  There is no user other than block/throttle.c so please keep it
private in the .c file.

> @@ -0,0 +1,59 @@
> +/* The ThrottleGroup structure (with its ThrottleState) is shared
> + * among different BlockDriverStates and it's independent from
> + * AioContext, so in order to use it from different threads it needs
> + * its own locking.
> + *
> + * This locking is however handled internally in block/throttle.c so it's
> + * transparent to outside users.
> + *
> + * The whole ThrottleGroup structure is private and invisible to
> + * outside users, that only use it through its ThrottleState.
> + *
> + * In addition to the ThrottleGroup structure, BlockDriverState has
> + * fields that need to be accessed by other members of the group and
> + * therefore also need to be protected by this lock. Once a
> + * BlockDriverState is registered in a group those fields can be accessed
> + * by other threads any time.
> + *
> + * Again, all this is handled internally in block/throttle.c and is most=
ly
> + * transparent to the outside. The 'throttle_timers' field however has an
> + * additional constraint because it may be temporarily invalid (see for =
example
> + * bdrv_set_aio_context()). Therefore block/throttle.c will access some
> + * other BlockDriverState's timers only after verifying that that BDS has
> + * throttled requests in the queue.
> + */
> +
> +typedef struct ThrottleGroup {
> +    char *name; /* This is constant during the lifetime of the group */
> +
> +    QemuMutex lock; /* This lock protects the following four fields */
> +    ThrottleState ts;
> +    QLIST_HEAD(, BDRVThrottleNodeState) head;
> +    struct BDRVThrottleNodeState *tokens[2];
> +    bool any_timer_armed[2];
> +
> +    /* These two are protected by the global throttle_groups_lock */
> +    unsigned refcount;
> +    QTAILQ_ENTRY(ThrottleGroup) list;
> +} ThrottleGroup;
> +
> +typedef struct BDRVThrottleNodeState {
> +    ThrottleGroup *throttle_group;
> +
> +    /* I/O throttling has its own locking, but also some fields are
> +     * protected by the AioContext lock.
> +     */
> +
> +    /* Protected by AioContext lock.  */
> +    CoQueue      throttled_reqs[2];
> +
> +    /* Nonzero if the I/O limits are currently being ignored; generally
> +     * it is zero.  */
> +    unsigned int io_limits_disabled;
> +
> +    ThrottleState *throttle_state;
> +    ThrottleTimers throttle_timers;
> +    unsigned       pending_reqs[2];
> +    QLIST_ENTRY(BDRVThrottleNodeState) round_robin;
> +
> +} BDRVThrottleNodeState;
> --=20
> 2.11.0
>=20

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZOPs0AAoJEJykq7OBq3PI0U4IAKp/AjJzC3EdEf+/vVAQvWkv
isG710Faw0sTyuTvZAADLvUBeNiqBdBiPIMs/HvXWkDCArq6BcrTJ0md6Bbx7KKu
SOqHPE4puRHk16elVDHxraE15miZN56FpZSx+QXkL+h3HjXI+7y2dH1WCQps1Z77
n7cfrJ81c+NRGX+1376wfXMNkHviYznx9szmeWVBEH4dvdCCJGlqqncQdzFg7SrU
Oeilv/UBwW7DUsLTn8/14l+9iIn1inDl5UnGjHlKzKd7fJr6waiKhgWvuw7tZ5Et
l9uKb1kYxK6YrDuDupQIkSjzG9oeB6sPKcaiYyp2ki0lgUgE4pfyk15229oE7Ps=
=KXw8
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
