Received: from eggs.gnu.org ([2001:4830:134:3::10]:50569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dQTvY-00018q-Qf
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:31:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dQTvU-0006Ly-TP
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:31:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dQTvU-0006Lp-NQ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:31:44 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1498654240.git.maozy.fnst@cn.fujitsu.com>
	<f268a317086c90e4d8e2547a084ec9b477fc6a04.1498654240.git.maozy.fnst@cn.fujitsu.com>
	<20170628132745.GK29134@redhat.com>
	<7d861d6c-fb0c-7a93-22bc-cc7dc814ddaf@cn.fujitsu.com>
Date: Thu, 29 Jun 2017 09:31:41 +0200
In-Reply-To: <7d861d6c-fb0c-7a93-22bc-cc7dc814ddaf@cn.fujitsu.com> (Mao
	Zhongyi's message of "Thu, 29 Jun 2017 11:08:09 +0800")
Message-ID: <878tkb2qsi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 4/4] net/socket: Improve -net socket
 error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, jasowang@redhat.com, qemu-devel@nongnu.org

Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:

> Hi, Daniel
>
> On 06/28/2017 09:27 PM, Daniel P. Berrange wrote:
>> On Wed, Jun 28, 2017 at 09:08:50PM +0800, Mao Zhongyi wrote:
>>> When -net socket fails, it first reports a specific error, then
>>> a generic one, like this:
>>>
>>>     $ qemu-system-x86_64 -net socket,
>>>     qemu-system-x86_64: -net socket: exactly one of fd=, listen=, connect=, mcast= or udp= is required
>>>     qemu-system-x86_64: -net socket: Device 'socket' could not be initialized
>>
>> This second line of error message comes from net/net.c in the
>> net_client_init1 method:
>>
>>         /* FIXME drop when all init functions store an Error */
>>         if (errp && !*errp) {
>>             error_setg(errp, QERR_DEVICE_INIT_FAILED,
>>                        NetClientDriver_lookup[netdev->type]);
>>         }
>>
>>
>> hopefully your patch could drop this code too ?
>>
>> In fact this is the only use of QERR_DEVICE_INIT_FAILED in the
>> whole tree, so the QERR constant could possibly be killed too.
>>
>
> OK, I will. :)

You can do that only when *all* init functions stor an Error!  We're not
there, yet:

    $ grep 'FIXME error_setg' net/*
    net/l2tpv3.c:    /* FIXME error_setg(errp, ...) on failure */
    net/slirp.c:    /* FIXME error_setg(errp, ...) on failure */
    net/socket.c:    /* FIXME error_setg(errp, ...) on failure */
    net/tap-win32.c:    /* FIXME error_setg(errp, ...) on failure */
    net/vde.c:    /* FIXME error_setg(errp, ...) on failure */
