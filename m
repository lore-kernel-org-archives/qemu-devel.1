Received: from eggs.gnu.org ([2001:4830:134:3::10]:51018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1ejo7W-0007Dd-V2
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1ejo7S-0000sf-RL
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:28:18 -0500
References: <20180208132336.6519-1-edgar.kaziakhmedov@virtuozzo.com>
	<60f2b126-21f2-c46b-d4c9-143b28b1f613@redhat.com>
From: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Message-ID: <5e16ec84-cb79-33be-a90c-fbb411a832f9@virtuozzo.com>
Date: Thu, 8 Feb 2018 18:28:06 +0300
MIME-Version: 1.0
In-Reply-To: <60f2b126-21f2-c46b-d4c9-143b28b1f613@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/1] nbd: increase maximum size of the
 PWRITE_ZERO request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>



On 02/08/2018 05:54 PM, Eric Blake wrote:
> On 02/08/2018 07:23 AM, Edgar Kaziakhmedov wrote:
>> Upstream NBD protocol implementation supports an efficient zero out
>> mechanism over the wire, along with the ability to check whether a
>> client allows using a hole.
>>
>> Accordingly, since PWRITE_ZERO doesn't involve any payload on the wire,
>> increase a maximum size of the PWRITE_ZERO request up to 1Gb (aligned).
>> Moreover, such change will decrease the number of PWRITE_ZERO NBD=20
>> commands
>> in comparison with the current 32M limit. The benefits of
>> the larger constraint can be examined in a block mirroring over NBD.
>
> We've got a potential problem.=C2=A0 Unless you have out-of-band=20
> communication of the maximum NBD_CMD_WRITE_ZEROES sizing (or if the=20
> NBD protocol is enhanced to advertise that as an additional piece of=20
> block size information during NBD_OPT_GO), then a client CANNOT assume=20
> that the server will accept a request this large. We MIGHT get lucky=20
> if all existing servers that accept WRITE_ZEROES requests either act=20
> on large requests or reply with EINVAL but do not outright drop the=20
> connection (which is different from servers that DO outright drop the=20
> connection for an NBD_CMD_WRITE larger than 32M).=C2=A0 But I don't know =
if=20
> that's how all servers behave, so sending a too-large WRITE_ZEROES=20
> request may have the unintended consequence of killing the connection.
Actually, I do not understand why current NBD servers shouldn't accept=20
such large requests, because most servers should apply some=20
optimizations avoiding direct filling with zeroes.
As for block-mirroring over NBD, it works fine with QEMU server=20
implementation and isn't it the main application?
>
> I'm adding the NBD list; perhaps before accepting this into qemu, I=20
> should revive my earlier attempt at codifying an NBD_OPT_GO info=20
> advertisement for maximum trim/zero sizing, which would let clients=20
> have a guarantee that their choice of sizing won't cause unexpected=20
> failures.
>
>>
>> Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
>> ---
>> =C2=A0 block/nbd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +=
-
>> =C2=A0 include/block/nbd.h | 3 +++
>> =C2=A0 2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/nbd.c b/block/nbd.c
>> index 94220f6d14..3641d9244e 100644
>> --- a/block/nbd.c
>> +++ b/block/nbd.c
>> @@ -477,7 +477,7 @@ static void nbd_refresh_limits(BlockDriverState=20
>> *bs, Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t max =3D MIN_NON_ZERO(NBD_MAX_BUF=
FER_SIZE,=20
>> s->info.max_block);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->bl.max_pdiscard =3D max;
>> -=C2=A0=C2=A0=C2=A0 bs->bl.max_pwrite_zeroes =3D max;
>> +=C2=A0=C2=A0=C2=A0 bs->bl.max_pwrite_zeroes =3D NBD_MAX_PWRITE_ZERO_SIZ=
E;
>
> max_discard should get the same treatment, whatever we decide (yes, it=20
> is feasible that a server may have different limits for NBD_CMD_TRIM=20
> than for NBD_CMD_WRITE_ZEROES, but in general, it's probably easier if=20
> both commands share theh same limit as both have very similar=20
> implementations).
Sounds reasonable.
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->bl.max_transfer =3D max;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->info.opt_block &&
>> diff --git a/include/block/nbd.h b/include/block/nbd.h
>> index ee74ec391a..e2f18e2332 100644
>> --- a/include/block/nbd.h
>> +++ b/include/block/nbd.h
>> @@ -182,6 +182,9 @@ enum {
>> =C2=A0 /* Maximum size of a single READ/WRITE data buffer */
>> =C2=A0 #define NBD_MAX_BUFFER_SIZE (32 * 1024 * 1024)
>>
>> +/* Maximum size of a single PWRITE_ZERO request 1Gb */
>> +#define NBD_MAX_PWRITE_ZERO_SIZE (1024 * 1024 * 1024)
>> +
>> =C2=A0 /* Maximum size of an export name. The NBD spec requires 256 and
>> =C2=A0=C2=A0 * suggests that servers support up to 4096, but we stick to=
 only the
>> =C2=A0=C2=A0 * required size so that we can stack-allocate the names, an=
d because
>> --=20
>> 2.11.0
>>
>>
>
