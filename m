Received: from eggs.gnu.org ([2001:4830:134:3::10]:54489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHo3l-0001ii-Cc
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eHo3k-00007y-3z
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:44:41 -0500
Date: Thu, 23 Nov 2017 10:44:26 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171123094426.GA4375@localhost.localdomain>
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510654613-47868-3-git-send-email-anton.nefedov@virtuozzo.com>
	<97df2225-908c-e817-8364-2454f1451768@redhat.com>
	<1dae35e5-390f-cfbe-fbd1-8c993517d596@virtuozzo.com>
	<efa75e61-f1f7-478f-b5b5-ab39491761e2@redhat.com>
	<20171121174202.GD11073@localhost.localdomain>
	<4c1a13c9-e5e5-b61f-76c2-ecb284a08349@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4c1a13c9-e5e5-b61f-76c2-ecb284a08349@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] qcow2: multiple clusters write
 compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com, Pavel Butsykin <pbutsykin@virtuozzo.com>

Am 23.11.2017 um 10:04 hat Anton Nefedov geschrieben:
>=20
>=20
> On 21/11/2017 8:42 PM, Kevin Wolf wrote:
> > Am 15.11.2017 um 17:30 hat Max Reitz geschrieben:
> > > On 2017-11-15 17:28, Anton Nefedov wrote:
> > > > On 15/11/2017 6:11 PM, Max Reitz wrote:
> > > > > On 2017-11-14 11:16, Anton Nefedov wrote:
> > > > > > From: Pavel Butsykin <pbutsykin@virtuozzo.com>
> > > > > >=20
> > > > > > At the moment, qcow2_co_pwritev_compressed can process the re=
quests size
> > > > > > less than or equal to one cluster. This patch added possibili=
ty to write
> > > > > > compressed data in the QCOW2 more than one cluster. The imple=
mentation
> > > > > > is simple, we just split large requests into separate cluster=
s and write
> > > > > > using existing functionality. For unaligned requests we use a=
 workaround
> > > > > > and do write data without compression.
> > > > > >=20
> > > > > > Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> > > > > > ---
> > > > > >  =A0 block/qcow2.c | 77
> > > > > > +++++++++++++++++++++++++++++++++++++++++++----------------
> > > > > >  =A0 1 file changed, 56 insertions(+), 21 deletions(-)
> > > > >=20
> > > > > On one hand, it might be better to do this centrally somewhere =
in
> > > > > block/io.c.=A0 On the other, that would require more work becau=
se it would
> > > > > probably mean having to introduce another field in BlockLimits,=
 and it
> > > > > wouldn't do much -- because qcow (v1) is, well, qcow v1...=A0 A=
nd vmdk
> > > > > seems to completely not care about this single cluster limitati=
on.=A0 So
> > > > > for now we probably wouldn't even gain anything by doing this i=
n
> > > > > block/io.c.
> > > > >=20
> > > > > So long story short, it's OK to do this locally in qcow2, yes.
> > > > >=20
> > > >=20
> > > > [..]
> > > >=20
> > > > > > +=A0=A0=A0=A0=A0=A0=A0 qemu_iovec_reset(&hd_qiov);
> > > > > > +=A0=A0=A0=A0=A0=A0=A0 chunk_size =3D MIN(bytes, s->cluster_s=
ize);
> > > > > > +=A0=A0=A0=A0=A0=A0=A0 qemu_iovec_concat(&hd_qiov, qiov, curr=
_off, chunk_size);
> > > > > > +
> > > > > > +=A0=A0=A0=A0=A0=A0=A0 ret =3D qcow2_co_pwritev_cluster_compr=
essed(bs, offset +
> > > > > > curr_off,
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 chunk_size,
> > > > > > &hd_qiov);
> > > > > > +=A0=A0=A0=A0=A0=A0=A0 if (ret =3D=3D -ENOTSUP) {
> > > > >=20
> > > > > Why this?=A0 I mean, I can see the appeal, but then we should p=
robably
> > > > > actually return -ENOTSUP somewhere (e.g. for unaligned clusters=
 and the
> > > > > like) -- and we should not abort if offset_into_cluster(s, clus=
ter) is
> > > > > true, but we should write the header uncompressed and compress =
the main
> > > > > bulk.
> > > > >=20
> > > > > Max
> > > > >=20
> > > >=20
> > > > Right, sorry, missed this part when porting the patch.
> > > >=20
> > > > I think this needs to be removed (and the commit message fixed
> > > > accordingly).
> > > > Returning an error, rather than silently falling back to uncompre=
ssed
> > > > seems preferable to me. "Compressing writers" (backup, img conver=
t and
> > > > now stream) are aware that they have to cluster-align, and if the=
y fail
> > > > to do so that means there is an error somewhere.
> > >=20
> > > OK for me.
> > >=20
> > > > If it won't return an error anymore, then the unaligned tail shou=
ldn't
> > > > either. So we can end up 'letting' the callers send small unalign=
ed
> > > > requests which will never get compressed.
> > >=20
> > > Either way is fine.  It just looks to me like vmdk falls back to
> > > uncompressed writes, so it's not like it would be completely new be=
havior...
> > >=20
> > > (But I won't judge whether what vmdk does is a good idea.)
> >=20
> > Probably not.
> >=20
> > If we let io.c know about the cluster-size alignment requirement for
> > compressed writes, the usual RMW code path could kick in. Wouldn't th=
is
> > actually be a better solution than uncompressed writes or erroring ou=
t?
> >=20
> > In fact, with this, we might even be very close to an option that tur=
ns
> > every write into a compressed write, so you get images that stay
> > compressed even while they are in use.
> >=20
> > Kevin
>=20
> That's alignment, and indeed it would be nice to have that block limit
> and I think this patch does not contradict with that (now that in v2 it
> doesn't fall back to uncompressed but returns EINVAL).

Yes, I agree.

> Unless we also want a max request limit so io.c does the request split?

I'm not sure about this one. We might want to change the qcow2 code
later so that we can actually write multiple compressed clusters at once
as an performance optimisation, and then we would give up the splitting
in io.c again. So maybe it's not really worth it.

Kevin
