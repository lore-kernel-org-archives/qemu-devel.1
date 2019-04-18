Received: from eggs.gnu.org ([209.51.188.92]:46349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDQB-0005BH-9l
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDPH-0003f2-QX
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:13:16 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190408143543.3982-1-kwolf@redhat.com>
	<20190408143543.3982-5-kwolf@redhat.com>
Date: Thu, 18 Apr 2019 22:13:10 +0200
In-Reply-To: <20190408143543.3982-5-kwolf@redhat.com> (Kevin Wolf's message of
	"Mon, 8 Apr 2019 16:35:43 +0200")
Message-ID: <875zrbjcmh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/4] file-posix: Add dynamic-auto-read-only
 QAPI feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, qemu-devel@nongnu.org

Kevin Wolf <kwolf@redhat.com> writes:

> In commit 23dece19da4 ('file-posix: Make auto-read-only dynamic') ,
> auto-read-only=on changed its behaviour in file-posix for the 4.0
> release. This change cannot be detected through the usual mechanisms
> like schema introspection. Add a new feature flag to the schema to
> allow libvirt to detect the presence of the new behaviour.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 7ccbfff9d0..4f96d5846b 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2843,6 +2843,13 @@
   ##
   # @BlockdevOptionsFile:
   #
   # Driver specific block device options for the file backend.
   #
   # @filename:    path to the image file
   # @pr-manager:  the id for the object that will handle persistent reservations
   #               for this device (default: none, forward the commands via SG_IO;
   #               since 2.11)
   # @aio:         AIO backend (default: threads) (since: 2.8)
   # @locking:     whether to enable file locking. If set to 'auto', only enable
   #               when Open File Descriptor (OFD) locking API is available
   #               (default: auto, since 2.10)
   # @drop-cache:  invalidate page cache during live migration.  This prevents
   #               stale data on the migration destination with cache.direct=off.
   #               Currently only supported on Linux hosts.
   #               (default: on, since: 4.0)
   # @x-check-cache-dropped: whether to check that page cache was dropped on live
   #                         migration.  May cause noticeable delays if the image
>  #                         file is large, do not use in production.
>  #                         (default: off) (since: 3.0)
>  #
> +# If the feature 'dynamic-auto-read-only' is present, enabled auto-read-only
> +# means that the driver will open the image read-only at first, dynamically
> +# reopen the image file read-write when the first writer is attached to the
> +# node and reopen read-only when the last writer is detached. This allows to
> +# give QEMU write permissions only on demand when an operation actually needs
> +# write access.
> +#
>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsFile',
> @@ -2852,7 +2859,9 @@
>              '*aio': 'BlockdevAioOptions',
>  	    '*drop-cache': {'type': 'bool',
>  	                    'if': 'defined(CONFIG_LINUX)'},
> -            '*x-check-cache-dropped': 'bool' } }
> +            '*x-check-cache-dropped': 'bool' },
> +  'features': [ { 'name': 'dynamic-auto-read-only',
> +                  'if': 'defined(CONFIG_POSIX)' } ] }
>  
>  ##
>  # @BlockdevOptionsNull:

This uses free-form text to document features.  That means the doc
generator can't flag missing documentation, like it could for members
(it doesn't only because we still got doc work to do there).

A more structured approach could look like this:

   ##
   # @BlockdevOptionsFile:
   #
   # Driver specific block device options for the file backend.
   #
   # @filename:    path to the image file
   [More members...]
   #
   # Features:
   # @dynamic-read-only: if present, enabled auto-read-only ...
   #
   # Since: 2.9
   ##
