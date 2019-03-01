Received: from eggs.gnu.org ([209.51.188.92]:56582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gzfpG-00065Z-NV
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:55:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gzfpF-0005Zw-T5
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:55:34 -0500
Date: Fri, 1 Mar 2019 11:55:13 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190301115513.48696631.cohuck@redhat.com>
In-Reply-To: <20190221005753.27955-14-crosa@redhat.com>
References: <20190221005753.27955-1-crosa@redhat.com>
	<20190221005753.27955-14-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>

On Wed, 20 Feb 2019 19:57:46 -0500
Cleber Rosa <crosa@redhat.com> wrote:

> The set_console() utility function traditionally adds a device either
> based on the explicitly given device type, or based on the machine type,
> a known good type of device.

Hm, I find this sentence hard to parse... maybe it should be "either
adds a device..." and "adds a known good type of device"?

> 
> But, for a number of machine types, it may be impossible or
> inconvenient to add the devices my means of "-device" command line

s/my/by/

> options, and then it may better to just use the "-serial" option and
> let QEMU itself, based on the machine type, set the device
> accordingly.
> 
> To achieve that, the behavior of set_console() now flags the intention
> to add a console device on launch(), and if no explicit device type is
> given, and there's no definition on CONSOLE_DEV_TYPES, the "-serial"
> is going to be added to the QEMU command line, instead of raising
> exceptions.
> 
> Based on testing with different machine types, the CONSOLE_DEV_TYPES
> is now being set to the bare essential entries (one entry to be
> honest), for machine types that can not easily give us a working
> console with "-serial".
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  scripts/qemu.py | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index ee85309923..bd1d2e2b9a 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -42,11 +42,6 @@ def kvm_available(target_arch=None):
>  
>  #: Maps machine types to the preferred console device types
>  CONSOLE_DEV_TYPES = {
> -    r'^clipper$': 'isa-serial',
> -    r'^malta': 'isa-serial',
> -    r'^(pc.*|q35.*|isapc)$': 'isa-serial',
> -    r'^(40p|powernv|prep)$': 'isa-serial',
> -    r'^pseries.*': 'spapr-vty',
>      r'^s390-ccw-virtio.*': 'sclpconsole',

FWIW, s390x has supported the '-serial' parameter since 3.0 (commit
052888f043bacb18231046045b1f9cd946703170). Maybe you can drop this now?
If not, what error are you getting?
