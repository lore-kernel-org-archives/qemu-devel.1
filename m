Received: from eggs.gnu.org ([2001:4830:134:3::10]:38467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIs5R-0004a9-OP
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIs5N-0003w7-Ne
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:42:33 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:37520)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIs5N-0003w0-7f
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:42:29 -0400
Date: Thu, 8 Jun 2017 10:41:49 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170608074149.4qhb66k6ujyonlo4@postretch>
References: <20170607130619.1545-1-el13635@mail.ntua.gr>
	<20170608072228.GA2232@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oysa5wv3kdho7fqe"
Content-Disposition: inline
In-Reply-To: <20170608072228.GA2232@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH RFC] block: add throttle block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kwolf@redhat.com, berto@igalia.com, qemu-devel@nongnu.org


--oysa5wv3kdho7fqe
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 08:22:28AM +0100, Stefan Hajnoczi wrote:
>On Wed, Jun 07, 2017 at 04:06:19PM +0300, Manos Pitsidianakis wrote:
>> +#define QEMU_OPT_IOPS_TOTAL "iops-total"
>> +#define QEMU_OPT_IOPS_TOTAL_MAX "iops-total-max"
>> +#define QEMU_OPT_IOPS_TOTAL_MAX_LENGTH "iops-total-max-length"
>> +#define QEMU_OPT_IOPS_READ "iops-read"
>> +#define QEMU_OPT_IOPS_READ_MAX "iops-read-max"
>> +#define QEMU_OPT_IOPS_READ_MAX_LENGTH "iops-read-max-length"
>> +#define QEMU_OPT_IOPS_WRITE "iops-write"
>> +#define QEMU_OPT_IOPS_WRITE_MAX "iops-write-max"
>> +#define QEMU_OPT_IOPS_WRITE_MAX_LENGTH "iops-write-max-length"
>> +#define QEMU_OPT_BPS_TOTAL "bps-total"
>> +#define QEMU_OPT_BPS_TOTAL_MAX "bps-total-max"
>> +#define QEMU_OPT_BPS_TOTAL_MAX_LENGTH "bps-total-max-length"
>> +#define QEMU_OPT_BPS_READ "bps-read"
>> +#define QEMU_OPT_BPS_READ_MAX "bps-read-max"
>> +#define QEMU_OPT_BPS_READ_MAX_LENGTH "bps-read-max-length"
>> +#define QEMU_OPT_BPS_WRITE "bps-write"
>> +#define QEMU_OPT_BPS_WRITE_MAX "bps-write-max"
>> +#define QEMU_OPT_BPS_WRITE_MAX_LENGTH "bps-write-max-length"
>> +#define QEMU_OPT_IOPS_SIZE "iops-size"
>> +#define QEMU_OPT_THROTTLE_GROUP_NAME "throttle-group"
>
>Please reuse include/qemu/throttle-options.h.

This would make the options too verbose, ie -drive=20
driver=3Dthrottle,file=3D..,throttling.iops-total=3D..,throttling. Eventual=
ly=20
of course throttle-options.h will be replaced.

However, this can't be done at this point anyway, since the=20
throttling.[...] options are consumed by the already existing throttling=20
code, and are unavailable for the driver.
>
>> +static QemuMutex throttle_groups_lock;
>> +static QTAILQ_HEAD(, ThrottleGroup) throttle_groups =3D
>> +    QTAILQ_HEAD_INITIALIZER(throttle_groups);
>
>Please reuse block/throttle-groups.c.  I think throttle-groups.c doesn't
>actually need BlockBackend so you can make the code more general.
>
>Define the necessary state:
>
>  typedef struct ThrottleGroupMember {
>    /* Protected by AioContext lock.  */
>    CoQueue      throttled_reqs[2];
>
>    /* Nonzero if the I/O limits are currently being ignored; generally
>     * it is zero.  */
>    unsigned int io_limits_disabled;
>
>    /* The following fields are protected by the ThrottleGroup lock.
>     * See the ThrottleGroup documentation for details.
>     * throttle_state tells us if I/O limits are configured. */
>    ThrottleState *throttle_state;
>    ThrottleTimers throttle_timers;
>    unsigned       pending_reqs[2];
>    QLIST_ENTRY(ThrottleGroupMember) round_robin;
>  } ThrottleGroupMember;
>
>Then refactor throttle-groups.c to use ThrottleGroupMember instead of
>BlockBackend(Public).

I've already done this, it was just in a different branch.

>
>> diff --git a/include/block/throttle.h b/include/block/throttle.h
>> new file mode 100644
>> index 0000000000..fed24f02a6
>> --- /dev/null
>> +++ b/include/block/throttle.h
>
>What is the purpose of this header?
>
>Header files in include/* are "public" APIs that other parts of QEMU can
>use.  There is no user other than block/throttle.c so please keep it
>private in the .c file.

Eventually the qmp/hmp/qom related stuff will be in a header file, and=20
this is why I put them from the beginning separately. But yes, in this=20
case it is not needed. Also, these probably should go to=20
include/qemu/throttle.h instead of a separate header file.

>
>> @@ -0,0 +1,59 @@
>> +/* The ThrottleGroup structure (with its ThrottleState) is shared
>> + * among different BlockDriverStates and it's independent from
>> + * AioContext, so in order to use it from different threads it needs
>> + * its own locking.
>> + *
>> + * This locking is however handled internally in block/throttle.c so it=
's
>> + * transparent to outside users.
>> + *
>> + * The whole ThrottleGroup structure is private and invisible to
>> + * outside users, that only use it through its ThrottleState.
>> + *
>> + * In addition to the ThrottleGroup structure, BlockDriverState has
>> + * fields that need to be accessed by other members of the group and
>> + * therefore also need to be protected by this lock. Once a
>> + * BlockDriverState is registered in a group those fields can be access=
ed
>> + * by other threads any time.
>> + *
>> + * Again, all this is handled internally in block/throttle.c and is mos=
tly
>> + * transparent to the outside. The 'throttle_timers' field however has =
an
>> + * additional constraint because it may be temporarily invalid (see for=
 example
>> + * bdrv_set_aio_context()). Therefore block/throttle.c will access some
>> + * other BlockDriverState's timers only after verifying that that BDS h=
as
>> + * throttled requests in the queue.
>> + */
>> +
>> +typedef struct ThrottleGroup {
>> +    char *name; /* This is constant during the lifetime of the group */
>> +
>> +    QemuMutex lock; /* This lock protects the following four fields */
>> +    ThrottleState ts;
>> +    QLIST_HEAD(, BDRVThrottleNodeState) head;
>> +    struct BDRVThrottleNodeState *tokens[2];
>> +    bool any_timer_armed[2];
>> +
>> +    /* These two are protected by the global throttle_groups_lock */
>> +    unsigned refcount;
>> +    QTAILQ_ENTRY(ThrottleGroup) list;
>> +} ThrottleGroup;
>> +
>> +typedef struct BDRVThrottleNodeState {
>> +    ThrottleGroup *throttle_group;
>> +
>> +    /* I/O throttling has its own locking, but also some fields are
>> +     * protected by the AioContext lock.
>> +     */
>> +
>> +    /* Protected by AioContext lock.  */
>> +    CoQueue      throttled_reqs[2];
>> +
>> +    /* Nonzero if the I/O limits are currently being ignored; generally
>> +     * it is zero.  */
>> +    unsigned int io_limits_disabled;
>> +
>> +    ThrottleState *throttle_state;
>> +    ThrottleTimers throttle_timers;
>> +    unsigned       pending_reqs[2];
>> +    QLIST_ENTRY(BDRVThrottleNodeState) round_robin;
>> +
>> +} BDRVThrottleNodeState;
>> --
>> 2.11.0
>>



--oysa5wv3kdho7fqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlk4/70ACgkQc2J8L2kN
9xCXeA/7BsZVoaGsz3Ne8hHVFjdm3e7RHfzC+zsgN1FHKgAWPx/WpIRp4mCZnwyY
e74bfYUnK+3EDuy5Ve1tWU0JfNzX0dpzJE117v0VWH/WVjKjcqnN09vx2+AUTy0Z
6YGFamWB7e1oRLVb0w4V0eQiABT8ecqvSl5CXGbrHU1wYGQKLL1+u6pU37N/rgkK
Io+gLXMGkjOvNc6k2OVz1XxwzR7nPKCrV2aDoG2EPKFYwJWIJMRhnpeJuFLGDDDu
NoDAPmGpN+jZ5C7Tl73lmKCTrx8eGezonBIiCC6MDV3Jmu33hge6nFQ6+fFYinYe
UVU+qu7vkmidOa8BokUMBT6RFUOPJkd4FaGKmLzJ7+CYWnTrd5Ny9v6D0bWrMibn
HC+L5VUBW48+Pr5awQlUjUaanokDAsYqo7jfO7U1RhOhiMcgwrLSaymECk0MXFXa
W94vCB93thTPP3TKybFGGoMcNiNw8JQgu4Qqr97anc+GLI3LTfYoBCDo+LrUPRQT
OmUzpuQFev51knqPnjGMPCCVMLX3ZtOnMtiuYRZPP7y3Q84r4IDllvrxbA0Jhdja
lmxha0TscXKcgU3OLGEYd8UCJYUew6Ot+TPfFSs6ZPpEBm7bwcHleJUD2RkYLeEN
gRoXiGGcAcajmuCH5IKXojYpbWmEDGJgF1BIZtinfCfRLQniLOQ=
=I/KT
-----END PGP SIGNATURE-----

--oysa5wv3kdho7fqe--
