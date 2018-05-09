Received: from eggs.gnu.org ([2001:4830:134:3::10]:52809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fGIRG-0000tV-HL
	for qemu-devel@nongnu.org; Wed, 09 May 2018 02:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fGIRB-0007zL-Jh
	for qemu-devel@nongnu.org; Wed, 09 May 2018 02:18:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55902 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fGIRB-0007x5-FU
	for qemu-devel@nongnu.org; Wed, 09 May 2018 02:18:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AEB58DC4D
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 06:18:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1525326658-3078-1-git-send-email-thuth@redhat.com>
	<87k1slot93.fsf@dusky.pond.sub.org>
	<54f1bb8c-c61e-557a-952d-92ba1297e818@redhat.com>
	<87in80ym1o.fsf@dusky.pond.sub.org>
	<9d66d071-324f-5d33-547d-901f497cb497@redhat.com>
Date: Wed, 09 May 2018 08:18:42 +0200
In-Reply-To: <9d66d071-324f-5d33-547d-901f497cb497@redhat.com> (Thomas Huth's
	message of "Tue, 8 May 2018 15:19:24 +0200")
Message-ID: <87tvrhbbct.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Thomas Huth <thuth@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> On 07.05.2018 09:14, Markus Armbruster wrote:
> [...]
>> Two (possibly confused) questions:
>> 
>> 1. The user can add nics without convenience options:
>> 
>>     $ upstream-qemu -display none -nodefaults -device e1000
>>     upstream-qemu: warning: nic e1000.0 has no peer
>> 
>>    Shouldn't we silence the warning then, too?
>
> No, since that is certainly a mis-configuration in that case. Why would
> a user want to add a NIC without host backend?

Related:

    $ upstream-qemu -display none -nodefaults -net nic
    upstream-qemu: warning: vlan 0 is not connected to host network

The root of my confusion: I'm having difficulties making the connection
from the guard predicate (!qtest_enabled() || nd_table[0].used) to
"stupid default setup that isn't the test's fault".

In what scenarios exactly do we get unwanted "has no peer" messages?
Mandatory onboard NIC, perhaps?

Arguably, onboard NICs should default to a null backend that behaves
like "no carrier".  That's exactly what physical hardware does.  Could
even be useful outside tests once we support hot-plugging network
backends (we might already, I have no idea), just like physical hardware
supports plugging in network cables.

[...]
