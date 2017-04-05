Received: from eggs.gnu.org ([2001:4830:134:3::10]:52472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cvp3m-0006Yn-I2
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 13:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cvp3k-0001yZ-SX
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 13:49:34 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cvp3k-0001yP-FW
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 13:49:32 -0400
Received: by mail-lf0-x242.google.com with SMTP id v2so1794224lfi.2
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 10:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<20170403170738.GC2768@redhat.com>
	<6a70868f-8831-54ce-5c67-c325acf03fec@intel.com>
	<b894f5b7-64ad-7696-b3fe-82941e2d6c5b@linux.vnet.ibm.com>
	<CAJ+F1C+XKOWyqse2L+4sYPOOnSfqX89+tVGtHhOqwc-GP0eZKQ@mail.gmail.com>
	<090205a2-2246-5fd1-2d60-d78848eb8af5@linux.vnet.ibm.com>
In-Reply-To: <090205a2-2246-5fd1-2d60-d78848eb8af5@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 05 Apr 2017 17:49:20 +0000
Message-ID: <CAJ+F1CLxZ15CnOxEwha6=NQyUSyLmoWh62ZAmr2OJT8TQDOB+A@mail.gmail.com>
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
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org

Hi

On Wed, Apr 5, 2017 at 7:32 PM Stefan Berger <stefanb@linux.vnet.ibm.com>
wrote:

> On 04/05/2017 11:08 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Wed, Apr 5, 2017 at 5:04 PM Stefan Berger <stefanb@linux.vnet.ibm.co=
m
> >
> > wrote:
> >
> >> On 04/05/2017 03:09 AM, Amarnath Valluri wrote:
> >>>
> >>> On 03.04.2017 20 <03%2004%2020%2017%2020>
> <03%2004%2020%2017%2020>:07, Daniel P. Berrange wrote:
> >>>> On Fri, Mar 31, 2017 at 04:10:09PM +0300, Amarnath Valluri wrote:
> >>>>> Briefly, Theses set of patches introduces:
> >>>>>    - new TPM backend driver to support software TPM
> emulators(swtpm(1)).
> >>>>>    - and few supported fixes/enhancements/cleanup to existing tpm
> >>>>> backend code.
> >>>>>
> >>>>> The similar idea was initiated earliar(2) by Stefan Berger(CCed)
> >>>>> with slightly
> >>>>> different approach, using CUSE. As swtpm has excellent support for
> >>>>> unix domain
> >>>>> sockets, hence this implementation uses unix domain sockets to
> >>>>> communicate with
> >>>>> swtpm.
> >>>>>
> >>>>> When Qemu is configured with 'emulator' tpm backend, it spawns
> >>>>> 'swtpm' and
> >>>>> communicates its via Unix domain sockets.
> >>>> I'm not convinced that having QEMU spawning swtpm itself is a
> desirable
> >>>> approach, as it means QEMU needs to have all the privileges that swt=
pm
> >>>> will need, so that swtpm can inherit them. At the very least I think
> we
> >>>> need to have a way to disable this spawning, so it can connect to a
> >>>> pre-existing swtpm process that's been spawned ahead of time. This
> will
> >>>> let us have stricter privilege separation.
> >>> Both spawning inside qemu and connecting to already running swtpm has
> >>> its own pros, Hence we can make this spawning as backend configuratio=
n
> >>> detail, So it looks like this:
> >>>
> >>> -tpmdev
> >>>
> >>
> emulator,id=3Did,tpmstatedir=3Ddir[,spawn=3D[on|off],data-path=3Dpath,ctr=
l-path=3Dpath,logfile=3Dpath,loglevel=3Dnumber]
> >>>    Options details:
> >>>       tpmstatedir - Directory path, which swtpm should  use for
> >>> storing  TPM state
> >>>       *spawn      - should spawn new process, defaults to 'off'
> >>>       *path         - swtpm binary path to spawn, ignored if spawn is
> off
> >>>       *data-path - Socket path to use/connect for data messages
> >>>       *ctrl-path   - Socket path to use/connect for out-of-band contr=
ol
> >>> messages
> >> FD passing would work?
> >>
> > Could with /dev/fdset in theory, but it would be better to use chardevs
> > instead.
> >
> > Is there any reason left to have 2 sockets? Couldn't the data be sent a=
s
> > another message on the "ctrl-path" ?
>
> Better to keep them separate so whatever comes out of a VM will never be
> mistaken for a control command.
>

This is a moot argument, there is no reason the code would mix the two,

An alternative to make the setup easier is to pass the data socket through
the ctrl socket, perhaps.


> >
> >
> >>>       *logfile       - File path to use for swtpm logs
> >>>       *loglevel    - log level number, defaults to 5 (ignored if no
> >>> logfile provided)
> >>>
> >>> -  If spawn is off, data-path and ctrl-path must be provided to qemu,
> >>> where to connect already running swtpm
> >>> -  If spawn if on, both data-path and ctrl-path are optional. If not
> >>> provided, qemu uses socket pairs to communicates with swptm, as it is
> >>> doing now.
> >>>
> >>> Hope this satisfies all usecases, if everyone here happy with this i
> >>> can submit the new patch with these changes.
> >>>
> >>> - Amarnath
> >>>
> >>
> >> --
> > Marc-Andr=C3=A9 Lureau
> >
>
>
> --
Marc-Andr=C3=A9 Lureau
