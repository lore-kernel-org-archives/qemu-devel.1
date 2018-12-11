Received: from eggs.gnu.org ([2001:4830:134:3::10]:43810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWjF4-0008Bg-VS
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWjF0-0008VA-K2
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:42:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gWjF0-0008O2-DP
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:42:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE773307D91A
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 14:42:16 +0000 (UTC)
Date: Tue, 11 Dec 2018 14:42:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181211144211.GJ921@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181211143745.17342-1-cfergeau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181211143745.17342-1-cfergeau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] spice: Make logging printing go through
 QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Fergeau <cfergeau@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Dec 11, 2018 at 03:37:45PM +0100, Christophe Fergeau wrote:
> Since spice 0.14.1, it's possible to use g_log_set_default_handler() to
> use a custom function to print spice-server's logs, which gives more
> consistent log output.
> 
> With older spice versions, this is not going to work as expected, but
> will not have any ill effect, so this call is not conditional on spice
> version.
> 
> Since this added g_log_set_default_handler() will bridge glib logging
> and QEMU logging, the call might fit better in a more generic place.

Yeah, I think this is the kind of thing that could go early in
the main() method.

It might also be relevant to integrate it into unit tests and
other tools (qemu-img/nbd/io/etc).

> 
> Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
> ---
>  ui/spice-core.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index ebaae24643..443a2b3d32 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -632,6 +632,30 @@ static void vm_change_state_handler(void *opaque, int running,
>      }
>  }
>  
> +static void qemu_log_func(const gchar *log_domain,
> +                          GLogLevelFlags log_level,
> +                          const gchar *message,
> +                          gpointer user_data)
> +{
> +    switch (log_level & G_LOG_LEVEL_MASK) {
> +        case G_LOG_LEVEL_DEBUG:
> +            break;
> +        case G_LOG_LEVEL_INFO:
> +            /* Fall through */
> +        case G_LOG_LEVEL_MESSAGE:
> +            info_report("%s", message);
> +            break;
> +        case G_LOG_LEVEL_WARNING:
> +            /* Fall through */
> +        case G_LOG_LEVEL_CRITICAL:
> +            warn_report("%s", message);

IIUC, CRITICAL & ERROR are both reporting errors, the
only difference is that  LEVEL_ERROR results in the
process being terminated immediately.

Anyway, I think this means G_LOG_LEVEL_CRITICAL
should use erorr_report too. Only G_LOG_LEVEL_WARNING
should use warn_report

> +            break;
> +        case G_LOG_LEVEL_ERROR:
> +            error_report("%s", message);
> +            break;
> +    }
> +}

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
