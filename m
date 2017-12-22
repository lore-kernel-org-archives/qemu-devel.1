Received: from eggs.gnu.org ([2001:4830:134:3::10]:41098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSNWI-0001iG-JZ
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:37:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSNWH-0005KH-Jq
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:37:50 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:42820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eSNWH-0005Jx-DV
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:37:49 -0500
Received: by mail-wm0-x241.google.com with SMTP id b199so22011727wme.1
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 05:37:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171125151610.20547-1-ehabkost@redhat.com>
References: <20171125151610.20547-1-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 22 Dec 2017 14:37:47 +0100
Message-ID: <CAJ+F1CJR4UWJRAAboqfa6eZjfyFrEEHxrdau0sL_L2QZnU2LeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/6] Replace has_dynamic_sysbus with
 list of allowed device types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, jgross@suse.com, Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>

Hi

On Sat, Nov 25, 2017 at 4:16 PM, Eduardo Habkost <ehabkost@redhat.com> wrot=
e:
> Changes v1 (RFC) -> v2:
> * Patch 1 now just adds TYPE_SYS_BUS_DEVICE to the existing
>   has_dynamic_sysbus=3Dtrue machines, and other patches make
>   the lists on each machine-type more specific.
> * Change the name of the new field to
>   allowed_dynamic_sysbus_devices.
> * The q35 allowed list is much shorter because the list of
>   user-creatable sysbus devices in QEMU is shorter.
> * Keep the xen_set_dynamic_sysbus() hack, just change it
>   to add 'xen-sysdev" to the allowed list.
> * Simplified the arm/virt code.
>
> Summary
> -------
>
> This series replaces the existing has_dynamic_sysbus flag (that
> makes the machine accept every user-creatable sysbus device type
> on the command-line) with a list of allowed devices.
>
> This will be helpful when implementing the new query-device-slots
> command, because each machine type will include only the sysbus
> devices it really supports, instead of including a catch-all
> TYPE_SYS_BUS_DEVICE "slot".
>
> This will be useful to add support to new sysbus devices on
> machines like pc_piix, that don't have has_dynamic_sysbus set
> today.
>
> This also makes the code safer: just compiling a new sysbus
> device in the same QEMU binary won't make a machine-type
> automatically start accepting the device.

Anything left for the series? (besides review of patch 5?) I need this
to be solved for the pending TPM CRB device to work with piix. Thanks

>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Cc: Alexander Graf <agraf@suse.de>
>
> Eduardo Habkost (6):
>   machine: Replace has_dynamic_sysbus with list of allowed devices
>   hw/arm/virt: Allow only supported dynamic sysbus devices
>   ppc: e500: Allow only supported dynamic sysbus devices
>   spapr: Allow only supported dynamic sysbus devices
>   xen: Add only xen-sysdev to dynamic sysbus device list
>   q35: Allow only supported dynamic sysbus devices
>
>  include/hw/boards.h  |  5 ++++-
>  hw/arm/virt.c        |  5 ++++-
>  hw/core/machine.c    | 43 +++++++++++++++++++++++++++++--------------
>  hw/i386/pc_q35.c     |  5 ++++-
>  hw/ppc/e500plat.c    |  4 +++-
>  hw/ppc/spapr.c       |  2 +-
>  hw/xen/xen_backend.c |  2 +-
>  7 files changed, 46 insertions(+), 20 deletions(-)
>
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
