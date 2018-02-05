Received: from eggs.gnu.org ([2001:4830:134:3::10]:59657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eillK-0003uF-BF
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:45:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eillF-00086g-BP
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:45:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eillF-000854-4K
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:45:01 -0500
Date: Mon, 5 Feb 2018 18:44:50 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180205184449.GE2317@work-vm>
References: <1517842735-9011-1-git-send-email-jianfeng.tan@intel.com>
	<1b6a1999-95bb-5eac-70e1-39e6ba5b22fc@redhat.com>
	<6716e932-9ce5-3d97-41cb-f33ea94ad4ce@intel.com>
	<502bbdba-0c35-e35a-6600-dfca739d0ea3@redhat.com>
	<20180205181521.47232aa4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180205181521.47232aa4@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] exec: eliminate ram naming issue as migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Tan, Jianfeng" <jianfeng.tan@intel.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>

* Igor Mammedov (imammedo@redhat.com) wrote:
> On Mon, 5 Feb 2018 17:19:09 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> > On 05/02/2018 17:12, Tan, Jianfeng wrote:
> > > Hi Paolo,
> > >=20
> > > On 2/5/2018 11:53 PM, Paolo Bonzini wrote: =20
> > >> On 05/02/2018 15:58, Jianfeng Tan wrote: =20
> > >>> Here are some options to fix this:
> > >>>
> > >>> 1. When we do ram name comparison, we truncate the prefix as this
> > >>> patch shows.
> > >>> It cannot cover the corner case: the source VM could have two ram=
 blocks
> > >>> with name of "pc.ram" and "/object/pc.ram". =20
> > >> That shouldn't happen ("pc.ram" exists even in the "-numa
> > >> node,memdev=3D..." case, but it has no RAM block). =20
> > >=20
> > > Suppose we have a VM started with "-m xG", and then hot plugged wit=
h a
> > > ram block:
> > > =A0 (qemu) object_add
> > > memory-backend-file,id=3Dpc.ram,size=3D1G,mem-path=3D/dev/hugepages
> > > =A0 (qemu) device_add pc-dimm,id=3Dpc.ram,memdev=3Dpc.ram
> > >=20
> > > Then we would have both ram block named pc.ram:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Block Name=A0=A0=A0 PSize
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pc.=
ram=A0=A0=A0=A0 4 KiB
> > > =A0=A0=A0=A0=A0 /objects/pc.ram=A0=A0=A0 2 MiB
> > >=20
> > > But I assume it's a corner case which not really happen. =20
> >=20
> > Yeah, you're right. :/  I hadn't thought of hotplug.  It can happen i=
ndeed.
> perhaps we should fail object_add memory-backend-foo if it resulted
> in creating ramblock with duplicate id
> =20
That's probably not a bad idea;  I thought I'd hit a simpliar problem a
while ago; I'd ended up (through a different problem) of having
RAMBlocks with empty names and ended up with two of them.

Dave

> >=20
> > >> However, note that
> > >>
> > >> =A0=A0 -m xG -numa node,memdev=3Dpc.ram \
> > >> =A0=A0 -object memory-backend-file,id=3Dpc.ram,...
> > >>
> > >> works for both vhost-kernel and vhost-user, so I'd rather consider=
 this
> > >> a configuration problem and not do anything. =20
> > >=20
> > > That configuration indeed works for both. But in the production env=
,
> > > lots of VMs are already started with previous mem config. If we do
> > > nothing, it will take a long time (shutdown/start for each VM) to
> > > migrate to the new setup. This patch is to make this process more s=
mooth
> > > without any bad effect if possible. =20
> >=20
> > I understand.  However it's not as bad as "there's no possibility at =
all
> > to migrate from vhost-kernel to vhost-user".  There are cases that ar=
e
> > more problematic: for example, there's no possibility at all to add
> > memory NUMA policy during a live migration, unless -object
> > memory-backend-* was used on the source.
> >=20
> > Paolo
> >=20
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
