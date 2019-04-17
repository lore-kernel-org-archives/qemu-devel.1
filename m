Received: from eggs.gnu.org ([209.51.188.92]:59349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGo5P-0007TD-TO
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGo5O-0007Nr-Su
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:11:03 -0400
Date: Wed, 17 Apr 2019 14:10:59 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190417171059.GC25134@habkost.net>
References: <1555315185-16414-1-git-send-email-like.xu@linux.intel.com>
	<1555315185-16414-3-git-send-email-like.xu@linux.intel.com>
	<20190416212003.GB2272@habkost.net>
	<87ftqh1ae5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftqh1ae5.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] core/qdev: refactor
 qdev_get_machine() with type assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Like Xu <like.xu@linux.intel.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, like.xu@intel.com, Igor Mammedov <imammedo@redhat.com>

On Wed, Apr 17, 2019 at 07:14:10AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On Mon, Apr 15, 2019 at 03:59:45PM +0800, Like Xu wrote:
> >> To avoid the misuse of qdev_get_machine() if machine hasn't been created yet,
> >> this patch uses qdev_get_machine_uncheck() for obj-common (share with user-only
> >> mode) and adds type assertion to qdev_get_machine() in system-emulation mode.
> >> 
> >> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> >> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> >
> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> >
> > I'm queueing the series on machine-next, thanks!
> 
> Hold your horses, please.
> 
> I dislike the name qdev_get_machine_uncheck().  I could live with
> qdev_get_machine_unchecked().
> 
> However, I doubt this is the right approach.
> 
> The issue at hand is undisciplined creation of QOM object /machine.
> 
> This patch adds an asseertion "undisciplined creation of /machine didn't
> create crap", but only in some places.
> 
> I think we should never create /machine as (surprising!) side effect of
> qdev_get_machine().  Create it explicitly instead, and have
> qdev_get_machine() use object_resolve_path("/machine", NULL) to get it.
> Look ma, no side effects.

OK, I'm dropping this one while we discuss it.

I really miss a good explanation why qdev_get_machine_unchecked()
needs to exist.  When exactly do we want /machine to exist but
not be TYPE_MACHINE?  Why?

Once the expectations and use cases are explained, we can choose
a better name for qdev_get_machine_unchecked() and document it
properly.

-- 
Eduardo
