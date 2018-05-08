Received: from eggs.gnu.org ([2001:4830:134:3::10]:53713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fG2Wu-0004GS-D0
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fG2Wr-0004Co-Oi
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:19:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33204 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fG2Wr-0004CW-K6
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:19:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E6D8681A88A2
	for <qemu-devel@nongnu.org>; Tue,  8 May 2018 13:19:30 +0000 (UTC)
References: <1525326658-3078-1-git-send-email-thuth@redhat.com>
	<87k1slot93.fsf@dusky.pond.sub.org>
	<54f1bb8c-c61e-557a-952d-92ba1297e818@redhat.com>
	<87in80ym1o.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9d66d071-324f-5d33-547d-901f497cb497@redhat.com>
Date: Tue, 8 May 2018 15:19:24 +0200
MIME-Version: 1.0
In-Reply-To: <87in80ym1o.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: Silence 'has no peer' messages in
 testing mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On 07.05.2018 09:14, Markus Armbruster wrote:
[...]
> Two (possibly confused) questions:
>=20
> 1. The user can add nics without convenience options:
>=20
>     $ upstream-qemu -display none -nodefaults -device e1000
>     upstream-qemu: warning: nic e1000.0 has no peer
>=20
>    Shouldn't we silence the warning then, too?

No, since that is certainly a mis-configuration in that case. Why would
a user want to add a NIC without host backend?

> 2. We already have code to silence the warning:
>=20
>     /* Don't warn about the default network setup that you get if
>      * no command line -net or -netdev options are specified. There
>      * are two cases that we would otherwise complain about:
>      * (1) board doesn't support a NIC but the implicit "-net nic"
>      * requested one
>      * (2) CONFIG_SLIRP not set, in which case the implicit "-net nic"
>      * sets up a nic that isn't connected to anything.
>      */
>     if (!default_net) {
>         net_check_clients();
>     }
>=20
>    Is it a good idea to split the logic between net_check_clients() and
>    its caller?

Hmm, it's likely nicer to keep everything in one place. Since
"default_net" is only available in vl.c, I think the checks should go
there... so I'll rework my patch accordingly.

 Thomas
