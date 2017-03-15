Received: from eggs.gnu.org ([2001:4830:134:3::10]:53186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1co5Rh-0007yc-5t
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 05:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1co5Re-0005Xn-4P
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 05:42:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1co5Rd-0005Xb-SZ
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 05:42:14 -0400
Date: Wed, 15 Mar 2017 09:42:07 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170315094207.GD7770@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170314102747.31395-1-fanc.fnst@cn.fujitsu.com>
	<87o9x4t51k.fsf@secure.mitica> <20170314123730.GO2652@redhat.com>
	<20170315041358.GA2818@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170315041358.GA2818@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Output dirty-bytes-rate instead of
 dirty-pages-rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Juan Quintela <quintela@redhat.com>, eblake@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com, maozy.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>

On Wed, Mar 15, 2017 at 12:13:58PM +0800, Chao Fan wrote:
> On Tue, Mar 14, 2017 at 12:37:30PM +0000, Daniel P. Berrange wrote:
> >On Tue, Mar 14, 2017 at 01:29:43PM +0100, Juan Quintela wrote:
> >> Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
> >> > In hmp, dirty-bytes-rate is more friendly than dirty-pages-rate.
> >> > It's also better for other tools to determine the cpu throttle
> >> > value in different architecture.
> >> >
> >> > Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> >> > Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> >>=20
> >> I agree with Daniel here, you can't change the meaning of a field.  =
Look
> >> at skipped pages.  It is zero know because it is not used anymore, b=
ut
> >> we can't drop it.
> >>=20
> >> I think it is better to expose page_size.  We have now
> >>=20
> >> trasferred: bytes
> >> total: bytes
> >> duplicate: number of zero pages
> >> skipped: always zero.
> >> normal: number of normal pages
> >> normal_bytes: the same  in bytes
> >> mbps: megabytes per second?  I can't even remember this one
> >> dirty_sync_count: number of times we have go through the whole memor=
y
> >> postcopy_requests =3D number of pages asked by postcopy faults?
> >> dirty_pages_rate =3D pages by some kind of unit
> >>=20
> >> And we haven't yet started with compression or xbzrle.  I think that=
 the
> >> best approach at this point is putting everything in pages except th=
e
> >> things that don't make sense.
> >>=20
> >> We can put everything on bytes, but then everything is HUGE.
> >>=20
> >> Anyways, what do libvirt/management apps preffer?
> >
> >Since we have many fields already which are reported as page counts, I
> >think just adding page size would be preferrable to having twice as ma=
ny
> >fields reported duplicating bytes + pages.
> >
> >The only reason to favour duplicating all fields to report bytes, is i=
f
> >we needed to vary page size to deal with huge pages (eg if some report=
ed
> >pages were 4kb and other reported pages with 2MB). You can easily just
> >scale huge pages counts to be "normal"  pages for purpose of reporting
> >though.
>=20
> I am wondering if it's OK to expose page_size in qmp or hmp, just like
> a new command 'info page_size'.
> If confirmed=EF=BC=8CI will make the new patch.

I'd suggest having it as a field of "info migrate"

Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|
