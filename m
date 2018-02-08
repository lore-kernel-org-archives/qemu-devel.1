Received: from eggs.gnu.org ([2001:4830:134:3::10]:33561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.ksingh@gmail.com>) id 1ejotB-00023m-EB
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.ksingh@gmail.com>) id 1ejot9-0000nB-Ls
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:17:33 -0500
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:37639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brijesh.ksingh@gmail.com>)
	id 1ejot9-0000mF-FI
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:17:31 -0500
Received: by mail-qk0-x229.google.com with SMTP id c128so6291423qkb.4
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 08:17:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202151616.GM15403@redhat.com>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<20180129174132.108925-19-brijesh.singh@amd.com>
	<20180130200838.GB2319@work-vm>
	<0abe3fee-a970-dc82-fd92-ad923bfa863a@amd.com>
	<20180201172709.GJ2457@work-vm>
	<07d86670-e960-db04-52a9-5e6ecee18bc3@amd.com>
	<20180202151616.GM15403@redhat.com>
From: Brijesh Singh <brijesh.ksingh@gmail.com>
Date: Thu, 8 Feb 2018 10:17:28 -0600
Message-ID: <CA+HCGMYbZ9ATosB29Oy9kELc78yQ0jGX7YrFDG2SzT2_Py-xAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Tom Lendacky <Thomas.Lendacky@amd.com>, "Chen,
	Xiaogang" <Xiaogang.Chen@amd.com>, Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Feb 2, 2018 at 9:16 AM, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:

> On Fri, Feb 02, 2018 at 09:11:41AM -0600, Brijesh Singh wrote:
> >
> >
> > On 02/01/2018 11:27 AM, Dr. David Alan Gilbert wrote:
> > > * Brijesh Singh (brijesh.singh@amd.com) wrote:
> > > >
> > > >
> > > > On 1/30/18 2:08 PM, Dr. David Alan Gilbert wrote:
> > > > > * Brijesh Singh (brijesh.singh@amd.com) wrote:
> > > > > > During machine creation we encrypted the guest bios image, the
> > > > > > LAUNCH_MEASURE command can be used to retrieve the measurement =
of
> > > > > > the encrypted memory region. Emit the SEV_MEASUREMENT event so
> that
> > > > > > libvirt can grab the measurement value as soon as we are done
> with
> > > > > > creating the encrypted machine.
> > > > > Can you ust clarify what happens if the libvirt has disconnected
> and
> > > > > reconnected to qemu and so didn't see the event?  Can the
> reconnecting
> > > > > libvirt query it and find out it's ready/not ready yet?
> > > >
> > > > Dave,
> > > >
> > > > I have not looked into details between libvirt and qemu interaction
> to
> > > > comment how and when the events will be delivered. Recently, one of
> my
> > > > colleague was implementing libvirt interface for the SEV guest and
> ran
> > > > into somewhat a similar challenge and posted question on libvirt
> mailing
> > > > list [1].
> > > >
> > > > In previous discussion on qemu mailing list, we agreed to implement
> SEV
> > > > MEASUREMENT event which can be seen by libvirt. That's what this
> patch
> > > > is doing.
> > > >
> > > > But during the libvirt implementation it seems that qemu monitor
> > > > silently drops all the events before it get the first
> qmp_capabilities
> > > > command. At a quick glance it seems on reconnect, libvirt issues
> > > > qmp_capabilities command and any event issued before the
> > > > qmp_capabilities command will never to delivered to libvirt. we are
> > > > looking for  help from libvirt/qemu monitor experts on how we solve
> this
> > > > problem. Our goal is to provide the measurement to libvirt before
> > > > libvirt issues "continue" command. Since event can't be seen by
> libvirt
> > > > before it resumes the guest hence I was wondering if we should we
> should
> > > > drop the SEV measurement event and consider adding a new QMP comman=
d
> to
> > > > query the SEV measurement.
> > >
> > > Yep, I'll leave it to the libvirt contacts for the best way they'd li=
ke
> > > to see that, as Eric says there's nothing wrong with having both the
> > > command and event if useful.  Also keep in mind coping with a guest
> that
> > > crashes early or that measurement never arrives.
> > >
> >
> > Yep, lets see what libvirt experts say about it.
> >
> > Hi Daniel,
> >
> > Do you have any recommendation on whether we should consider adding a n=
ew
> > QMP to retrieve the measurement or we do event or both? Please note tha=
t
> the
> > launch measurement is generate only once for the lifetime of the guest.
> The
> > measurement will be available after qmeu encrypts the guest bios during
> the
> > machine initialization time.
>
> IIUC, the measurement event is only required during the initial QEMU
> startup sequence. Once the guest CPUs are running this info is not needed
> any more.
>

That is correct.



>
> If libvirtd crashes/restarts in the middle of QEMU startup sequence it is
> game over from libvirt's POV. Libvirtd won't try to carry on starting tha=
t
> guest when it restarts. So I don't think there's a compelling need for a
> command to query the measurement from libvirt's POV, the event is fine.
>
>

Sorry for the late response, somehow this email was never delievered to my
AMD account hence I was not able to see the response on-time.

Anyway, the main issue is event emitted before "qmp_capabilities" are
dropped silently , see [1] . In our case, the measurement event is emitted
during the machine creation time, libvirt was still waiting to reconnect
the monitor when event was emitted hence libvirt never gets the event.
Because of this, I am not able to see any strong reason to emit the event.
Do you see any issue with libvirt issuing a  'query-sev-launch-measure' to
get the measurement on reconnect ?

[1] https://github.com/qemu/qemu/blob/master/monitor.c#L418



That all said, I think it might be useful to have a command to query the
> SEV measurement purely as a debugging aid, if some admin / support person
> wants to get hold of this info for some reason...
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/
> dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/
> dberrange :|
>
>
