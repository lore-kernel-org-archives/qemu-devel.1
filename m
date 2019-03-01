Received: from eggs.gnu.org ([209.51.188.92]:34584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzl3O-0006bU-4O
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:30:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzl3M-000502-6g
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:30:30 -0500
References: <20190301160929.19892-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bd5824cb-7adb-1e96-fbd2-eb666288c253@redhat.com>
Date: Fri, 1 Mar 2019 10:30:07 -0600
MIME-Version: 1.0
In-Reply-To: <20190301160929.19892-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: add drop-cache=on|off option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Daniel Berrange <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Neil Skrypuch <neil@tembosocial.com>, Stefano Garzarella <sgarzare@redhat.com>

On 3/1/19 10:09 AM, Stefan Hajnoczi wrote:
> Commit dd577a26ff03b6829721b1ffbbf9e7c411b72378 ("block/file-posix:
> implement bdrv_co_invalidate_cache() on Linux") introduced page cache
> invalidation so that cache.direct=off live migration is safe on Linux.
> 
> The invalidation takes a significant amount of time when the file is
> large and present in the page cache.  Normally this is not the case for
> cross-host live migration but it can happen when migrating between QEMU
> processes on the same host.
> 
> On same-host migration we don't need to invalidate pages for correctness
> anyway, so an option to skip page cache invalidation is useful.  I
> investigated optimizing invalidation and detecting same-host migration,
> but both are hard to achieve so a user-visible option will suffice.
> 
> Suggested-by: Neil Skrypuch <neil@tembosocial.com>
> Tested-by: Neil Skrypuch <neil@tembosocial.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Remove outdated comment about libvirt feature detection [danpb]

Question - if we used qapi's 'if':COND to only declare the field on
platforms where we know at compile time that we can support it, would
that be enough for libvirt to introspect that if the field exists then
migration is safe, without having to rely on an query-qemu-features command?

> +++ b/qapi/block-core.json
> @@ -2807,6 +2807,10 @@
>  # @locking:     whether to enable file locking. If set to 'auto', only enable
>  #               when Open File Descriptor (OFD) locking API is available
>  #               (default: auto, since 2.10)
> +# @drop-cache:  invalidate page cache during live migration.  This prevents
> +#               stale data on the migration destination with cache.direct=off.
> +#               Currently only supported on Linux hosts.
> +#               (default: on, since: 4.0)
>  # @x-check-cache-dropped: whether to check that page cache was dropped on live
>  #                         migration.  May cause noticeable delays if the image
>  #                         file is large, do not use in production.
> @@ -2819,6 +2823,7 @@
>              '*pr-manager': 'str',
>              '*locking': 'OnOffAuto',
>              '*aio': 'BlockdevAioOptions',
> +            '*drop-cache': 'bool',
>              '*x-check-cache-dropped': 'bool' } }

In other words, now that we can use 'if' to hide features that aren't
supported based on compile-time knowledge, shouldn't we use that to make
the doc comment "only supported on Linux hosts" introspectible?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
