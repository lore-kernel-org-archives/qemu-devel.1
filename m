Received: from eggs.gnu.org ([2001:4830:134:3::10]:33500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dYmLN-00083t-HW
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 00:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dYmLK-0000lv-G3
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 00:48:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:24006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1dYmLK-0000kZ-68
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 00:48:42 -0400
Message-ID: <1500699121.4962.54.camel@intel.com>
From: Amarnath Valluri <amarnath.valluri@intel.com>
Reply-To: amarnath.valluri@intel.com
Date: Sat, 22 Jul 2017 07:52:01 +0300
In-Reply-To: <CAJ+F1C+MYV+GLpGD0RZJ9gWXchfcbjrbDHQ5OsxuZ6W=chzBEw@mail.gmail.com>
References: <1500367747-8992-1-git-send-email-amarnath.valluri@intel.com>
	<1500367747-8992-9-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1C+MYV+GLpGD0RZJ9gWXchfcbjrbDHQ5OsxuZ6W=chzBEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On Tue, 2017-07-18 at 05:08 -0700, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Jul 18, 2017 at 1:49 AM, Amarnath Valluri
> <amarnath.valluri@intel.com> wrote:
> > This change introduces a new TPM backend driver that can communicate with
> > swtpm(software TPM emulator) using unix domain socket interface.
> >
> > Swtpm uses two unix sockets, one for plain TPM commands and responses, and one
> > for out-of-band control messages.
> >
> > The swtpm and associated tools can be found here:
> >     https://github.com/stefanberger/swtpm
> >
> > The swtpm's control channel protocol specification can be found here:
> >     https://github.com/stefanberger/swtpm/wiki/Control-Channel-Specification
> 
> I am afraid this isn't enough yet.
> 
> > Usage:
> >     # setup TPM state directory
> >     mkdir /tmp/mytpm
> >     chown -R tss:root /tmp/mytpm
> >     /usr/bin/swtpm_setup --tpm-state /tmp/mytpm --createek
> >
> >     # Ask qemu to use TPM emulator with given tpm state directory
> >     qemu-system-x86_64 \
> >         [...] \
> >         -tpmdev emulator,id=tpm0,tpmstatedir=/tmp/mytpm,logfile=/tmp/swtpm.log \
> 
> We should rather follow the vhost-user pattern: do not deal with
> spawning the external swtpm/backend, just use chardev to connect to
> it. At least you don't have to deal with process argument details,
> management etc that may change version to version.
I made the spawning completely optional and it is useful in some
environments, especially makes life easier when multiple QEMU instances
on a system.

One can configure QEMU to connect to already running software emulator
using Unix domain socket paths:
  -tpmdev emulator,id=tpm0,data-path=/path/,ctrl-path=/path

- Amarnath
