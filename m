Received: from eggs.gnu.org ([2001:4830:134:3::10]:56969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eur3p-0000Xu-1R
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eur3l-0006r6-RI
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:50:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55194 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eur3l-0006qu-N4
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:50:05 -0500
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-24-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c4fbae90-a94e-be08-49c8-607d7ec5465c@redhat.com>
Date: Sat, 10 Mar 2018 20:49:42 -0600
MIME-Version: 1.0
In-Reply-To: <20180309090006.10018-24-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 23/23] tests: qmp-test: add oob test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 03/09/2018 03:00 AM, Peter Xu wrote:
> Test the new OOB capability.  Here we used the new "x-oob-test" command.
> Firstly, we send a lock=true and oob=false command to hang the main

s/Firstly/First/

> thread.  Then send another lock=false and oob=true command (which will
> be run inside parser this time) to free that hanged command.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tests/qmp-test.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 65 insertions(+)
> 

> +    /* Now, enable OOB in current QMP session, it should success. */

s/success/succeed/

> +
> +    /*
> +     * Firstly send the "x-oob-test" command with lock=true and

s/Firstly/First/

> +     * oob=false, it should hang the dispatcher and main thread;
> +     * later, we send another lock=false with oob=true to continue
> +     * that thread processing.  Finally we should receive replies from
> +     * both commands.
> +     */
> +    qmp_async("{ 'execute': 'x-oob-test',"
> +              "  'arguments': { 'lock': true }, "
> +              "  'id': 'lock-cmd'}");
> +    qmp_async("{ 'execute': 'x-oob-test', "
> +              "  'arguments': { 'lock': false }, "
> +              "  'control': { 'run-oob': true }, "
> +              "  'id': 'unlock-cmd' }");
> +
> +    /* Ignore all events.  Wait for 2 acks */
> +    while (acks < 2) {
> +        resp = qmp_receive();
> +        cmd_id = qdict_get_str(resp, "id");
> +        if (!g_strcmp0(cmd_id, "lock-cmd") ||
> +            !g_strcmp0(cmd_id, "unlock-cmd")) {
> +            acks++;
> +        }
> +        QDECREF(resp);
> +    }

Can you make the reply order deterministic?  Perhaps by having the lock 
command insert a sleep after locking but before replying, so that the 
unlock always gets to reply first?  But that can be a followup.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
