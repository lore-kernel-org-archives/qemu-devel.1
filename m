Received: from eggs.gnu.org ([209.51.188.92]:59840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gonLK-0004lB-AY
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gonLJ-00084r-30
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:43:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gonLI-00084X-PY
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:43:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB099A0902
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 10:43:39 +0000 (UTC)
Date: Wed, 30 Jan 2019 10:43:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190130104331.GG15904@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190130103236.18302-1-dgilbert@redhat.com>
	<20190130103236.18302-3-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130103236.18302-3-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/9] migration: Add announce parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, quintela@redhat.com, mst@redhat.com, eblake@redhat.com, armbru@redhat.com, germano@redhat.com

On Wed, Jan 30, 2019 at 10:32:29AM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Add migration parameters that control RARP/GARP announcement timeouts.
> 
> Based on earlier patches by myself and
>   Vladislav Yasevich <vyasevic@redhat.com>
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hmp.c                    |  28 +++++++++++
>  include/migration/misc.h |   2 +
>  include/qemu/typedefs.h  |   1 +
>  migration/migration.c    | 100 +++++++++++++++++++++++++++++++++++++++
>  qapi/migration.json      |  54 +++++++++++++++++++--
>  5 files changed, 182 insertions(+), 3 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 7a795ecc16..113bb5d925 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -6,6 +6,7 @@
>  ##
>  
>  { 'include': 'common.json' }
> +{ 'include': 'net.json' }


> @@ -572,6 +588,18 @@
>  ##
>  # @MigrateSetParameters:
>  #
> +# @announce-initial: Initial delay (in ms) before sending the first announce
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

Historically we've just had a flat list of migration parameters, but
QAPI doesn't require this. So I wonder about just referencing the
type you defined in the previous patch:

   '*announce': 'AnnounceParameters

from a QMP pov this is trivial & feels more natural. The only downside
I see is that for HMP it would need to be flattened to what it is here.
We generally tend to prefer QMP's natural style, even if it doesn't
match what's nicest for HMP.

> @@ -692,6 +724,18 @@
>  #
>  # The optional members aren't actually optional.
>  #
> +# @announce-initial: Initial delay (in ms) before sending the first announce
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

Same here about just referencing the AnnounceParameters type.

> +            '*compress-level': 'uint8',
>              '*compress-threads': 'uint8',
>              '*compress-wait-thread': 'bool',
>              '*decompress-threads': 'uint8',

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
