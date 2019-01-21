Received: from eggs.gnu.org ([209.51.188.92]:54109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1glU07-0006j6-2F
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1glU06-0000bk-6U
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:28:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1glU05-0000ZG-UQ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:28:06 -0500
Date: Mon, 21 Jan 2019 02:21:39 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <790023026.65652877.1548055299697.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190121061143.GB21562@tiger-server>
References: <cover.1547624239.git.yi.z.zhang@linux.intel.com>
	<be0aba0f61ea5c583ea696db4cc621d3886893de.1547624239.git.yi.z.zhang@linux.intel.com>
	<20190116103615-mutt-send-email-mst@kernel.org>
	<20190121061143.GB21562@tiger-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V9 6/6] docs: Added MAP_SYNC documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Zhang <yi.z.zhang@linux.intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, stefanha@redhat.com, pbonzini@redhat.com, yu c zhang <yu.c.zhang@linux.intel.com>, ehabkost@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com, dan j williams <dan.j.williams@intel.com>


> > > ---
> > >  docs/nvdimm.txt | 21 ++++++++++++++++++++-
> > >  qemu-options.hx |  4 ++++
> > >  2 files changed, 24 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> > > index 5f158a6..565ba73 100644
> > > --- a/docs/nvdimm.txt
> > > +++ b/docs/nvdimm.txt
> > > @@ -142,11 +142,30 @@ backend of vNVDIMM:
> > >  Guest Data Persistence
> > >  ----------------------
> > > =20
> > > +vNVDIMM is designed and implemented to guarantee the guest data
> > > +persistence on the backends even on the host crash and power
> >=20
> > in case of a host crash or a power failure
> >=20
> > (be consistent)
> >=20
> > > +failures. However, there are still some requirements and limitations
> > > +as explained below.
> > > +
> > >  Though QEMU supports multiple types of vNVDIMM backends on Linux,
> > > -currently the only one that can guarantee the guest write persistenc=
e
> > > +if MAP_SYNC is not supported by the host kernel and the backends,
> > > +the only backend that can guarantee the guest write persistence
> > >  is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
> > >  which all guest access do not involve any host-side kernel cache.
> > > =20
> > > +mmap(2) flag MAP_SYNC is added since Linux kernel 4.15. On such
> > > +systems, QEMU can mmap(2) the backend with MAP_SYNC, which can ensur=
e
> >=20
> > which ensures
> >=20
> > > +filesystem metadata consistent
> >=20
> > consistency
> >=20
> > > even after a system crash or power
> >=20
> > a power
> >=20
> > > +failure. Besides the host kernel support, enabling MAP_SYNC in QEMU
> > > +also requires:
> > > +
> > > + - the backend is a file supporting DAX, e.g., a file on an ext4 or
> > > +   xfs file system mounted with '-o dax',
> > > +
> > > + - 'share' option of memory-backend-file is 'on'.
> >=20
> > why does share need to be on?
> According to mmap(2) man page,
> MAP_SYNC is available only with the MAP_SHARED_VALIDATE map=E2=80=90ping =
type.
> I will add this to documentation, Thanks.

MAP_SHARE_VALIDATE should be used to validate MAP_SYNC with MAP_SHARED.

#define MAP_SHARED_VALIDATE 0x03

In contrast, MAP_SHARED is:
#define MAP_SHARED      0x01            /* Share changes */

I think we should use MAP_SHARED_VALIDATE with MAP_SYNC here?

Thanks,
Pankaj=20

> >=20
> > > +
> > > + - 'pmem' option of memory-backend-file is 'on'
> > > +
> > >  When using other types of backends, it's suggested to set 'unarmed'
> > >  option of '-device nvdimm' to 'on', which sets the unarmed flag of t=
he
> > >  guest NVDIMM region mapping structure.  This unarmed flag indicates
> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index 08f8516..545cb8a 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -4002,6 +4002,10 @@ using the SNIA NVM programming model (e.g. Int=
el
> > > NVDIMM).
> > >  If @option{pmem} is set to 'on', QEMU will take necessary operations=
 to
> > >  guarantee the persistence of its own writes to @option{mem-path}
> > >  (e.g. in vNVDIMM label emulation and live migration).
> > > +Also, we will map the backend-file with MAP_SYNC flag, which can ens=
ure
> > > +the file metadata is in sync to @option{mem-path} even on the host c=
rash
> > > +and power failures. MAP_SYNC requires supports from both the host ke=
rnel
> >=20
> > requires support
> >=20
> > > +(since Linux kernel 4.15) and @option{mem-path} (only files supporti=
ng
> > > DAX).
> > > =20
> > >  @item -object
> > >  memory-backend-ram,id=3D@var{id},merge=3D@var{on|off},dump=3D@var{on=
|off},share=3D@var{on|off},prealloc=3D@var{on|off},size=3D@var{size},host-n=
odes=3D@var{host-nodes},policy=3D@var{default|preferred|bind|interleave}
> > > =20
> > > --
> > > 2.7.4
>=20
