Received: from eggs.gnu.org ([2001:4830:134:3::10]:38100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1csZHL-00085z-AR
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1csZHH-00036k-CX
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:22:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:8161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1csZHH-00035O-0x
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:22:03 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Mon, 27 Mar 2017 18:21:59 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1A40E6D@ORSMSX112.amr.corp.intel.com>
References: <4712D8F4B26E034E80552F30A67BE0B1A3D97E@ORSMSX112.amr.corp.intel.com>
	<20170327132454.GD28620@stefanha-x1.localdomain>
In-Reply-To: <20170327132454.GD28620@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Daniel Berrange <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

> > ./trace.o, ./qapi/trace.o and ./util/trace.o are added into
> > libqemuutil.a  to avoid recursive dependencies between
> > libqemuutil.a and libqemutrace.a.
>=20
> Why would libqemutrace.a depend on libqemuutil.a?

Each trace.c calls trace_event_register_group to register events,=20
trace_event_register_group is defined in trace/control.c , which=20
is linked into libqemuutil.a.


> Tracing code shouldn't call other QEMU code.  That would could create
> infinite recursion when a trace event is fired.

If all trace.o needed by libqemuutil.a are linked into libqemuutil.a,=20
libqemuutil.a will not depend on libqemutrace.a. This is what this patch=20
take to break the infinite recursion.

Or we can link trace/*.o to libqemutrace.a, hope it breaks the infinite=20
recursion. But trace/*.o may still depend on libqemuutil.a

Or we can just link all trace.o to libqemuutil.a.


Anthony
