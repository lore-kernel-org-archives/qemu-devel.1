Received: from eggs.gnu.org ([2001:4830:134:3::10]:55681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRa3g-0000K3-U3
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRa3b-0002gO-UO
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:53:32 -0500
Received: from 12.mo7.mail-out.ovh.net ([178.33.107.167]:41964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gRa3b-0002fr-O3
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:53:27 -0500
Received: from player771.ha.ovh.net (unknown [10.109.160.12])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 3D6C8ECD75
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 10:53:26 +0100 (CET)
Date: Tue, 27 Nov 2018 10:53:21 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181127105321.5c46713d@bahia.lan>
In-Reply-To: <20181127092801.21777-1-marcandre.lureau@redhat.com>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v4 00/28] Generalize machine
 compatibility properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com

Hi Marc-Andr=C3=A9,

Patches 1 to 8 don't seem to belong to this series, and they already got
merged in master actually. Also next release is expected to be 4.0.

Cheers,

--
Greg

On Tue, 27 Nov 2018 13:27:33 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Hi,
>=20
> During "[PATCH v2 05/10] qom/globals: generalize
> object_property_set_globals()" review, Eduardo suggested to rework the
> GlobalProperty handling, so that -global is limited to QDev only and
> we avoid mixing the machine compats and the user-provided -global
> properties (instead of generalizing -global to various object kinds,
> like I proposed in v2).
>=20
> "qdev: do not mix compat props with global props" patch decouples a
> bit user-provided -global from machine compat properties. This allows
> to get rid of "user_provided" and "errp" fields in following patches.
>=20
> Instead of explcitely calling object_apply_global_props() in the
> various object post_init, I opted for creating a new TYPE_COMPAT_PROPS
> interface. The interface approach gives a lot more flexibility on
> which objects can have compat props. This requires some interface
> improvments in "qom: teach interfaces to implement post-init".
>=20
> A new compat property "x-use-canonical-path-for-ramblock-id" is added
> to hostmem for legacy canonical path names, set to true for -file and
> -memfd with qemu < 3.2.
>=20
> (this series was initially titled "[PATCH v2 00/10] hostmem: use
> object "id" for memory region name with >=3D 3.1", but its focus is more
> in refactoring the global and compatilibity properties handling now)
>=20
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
>=20
> v3:
> - GlobalProperties improvements/cleanups
> - drop generalizing the -global idea
> - "replace" the set_globals flag with a TYPE_COMPAT_PROPS interface
> - update hw/i386 machine version to 3.2
> - add "qom: make interface types abstract" interface cleanup
>=20
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
>=20
> Edgar E. Iglesias (1):
>   net: cadence_gem: Remove incorrect assert()
>=20
> Eric Auger (1):
>   MAINTAINERS: Add an ARM SMMU section
>=20
> Greg Kurz (1):
>   9p: fix QEMU crash when renaming files
>=20
> Marc-Andr=C3=A9 Lureau (20):
>   tests: qdev_prop_check_globals() doesn't return "all_used"
>   qom: make interface types abstract
>   qom: make user_creatable_complete() specific to UserCreatable
>   accel: register global_props like machine globals
>   qdev: move qdev_prop_register_global_list() to tests
>   qom: remove unimplemented class_finalize
>   hw: apply accel compat properties without touching globals
>   hw: apply machine compat properties without touching globals
>   hw: remove SET_MACHINE_COMPAT
>   qdev: all globals are now user-provided
>   qdev-props: convert global_props to GPtrArray
>   qdev-props: remove errp from GlobalProperty
>   qdev-props: call object_apply_global_props()
>   qom: teach interfaces to implement post-init
>   qom: add object_class_get_class_data()
>   arm: replace instance_post_init()
>   machine: add compat-props interface
>   hw/i386: add pc-i440fx-3.2 & pc-q35-3.2
>   hw/arm/virt: add virt-3.2 machine type
>   hostmem: use object id for memory region name with >=3D 3.1
>=20
> Max Filippov (4):
>   target/xtensa: gdbstub fix register counting
>   target/xtensa: drop num_[core_]regs from dc232b/dc233c configs
>   target/xtensa: xtfpga: provide default memory sizes
>   MAINTAINERS: add missing xtensa patterns
>=20
> Thomas Huth (1):
>   MAINTAINERS: Assign some more files in the hw/arm/ directory
>=20
