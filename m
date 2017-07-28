Received: from eggs.gnu.org ([2001:4830:134:3::10]:51083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db5uX-0008Qi-ON
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 10:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db5uU-0005E8-16
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 10:06:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1db5uT-0005Cb-OO
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 10:06:33 -0400
Date: Fri, 28 Jul 2017 15:06:23 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170728140623.GQ31495@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
	<20170726112633.GE18489@stefanha-x1.localdomain>
	<CAFEAcA_pXX6ZCsBwAQnzQbTSbxzAh=nFpPeEzZoRBhBDt2r+vA@mail.gmail.com>
	<20170727104302.GI2555@redhat.com>
	<CAFEAcA8oyHi+7NVCE8YWHY+v0UXLbt2tWHGE4AP_V8TtDBc89g@mail.gmail.com>
	<20170727152137.GW2555@redhat.com>
	<CAFEAcA-eH7J+fFXYgFo6Wx58zgD8=kqhrGE5BqR+NrhHjipsFw@mail.gmail.com>
	<20170727154535.GY2555@redhat.com>
	<20170728133430.GS12364@stefanha-x1.localdomain>
	<CAFEAcA9p38P2x3s4grvFPkGaH+JEmwqyAC9SsLWqqFL8k+Eiww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9p38P2x3s4grvFPkGaH+JEmwqyAC9SsLWqqFL8k+Eiww@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/13] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "Emilio G. Cota" <cota@braap.org>, =?utf-8?B?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jul 28, 2017 at 02:41:19PM +0100, Peter Maydell wrote:
> On 28 July 2017 at 14:34, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > Llu=C3=ADs/Peter: What are the requirements for instrumentation code
> > interacting with the running QEMU instance?  simpletrace is
> > asynchronous, meaning it does not wait for anyone handle the trace ev=
ent
> > before continuing execution, and is therefore not suitable for
> > SystemTap-style scripts that can interact with the program while
> > handling a trace event.
>=20
> I think you'd probably want synchronous -- it's pretty helpful
> to be able to say "register a trace event hook that doesn't
> fire very often, and use that to get to the region of
> execution that's of interest to you, then enable more hooks
> to get more detail at that point". (For instance, "wait til
> we've executed 5,000,000 instructions, then turn on the
> tracing of all instruction execution, register modification
> and memory accesses".)

Currently simpletrace probes have a fixed action when they are enabled,
namely to print state to the trace log file. Perhaps we can make the
action more flexible, if we create a more formal protocol for simpletrace
to let it talk over a UNIX socket. By default it could send probe data
asynchronously as now, but you could mark probes such that they require
a synchronous ACK, thus pausing execution until that ACK is received
from the instrumenting program.

For that to be useful, we would need to have allow probes to be turned
on/off via this trace socket, since the normal HMP/QMP monitor execution
would be blocked while this probe is running.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
