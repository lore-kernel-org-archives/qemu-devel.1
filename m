Received: from eggs.gnu.org ([2001:4830:134:3::10]:36257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g7HrH-0001kf-S2
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:24:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g7HrH-00024I-0q
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:24:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g7HrG-00023o-OE
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 06:24:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id n1-v6so1549594wrt.10
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 03:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180912125531.32131-1-marcandre.lureau@redhat.com>
In-Reply-To: <20180912125531.32131-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Oct 2018 14:24:37 +0400
Message-ID: <CAJ+F1C+W4X3CC5RZvdXTq_76rTg+93b9-cFst1efEbX-fUP4zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/9] hostmem-ram: use whole path for region
 name with >= 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, mark.cave-ayland@ilande.co.uk, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, atar4qemu@gmail.com, Richard Henderson <rth@twiddle.net>

Hi

On Wed, Sep 12, 2018 at 4:57 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi,
>
> The migration code expects the RAM block name to match between the
> source and destination.  However the backend type may change, so it is
> possible (so far) to migrate from a hostmem-file to a hostmem-memfd
> for example.
>
> However, hostmem backends use inconsistent RAM naming, which can cause
> a name mismatch. hostmem-file and hostmem-memfd use the whole object
> path as memory name, while -ram use only the "component" (or basename)
> of the path.
>
> This series adds global/compat property support for objects others
> than TYPE_DEVICE (only TYPE_USER_CREATABLE for now), and a new compat
> property "x-component-name" to hostmem-ram. Machines >=3D 3.1 will use
> the whole path for the -ram memory name (like -file and -memfd).

The series now has a minor conflict in vl.c. I can resend if necessary.

Anyone to review the qdev/qom changes?

thanks

>
> Marc-Andr=C3=A9 Lureau (9):
>   qom/user-creatable: add a few helper macros
>   accel: register global_props like machine globals
>   qdev: move qdev_prop_register_global_list() to tests
>   qom/globals: move qdev globals to qom
>   qom/globals: generalize object_property_set_globals()
>   qom/object: set globals when initializing object
>   tests: add user-creatable test to test-qdev-global-props
>   hw/i386: add pc-i440fx-3.1 & pc-q35-3.1
>   hostmem-ram: use whole path for memory region name with >=3D 3.1
>
>  include/hw/compat.h                           |   6 +-
>  include/hw/i386/pc.h                          |   5 +-
>  include/hw/qdev-core.h                        |  20 ---
>  include/hw/qdev-properties.h                  |  34 +---
>  include/qom/globals.h                         |  32 ++++
>  include/qom/object_interfaces.h               |   4 +
>  accel/accel.c                                 |   9 +-
>  backends/hostmem-ram.c                        |  47 +++++-
>  hw/core/machine.c                             |   2 +-
>  hw/core/qdev-properties.c                     |  97 -----------
>  hw/core/qdev.c                                |   6 -
>  hw/i386/pc_piix.c                             |  15 +-
>  hw/i386/pc_q35.c                              |  13 +-
>  qom/cpu.c                                     |   2 +-
>  qom/globals.c                                 |  81 ++++++++++
>  qom/object.c                                  |   6 +-
>  qom/object_interfaces.c                       |   9 +-
>  target/i386/cpu.c                             |   2 +-
>  target/sparc/cpu.c                            |   2 +-
>  ...dev-global-props.c =3D> test-global-props.c} | 150 +++++++++++++++---
>  vl.c                                          |   8 +-
>  qom/Makefile.objs                             |   2 +-
>  tests/Makefile.include                        |   4 +-
>  23 files changed, 350 insertions(+), 206 deletions(-)
>  create mode 100644 include/qom/globals.h
>  create mode 100644 qom/globals.c
>  rename tests/{test-qdev-global-props.c =3D> test-global-props.c} (71%)
>
> --
> 2.19.0.rc1
>
>


--=20
Marc-Andr=C3=A9 Lureau
