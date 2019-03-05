Received: from eggs.gnu.org ([209.51.188.92]:59531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1F6b-0001GI-Jx
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1F6Z-0001Nu-GP
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:47:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h1F6Z-0001Js-91
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:47:55 -0500
References: <20190305181602.9051-1-dgilbert@redhat.com>
	<20190305181602.9051-11-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <84195982-1d8f-0bae-5136-6443a1f63c2a@redhat.com>
Date: Tue, 5 Mar 2019 12:47:50 -0600
MIME-Version: 1.0
In-Reply-To: <20190305181602.9051-11-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 10/21] migration: Create socket-address
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com

On 3/5/19 12:15 PM, Dr. David Alan Gilbert (git) wrote:
> From: Juan Quintela <quintela@redhat.com>
> 
> It will be used to store the uri parameters. We want this only for
> tcp, so we don't set it for other uris.  We need it to know what port
> is migration running.
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> 

This was not the usual '---' divider, and hence:

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
> Free string (eric)
> Handle VSOCK address nicely (not that migration can use them yet).
> Remove useless breaks (dave)
> rename socket_address to socket_address_list to avoid confusion
> Update to 4.0 (eric)
> Put a comment indicating that there is a problem on the qapi
> generator (markus).

...all this got included, even if it was perhaps not intended.

> Message-Id: <20190227105128.1655-3-quintela@redhat.com>
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

At any rate, it certainly looks odd to split *-by: tags by so much text.

> +++ b/qapi/sockets.json
> @@ -152,3 +152,21 @@
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
> +# FIXME: This shouldn't be needed, but this struct has two users, and
> +# current qapi generator generates it on the 1st place that uses it,
> +# so the second user don't see it.  Putting it here it is seen in both
> +# sides.

If Markus' pull request lands first, we don't need this.
https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg01185.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
