Received: from eggs.gnu.org ([2001:4830:134:3::10]:57627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsP4S-0007Qp-KA
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsP4N-00018w-4w
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:00:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19269)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dsP4M-00017q-Ul
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:00:19 -0400
Date: Thu, 14 Sep 2017 10:00:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170914100011.296185d2@nial.brq.redhat.com>
In-Reply-To: <20170914070118.GA8181@in.ibm.com>
References: <20170914070118.GA8181@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU terminates during reboot after memory unplug
 with vhost=on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, groug@kaod.org, david@gibson.dropbear.id.au

On Thu, 14 Sep 2017 12:31:18 +0530
Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:

> Hi,
>=20
> QEMU hits the below assert
>=20
> qemu-system-ppc64: used ring relocated for ring 2
> qemu-system-ppc64: qemu/hw/virtio/vhost.c:649: vhost_commit: Assertion `r=
 >=3D 0' failed.
>=20
> in the following scenario:
>=20
> 1. Boot guest with vhost=3Don
>   -netdev tap,id=3Dmynet0,script=3Dqemu-ifup,downscript=3Dqemu-ifdown,vho=
st=3Don -device virtio-net-pci,netdev=3Dmynet0
> 2. Hot add a DIMM device=20
> 3. Reboot
>    When the guest reboots, we can see
>    vhost_virtqueue_start:vq->used_phys getting assigned an address that
>    falls in the hotplugged memory range.
> 4. Remove the DIMM device
>    Guest refuses the removal as the hotplugged memory is under use.
> 5. Reboot

>    QEMU forces the removal of the DIMM device during reset and that's
>    when we hit the above assert.
I don't recall implementing forced removal om DIMM,
could you point out to the related code, pls?

> Any pointers on why we are hitting this assert ? Shouldn't vhost be
> done with using the hotplugged memory when we hit reset ?

=46rom another point of view,
DIMM shouldn't be removed unless guest explicitly ejects it
(at least that should be so in x86 case).

>=20
> Regards,
> Bharata.
>=20
>=20
