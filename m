Received: from eggs.gnu.org ([2001:4830:134:3::10]:47001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jannh@google.com>) id 1feroV-000082-8C
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 20:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jannh@google.com>) id 1feroT-0002rv-TB
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 20:56:31 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:44601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jannh@google.com>) id 1feroT-0002rd-Lz
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 20:56:29 -0400
Received: by mail-oi0-x244.google.com with SMTP id s198-v6so71762439oih.11
	for <qemu-devel@nongnu.org>; Sun, 15 Jul 2018 17:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2Rq18M+a84Ae+N5_=eS2A6zZNrG9r19MWS6hddq=x4Rw@mail.gmail.com>
	<CAFEAcA_+oq2H=-_7+AxqpXb_VhUsSAgVgN8K7Q+ffeKXxs5gWQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_+oq2H=-_7+AxqpXb_VhUsSAgVgN8K7Q+ffeKXxs5gWQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 16 Jul 2018 02:56:01 +0200
Message-ID: <CAG48ez2CkA4jS8WiJ7Yj6dTsvoC_ozNdoQeOXxfg7JmRaK8srw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] insecure git submodule URLs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu Developers <qemu-devel@nongnu.org>, jcody@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

On Sun, Jul 15, 2018 at 11:18 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On 15 July 2018 at 20:50, Jann Horn via Qemu-devel
> <qemu-devel@nongnu.org> wrote:
> > I noticed that when I build QEMU from git for the first time, it pulls
> > in submodules over the insecure git:// protocol - in other words, as
> > far as I can tell, if I'm e.g. on an open wifi network while building
> > QEMU for the first time, even if I cloned the main repository over
> > https, anyone could smuggle in malicious code as part of e.g. a
> > submodule's makefile.
>
> Yes, this came up the other week.
>
> > I'm not sure what your preferred fix for this is, so I'm not sending a
> > patch yet. As far as I can tell, the two options are:
> >
> >  - change .gitmodules to use https for everything
>
> We should probably do this...
>
> >  - change .gitmodules to use relative URLs
> >
> > If you want, I'll send a patch that does one of these, although it's
> > probably faster if you just do it yourselves.
> >
> > Relative URLs would have the advantage that if someone is cloning from
> > a mirror (in other words, github), the submodules will also
> > automatically come from the same mirror.
>
> Do we mirror all our submodules to github?

Looks that way - I cloned from github, patched my .submodules to use
relative URLs for everything, then tested:

$ git submodule init
Submodule 'capstone' (capstone.git) registered for path 'capstone'
Submodule 'dtc' (dtc.git) registered for path 'dtc'
Submodule 'roms/QemuMacDrivers' (QemuMacDrivers.git) registered for
path 'roms/QemuMacDrivers'
Submodule 'roms/SLOF' (SLOF.git) registered for path 'roms/SLOF'
Submodule 'roms/ipxe' (ipxe.git) registered for path 'roms/ipxe'
Submodule 'roms/openbios' (openbios.git) registered for path 'roms/openbios'
Submodule 'roms/openhackware' (openhackware.git) registered for path
'roms/openhackware'
Submodule 'roms/qemu-palcode' (qemu-palcode.git) registered for path
'roms/qemu-palcode'
Submodule 'roms/seabios' (seabios.git) registered for path 'roms/seabios'
Submodule 'roms/seabios-hppa'
(https://github.com/hdeller/seabios-hppa.git) registered for path
'roms/seabios-hppa'
Submodule 'roms/sgabios' (sgabios.git) registered for path 'roms/sgabios'
Submodule 'roms/skiboot' (skiboot.git) registered for path 'roms/skiboot'
Submodule 'roms/u-boot' (u-boot.git) registered for path 'roms/u-boot'
Submodule 'roms/u-boot-sam460ex' (u-boot-sam460ex.git) registered for
path 'roms/u-boot-sam460ex'
Submodule 'ui/keycodemapdb' (keycodemapdb.git) registered for path
'ui/keycodemapdb'
$ git submodule update
Submodule path 'capstone': checked out
'22ead3e0bfdb87516656453336160e0a37b066bf'
Submodule path 'dtc': checked out 'e54388015af1fb4bf04d0bca99caba1074d9cc42'
Submodule path 'roms/QemuMacDrivers': checked out
'd4e7d7ac663fcb55f1b93575445fcbca372f17a7'
Submodule path 'roms/SLOF': checked out
'7d37babcfa48a6eb08e726a8d13b745cb2eebe1c'
Submodule path 'roms/ipxe': checked out
'0600d3ae94f93efd10fc6b3c7420a9557a3a1670'
Submodule path 'roms/openbios': checked out
'8fe6f5f96f6ca39f1f62200be7fa130e929f13f2'
Submodule path 'roms/openhackware': checked out
'c559da7c8eec5e45ef1f67978827af6f0b9546f5'
Submodule path 'roms/qemu-palcode': checked out
'f3c7e44c70254975df2a00af39701eafbac4d471'
Submodule path 'roms/seabios': checked out
'f9626ccb91e771f990fbb2da92e427a399d7d918'
Submodule path 'roms/seabios-hppa': checked out
'1ef99a01572c2581c30e16e6fe69e9ea2ef92ce0'
Submodule path 'roms/sgabios': checked out
'cbaee52287e5f32373181cff50a00b6c4ac9015a'
Submodule path 'roms/skiboot': checked out
'e0ee24c27a172bcf482f6f2bc905e6211c134bcc'
Submodule path 'roms/u-boot': checked out
'd85ca029f257b53a96da6c2fb421e78a003a9943'
Submodule path 'roms/u-boot-sam460ex': checked out
'60b3916f33e617a815973c5a6df77055b2e3a588'
Submodule path 'ui/keycodemapdb': checked out
'6b3d716e2b6472eb7189d3220552280ef3d832ce'

> > As far as I can tell, the QEMU git server only supports the "dumb" git
> > protocol when accessed over HTTPS, not the "smart" protocol. I'm not
> > sure whether that might be why QEMU is currently still using the
> > insecure git protocol instead of git over HTTPS?
>
> This is why we haven't switched over the submodules yet, yes.
> It's on Jeff's todo list for the server, though.
>
> thanks
> -- PMM
