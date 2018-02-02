Received: from eggs.gnu.org ([2001:4830:134:3::10]:38254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ehd5A-00046P-Fj
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ehd57-0002vE-5D
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:16:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ehd56-0002uY-Q5
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:16:49 -0500
Date: Fri, 2 Feb 2018 15:16:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180202151616.GM15403@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<20180129174132.108925-19-brijesh.singh@amd.com>
	<20180130200838.GB2319@work-vm>
	<0abe3fee-a970-dc82-fd92-ad923bfa863a@amd.com>
	<20180201172709.GJ2457@work-vm>
	<07d86670-e960-db04-52a9-5e6ecee18bc3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07d86670-e960-db04-52a9-5e6ecee18bc3@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 18/23] sev: emit the SEV_MEASUREMENT
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Chen, Xiaogang" <Xiaogang.Chen@amd.com>

On Fri, Feb 02, 2018 at 09:11:41AM -0600, Brijesh Singh wrote:
>=20
>=20
> On 02/01/2018 11:27 AM, Dr. David Alan Gilbert wrote:
> > * Brijesh Singh (brijesh.singh@amd.com) wrote:
> > >=20
> > >=20
> > > On 1/30/18 2:08 PM, Dr. David Alan Gilbert wrote:
> > > > * Brijesh Singh (brijesh.singh@amd.com) wrote:
> > > > > During machine creation we encrypted the guest bios image, the
> > > > > LAUNCH_MEASURE command can be used to retrieve the measurement =
of
> > > > > the encrypted memory region. Emit the SEV_MEASUREMENT event so =
that
> > > > > libvirt can grab the measurement value as soon as we are done w=
ith
> > > > > creating the encrypted machine.
> > > > Can you ust clarify what happens if the libvirt has disconnected =
and
> > > > reconnected to qemu and so didn't see the event?  Can the reconne=
cting
> > > > libvirt query it and find out it's ready/not ready yet?
> > >=20
> > > Dave,
> > >=20
> > > I have not looked into details between libvirt and qemu interaction=
 to
> > > comment how and when the events will be delivered. Recently, one of=
 my
> > > colleague was implementing libvirt interface for the SEV guest and =
ran
> > > into somewhat a similar challenge and posted question on libvirt ma=
iling
> > > list [1].
> > >=20
> > > In previous discussion on qemu mailing list, we agreed to implement=
 SEV
> > > MEASUREMENT event which can be seen by libvirt. That's what this pa=
tch
> > > is doing.
> > >=20
> > > But during the libvirt implementation it seems that qemu monitor
> > > silently drops all the events before it get the first qmp_capabilit=
ies
> > > command. At a quick glance it seems on reconnect, libvirt issues
> > > qmp_capabilities command and any event issued before the
> > > qmp_capabilities command will never to delivered to libvirt. we are
> > > looking for=C2=A0 help from libvirt/qemu monitor experts on how we =
solve this
> > > problem. Our goal is to provide the measurement to libvirt before
> > > libvirt issues "continue" command. Since event can't be seen by lib=
virt
> > > before it resumes the guest hence I was wondering if we should we s=
hould
> > > drop the SEV measurement event and consider adding a new QMP comman=
d to
> > > query the SEV measurement.
> >=20
> > Yep, I'll leave it to the libvirt contacts for the best way they'd li=
ke
> > to see that, as Eric says there's nothing wrong with having both the
> > command and event if useful.  Also keep in mind coping with a guest t=
hat
> > crashes early or that measurement never arrives.
> >=20
>=20
> Yep, lets see what libvirt experts say about it.
>=20
> Hi Daniel,
>=20
> Do you have any recommendation on whether we should consider adding a n=
ew
> QMP to retrieve the measurement or we do event or both? Please note tha=
t the
> launch measurement is generate only once for the lifetime of the guest.=
 The
> measurement will be available after qmeu encrypts the guest bios during=
 the
> machine initialization time.

IIUC, the measurement event is only required during the initial QEMU
startup sequence. Once the guest CPUs are running this info is not needed
any more.

If libvirtd crashes/restarts in the middle of QEMU startup sequence it is
game over from libvirt's POV. Libvirtd won't try to carry on starting tha=
t
guest when it restarts. So I don't think there's a compelling need for a
command to query the measurement from libvirt's POV, the event is fine.

That all said, I think it might be useful to have a command to query the
SEV measurement purely as a debugging aid, if some admin / support person
wants to get hold of this info for some reason...

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
