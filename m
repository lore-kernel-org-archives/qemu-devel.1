Received: from eggs.gnu.org ([2001:4830:134:3::10]:40825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqg8E-0005lh-CN
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqg8D-0007uq-JM
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:53:42 -0400
References: <20180802144834.520904-1-eblake@redhat.com>
	<20180802144834.520904-3-eblake@redhat.com>
	<c7dc405d-0b83-b680-6e45-db4b211d3ef2@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f3dd742c-cca3-3ee1-797e-72721752493e@redhat.com>
Date: Fri, 17 Aug 2018 09:53:37 -0500
MIME-Version: 1.0
In-Reply-To: <c7dc405d-0b83-b680-6e45-db4b211d3ef2@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, rjones@redhat.com, qemu-block@nongnu.org

On 08/17/2018 08:49 AM, Vladimir Sementsov-Ogievskiy wrote:

>> BDRV_SECTOR_SIZE : 1;
>> +=C2=A0=C2=A0=C2=A0 /* minimum - 1 for back-compat, or actual if clien=
t will obey it. */
>> +=C2=A0=C2=A0=C2=A0 if (client->opt =3D=3D NBD_OPT_INFO || blocksize) =
{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizes[0] =3D blk_get_reque=
st_alignment(exp->blk);
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizes[0] =3D 1;
>> +=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* preferred - Hard-code to 4096 for no=
w.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * TODO: is blk_bs(blk)->bl.opt_tr=
ansfer appropriate? */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizes[1] =3D 4096;
>=20
> Here, what about dirty bitmap export through BLOCK_STATUS? Could it's=20
> granularity be less than request_alignment? Shouldn't we handle it some=
how?

Can you create a dirty bitmap with a granularity smaller than=20
request_alignment?  I know you can configure dirty bitmap granularity=20
independently from cluster size (in both directions: either smaller or=20
larger than cluster size), but that it has a least a minimum lower=20
bounds of 512.  You're probably right that we also want it to have a=20
minimum lower bound of the request_alignment (if you're using a device=20
with 4k minimum I/O, request_alignment would be 4k, and having a dirty=20
bitmap any smaller than that granularity is wasted space).

On the other hand, I also think we're safe for this patch: even if you=20
waste the space by creating a bitmap with too-small granularity, the=20
actions that write bits into the bitmap will still be aligned to=20
request_alignment, which means you always set a multiple of bits per=20
action; when reading back the dirty bitmap to report over=20
NBD_CMD_BLOCK_STATUS, you'll never encounter a change in bit status=20
except on alignment boundaries (based on how the bits were written), and=20
thus what NBD reports will still be aligned to the advertised minimum=20
size, rather than the smaller bitmap granularity.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
