Received: from eggs.gnu.org ([2001:4830:134:3::10]:36167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvQcm-0005Cd-FG
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvQci-0006r4-N7
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:44:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cvQci-0006pP-EO
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:44:00 -0400
Date: Tue, 4 Apr 2017 16:43:55 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170404154355.GY25661@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<20170403170738.GC2768@redhat.com>
	<CAJ+F1CKVU+bgyE2Z7v3kECZ-GVLj+gMiiRoSZt7yWGMj0UkfgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKVU+bgyE2Z7v3kECZ-GVLj+gMiiRoSZt7yWGMj0UkfgA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/7] Provide support for the software TPM
 emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, patrick.ohly@intel.com, qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com

On Mon, Apr 03, 2017 at 05:18:37PM +0000, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Apr 3, 2017 at 7:08 PM Daniel P. Berrange <berrange@redhat.com>
> wrote:
>=20
> > On Fri, Mar 31, 2017 at 04:10:09PM +0300, Amarnath Valluri wrote:
> > > Briefly, Theses set of patches introduces:
> > >  - new TPM backend driver to support software TPM emulators(swtpm(1=
)).
> > >  - and few supported fixes/enhancements/cleanup to existing tpm bac=
kend
> > code.
> > >
> > > The similar idea was initiated earliar(2) by Stefan Berger(CCed) wi=
th
> > slightly
> > > different approach, using CUSE. As swtpm has excellent support for =
unix
> > domain
> > > sockets, hence this implementation uses unix domain sockets to
> > communicate with
> > > swtpm.
> > >
> > > When Qemu is configured with 'emulator' tpm backend, it spawns 'swt=
pm'
> > and
> > > communicates its via Unix domain sockets.
> >
> > I'm not convinced that having QEMU spawning swtpm itself is a desirab=
le
> > approach, as it means QEMU needs to have all the privileges that swtp=
m
> > will need, so that swtpm can inherit them. At the very least I think =
we
> > need to have a way to disable this spawning, so it can connect to a
> > pre-existing swtpm process that's been spawned ahead of time. This wi=
ll
> > let us have stricter privilege separation.
> >
>=20
> Could the security contexts be given as arguments to qemu for the
> subprocesses? The reason to have qemu spawn its own subprocess is that =
it
> would leave more flexibility on how and when to do it, or even to use
> multiple subprcesses if some day that makes sense. If there is no reaso=
n to
> make this interface public or shared by various other processes, I woul=
d
> rather see it as internal to qemu rather than managed by other tools. I=
t
> also makes command line & testing easier.

If QEMU is responsible for spawning it, then swtpm would have to run as t=
he
same user/group as QEMU, as we do not want QEMU to have ability to invoke
programs with setuid. This means any state files / config / devices that
swtpm has to access would also be accessible by QEMU directly (assuming j=
ust
DAC controls, no MAC like SELinux). It also means that swtpm would be abl=
e
to access QEMU resources - so a bug in swtpm would allow swtpm to comprom=
ise
the guest disk image and other resources QEMU access.

If by contrast, libvirtd is responsible for spawning it, or an even a hig=
her
level mgmt app like OpenStack/oVirt, then swtpm can be run with completel=
y
isolated user / group privileges. The only resource that QEMU needs acces=
s
to is the UNIX domain socket, and swtpm doesn't need to access anything
belonging to QEMU. This will give us much stronger security separation
between swtpm & QEMU.  It will also allow us to write a more useful secco=
mp
policy that entirey blocks exec() from QEMU, further mitigating damage fr=
om
potential QEMU exploits.=20

Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|
