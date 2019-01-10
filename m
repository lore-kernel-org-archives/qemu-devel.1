Received: from eggs.gnu.org ([209.51.188.92]:55270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghXfM-0004DH-T9
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghXfI-00012E-FQ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:34:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ghXfI-00011v-65
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:34:20 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <154703587757.13472.3898702635363120794.stgit@pasha-VirtualBox>
	<154703593746.13472.3886549854409661470.stgit@pasha-VirtualBox>
Date: Thu, 10 Jan 2019 11:34:08 +0100
In-Reply-To: <154703593746.13472.3886549854409661470.stgit@pasha-VirtualBox>
	(Pavel Dovgalyuk's message of "Wed, 09 Jan 2019 15:12:17 +0300")
Message-ID: <877efciyxr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 10/21] qapi: introduce replay.json for
 record/replay-related stuff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com, quintela@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net

Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:

> This patch adds replay.json file. It will be
> used for adding record/replay-related data structures and commands.
>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>  MAINTAINERS             |    1 +
>  Makefile.objs           |    4 ++--
>  include/sysemu/replay.h |    1 +
>  qapi/misc.json          |   18 ------------------
>  qapi/qapi-schema.json   |    1 +
>  qapi/replay.json        |   26 ++++++++++++++++++++++++++
>  6 files changed, 31 insertions(+), 20 deletions(-)
>  create mode 100644 qapi/replay.json
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0bfd95a..7b0a1bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2122,6 +2122,7 @@ F: net/filter-replay.c
>  F: include/sysemu/replay.h
>  F: docs/replay.txt
>  F: stubs/replay.c
> +F: qapi/replay.json
>  
>  IOVA Tree
>  M: Peter Xu <peterx@redhat.com>
> diff --git a/Makefile.objs b/Makefile.objs
> index 4561159..8164b22 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -1,6 +1,6 @@
>  QAPI_MODULES = block-core block char common crypto introspect job migration
> -QAPI_MODULES += misc net rdma rocker run-state sockets tpm trace transaction
> -QAPI_MODULES += ui
> +QAPI_MODULES += misc net rdma replay rocker run-state sockets tpm trace
> +QAPI_MODULES += transaction ui
>  
>  #######################################################################
>  # Common libraries for tools and emulators
> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> index b3f593f..2054296 100644
> --- a/include/sysemu/replay.h
> +++ b/include/sysemu/replay.h
> @@ -13,6 +13,7 @@
>   */
>  
>  #include "sysemu.h"
> +#include "qapi/qapi-types-replay.h"
>  #include "qapi/qapi-types-misc.h"

I believe you can drop qapi/qapi-types-misc.h now.

>  #include "qapi/qapi-types-ui.h"
>  
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 24d20a8..e5e0bea 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -3125,24 +3125,6 @@
>    'data': { 'offset': 'int' } }
>  
>  ##
> -# @ReplayMode:
> -#
> -# Mode of the replay subsystem.
> -#
> -# @none: normal execution mode. Replay or record are not enabled.
> -#
> -# @record: record mode. All non-deterministic data is written into the
> -#          replay log.
> -#
> -# @play: replay mode. Non-deterministic data required for system execution
> -#        is read from the log.
> -#
> -# Since: 2.5
> -##
> -{ 'enum': 'ReplayMode',
> -  'data': [ 'none', 'record', 'play' ] }
> -
> -##
>  # @xen-load-devices-state:
>  #
>  # Load the state of all devices from file. The RAM and the block devices
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 3bbdfce..b85fd04 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -95,3 +95,4 @@
   # Documentation generated with qapi-gen.py is in source order, with
   # included sub-schemas inserted at the first include directive
   # (subsequent include directives have no effect).  To get a sane and
   # stable order, it's best to include each sub-schema just once, or
   # include it first right here.
[...]
>  { 'include': 'trace.json' }
>  { 'include': 'introspect.json' }
>  { 'include': 'misc.json' }
> +{ 'include': 'replay.json' }

I doubt this the best spot for replay stuff in the generated
documentation.

Is there another chapter you'd consider related?

> diff --git a/qapi/replay.json b/qapi/replay.json
> new file mode 100644
> index 0000000..9e13551
> --- /dev/null
> +++ b/qapi/replay.json
> @@ -0,0 +1,26 @@
> +# -*- Mode: Python -*-
> +#
> +
> +##
> +# = Record/replay
> +##
> +
> +{ 'include': 'common.json' }
> +
> +##
> +# @ReplayMode:
> +#
> +# Mode of the replay subsystem.
> +#
> +# @none: normal execution mode. Replay or record are not enabled.
> +#
> +# @record: record mode. All non-deterministic data is written into the
> +#          replay log.
> +#
> +# @play: replay mode. Non-deterministic data required for system execution
> +#        is read from the log.
> +#
> +# Since: 2.5
> +##
> +{ 'enum': 'ReplayMode',
> +  'data': [ 'none', 'record', 'play' ] }
