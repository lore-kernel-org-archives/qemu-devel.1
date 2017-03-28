Received: from eggs.gnu.org ([2001:4830:134:3::10]:38948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cswME-0004v4-O3
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cswMB-00057S-Mi
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:00:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:56468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cswMB-00057H-CT
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:00:39 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Tue, 28 Mar 2017 19:00:34 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1A42954@ORSMSX112.amr.corp.intel.com>
References: <4712D8F4B26E034E80552F30A67BE0B1A3D97E@ORSMSX112.amr.corp.intel.com>
	<20170327132454.GD28620@stefanha-x1.localdomain>
	<4712D8F4B26E034E80552F30A67BE0B1A40E6D@ORSMSX112.amr.corp.intel.com>
	<339080cc-c86d-93be-9c13-596eb43d56dd@redhat.com>
In-Reply-To: <339080cc-c86d-93be-9c13-596eb43d56dd@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] Create libqemutrace.a for all trace.o
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Daniel Berrange <berrange@redhat.com>

> >>> ./trace.o, ./qapi/trace.o and ./util/trace.o are added into
> >>> libqemuutil.a  to avoid recursive dependencies between
> >>> libqemuutil.a and libqemutrace.a.
> >> Why would libqemutrace.a depend on libqemuutil.a?
> > Each trace.c calls trace_event_register_group to register events,
> > trace_event_register_group is defined in trace/control.c , which
> > is linked into libqemuutil.a.
>=20
> Ah:
>=20
> util-obj-$(CONFIG_TRACE_SIMPLE) +=3D simple.o
> util-obj-$(CONFIG_TRACE_FTRACE) +=3D ftrace.o
> util-obj-y +=3D control.o
> util-obj-y +=3D qmp.o
>=20
> With the introduction of libqemutrace.a, I believe these should be moved
> into libqemutrace.a.

Agreed,
But it doesn't solve infinite recursion issue. register_module_init is=20
needed by libqemutrace.a, which is defined util/module.c.

it is hard to remove libqemutrace.a dependency on libqemuutil.a.

Removing libqemuutil.a dependency on libqemutrace.a is feasible.
Just like what I did in this patch, include all util related trace.o=20
to libqemuutila.

The other simple way is to include all trace.o into libqemuutil.a

What's your opinion?

Thanks
Anthony
