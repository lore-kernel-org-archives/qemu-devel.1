Received: from eggs.gnu.org ([2001:4830:134:3::10]:59335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUGA9-0007SK-L2
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 14:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUGA6-0007Zj-TS
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 14:15:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gUGA6-0007ZD-LS
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 14:15:14 -0500
Date: Tue, 4 Dec 2018 17:15:06 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181204191506.GI18284@habkost.net>
References: <20181109173309.25212-1-danielhb413@gmail.com>
	<20181109173309.25212-4-danielhb413@gmail.com>
	<87bm689ien.fsf@dusky.pond.sub.org>
	<87va4f4st9.fsf@dusky.pond.sub.org>
	<2883a083-81a4-f29c-7c3c-df80853ce06b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2883a083-81a4-f29c-7c3c-df80853ce06b@gmail.com>
Subject: Re: [Qemu-devel] [PATCH for-3.2 v10 3/3] qmp hmp: Make
 system_wakeup check wake-up support and run state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, mdroth@linux.vnet.ibm.com, imammedo@redhat.com

On Tue, Dec 04, 2018 at 04:36:56PM -0200, Daniel Henrique Barboza wrote:
> 
> 
> On 11/29/18 4:55 PM, Markus Armbruster wrote:
> > One more thing...
> > 
> > Markus Armbruster <armbru@redhat.com> writes:
> > 
> > > Daniel Henrique Barboza <danielhb413@gmail.com> writes:
> > > 
> > > > The qmp/hmp command 'system_wakeup' is simply a direct call to
> > > > 'qemu_system_wakeup_request' from vl.c. This function verifies if
> > > > runstate is SUSPENDED and if the wake up reason is valid before
> > > > proceeding. However, no error or warning is thrown if any of those
> > > > pre-requirements isn't met. There is no way for the caller to
> > > > differentiate between a successful wakeup or an error state caused
> > > > when trying to wake up a guest that wasn't suspended.
> > > > 
> > > > This means that system_wakeup is silently failing, which can be
> > > > considered a bug. Adding error handling isn't an API break in this
> > > > case - applications that didn't check the result will remain broken,
> > > > the ones that check it will have a chance to deal with it.
> > > > 
> > > > Adding to that, the commit before previous created a new QMP API called
> > > > query-current-machine, with a new flag called wakeup-suspend-support,
> > > > that indicates if the guest has the capability of waking up from suspended
> > > > state. Although such guest will never reach SUSPENDED state and erroring
> > > > it out in this scenario would suffice, it is more informative for the user
> > > > to differentiate between a failure because the guest isn't suspended versus
> > > > a failure because the guest does not have support for wake up at all.
> > > > 
> > > > All this considered, this patch changes qmp_system_wakeup to check if
> > > > the guest is capable of waking up from suspend, and if it is suspended.
> > > > After this patch, this is the output of system_wakeup in a guest that
> > > > does not have wake-up from suspend support (ppc64):
> > > > 
> > > > (qemu) system_wakeup
> > > > wake-up from suspend is not supported by this guest
> > > > (qemu)
> > > > 
> > > > And this is the output of system_wakeup in a x86 guest that has the
> > > > support but isn't suspended:
> > > > 
> > > > (qemu) system_wakeup
> > > > Unable to wake up: guest is not in suspended state
> > > > (qemu)
> > > > 
> > > > Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> > > > Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> > > > ---
> > > >   hmp.c                   |  5 ++++-
> > > >   hw/acpi/core.c          |  4 +++-
> > > >   hw/char/serial.c        |  3 ++-
> > > >   hw/input/ps2.c          |  9 ++++++---
> > > >   hw/timer/mc146818rtc.c  |  3 ++-
> > > >   include/sysemu/sysemu.h |  3 ++-
> > > >   migration/migration.c   |  7 +++++--
> > > >   qapi/misc.json          |  8 +++++++-
> > > >   qmp.c                   | 13 ++++++++++++-
> > > >   vl.c                    |  6 ++++--
> > > >   10 files changed, 47 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/hmp.c b/hmp.c
> > > > index 7828f93a39..0f5d943413 100644
> > > > --- a/hmp.c
> > > > +++ b/hmp.c
> > > > @@ -1220,7 +1220,10 @@ void hmp_cont(Monitor *mon, const QDict *qdict)
> > > >   void hmp_system_wakeup(Monitor *mon, const QDict *qdict)
> > > >   {
> > > > -    qmp_system_wakeup(NULL);
> > > > +    Error *err = NULL;
> > > > +
> > > > +    qmp_system_wakeup(&err);
> > > > +    hmp_handle_error(mon, &err);
> > > >   }
> > > >   void hmp_nmi(Monitor *mon, const QDict *qdict)
> > > > diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> > > > index 52e18d7810..a7073dd435 100644
> > > > --- a/hw/acpi/core.c
> > > > +++ b/hw/acpi/core.c
> > > > @@ -514,7 +514,9 @@ static uint32_t acpi_pm_tmr_get(ACPIREGS *ar)
> > > >   static void acpi_pm_tmr_timer(void *opaque)
> > > >   {
> > > >       ACPIREGS *ar = opaque;
> > > > -    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_PMTIMER);
> > > > +    Error *err = NULL;
> > > > +
> > > > +    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_PMTIMER, &err);
> > > >       ar->tmr.update_sci(ar);
> > > >   }
> > Leaks the error object when qemu_system_wakeup_request() fails.
> > 
> > If it cannot fail here, pass &error_abort.
> > 
> > If it can fail, but you want to ignore failure, pass NULL.
> 
> Good point. I'll simply pass NULL to all callers that didn't care
> for the error prior to this change.

Most times I saw QEMU code ignoring errors, it actually didn't
expect any errors to happen and was supposed to be using
&error_abort instead.

This makes NULL errp always look like a bug to be fixed.  If you
are sure you really want to ignore an error, I'd recommend adding
a comment making your intention explicit.

-- 
Eduardo
