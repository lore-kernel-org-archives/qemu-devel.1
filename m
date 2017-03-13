Received: from eggs.gnu.org ([2001:4830:134:3::10]:41127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnSyp-0008CV-Bq
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnSyl-0003QB-L1
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:37:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cnSyl-0003Ot-EG
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:37:51 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B6ACC081F58
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 16:37:51 +0000 (UTC)
Date: Mon, 13 Mar 2017 16:37:44 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170313163744.GL4799@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170313124434.1043-1-quintela@redhat.com>
	<20170313124434.1043-7-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170313124434.1043-7-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/16] migration: Create x-multifd-threads
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, dgilbert@redhat.com

On Mon, Mar 13, 2017 at 01:44:24PM +0100, Juan Quintela wrote:
> Indicates the number of threads that we would create.  By default we
> create 2 threads.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> diff --git a/qapi-schema.json b/qapi-schema.json
> index d21934b..b7cb26d 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -985,13 +985,17 @@
>  # @x-checkpoint-delay: The delay time (in ms) between two COLO checkpoints in
>  #          periodic mode. (Since 2.8)
>  #
> +# @x-multifd-threads: Number of threads used to migrate data in parallel
> +#                     The default value is 2 (since 2.9)
> +#
>  # Since: 2.4
>  ##
>  { 'enum': 'MigrationParameter',
>    'data': ['compress-level', 'compress-threads', 'decompress-threads',
>             'cpu-throttle-initial', 'cpu-throttle-increment',
>             'tls-creds', 'tls-hostname', 'max-bandwidth',
> -           'downtime-limit', 'x-checkpoint-delay' ] }
> +           'downtime-limit', 'x-checkpoint-delay',
> +           'x-multifd-threads'] }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1054,6 +1058,10 @@
>  #
>  # @x-checkpoint-delay: the delay time between two COLO checkpoints. (Since 2.8)
>  #
> +#
> +# @x-multifd-threads: Number of threads used to migrate data in parallel
> +#                     The default value is 2 (since 2.9)
> +#

Presumably, the number of threads is the same as the number of sockets
opened ? It is probably useful to make it explicit that increasing
threads also causes increased number of TCP sockets to be opened.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
