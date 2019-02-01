Received: from eggs.gnu.org ([209.51.188.92]:49185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpdOB-0001LQ-PM
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpdO7-0006oa-Ls
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:18:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gpdO6-0006N6-5h
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:18:03 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA8548DA32
	for <qemu-devel@nongnu.org>; Fri,  1 Feb 2019 18:17:28 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190128170321.16936-1-dgilbert@redhat.com>
	<20190128170321.16936-3-dgilbert@redhat.com>
Date: Fri, 01 Feb 2019 19:17:22 +0100
In-Reply-To: <20190128170321.16936-3-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 28 Jan 2019 17:03:14 +0000")
Message-ID: <87a7jfz83x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/9] migration: Add announce parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, eblake@redhat.com, berrange@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Add migration parameters that control RARP/GARP announcement timeouts.
>
> Based on earlier patches by myself and
>   Vladislav Yasevich <vyasevic@redhat.com>
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
[...]
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 7a795ecc16..868071d3a0 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -6,6 +6,7 @@
>  ##
>  
>  { 'include': 'common.json' }
> +{ 'include': 'net.json' }
>  
>  ##
>  # @MigrationStats:

This hunk looks superfluous.

> @@ -480,6 +481,18 @@
>  #
>  # Migration parameters enumeration
>  #
> +# @announce-initial: Inital delay (in ms) before sending the first announce
> +#          (Since 4.0)

Current master has one instance of ms in qapi/, 9 of milliseconds.  I'd
stick to the more common spelling.

> +#
> +# @announce-max: Maximum delay (in ms) between packets in the announcment
> +#          (Since 4.0)
> +#
> +# @announce-rounds: Number of self-announce packets sent after migration
> +#          (Since 4.0)
> +#
> +# @announce-step: Increase in delay (in ms) between subsequent packets in
> +#          the announcement (Since 4.0)
> +#
>  # @compress-level: Set the compression level to be used in live migration,
>  #          the compression level is an integer between 0 and 9, where 0 means
>  #          no compression, 1 means the best compression speed, and 9 means best
> @@ -557,10 +570,13 @@
>  #
>  # @max-cpu-throttle: maximum cpu throttle percentage.
>  #                    Defaults to 99. (Since 3.1)
> +#
>  # Since: 2.4
>  ##
>  { 'enum': 'MigrationParameter',
> -  'data': ['compress-level', 'compress-threads', 'decompress-threads',
> +  'data': ['announce-initial', 'announce-max',
> +           'announce-rounds', 'announce-step',
> +           'compress-level', 'compress-threads', 'decompress-threads',
>             'compress-wait-thread',
>             'cpu-throttle-initial', 'cpu-throttle-increment',
>             'tls-creds', 'tls-hostname', 'max-bandwidth',
> @@ -572,6 +588,18 @@
>  ##
>  # @MigrateSetParameters:
>  #
> +# @announce-initial: Inital delay (in ms) before sending the first announce
> +#          (Since 4.0)
> +#
> +# @announce-max: Maximum delay (in ms) between packets in the announcment
> +#          (Since 4.0)
> +#
> +# @announce-rounds: Number of self-announce packets sent after migration
> +#          (Since 4.0)
> +#
> +# @announce-step: Increase in delay (in ms) between subsequent packets in
> +#          the announcement (Since 4.0)
> +#
>  # @compress-level: compression level
>  #
>  # @compress-threads: compression thread count
> @@ -653,7 +681,11 @@
>  # TODO either fuse back into MigrationParameters, or make
>  # MigrationParameters members mandatory
>  { 'struct': 'MigrateSetParameters',
> -  'data': { '*compress-level': 'int',
> +  'data': { '*announce-initial': 'size',
> +            '*announce-max': 'size',
> +            '*announce-rounds': 'size',
> +            '*announce-step': 'size',
> +            '*compress-level': 'int',
>              '*compress-threads': 'int',
>              '*compress-wait-thread': 'bool',
>              '*decompress-threads': 'int',
> @@ -692,6 +724,18 @@
>  #
>  # The optional members aren't actually optional.
>  #
> +# @announce-initial: Inital delay (in ms) before sending the first announce
> +#          (Since 4.0)
> +#
> +# @announce-max: Maximum delay (in ms) between packets in the announcment
> +#          (Since 4.0)
> +#
> +# @announce-rounds: Number of self-announce packets sent after migration
> +#          (Since 4.0)
> +#
> +# @announce-step: Increase in delay (in ms) between subsequent packets in
> +#          the announcement (Since 4.0)
> +#
>  # @compress-level: compression level
>  #
>  # @compress-threads: compression thread count
> @@ -769,7 +813,11 @@
>  # Since: 2.4
>  ##
>  { 'struct': 'MigrationParameters',
> -  'data': { '*compress-level': 'uint8',
> +  'data': { '*announce-initial': 'size',
> +            '*announce-max': 'size',
> +            '*announce-rounds': 'size',
> +            '*announce-step': 'size',
> +            '*compress-level': 'uint8',
>              '*compress-threads': 'uint8',
>              '*compress-wait-thread': 'bool',
>              '*decompress-threads': 'uint8',
> @@ -785,7 +833,7 @@
>              '*x-multifd-page-count': 'uint32',
>              '*xbzrle-cache-size': 'size',
>  	    '*max-postcopy-bandwidth': 'size',
> -            '*max-cpu-throttle':'uint8'} }
> +            '*max-cpu-throttle':'uint8' } }
>  
>  ##
>  # @query-migrate-parameters:

Since you're tidying up whitespace, consider expanding the tab.

With the superfluous hunk dropped, QAPI part
Acked-by: Markus Armbruster <armbru@redhat.com>
