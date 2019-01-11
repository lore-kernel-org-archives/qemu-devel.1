Received: from eggs.gnu.org ([209.51.188.92]:39548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghtZb-0002cd-V3
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:57:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghtZa-00007t-No
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:57:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ghtZa-00007W-GB
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:57:54 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190111063732.10484-1-xiaoguangrong@tencent.com>
	<20190111063732.10484-4-xiaoguangrong@tencent.com>
Date: Fri, 11 Jan 2019 10:57:46 +0100
In-Reply-To: <20190111063732.10484-4-xiaoguangrong@tencent.com> (guangrong
	xiao's message of "Fri, 11 Jan 2019 14:37:32 +0800")
Message-ID: <87r2dj5xet.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/3] migration: introduce adaptive model
 for waiting thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, cota@braap.org, Eric Blake <eblake@redhat.com>

guangrong.xiao@gmail.com writes:

> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>
> Currently we have two behaviors if all threads are busy to do compression,
> the main thread mush wait one of them becoming free if @compress-wait-thread
> set to on or the main thread can directly return without wait and post
> the page out as normal one
>
> Both of them have its profits and short-comes, however, if the bandwidth is
> not limited extremely so that compression can not use out all of it bandwidth,
> at the same time, the migration process is easily throttled if we posted too
> may pages as normal pages. None of them can work properly under this case
>
> In order to use the bandwidth more effectively, we introduce the third
> behavior, adaptive, which make the main thread wait if there is no bandwidth
> left or let the page go out as normal page if there has enough bandwidth to
> make sure the migration process will not be throttled
>
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  hmp.c                 |   6 ++-
>  migration/migration.c | 116 ++++++++++++++++++++++++++++++++++++++++++++------
>  migration/migration.h |  13 ++++++
>  migration/ram.c       | 116 +++++++++++++++++++++++++++++++++++++++++++++-----
>  qapi/migration.json   |  39 +++++++++++------

You neglected to cc: the QAPI schema maintainers.
scripts/get_maintainer.pl can help you find the maintainers to cc: on
your patches.

>  5 files changed, 251 insertions(+), 39 deletions(-)
[...]
> diff --git a/qapi/migration.json b/qapi/migration.json
> index c5babd03b0..0220a0945b 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -93,11 +93,16 @@
>  #
>  # @compression-rate: rate of compressed size
>  #
> +# @compress-no-wait-weight: it controls how many pages are directly posted
> +#     out as normal page when all compression threads are currently busy.
> +#     Only available if compress-wait-thread = adaptive. (Since 3.2)

"Only available" suggests the member is optional.

> +#
>  # Since: 3.1
>  ##
>  { 'struct': 'CompressionStats',
>    'data': {'pages': 'int', 'busy': 'int', 'busy-rate': 'number',
> -	   'compressed-size': 'int', 'compression-rate': 'number' } }
> +	   'compressed-size': 'int', 'compression-rate': 'number',
> +	   'compress-no-wait-weight': 'int'} }

It isn't.  Should it be optional?  If not, what's its value when
compress-wait-thread isn't adaptive?

>  
>  ##
>  # @MigrationStatus:
> @@ -489,9 +494,13 @@
>  #          the compression thread count is an integer between 1 and 255.
>  #
>  # @compress-wait-thread: Controls behavior when all compression threads are
> -#                        currently busy. If true (default), wait for a free
> -#                        compression thread to become available; otherwise,
> -#                        send the page uncompressed. (Since 3.1)
> +#          currently busy. If 'true/on' (default), wait for a free

> +#          compression thread to become available; if 'false/off', send the
> +#          page uncompressed. (Since 3.1)
> +#          If it is 'adaptive',  the behavior is adaptively controlled based on
> +#          the rate limit. If it has enough bandwidth, it acts as
> +#          compress-wait-thread is off. (Since 3.2)
> +#
>  #
>  # @decompress-threads: Set decompression thread count to be used in live
>  #          migration, the decompression thread count is an integer between 1
> @@ -577,9 +586,12 @@
>  # @compress-threads: compression thread count
>  #
>  # @compress-wait-thread: Controls behavior when all compression threads are
> -#                        currently busy. If true (default), wait for a free
> -#                        compression thread to become available; otherwise,
> -#                        send the page uncompressed. (Since 3.1)
> +#          currently busy. If 'true/on' (default), wait for a free
> +#          compression thread to become available; if 'false/off', send the
> +#          page uncompressed. (Since 3.1)
> +#          If it is 'adaptive',  the behavior is adaptively controlled based on
> +#          the rate limit. If it has enough bandwidth, it acts as
> +#          compress-wait-thread is off. (Since 3.2)
>  #
>  # @decompress-threads: decompression thread count
>  #
> @@ -655,7 +667,7 @@
>  { 'struct': 'MigrateSetParameters',
>    'data': { '*compress-level': 'int',
>              '*compress-threads': 'int',
> -            '*compress-wait-thread': 'bool',
> +            '*compress-wait-thread': 'str',

Compatibility break.

You can add a separate flag like you did in v1 if I understand your cover
letter correctly.  Awkward.

You can use a suitable alternate of bool and enum.

'str' is not a good idea, because it defeats introspection.

>              '*decompress-threads': 'int',
>              '*cpu-throttle-initial': 'int',
>              '*cpu-throttle-increment': 'int',
> @@ -697,9 +709,12 @@
>  # @compress-threads: compression thread count
>  #
>  # @compress-wait-thread: Controls behavior when all compression threads are
> -#                        currently busy. If true (default), wait for a free
> -#                        compression thread to become available; otherwise,
> -#                        send the page uncompressed. (Since 3.1)
> +#          currently busy. If 'true/on' (default), wait for a free
> +#          compression thread to become available; if 'false/off', send the
> +#          page uncompressed. (Since 3.1)
> +#          If it is 'adaptive',  the behavior is adaptively controlled based on
> +#          the rate limit. If it has enough bandwidth, it acts as
> +#          compress-wait-thread is off. (Since 3.2)
>  #
>  # @decompress-threads: decompression thread count
>  #
> @@ -771,7 +786,7 @@
>  { 'struct': 'MigrationParameters',
>    'data': { '*compress-level': 'uint8',
>              '*compress-threads': 'uint8',
> -            '*compress-wait-thread': 'bool',
> +            '*compress-wait-thread': 'str',

Likewise.

>              '*decompress-threads': 'uint8',
>              '*cpu-throttle-initial': 'uint8',
>              '*cpu-throttle-increment': 'uint8',
