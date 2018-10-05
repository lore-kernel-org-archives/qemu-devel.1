Received: from eggs.gnu.org ([2001:4830:134:3::10]:41431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g8PkP-0003BK-Oo
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g8PkK-0000AY-1U
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:02:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1g8PkC-0008M2-FX
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:02:15 -0400
Date: Fri, 5 Oct 2018 14:02:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181005130202.GL778@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181003091344.24496-1-d.csapak@proxmox.com>
	<20181004135110.GQ3667@redhat.com>
	<3672933a-18c4-8283-1318-c7b57fdf08d7@proxmox.com>
	<20181005083827.GE778@redhat.com>
	<dc14192a-ad21-d2b3-385a-07b274ad5c59@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc14192a-ad21-d2b3-385a-07b274ad5c59@proxmox.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/1] add exit-script option to qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dominik Csapak <d.csapak@proxmox.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Fri, Oct 05, 2018 at 02:57:03PM +0200, Dominik Csapak wrote:
> On 10/5/18 10:38 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Oct 05, 2018 at 08:56:27AM +0200, Dominik Csapak wrote:
> > > On 10/4/18 3:51 PM, Daniel P. Berrang=C3=A9 wrote:
> > > > On Wed, Oct 03, 2018 at 11:13:43AM +0200, Dominik Csapak wrote:
> > > > > this patch aims to execute a script when qemu exits
> > > > > so that one can do cleanups when using --daemonize without
> > > > > having to use the qmp monitor
> > > >=20
> > > > IMHO the idea of cleanup scripts run by QEMU itself is flawed.
> > > > QEMU will inevitably crash before cleanup scripts can be run,
> > > > so whatever mgmt app is using QEMU needs to be able to do
> > > > cleanup without QEMU's help.
> > > >=20
> > > > I think this can be done more reliably with a wrapper script,
> > > > that spawns QEMU, waits for it to exit and then calls the
> > > > cleanup script. On Linux at least you can use prctl() with
> > > > PR_SET_CHILD_SUBREAPER so you can detect exit'ing of QEMU
> > > > even after it has daemonized.
> > > >=20
> > > > Perhaps we could have such a wrapper script put in the
> > > > contrib directory
> > > >=20
> > > > Regards,
> > > > Daniel
> > > >=20
> > > Hi,
> > >=20
> > > for cleaning up after qemu crashes, you are completely right,
> > > (ignoring that the downscript for tap devices also never gets execu=
ted
> > > then), but this series has another use.
> > >=20
> > > With it, a user can determine the reason of a graceful shutdown
> > > (e.g., if it was by a signal, qmp or from inside) of qemu,
> > > especially when using -no-reboot without using qmp
> > >=20
> > > and using qmp for that is not very practical for everyone,
> > > or is there another way for that which i am missing?
> >=20
> > Honestly QMP *is* the right answer. We've put alot of effort into QMP
> > and I don't think it is sensible to start adding new mechanisms to
> > provide the same information in an adhoc manner.
> >=20
> > What makes you think QMP isn't practical to use ?  We have client
> > impls that talk to QMP in scripts/qmp that are just a few 100 lines
> > of pretty simple python code.
> >=20
>=20
> ok, i just found that having to start an extra program waiting for qmp
> events might be overkill for some users
>=20
> nonetheless, i just found out that even with qmp, there is no way
> to see if a machine started with '-no-reboot' was trying to reboot
> or just shutting down, in both cases i got a SHUTDOWN event
> with 'guest: true'
>=20
> would it make sense to send a patch that introduces a new data field
> for the shutdown event that says if it was really a reset?

I had a feeling there was another way to detct it, but I'm not seeing
it in QMP. So yeah, if this can't be determined, then I expect it is
worth extending QMP to report this=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
