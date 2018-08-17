Received: from eggs.gnu.org ([2001:4830:134:3::10]:45786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqgJq-0002hn-IR
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqgJf-0001J2-Lf
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:05:37 -0400
References: <20180802144834.520904-1-eblake@redhat.com>
	<20180802144834.520904-3-eblake@redhat.com>
	<c7dc405d-0b83-b680-6e45-db4b211d3ef2@virtuozzo.com>
	<f3dd742c-cca3-3ee1-797e-72721752493e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4e759caf-4493-a473-fc63-82670e62c3b6@virtuozzo.com>
Date: Fri, 17 Aug 2018 18:04:26 +0300
MIME-Version: 1.0
In-Reply-To: <f3dd742c-cca3-3ee1-797e-72721752493e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 2/4] nbd/server: Advertise actual minimum
 block size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, rjones@redhat.com, qemu-block@nongnu.org

17.08.2018 17:53, Eric Blake wrote:
> On 08/17/2018 08:49 AM, Vladimir Sementsov-Ogievskiy wrote:
>
>>> BDRV_SECTOR_SIZE : 1;
>>> +=C2=A0=C2=A0=C2=A0 /* minimum - 1 for back-compat, or actual if client=
 will obey=20
>>> it. */
>>> +=C2=A0=C2=A0=C2=A0 if (client->opt =3D=3D NBD_OPT_INFO || blocksize) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizes[0] =3D blk_get_reques=
t_alignment(exp->blk);
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizes[0] =3D 1;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* preferred - Hard-code to 4096 for now=
.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * TODO: is blk_bs(blk)->bl.opt_tra=
nsfer appropriate? */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizes[1] =3D 4096;
>>
>> Here, what about dirty bitmap export through BLOCK_STATUS? Could it's=20
>> granularity be less than request_alignment? Shouldn't we handle it=20
>> somehow?
>
> Can you create a dirty bitmap with a granularity smaller than=20
> request_alignment?=C2=A0 I know you can configure dirty bitmap granularit=
y=20
> independently from cluster size (in both directions: either smaller or=20
> larger than cluster size), but that it has a least a minimum lower=20
> bounds of 512.=C2=A0 You're probably right that we also want it to have a=
=20
> minimum lower bound of the request_alignment (if you're using a device=20
> with 4k minimum I/O, request_alignment would be 4k, and having a dirty=20
> bitmap any smaller than that granularity is wasted space).
>
> On the other hand, I also think we're safe for this patch: even if you=20
> waste the space by creating a bitmap with too-small granularity, the=20
> actions that write bits into the bitmap will still be aligned to=20
> request_alignment,

Not quite right: nbd_export_bitmap searches through the backing chain=20
for the bitmap, and it may correspond to the bds with smaller=20
request_alignment.

> which means you always set a multiple of bits per action; when reading=20
> back the dirty bitmap to report over NBD_CMD_BLOCK_STATUS, you'll=20
> never encounter a change in bit status except on alignment boundaries=20
> (based on how the bits were written), and thus what NBD reports will=20
> still be aligned to the advertised minimum size, rather than the=20
> smaller bitmap granularity.
>


--=20
Best regards,
Vladimir
