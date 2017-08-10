Received: from eggs.gnu.org ([2001:4830:134:3::10]:37554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dfs13-0003re-Ua
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dfs0z-0003Ma-Q2
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:17:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61327)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dfs0z-0003Lj-Jt
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:17:01 -0400
Date: Thu, 10 Aug 2017 15:16:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170810181648.GC3108@localhost.localdomain>
References: <1502359687-25370-1-git-send-email-tianyu.lan@intel.com>
	<20170810102649.GF12980@redhat.com>
	<00cb01a4-5c27-fc69-d3ae-0653aa54b121@intel.com>
	<20170810124102.GA21850@flask>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170810124102.GA21850@flask>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] x86: Increase max vcpu number to 352
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, "Daniel P. Berrange" <berrange@redhat.com>, pbonzini@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net, Igor Mammedov <imammedo@redhat.com>

On Thu, Aug 10, 2017 at 02:41:03PM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:
> 2017-08-10 19:02+0800, Lan Tianyu:
> > On 2017=E5=B9=B408=E6=9C=8810=E6=97=A5 18:26, Daniel P. Berrange wrot=
e:
> >> On Thu, Aug 10, 2017 at 06:08:07PM +0800, Lan Tianyu wrote:
> >>> Intel Xeon phi chip will support 352 logical threads. For HPC
> >>> usage case, it will create a huge VM with vcpus number as same as h=
ost
> >>> cpus. This patch is to increase max vcpu number to 352.
> >>=20
> >> If we pick arbitray limits based on size of physical CPUs that happe=
n
> >> to be shipping today, we'll continue the cat+mouse game forever trai=
ling
> >> latest CPUs that vendors ship.
> >>=20
> >> IMHO we should pick a higher number influenced by technical constrai=
nts
> >> of the q35 impl instead. eg can we go straight to something like 512=
 or
> >> 1024  ?
> >=20
> > Sure. 512 should be enough and some arrays is defined according to ma=
x
> > vcpu number.
>=20
> Hm, which arrays are that?  I was thinking it is safe to bump it to
> INT_MAX as the number is only used when setting global max_cpus.

We had a MAX_CPUMASK_BITS macro, and bitmaps whose sizes were
defined at compile time based on it.  But commit
cdda2018e3b9ce0c18938767dfdb1e05a05b67ca removed it.  Probably
those arrays all use max_cpus, by now (and the default for
max_cpus is smp_cpus, not MachineClass::max_cpus).

Anyway, if we set it to INT_MAX, there are some cases where more
appropriate error checking/reporting could be required because
they won't handle overflow very well:
* pcms->apic_id_limit initialization at pc_cpus_init()
* ACPI code that assumes possible_cpus->cpus[i].arch_id fits
  in a 32-bit integer
* Other x86_cpu_apic_id_from_index() calls in PC code
  (especially the initialization of possible_cpus->cpus[i].arch_id).
  Note that x86_cpu_apic_id_from_index(cpu_index) might not fit
  in 32 bits even if cpu_index <=3D UINT32_MAX.

--=20
Eduardo
