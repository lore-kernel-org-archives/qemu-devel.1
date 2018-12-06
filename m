Received: from eggs.gnu.org ([2001:4830:134:3::10]:37684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUncH-0001Vm-MJ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:58:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUncB-00009k-W9
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:58:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUnc8-00005Z-2f
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:58:25 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181205194701.17836-1-danielhb413@gmail.com>
	<20181205194701.17836-4-danielhb413@gmail.com>
Date: Thu, 06 Dec 2018 07:58:15 +0100
In-Reply-To: <20181205194701.17836-4-danielhb413@gmail.com> (Daniel Henrique
	Barboza's message of "Wed, 5 Dec 2018 17:47:01 -0200")
Message-ID: <87tvjrjg54.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 3/3] qmp hmp: Make system_wakeup check
 wake-up support and run state
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

> The qmp/hmp command 'system_wakeup' is simply a direct call to
> 'qemu_system_wakeup_request' from vl.c. This function verifies if
> runstate is SUSPENDED and if the wake up reason is valid before
> proceeding. However, no error or warning is thrown if any of those
> pre-requirements isn't met. There is no way for the caller to
> differentiate between a successful wakeup or an error state caused
> when trying to wake up a guest that wasn't suspended.
>
> This means that system_wakeup is silently failing, which can be
> considered a bug. Adding error handling isn't an API break in this
> case - applications that didn't check the result will remain broken,
> the ones that check it will have a chance to deal with it.
>
> Adding to that, the commit before previous created a new QMP API called
> query-current-machine, with a new flag called wakeup-suspend-support,
> that indicates if the guest has the capability of waking up from suspended
> state. Although such guest will never reach SUSPENDED state and erroring
> it out in this scenario would suffice, it is more informative for the user
> to differentiate between a failure because the guest isn't suspended versus
> a failure because the guest does not have support for wake up at all.
>
> All this considered, this patch changes qmp_system_wakeup to check if
> the guest is capable of waking up from suspend, and if it is suspended.
> After this patch, this is the output of system_wakeup in a guest that
> does not have wake-up from suspend support (ppc64):
>
> (qemu) system_wakeup
> wake-up from suspend is not supported by this guest
> (qemu)
>
> And this is the output of system_wakeup in a x86 guest that has the
> support but isn't suspended:
>
> (qemu) system_wakeup
> Unable to wake up: guest is not in suspended state
> (qemu)
>
> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
