Received: from eggs.gnu.org ([2001:4830:134:3::10]:54740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXPXP-0004w0-Rw
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:52:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXPXM-0002Gv-Mg
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:52:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gXPXM-0002D0-Fo
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:52:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2284307D861
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 11:52:15 +0000 (UTC)
Date: Thu, 13 Dec 2018 11:52:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181213115212.GF5171@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181213112612.31242-1-cfergeau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181213112612.31242-1-cfergeau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] log: Make glib logging go through QEMU
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

On Thu, Dec 13, 2018 at 12:26:12PM +0100, Christophe Fergeau wrote:
> This commit adds a qemu_init_logging() helper which calls
> g_log_set_default_handler() so that glib logs (g_log, g_warning, ...)
> are handled similarly to other QEMU logs. This means they will get a
> timestamp if timestamps are enabled, and they will go through the
> monitor if one is configured.
> This commit also adds a call to qemu_init_logging() to the binaries
> installed by QEMU.
> 
> At the moment, this change will mostly impact SPICE logging if your
> spice version is >= 0.14.1. With older spice versions, this is not going
> to work as expected, but will not have any ill effect, so this call is
> not conditional on the SPICE version.
> 
> Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
> ---
> Changes since v1:
> - introduced a qemu_init_logging() helper, and call that in more
>   binaries than just vl.c

> +static void qemu_log_func(const gchar *log_domain,
> +                          GLogLevelFlags log_level,
> +                          const gchar *message,
> +                          gpointer user_data)
> +{
> +    switch (log_level & G_LOG_LEVEL_MASK) {
> +    case G_LOG_LEVEL_DEBUG:
> +        break;
> +    case G_LOG_LEVEL_INFO:
> +        /* Fall through */
> +    case G_LOG_LEVEL_MESSAGE:
> +        info_report("%s", message);
> +        break;
> +    case G_LOG_LEVEL_WARNING:
> +        /* Fall through */
> +    case G_LOG_LEVEL_CRITICAL:
> +        warn_report("%s", message);
> +        break;

This didn't adress my previous comment that _CRITICAL should do an
error_report, not warn_reoprt.

> +    case G_LOG_LEVEL_ERROR:
> +        error_report("%s", message);
> +        break;
> +    }
> +}

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
