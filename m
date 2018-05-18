Received: from eggs.gnu.org ([2001:4830:134:3::10]:60279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJb45-0008Op-30
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJb40-0003ID-KB
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:48:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39534 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fJb40-0003Hk-EC
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:48:36 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180517192325.8335-1-danielhb@linux.ibm.com>
	<20180517192325.8335-2-danielhb@linux.ibm.com>
Date: Fri, 18 May 2018 10:48:31 +0200
In-Reply-To: <20180517192325.8335-2-danielhb@linux.ibm.com> (Daniel Henrique
	Barboza's message of "Thu, 17 May 2018 16:23:23 -0300")
Message-ID: <87wow1gxi8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 1/3] qmp: adding
 'wakeup-suspend-support' in query-target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com, Eduardo Habkost <ehabkost@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, libvir-list@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Cc'ing a few more people.

Daniel Henrique Barboza <danielhb@linux.ibm.com> writes:

> When issuing the qmp/hmp 'system_wakeup' command, what happens in a
> nutshell is:
>
> - qmp_system_wakeup_request set runstate to RUNNING, sets a wakeup_reason
> and notify the event
> - in the main_loop, all vcpus are paused, a system reset is issued, all
> subscribers of wakeup_notifiers receives a notification, vcpus are then
> resumed and the wake up QAPI event is fired
>
> Note that this procedure alone doesn't ensure that the guest will awake
> from SUSPENDED state - the subscribers of the wake up event must take
> action to resume the guest, otherwise the guest will simply reboot.
>
> At this moment there are only two subscribers of the wake up event: one
> in hw/acpi/core.c and another one in hw/i386/xen/xen-hvm.c. This means
> that system_wakeup does not work as intended with other architectures.
>
> However, only the presence of 'system_wakeup' is required for QGA to
> support 'guest-suspend-ram' and 'guest-suspend-hybrid' at this moment.
> This means that the user/management will expect to suspend the guest using
> one of those suspend commands and then resume execution using system_wakeup,
> regardless of the support offered in system_wakeup in the first place.
>
> This patch adds a new flag called 'wakeup-suspend-support' in TargetInfo
> that allows the caller to query if the guest supports wake up from
> suspend via system_wakeup. It goes over the subscribers of the wake up
> event and, if it's empty, it assumes that the guest does not support
> wake up from suspend (and thus, pm-suspend itself).
>
> This is the expected output of query-target when running a x86 guest:
>
> {"execute" : "query-target"}
> {"return": {"arch": "x86_64", "wakeup-suspend-support": true}}
>
> This is the output when running a pseries guest:
>
> {"execute" : "query-target"}
> {"return": {"arch": "ppc64", "wakeup-suspend-support": false}}
>
> Given that the TargetInfo structure is read-only, adding a new flag to
> it is backwards compatible. There is no need to deprecate the old
> TargetInfo format.
>
> With this extra tool, management can avoid situations where a guest
> that does not have proper suspend/wake capabilities ends up in
> inconsistent state (e.g.
> https://github.com/open-power-host-os/qemu/issues/31).
>
> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.ibm.com>

Is query-target is the right place to carry this flag?  v7 is rather
late for this kind of question; my sincere apologies.

The flag is true after qemu_register_wakeup_notifier().  Callers so far:

* piix4_pm_realize() via acpi_pm1_cnt_init()

  This is the realize method of device PIIX4_PM.  It's an optional
  onboard device (suppressed by -no-acpi) of machine types
  pc-i440fx-VERSION, pc-VERSION, malta.

* pc_q35_init() via ich9_lpc_pm_init(), ich9_pm_init(),
  acpi_pm1_cnt_init()

  This is the initialization method of machine types pc-q35-VERSION.
  Note that -no-acpi is not honored.

* vt82c686b_pm_realize() via acpi_pm1_cnt_init()

  This is the realize method of device VT82C686B_PM.  It's an onboard
  device of machine type fulong2e.  Again, -no-acpi is not honored.
 
* xen_hvm_init()

  This one gets called with -accel xen.  I suspect the actual callback
  xen_wakeup_notifier() doesn't actually make wakeup work, unlike the
  acpi_notify_wakeup() callback registered by the other callers.

  Issue#1: this calls into question your assumption that the existence
  of a wake-up notifier implies wake-up works.  It still holds if
  --accel xen is only accepted together with other configuration that
  triggers registration of acpi_notify_wakeup().  Is it?  Stefano,
  Anthony?

Issue#2: the flag isn't a property of the target.  Due to -no-acpi, it's
not even a property of the machine type.  If it was, query-machines
would be the natural owner of the flag.

Perhaps query-machines is still the proper owner.  The value of
wakeup-suspend-support would have to depend on -no-acpi for the machine
types that honor it.  Not ideal; I'd prefer MachineInfo to be static.
Tolerable?  I guess that's also a libvirt question.
