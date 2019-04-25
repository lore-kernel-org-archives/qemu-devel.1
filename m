Received: from eggs.gnu.org ([209.51.188.92]:39638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJkYU-0005l7-H8
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJkYQ-0007LM-6G
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40681)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJkYP-0005ZT-Uh
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:10 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Apr 2019 17:00:47 -0300
Message-Id: <20190425200051.19906-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] Remove some qdev_get_machine() calls from
 CONFIG_USER_ONLY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Like Xu <like.xu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>

This series moves some qdev code outside qdev.o, so it can be
compiled only in CONFIG_SOFTMMU.

The code being moved includes two qdev_get_machine() calls, so
this will make it easier to move qdev_get_machine() to
CONFIG_SOFTMMU later.

After this series, there's one remaining qdev_get_machine() call
that seems more difficult to remove:

    static void device_set_realized(Object *obj, bool value, Error **errp)
    {
        /* [...] */
        if (!obj->parent) {
            gchar *name = g_strdup_printf("device[%d]", unattached_count++);

            object_property_add_child(container_get(qdev_get_machine(),
                                                    "/unattached"),
                                      name, obj, &error_abort);
            unattached_parent = true;
            g_free(name);
        }
        /* [...] */
    }

This one is tricky because on system emulation mode it needs
"/machine" to already exist, but in user-only mode it needs to
implicitly create a "/machine" container.

Eduardo Habkost (4):
  machine: Move gpio code to hw/core/gpio.c
  move qdev hotplug code to qdev-hotplug.c
  qdev: Don't compile hotplug code in user-mode emulation
  qdev-hotplug: Don't check type of qdev_get_machine()

 hw/core/bus.c                |  11 --
 hw/core/gpio.c               | 206 ++++++++++++++++++++++++++++++++
 hw/core/qdev-hotplug-stubs.c |  44 +++++++
 hw/core/qdev-hotplug.c       |  64 ++++++++++
 hw/core/qdev.c               | 219 -----------------------------------
 hw/core/Makefile.objs        |   5 +-
 tests/Makefile.include       |   3 +-
 7 files changed, 320 insertions(+), 232 deletions(-)
 create mode 100644 hw/core/gpio.c
 create mode 100644 hw/core/qdev-hotplug-stubs.c
 create mode 100644 hw/core/qdev-hotplug.c

-- 
2.18.0.rc1.1.g3f1ff2140
