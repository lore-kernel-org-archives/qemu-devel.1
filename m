Received: from eggs.gnu.org ([2001:4830:134:3::10]:54959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cv5cw-0000Q9-Vf
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cv5cv-0003jU-PA
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:18:50 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cv5cv-0003j3-CR
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:18:49 -0400
Received: by mail-lf0-x241.google.com with SMTP id n78so13519752lfi.3
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 10:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<20170403170738.GC2768@redhat.com>
In-Reply-To: <20170403170738.GC2768@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 03 Apr 2017 17:18:37 +0000
Message-ID: <CAJ+F1CKVU+bgyE2Z7v3kECZ-GVLj+gMiiRoSZt7yWGMj0UkfgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: "Daniel P. Berrange" <berrange@redhat.com>, Amarnath Valluri <amarnath.valluri@intel.com>
Cc: patrick.ohly@intel.com, qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com

Hi

On Mon, Apr 3, 2017 at 7:08 PM Daniel P. Berrange <berrange@redhat.com>
wrote:

> On Fri, Mar 31, 2017 at 04:10:09PM +0300, Amarnath Valluri wrote:
> > Briefly, Theses set of patches introduces:
> >  - new TPM backend driver to support software TPM emulators(swtpm(1)).
> >  - and few supported fixes/enhancements/cleanup to existing tpm backend
> code.
> >
> > The similar idea was initiated earliar(2) by Stefan Berger(CCed) with
> slightly
> > different approach, using CUSE. As swtpm has excellent support for unix
> domain
> > sockets, hence this implementation uses unix domain sockets to
> communicate with
> > swtpm.
> >
> > When Qemu is configured with 'emulator' tpm backend, it spawns 'swtpm'
> and
> > communicates its via Unix domain sockets.
>
> I'm not convinced that having QEMU spawning swtpm itself is a desirable
> approach, as it means QEMU needs to have all the privileges that swtpm
> will need, so that swtpm can inherit them. At the very least I think we
> need to have a way to disable this spawning, so it can connect to a
> pre-existing swtpm process that's been spawned ahead of time. This will
> let us have stricter privilege separation.
>

Could the security contexts be given as arguments to qemu for the
subprocesses? The reason to have qemu spawn its own subprocess is that it
would leave more flexibility on how and when to do it, or even to use
multiple subprcesses if some day that makes sense. If there is no reason to
make this interface public or shared by various other processes, I would
rather see it as internal to qemu rather than managed by other tools. It
also makes command line & testing easier.

Similarly, I think the swtpm protocol must offer enough guarantee about
stability, versionning / capabilities, that we can later extend it. swtpm
could likely be implemented in qemu (by using libswtpm), using a private
protocol. It's hard to estimate how much code that represents, but I think
by reusing glib & qemu common it should be fairly small & simple. I haven't
looked in details.

thanks
--=20
Marc-Andr=C3=A9 Lureau
