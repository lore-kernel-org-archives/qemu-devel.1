Received: from eggs.gnu.org ([2001:4830:134:3::10]:47034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gS0og-0007wo-KV
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:27:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gS0oc-00053g-J8
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:27:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62231)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gS0oc-00053R-Dc
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:27:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 470663001519
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 14:27:45 +0000 (UTC)
References: <20181128113337.7238-1-quintela@redhat.com>
	<20181128113337.7238-3-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <743778f1-1769-502d-26ff-51c17578e283@redhat.com>
Date: Wed, 28 Nov 2018 08:27:40 -0600
MIME-Version: 1.0
In-Reply-To: <20181128113337.7238-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 2/5] migration: Create socket-address
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
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, Markus Armbruster <armbru@redhat.com>

On 11/28/18 5:33 AM, Juan Quintela wrote:
> It will be used to store the uri parameters. We want this only for
> tcp, so we don't set it for other uris.  We need it to know what port
> is migration running.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> 

That's not the typical --- separator that git-am would recognize.

> This used to be uri parameter, but it has so many troubles to
> reproduce that it don't just make sense.
> 
> This used to be a port parameter.  I was asked to move to
> SocketAddress, done.
> I also merged the setting of the migration tcp port in this one
> because now I need to free the address, and this makes it easier.
> This used to be x-socket-address with a single direction, now it is a
> list of addresses.
> Move SocketAddress_to_str here.  I used to try to generalize the one
> in chardev/char-socket.c, but it is not worth it.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

the double S-o-b is odd, especially if the second one was intended to be 
stripped.


> +++ b/qapi/migration.json
> @@ -6,6 +6,7 @@
>   ##
>   
>   { 'include': 'common.json' }
> +{ 'include': 'sockets.json' }
>   
>   ##
>   # @MigrationStats:
> @@ -196,6 +197,8 @@
>   # @compression: migration compression statistics, only returned if compression
>   #           feature is on and status is 'active' or 'completed' (Since 3.1)
>   #
> +# @socket-address: Only used for tcp, to know what the real port is (Since 3.1)
> +#

s/3.1/4.0/ now...

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
> +# I am open to comments about how to share it
> +#
> +# @dummy-list: A dummy list
> +#
> +# Since: 3.1
> +##
> +{ 'struct': 'DummyStruct',
> +  'data': { 'dummy-list': ['SocketAddress'] } }

We've had a couple of threads about this in the last couple of months; 
maybe it's time for a qapi generator patch where we add an optional 
'gen-list':true marker to any struct that needs to have a list generated 
for C code even when no QMP command uses the list form.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
