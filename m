Received: from eggs.gnu.org ([2001:4830:134:3::10]:44441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRHSj-0007mt-5y
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRHSO-0006ZH-CY
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:02:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gRHSM-0006WP-BQ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:01:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A879CA4283
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 14:01:44 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181122071613.2889-1-kraxel@redhat.com>
Date: Mon, 26 Nov 2018 15:01:42 +0100
In-Reply-To: <20181122071613.2889-1-kraxel@redhat.com> (Gerd Hoffmann's
	message of "Thu, 22 Nov 2018 08:16:13 +0100")
Message-ID: <87h8g4lyyh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3] qapi: add query-display-options command
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
>
> Use case: commit d4dc4ab1 added rendernode parameter for egl-headless.

I understand why exposing DisplayOptions in query-qmp-schema is useful.
But can you think of a use for the new command?

If not, then this is a workaround for lack of CLI introspection.
That's okay, ball's in my court on that.  But I'd like to have the
"workaroundness" spelled out in the commit message then.

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Tested-by: Eric Blake <eblake@redhat.com>
> Tested-by: Erik Skultety <eskultet@redhat.com>
> ---
>  vl.c         |  6 ++++++
>  qapi/ui.json | 13 +++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/vl.c b/vl.c
> index fa25d1ae2d..d6fd95c227 100644
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
> @@ -2055,6 +2056,11 @@ static void parse_display_qapi(const char *optarg)
>      visit_free(v);
>  }
>  
> +DisplayOptions *qmp_query_display_options(Error **errp)
> +{
> +    return QAPI_CLONE(DisplayOptions, &dpy);
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

Patch looks good to me.
