Received: from eggs.gnu.org ([2001:4830:134:3::10]:47398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e9Gzf-000728-MY
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e9Gzc-0003bV-JE
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:49:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e9Gzc-0003au-Cq
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:49:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BBE413AA3
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 20:49:07 +0000 (UTC)
Date: Mon, 30 Oct 2017 21:48:20 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171030204820.GA15154@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171030112112.6952-1-quintela@redhat.com>
	<20171030112112.6952-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171030112112.6952-2-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] qio: Make port 0 work for qio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

On Mon, Oct 30, 2017 at 12:21:07PM +0100, Juan Quintela wrote:
> For tcp sockets we read back what is the socket/address.  So we know
> what is the port that we are listening into.
> 
> Looked all callers of the function, and they just create the addr, use
> it, and drop it, so no problem that we always update the port in the
> address.

Can you explain more why you need this ?

Nothing should be using the socket_listen() method directly any more IIRC,
and for the QIOChannelSocket classes, you should not rely on the address that
you pass in, being the same as the one that ultimately gets passed into the
socket_listen() method.

Patches that I have pending change things so that listening happens in two
phases. First we take the SocketAddress and do DNS resolution to create
mutliple new SocketAddress structs. These are then passed into the lowlevel
socket_listen() method. So with that happening, even if you update the address
in socket_listen() that info won't get back upto the caller.

If you have a QIOChannelSocket instance, and you want to know what port it
ended up listening on, you should call qio_channel_socket_get_local_address()
method instead, which returns a dynamically popualted SocketAddress struct.
This should mean socket_listen() never needs to update the address that it
binds on.

IOW, I think this patch is redundant.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
