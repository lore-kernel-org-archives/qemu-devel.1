Received: from eggs.gnu.org ([2001:4830:134:3::10]:33070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPW0r-0002Wh-Vq
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:10:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPW0o-0007Y9-2a
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:10:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gPW0n-0007Uu-Tk
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:10:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B06093002C89
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 17:10:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181121131638.26369-1-kraxel@redhat.com>
Date: Wed, 21 Nov 2018 18:09:56 +0100
In-Reply-To: <20181121131638.26369-1-kraxel@redhat.com> (Gerd Hoffmann's
	message of "Wed, 21 Nov 2018 14:16:38 +0100")
Message-ID: <874lca1hnf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] qapi: add query-display-options command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Gerd Hoffmann <kraxel@redhat.com> writes:

> Add query-display-options command, which allows querying the qemu
> display configuration, and -- as an intentional side effect -- makes
> DisplayOptions discoverable via query-qmp-schema so libvirt can go
> figure which display options are supported.

I understand the why the side effect is useful.  But is it the only
reason for the new command?

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Tested-by: Eric Blake <eblake@redhat.com>
> Tested-by: Erik Skultety <eskultet@redhat.com>
> ---
>  vl.c         | 10 ++++++++++
>  qapi/ui.json | 13 +++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/vl.c b/vl.c
> index fa25d1ae2d..c6e662677a 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -128,6 +128,7 @@ int main(int argc, char **argv)
>  #include "qapi/qapi-commands-block-core.h"
>  #include "qapi/qapi-commands-misc.h"
>  #include "qapi/qapi-commands-run-state.h"
> +#include "qapi/qapi-commands-ui.h"
>  #include "qapi/qmp/qerror.h"
>  #include "sysemu/iothread.h"
>  
> @@ -2055,6 +2056,15 @@ static void parse_display_qapi(const char *optarg)
>      visit_free(v);
>  }
>  
> +DisplayOptions *qmp_query_display_options(Error **errp)
> +{
> +    DisplayOptions *opts;
> +
> +    opts = g_new(DisplayOptions, 1);
> +    QAPI_CLONE_MEMBERS(DisplayOptions, opts, &dpy);
> +    return opts;

What's wrong with

       return QAPI_CLONE(DisplayOptions, &dpy)

?

> +}
> +
>  static void parse_display(const char *p)
>  {
>      const char *opts;
> diff --git a/qapi/ui.json b/qapi/ui.json
> index e0000248d3..fd39acb5c3 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -1102,3 +1102,16 @@
>    'discriminator' : 'type',
>    'data'    : { 'gtk'            : 'DisplayGTK',
>                  'egl-headless'   : 'DisplayEGLHeadless'} }
> +
> +##
> +# @query-display-options:
> +#
> +# Returns information about display configuration
> +#
> +# Returns: @DisplayOptions
> +#
> +# Since: 3.1
> +#
> +##
> +{ 'command': 'query-display-options',
> +  'returns': 'DisplayOptions' }
