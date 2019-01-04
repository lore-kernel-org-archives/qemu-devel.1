Received: from eggs.gnu.org ([208.118.235.92]:57054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gfNrv-0002vb-Tg
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:42:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gfNrs-0007jU-C7
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:42:26 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gfNrq-0007hx-G3
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:42:22 -0500
Received: by mail-wm1-x341.google.com with SMTP id f188so928776wmf.5
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 03:42:21 -0800 (PST)
MIME-Version: 1.0
References: <20181221090410.27250-1-marcandre.lureau@redhat.com>
In-Reply-To: <20181221090410.27250-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 4 Jan 2019 15:42:08 +0400
Message-ID: <CAJ+F1CKwA3hL4xA5De8VEqaOXqgN5LNouxj727q4WVaTUUt3Gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 00/28] Generalize machine compatibility
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Hi

On Fri, Dec 21, 2018 at 1:04 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi,
>
> During "[PATCH v2 05/10] qom/globals: generalize
> object_property_set_globals()" review, Eduardo suggested to rework the
> GlobalProperty handling, so that -global is limited to QDev only and
> we avoid mixing the machine compats and the user-provided -global
> properties (instead of generalizing -global to various object kinds,
> like I proposed in v2).
>
> "qdev: do not mix compat props with global props" patch decouples a
> bit user-provided -global from machine compat properties. This allows
> to get rid of "user_provided" and "errp" fields in following patches.
>
> A new compat property "x-use-canonical-path-for-ramblock-id" is added
> to hostmem for legacy canonical path names, set to true for -file and
> -memfd with qemu < 4.0.
>
> (this series was initially titled "[PATCH v2 00/10] hostmem: use
> object "id" for memory region name with >=3D 3.1", but its focus is more
> in refactoring the global and compatilibity properties handling now)
>

Beside the rebase conflicts, and added comment in patch 25, all
patches have been reviewed-by. I have pushed the rebased version on
github: https://github.com/elmarco/qemu/tree/props

Eduardo, Igor, who is making the pullreq? I could also send it, if you are =
okay.

Thanks

> v7:
> - rebased (s390 conflicts)
> - rename self/backend in last patch
> - add some r-b tags
>
> v6:
> - split "hw: apply machine compat properties without touching globals"
> - replace PC_COMPAT_* and HW_COMPAT_* defines with static arrays
> - add ARMCPUInfo *info in ARMCPUClass for "arm: replace
>   instance_post_init()" patch
> - rebased, commit message updates, add some r-b tags
>
> v5:
> - replace the SET_COMPAT macros, use normal function instead
>   (suggested by Eduardo)
> - replace the TYPE_COMPAT_PROPS interface approach for explicit
>   object_apply_compat_props(), solving post-init ordering issues.
> - get back to coupling compat properties with machine, in qdev
>   (although there is still some discussion how to improve this, it
>    can be changed later)
> - mark the "arm: replace instance_post_init()" as RFC, since it is not
>   longer required for this series
> - change machines version from 3.2 to 4.0
> - add some r-b tags
>
> v4:
> - fix accel/machine compat props apply order inversion
> - split "qdev: do not mix compat props with global props": replace
>   using current_machine by new compat_props global, introduce
>   SET_COMPAT() macro, use GPtrArray.
> - add a comment about "qdev-props: call object_apply_global_props()"
>   error reporting
> - add "arm: replace instance_post_init()", to solve the post-init
>   ordering issue
> - add "hw/arm/virt: add virt-3.2 machine type" for completeness
> - commit message improvements
> - rebased, add r-b tags
>
> v3:
> - GlobalProperties improvements/cleanups
> - drop generalizing the -global idea
> - "replace" the set_globals flag with a TYPE_COMPAT_PROPS interface
> - update hw/i386 machine version to 3.2
> - add "qom: make interface types abstract" interface cleanup
>
> v2:
> - replace "qom/user-creatable: add a few helper macros" patch for a
>   more optimized "qom: make user_creatable_complete() specific to
>   UserCreatable"
> - rename register_global_list() to register_global_properties()
> - call object_property_set_globals() after post-init
> - add and use a ObjectClass.set_globals flag, instead of dynamically
>   check object class in object_property_set_globals()
> - use object "id" in >=3D 3.1 instead of canonical path, add compat
>   property "x-use-canonical-path-for-ramblock-id" in base hostmem
>   class.
>
> Marc-Andr=C3=A9 Lureau (28):
>   hw: apply accel compat properties without touching globals
>   machines: replace COMPAT define with a static array
>   hw: apply machine compat properties without touching globals
>   machine: move compat properties out of globals
>   hw: remove SET_MACHINE_COMPAT
>   compat: replace PC_COMPAT_3_1 & HW_COMPAT_3_1 macros
>   compat: replace PC_COMPAT_3_0 & HW_COMPAT_3_0 macros
>   compat: replace PC_COMPAT_2_12 & HW_COMPAT_2_12 macros
>   compat: replace PC_COMPAT_2_11 & HW_COMPAT_2_11 macros
>   compat: replace PC_COMPAT_2_10 & HW_COMPAT_2_10 macros
>   compat: replace PC_COMPAT_2_9 & HW_COMPAT_2_9 macros
>   compat: replace PC_COMPAT_2_8 & HW_COMPAT_2_8 macros
>   compat: replace PC_COMPAT_2_7 & HW_COMPAT_2_7 macros
>   compat: replace PC_COMPAT_2_6 & HW_COMPAT_2_6 macros
>   compat: replace PC_COMPAT_2_5 & HW_COMPAT_2_5 macros
>   compat: replace PC_COMPAT_2_4 & HW_COMPAT_2_4 macros
>   compat: replace PC_COMPAT_2_3 & HW_COMPAT_2_3 macros
>   compat: replace PC_COMPAT_2_2 & HW_COMPAT_2_2 macros
>   compat: replace PC_COMPAT_2_1 & HW_COMPAT_2_1 macros
>   include: remove compat.h
>   compat: remove remaining PC_COMPAT macros
>   qdev: make a separate helper function to apply compat properties
>   qdev: all globals are now user-provided
>   qdev-props: convert global_props to GPtrArray
>   qdev-props: remove errp from GlobalProperty
>   qdev-props: call object_apply_global_props()
>   arm: replace instance_post_init()
>   hostmem: use object id for memory region name with >=3D 4.0
>
>  include/hw/boards.h            |  59 ++-
>  include/hw/compat.h            | 291 --------------
>  include/hw/i386/pc.h           | 684 +++------------------------------
>  include/hw/qdev-core.h         |  21 +-
>  include/qom/object.h           |   3 +
>  include/sysemu/accel.h         |   4 +-
>  include/sysemu/hostmem.h       |   3 +-
>  target/arm/cpu-qom.h           |   3 +
>  target/arm/cpu.h               |   2 +
>  accel/accel.c                  |  12 -
>  backends/hostmem-file.c        |   8 +-
>  backends/hostmem-memfd.c       |   2 +-
>  backends/hostmem-ram.c         |   9 +-
>  backends/hostmem.c             |  36 ++
>  hw/arm/virt.c                  |  46 +--
>  hw/core/machine.c              | 339 +++++++++++++++-
>  hw/core/qdev-properties.c      |  49 +--
>  hw/core/qdev.c                 |  15 +
>  hw/i386/pc.c                   | 668 ++++++++++++++++++++++++++++++++
>  hw/i386/pc_piix.c              | 603 +++++++++++++++--------------
>  hw/i386/pc_q35.c               |  36 +-
>  hw/ppc/spapr.c                 | 207 +++++-----
>  hw/s390x/s390-virtio-ccw.c     | 196 +++++-----
>  hw/xen/xen-common.c            |  41 +-
>  qom/cpu.c                      |   1 -
>  qom/object.c                   |  35 ++
>  target/arm/cpu.c               |  30 +-
>  target/arm/cpu64.c             |  24 +-
>  target/i386/cpu.c              |   1 -
>  target/sparc/cpu.c             |   1 -
>  tests/test-qdev-global-props.c |  57 +--
>  vl.c                           |   4 -
>  32 files changed, 1818 insertions(+), 1672 deletions(-)
>  delete mode 100644 include/hw/compat.h
>
> --
> 2.20.1.2.gb21ebb671b
>
>


--
Marc-Andr=C3=A9 Lureau
