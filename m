Received: from eggs.gnu.org ([2001:4830:134:3::10]:60960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGOmp-0003vt-6Q
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGOmj-0002MF-Fy
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:05:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58398 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fGOmj-0002Lx-AX
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:05:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D642281A8072
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 13:05:32 +0000 (UTC)
References: <20180509120140.6612-1-quintela@redhat.com>
	<20180509120140.6612-2-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <44f12777-4905-0590-3417-62f982dcf96b@redhat.com>
Date: Wed, 9 May 2018 08:05:32 -0500
MIME-Version: 1.0
In-Reply-To: <20180509120140.6612-2-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 1/3] migration: Create socket-address
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 05/09/2018 07:01 AM, Juan Quintela wrote:
> It will be used to store the uri parameters. We want this only for
> tcp, so we don't set it for other uris.  We need it to know what port
> is migration running.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> 

> +++ b/qapi/migration.json
> @@ -6,6 +6,7 @@
>   ##
>   
>   { 'include': 'common.json' }
> +{ 'include': 'sockets.json' }
>   
>   ##
>   # @MigrationStats:
> @@ -169,6 +170,7 @@
>   #           only present when the postcopy-blocktime migration capability
>   #           is enabled. (Since 2.13)
>   #
> +# @socket-address: Only used for tcp, to know what the real port is (Since 2.13)

Maybe s/real port is/real ports are/, since...

>   #
>   # Since: 0.14.0
>   ##
> @@ -183,7 +185,8 @@
>              '*cpu-throttle-percentage': 'int',
>              '*error-desc': 'str',
>              '*postcopy-blocktime' : 'uint32',
> -           '*postcopy-vcpu-blocktime': ['uint32']} }
> +           '*postcopy-vcpu-blocktime': ['uint32'],
> +           '*socket-address': ['SocketAddress'] } }

...an array is potentially plural.

>   
>   ##
>   # @query-migrate:
> @@ -690,6 +693,7 @@
>   #                     needs to be a multiple of the target page size
>   #                     and a power of 2
>   #                     (Since 2.11)
> +#
>   # Since: 2.4
>   ##
>   { 'struct': 'MigrationParameters',

Spurious hunk?  Although it looks reasonable, it could be a separate 
trivial cleanup patch.

> diff --git a/qapi/sockets.json b/qapi/sockets.json
> index fc81d8d5e8..f1ca09a927 100644
> --- a/qapi/sockets.json
> +++ b/qapi/sockets.json
> @@ -152,3 +152,16 @@
>               'unix': 'UnixSocketAddress',
>               'vsock': 'VsockSocketAddress',
>               'fd': 'String' } }
> +
> +##
> +# @DummyStruct:
> +#
> +# Both block-core and migration needs SocketAddressList

s/needs/need/

> +# I am open to comments about how to share it

Since this is two sentences, trailing '.' would help.

> +#
> +# @dummy-list: A dummy list
> +#
> +# Since: 2.13
> +##
> +{ 'struct': 'DummyStruct',
> +  'data': { 'dummy-list': ['SocketAddress'] } }
> 

We've used this idiom elsewhere; it might be better to amend 
DummyForceArrays in qapi/misc.json, except then misc.json might need to 
include sockets.json for the definition of SocketAddress.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
