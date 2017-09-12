Received: from eggs.gnu.org ([2001:4830:134:3::10]:33451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drks1-0006gI-Ln
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drkrv-0001dL-LH
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:04:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drkrv-0001cg-Cg
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:04:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50F6C883BE
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 13:04:46 +0000 (UTC)
Date: Tue, 12 Sep 2017 14:04:42 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170912130442.GI17633@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1504771369.git.mprivozn@redhat.com>
	<35d6ce6fe3d357122d73b8272bc8198134c74104.1504771369.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35d6ce6fe3d357122d73b8272bc8198134c74104.1504771369.git.mprivozn@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 3/3] watchdog: Allow setting action on
 the fly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

On Thu, Sep 07, 2017 at 10:05:26AM +0200, Michal Privoznik wrote:
> Currently, the only time that users can set watchdog action is at
> the start as all we expose is this -watchdog-action command line
> argument. This is suboptimal when users want to plug the device
> later via monitor. Alternatively, they might want to change the
> action for already existing device on the fly.
> 
> Inspired by: https://bugzilla.redhat.com/show_bug.cgi?id=1447169
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  hw/watchdog/watchdog.c | 8 +++++++-
>  qapi-schema.json       | 9 +++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
> index 0d3eeed187..670114ecfe 100644
> --- a/hw/watchdog/watchdog.c
> +++ b/hw/watchdog/watchdog.c
> @@ -29,6 +29,7 @@
>  #include "qapi-event.h"
>  #include "hw/nmi.h"
>  #include "qemu/help_option.h"
> +#include "qmp-commands.h"
>  
>  static WatchdogAction watchdog_action = WATCHDOG_ACTION_RESET;
>  static QLIST_HEAD(watchdog_list, WatchdogTimerModel) watchdog_list;
> @@ -85,7 +86,7 @@ int select_watchdog_action(const char *p)
>      g_free(qapi_value);
>      if (action < 0)
>          return -1;
> -    watchdog_action = action;
> +    qmp_watchdog_set_action(action, &error_abort);
>      return 0;
>  }
>  
> @@ -142,3 +143,8 @@ void watchdog_perform_action(void)
>          assert(0);
>      }
>  }
> +
> +void qmp_watchdog_set_action(WatchdogAction action, Error **errp)
> +{
> +    watchdog_action = action;
> +}
> diff --git a/qapi-schema.json b/qapi-schema.json
> index f3af2cb851..f5db401838 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3143,3 +3143,12 @@
>  # Since 2.9
>  ##
>  { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
> +
> +##
> +# @watchdog-set-action:
> +#
> +# Set watchdog action
> +#
> +# Since 2.11

Not sure how much it matters, but the standard syntax has a ':' following
the 'Since' word

I do notice that query-vm-generation-id violates this rule though, which
I what I guess you copied ?

> +##
> +{ 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
> --

Assuming the ':' is added in next posting (or by the committer), then

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
