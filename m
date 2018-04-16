Received: from eggs.gnu.org ([2001:4830:134:3::10]:57046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1f8AzE-0001oJ-AB
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 16:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <juterry@microsoft.com>) id 1f8Az9-0000Ww-RB
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 16:44:28 -0400
Received: from mail-co1nam03on0139.outbound.protection.outlook.com
	([104.47.40.139]:33568
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <juterry@microsoft.com>)
	id 1f8Az9-0000VG-7P
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 16:44:23 -0400
From: "Justin Terry (VM)" <juterry@microsoft.com>
Date: Mon, 16 Apr 2018 20:44:20 +0000
Message-ID: <DM5PR21MB017035678A281ABAEC94CF94B6B00@DM5PR21MB0170.namprd21.prod.outlook.com>
References: <20180326170658.606-1-juterry@microsoft.com>
	<20180328175050.GH5046@localhost.localdomain>
	<DM5PR21MB0170C0B7995A9AC36D2F7C5BB6A30@DM5PR21MB0170.namprd21.prod.outlook.com>
	<de10b07e-3ce7-e1e1-f437-792fe246d218@redhat.com>
	<20180416163303.GI29865@localhost.localdomain>
In-Reply-To: <20180416163303.GI29865@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] WHPX fixes an issue with CPUID 1 not
 returning CPUID_EXT_HYPERVISOR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "rth@twiddle.net" <rth@twiddle.net>

Hey Eduardo/Paolo,

I have not forgotten about your responses. I am working out how best to do =
this in our platform and will send a follow up patch (this one is already m=
erged) to fully support the -cpu flag. It looks like all the pieces are in =
place between the two and we just need a bit of translation between the QEM=
U state at partition creation/start/execution to handle the various exits e=
ither by pre-setting the value or via the actual CPUID trap at runtime. Tha=
nk you for all your insights/input up to here. It has been really helpful. =
More to come.

Thanks,
Justin

> -----Original Message-----
> From: Eduardo Habkost <ehabkost@redhat.com>
> Sent: Monday, April 16, 2018 9:33 AM
> To: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Justin Terry (VM) <juterry@microsoft.com>; qemu-devel@nongnu.org;
> rth@twiddle.net
> Subject: Re: [PATCH] WHPX fixes an issue with CPUID 1 not returning
> CPUID_EXT_HYPERVISOR
>=20
> On Thu, Apr 05, 2018 at 05:50:20PM +0200, Paolo Bonzini wrote:
> > On 28/03/2018 22:48, Justin Terry (VM) wrote:
> [...]
> > > If we use [2] to inject the answers at creation time WHPX needs
> > > access to the CPUX86State at accel init which also doesn't seem to
> > > be possible in QEMU today. WHPX could basically just call
> > > cpu_x86_cpuid() for each CPUID QEMU cares about and plumb the
> answer
> > > before start. This has the best performance as we avoid the
> > > additional exits but has an issue in that the results must be known a=
head
> of time.
> >
> > The earliest where you have access to that is x86_cpu_initfn.
>=20
> x86_cpu_initfn() is the earliest you have access to the CPU object, but n=
ote
> that the final CPUID bits (based on -cpu options, accel data, and possibl=
y
> other input) are known only when x86_cpu_realizefn() is called.
>=20
> --
> Eduardo
