Received: from eggs.gnu.org ([2001:4830:134:3::10]:57009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEFYU-00083q-A8
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEFYS-0007po-TH
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:49:58 -0400
References: <20180501211336.986372-1-eblake@redhat.com>
	<20180501211336.986372-4-eblake@redhat.com>
	<26f63bd9-4f91-fd46-631c-5f12c04fc9e0@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <49fac5ae-4a46-65bf-e889-b5bf979391f3@redhat.com>
Date: Thu, 3 May 2018 09:49:48 -0500
MIME-Version: 1.0
In-Reply-To: <26f63bd9-4f91-fd46-631c-5f12c04fc9e0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] nbd/client: Support requests of
 additional block sizing info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, edgar.kaziakhmedov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 05/03/2018 04:17 AM, Vladimir Sementsov-Ogievskiy wrote:
> 02.05.2018 00:13, Eric Blake wrote:
>> The NBD spec is clarifying [1] that a server may want to advertise
>> different limits for READ/WRITE (in our case, 32M) than for
>> TRIM/ZERO (in our case, nearly 4G).=C2=A0 Implement the client
>> side support for these alternate limits, by always requesting
>> the new information (a compliant server must ignore the
>> request if it is unknown), and by validating anything reported
>> by the server before populating the block layer limits.
>>
>> [1] https://lists.debian.org/nbd/2018/03/msg00048.html
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> +++ b/nbd/client.c
>> @@ -337,16 +337,18 @@ static int nbd_opt_go(QIOChannel *ioc, const=20
>> char *wantname,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->flags =3D 0;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nbd_opt_go_start(wantname);
>> -=C2=A0=C2=A0=C2=A0 buf =3D g_malloc(4 + len + 2 + 2 * info->request_s=
izes + 1);
>> +=C2=A0=C2=A0=C2=A0 buf =3D g_malloc(4 + len + 2 + 3 * 2 * info->reque=
st_sizes + 1);
>=20
> Hmm, what "+1" means?

Doesn't appear to be necessary, but a little slop never hurts.  Better=20
might be struct-ifying things rather than open-coding offsets, or even=20
using a vectored approach rather than requiring a single buffer.  But if=20
useful, that's refactoring that is independent of this patch, while this=20
is just demonstrating the bare minimum implementation of the new feature.

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stl_be_p(buf, len);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(buf + 4, wantname, len);
>> -=C2=A0=C2=A0=C2=A0 /* At most one request, everything else up to serv=
er */
>> -=C2=A0=C2=A0=C2=A0 stw_be_p(buf + 4 + len, info->request_sizes);
>> +=C2=A0=C2=A0=C2=A0 /* Either 0 or 3 requests, everything else up to s=
erver */
>> +=C2=A0=C2=A0=C2=A0 stw_be_p(buf + 4 + len, 3 * info->request_sizes);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (info->request_sizes) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stw_be_p(buf + =
4 + len + 2, NBD_INFO_BLOCK_SIZE);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stw_be_p(buf + 4 + len + 2=
 + 2, NBD_INFO_TRIM_SIZE);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stw_be_p(buf + 4 + len + 2=
 + 2 + 2, NBD_INFO_ZERO_SIZE);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error =3D nbd_send_option_request(ioc, =
NBD_OPT_GO,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4 + le=
n + 2 + 2 *=20
>> info->request_sizes,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4 + le=
n + 2 + 3 * 2 *=20
>> info->request_sizes,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 buf, errp);
>=20
> magic chunk) Change looks correct. Is it worth introducing a buf_len=20
> variable, to
> not retype it?

And increment as we go?  Yeah, it might make things more legible.


>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be=
32_to_cpus(&info->max_trim);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (!info->min_trim || !info->max_trim ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (info->max_trim !=3D UINT32_MAX &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 !QEMU_IS_ALIGNED(info->max_trim, info->min_tr=
im))) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "server trim sizes %" PRIu32 "/%"=20
>> PRIu32
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 " are not valid", info->min_trim,=20
>> info->max_trim);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 nbd_send_opt_abort(ioc);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> Didn't you forget to check that min_trim is a power of two?

Nope. The NBD spec wording specifically uses "The minimum trim size=20
SHOULD be a power of 2, and MUST be at least as large as the preferred=20
block size advertised in `NBD_INFO_BLOCK_SIZE`", in part because there=20
ARE existing hardware iscsi devices that have an advertised=20
preferred/maximum trim size of exactly 15 megabytes (you can request=20
smaller trims 1M at a time, and the device then caches things to=20
eventually report unmapped slices at a 15M boundary).  For more=20
information on this odd hardware, look in the qemu logs for the Dell=20
Equallogic device, such as commit 3482b9bc.

Since the NBD 'min trim' is advisory, and merely telling the client the=20
ideal alignments to use for a trim most likely to have an effect (on=20
Equallogic, a 1M trim by itself might not trim anything unless=20
neighboring areas are also trimmed, while an aligned 15M trim is=20
immediately observable), an NBD server wrapping such an iscsi device may=20
prefer to mirror the hardware's preferred alignment of 15M, rather than=20
inventing a minimum alignment of 1M, in what it advertises in=20
NBD_INFO_TRIM_SIZE.

And maybe I should tweak the NBD spec addition to call things "preferred=20
trim/zero" rather than "min trim/zero", if that makes things any easier=20
to grasp on first read, and better matches the iscsi concept.

>=20
> hmm, so, now nbd_opt_go() is full of very-very similar code parts, whic=
h=20
> may worth some refactoring now or in future.
>=20
> Are we going to add similar limits for BLOCK_STATUS? and for CACHE? I=20
> have an idea: why not to make an universal option for it in
> protocol? Something like
>=20
> option INFO_CMD_SIZE:
>  =C2=A0 uint16_t command
>  =C2=A0 uint32_t min_block
>  =C2=A0 uint32_t max_block
>=20
> and server can send several such options. Most of semantics for these=20
> additional limits are common, so it will simplify both documentation
> and realization..
>=20
> I'll copy this to nbd thread and it is better to discuss it in it.

Yep, I've followed up on that thread, but will post a v2 of this=20
proposal along those lines.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
