Received: from eggs.gnu.org ([2001:4830:134:3::10]:58835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUeFs-0007qO-DW
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUeFr-00020i-Hm
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:58:48 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  5 Dec 2018 18:58:22 -0200
Message-Id: <20181205205827.19387-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 0/5] spapr/virt/pc: Eliminate custom
 instance_init functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>

Based-on: <154385451622.17724.12272989665681200621.stgit@gimli.home>

To help us make machine-type version differences introspectable
by QEMU, the info need to be available at class_init time, and
not require instantiating a machine object.

This series moves machine-type version differences to class_init
functions, and let us eliminate version-specific instance_init
functions from spapr and virt.

On PC the pc_compat_*() functions still have some KVM-specific
code that needs to be moved to class_init before we delete the
pc_compat_*() functions.  We will probably be able to implement
this using AccelClass::compat_props later.

I also plan to move default_machine_opts data to
MachineClass::compat_props, after the compat_props/globals
cleanup[1] being implemented by Marc-Andr=C3=A9 Lureau is merged.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg576381.html

Eduardo Habkost (5):
  virt: Eliminate separate instance_init functions
  spapr: Use default_machine_opts to set use_hotplug_event_source
  spapr: Use default_machine_opts to set suppress_vmdesc
  spapr: Delete instance_options functions
  pc: Use default_machine_opts to set suppress_vmdesc

 hw/arm/virt.c     | 87 +++++++++++---------------------------------
 hw/i386/pc_piix.c |  2 +-
 hw/ppc/spapr.c    | 91 ++---------------------------------------------
 3 files changed, 24 insertions(+), 156 deletions(-)

--=20
2.18.0.rc1.1.g3f1ff2140
