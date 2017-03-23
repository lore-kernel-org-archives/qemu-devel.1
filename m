Received: from eggs.gnu.org ([2001:4830:134:3::10]:51678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cr56y-0005Pa-OI
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cr56v-0005TP-KC
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:57:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cr56v-0005TE-ET
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:57:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C6F9C04BD3E
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 15:57:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Mar 2017 16:57:09 +0100
Message-ID: <87h92kgf56.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] Questions around SocketChardev member is_unix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>

qmp_chardev_open_socket() initializes SocketChardev member is_unix like
this:

    s->is_unix = sock->addr->type == SOCKET_ADDRESS_KIND_UNIX;

Its only use is

    if (s->is_unix) {
        qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
    }

Same function.  Should @is_unix be a local variable instead of a member?

It opens the connection like this:

        qio_channel_socket_connect_async(sioc, s->addr,
                                         qemu_chr_socket_connected,
                                         chr, NULL);

or like this:

            if (qio_channel_socket_listen_sync(sioc, s->addr, errp) < 0) {
                goto error;
            }

Looks like it supports all SocketAddressKind, including
SOCKET_ADDRESS_KIND_FD.

If you use SOCKET_ADDRESS_KIND_FD, QEMU_CHAR_FEATURE_FD_PASS is not
set.  Should it be set?
