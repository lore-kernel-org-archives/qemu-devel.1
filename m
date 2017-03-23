Received: from eggs.gnu.org ([2001:4830:134:3::10]:58922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr5T8-0006qJ-KJ
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr5T7-0006Lc-OU
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:20:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cr5T7-0006L1-IT
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:20:09 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4835480483
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 16:20:09 +0000 (UTC)
References: <87h92kgf56.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6b87cce7-76bd-924a-8fde-da18ed60fb42@redhat.com>
Date: Thu, 23 Mar 2017 17:20:06 +0100
MIME-Version: 1.0
In-Reply-To: <87h92kgf56.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Questions around SocketChardev member is_unix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>



On 23/03/2017 16:57, Markus Armbruster wrote:
> qmp_chardev_open_socket() initializes SocketChardev member is_unix like
> this:
> 
>     s->is_unix = sock->addr->type == SOCKET_ADDRESS_KIND_UNIX;
> 
> Its only use is
> 
>     if (s->is_unix) {
>         qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
>     }
> 
> Same function.  Should @is_unix be a local variable instead of a member?

Yes, and same for s->client.is_unix (block/nbd.c) and vd->is_unix
(ui/vnc.c).  It seems to be an artifact of pre-QIOChannel code.

> It opens the connection like this:
> 
>         qio_channel_socket_connect_async(sioc, s->addr,
>                                          qemu_chr_socket_connected,
>                                          chr, NULL);
> 
> or like this:
> 
>             if (qio_channel_socket_listen_sync(sioc, s->addr, errp) < 0) {
>                 goto error;
>             }
> 
> Looks like it supports all SocketAddressKind, including
> SOCKET_ADDRESS_KIND_FD.
> 
> If you use SOCKET_ADDRESS_KIND_FD, QEMU_CHAR_FEATURE_FD_PASS is not
> set.  Should it be set?

Probably it should do getsockname and set it dependent on the address
family in the result.

Paolo
