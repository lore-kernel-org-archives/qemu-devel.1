Received: from eggs.gnu.org ([2001:4830:134:3::10]:34643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUnXz-0006aT-E3
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUnXv-0004Ot-1r
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:54:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUnXu-0004OF-Ou
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:54:02 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181205194701.17836-1-danielhb413@gmail.com>
	<20181205194701.17836-2-danielhb413@gmail.com>
Date: Thu, 06 Dec 2018 07:53:56 +0100
In-Reply-To: <20181205194701.17836-2-danielhb413@gmail.com> (Daniel Henrique
	Barboza's message of "Wed, 5 Dec 2018 17:46:59 -0200")
Message-ID: <8736rbkuwr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 1/3] qmp: query-current-machine with
 wakeup-suspend-support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com, mdroth@linux.vnet.ibm.com, imammedo@redhat.com

Daniel Henrique Barboza <danielhb413@gmail.com> writes:

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
> action to resume the guest, otherwise the guest will simply reboot. At
> this moment, only the ACPI machines via acpi_pm1_cnt_init and xen_hvm_init
> have wake-up from suspend support.
>
> However, only the presence of 'system_wakeup' is required for QGA to
> support 'guest-suspend-ram' and 'guest-suspend-hybrid' at this moment.
> This means that the user/management will expect to suspend the guest using
> one of those suspend commands and then resume execution using system_wakeup,
> regardless of the support offered in system_wakeup in the first place.
>
> This patch creates a new API called query-current-machine [1], that holds
> a new flag called 'wakeup-suspend-support' that indicates if the guest
> supports wake up from suspend via system_wakeup. The machine is considered
> to implement wake-up support if a call to a new 'qemu_register_wakeup_support'
> is made during its init, as it is now being done inside acpi_pm1_cnt_init
> and xen_hvm_init. This allows for any other machine type to declare wake-up
> support regardless of ACPI state or wakeup_notifiers subscription, making easier
> for newer implementations that might have their own mechanisms in the future.
>
> This is the expected output of query-current-machine when running a x86
> guest:
>
> {"execute" : "query-current-machine"}
> {"return": {"wakeup-suspend-support": true}}
>
> Running the same x86 guest, but with the --no-acpi option:
>
> {"execute" : "query-current-machine"}
> {"return": {"wakeup-suspend-support": false}}
>
> This is the output when running a pseries guest:
>
> {"execute" : "query-current-machine"}
> {"return": {"wakeup-suspend-support": false}}
>
> With this extra tool, management can avoid situations where a guest
> that does not have proper suspend/wake capabilities ends up in
> inconsistent state (e.g.
> https://github.com/open-power-host-os/qemu/issues/31).
>
> [1] the decision of creating the query-current-machine API is based
> on discussions in the QEMU mailing list where it was decided that
> query-target wasn't a proper place to store the wake-up flag, neither
> was query-machines because this isn't a static property of the
> machine object. This new API can then be used to store other
> dynamic machine properties that are scattered around the code
> ATM. More info at:
> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg04235.html
>
> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
