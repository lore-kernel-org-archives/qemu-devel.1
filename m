Received: from eggs.gnu.org ([209.51.188.92]:33329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h3VZs-0005HR-BQ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h3VZr-0000di-CG
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:47:32 -0400
Date: Mon, 11 Mar 2019 20:47:18 -0400
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190312004718.kex6fnzr7ccirl4q@localhost.localdomain>
References: <20190221005753.27955-1-crosa@redhat.com>
	<20190221005753.27955-14-crosa@redhat.com>
	<20190301115513.48696631.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301115513.48696631.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 13/20] scripts/qemu.py: support adding a
 console with the default serial device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>

On Fri, Mar 01, 2019 at 11:55:13AM +0100, Cornelia Huck wrote:
> On Wed, 20 Feb 2019 19:57:46 -0500
> Cleber Rosa <crosa@redhat.com> wrote:
> 
> > The set_console() utility function traditionally adds a device either
> > based on the explicitly given device type, or based on the machine type,
> > a known good type of device.
> 
> Hm, I find this sentence hard to parse... maybe it should be "either
> adds a device..." and "adds a known good type of device"?
>

OK, sounds good, but I may change it a little bit given that you
following feedback made me change (positively) a lot here.

> > 
> > But, for a number of machine types, it may be impossible or
> > inconvenient to add the devices my means of "-device" command line
> 
> s/my/by/
>

Same here.

> > options, and then it may better to just use the "-serial" option and
> > let QEMU itself, based on the machine type, set the device
> > accordingly.
> > 
> > To achieve that, the behavior of set_console() now flags the intention
> > to add a console device on launch(), and if no explicit device type is
> > given, and there's no definition on CONSOLE_DEV_TYPES, the "-serial"
> > is going to be added to the QEMU command line, instead of raising
> > exceptions.
> > 
> > Based on testing with different machine types, the CONSOLE_DEV_TYPES
> > is now being set to the bare essential entries (one entry to be
> > honest), for machine types that can not easily give us a working
> > console with "-serial".
> > 
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  scripts/qemu.py | 39 +++++++++++++++++++--------------------
> >  1 file changed, 19 insertions(+), 20 deletions(-)
> > 
> > diff --git a/scripts/qemu.py b/scripts/qemu.py
> > index ee85309923..bd1d2e2b9a 100644
> > --- a/scripts/qemu.py
> > +++ b/scripts/qemu.py
> > @@ -42,11 +42,6 @@ def kvm_available(target_arch=None):
> >  
> >  #: Maps machine types to the preferred console device types
> >  CONSOLE_DEV_TYPES = {
> > -    r'^clipper$': 'isa-serial',
> > -    r'^malta': 'isa-serial',
> > -    r'^(pc.*|q35.*|isapc)$': 'isa-serial',
> > -    r'^(40p|powernv|prep)$': 'isa-serial',
> > -    r'^pseries.*': 'spapr-vty',
> >      r'^s390-ccw-virtio.*': 'sclpconsole',
> 
> FWIW, s390x has supported the '-serial' parameter since 3.0 (commit
> 052888f043bacb18231046045b1f9cd946703170). Maybe you can drop this now?

Yes, thanks for pointing that out!  I'm simplifying the set_console()
behavior and dropping the CONSOLE_DEV_TYPES dict completely.

> If not, what error are you getting?

No errors, it seems to work great now.

- Cleber.
