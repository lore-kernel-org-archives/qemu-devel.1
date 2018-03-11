Received: from eggs.gnu.org ([2001:4830:134:3::10]:56485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euqzm-0007m8-TD
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euqzj-0005qt-Qi
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:45:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1euqzj-0005q9-Ls
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:45:55 -0500
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-23-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <43e12d53-0bbf-b485-6c99-05cec63804ab@redhat.com>
Date: Sat, 10 Mar 2018 20:45:46 -0600
MIME-Version: 1.0
In-Reply-To: <20180309090006.10018-23-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 22/23] tests: qmp-test: verify command
 batching
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
> OOB introduced DROP event for flow control.  This should not affect old
> QMP clients.  Add a command batching check to make sure of it.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tests/qmp-test.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 

>   
> +    /*
> +     * Test command batching.  In current test OOB is not enabled, we
> +     * should be able to run as many commands in batch as we like.
> +     * Using 16 (>8, which is OOB queue length) to make sure OOB won't
> +     * break existing clients.  Note: this test does not control the
> +     * scheduling of QEMU's QMP command processing threads so it may
> +     * not really trigger batching inside QEMU.  This is just a
> +     * best-effort test.
> +     */
> +    for (i = 0; i < 16; i++) {
> +        qtest_async_qmp(qts, "{ 'execute': 'query-version' }");

Would the test be any more robust if we could generate a single string 
to send all at once, rather than multiple separate calls to 
qtest_async_qmp() (the overhead in generating separate strings means the 
monitor may have made progress before we send the next string).  But 
that can be a followup, if you want to pursue the idea.

> +    }
> +    /* Verify the replies to make sure no command is dropped. */
> +    for (i = 0; i < 16; i++) {
> +        resp = qtest_qmp_receive(qts);
> +        /* It should never be dropped.  Each of them should be a reply. */
> +        g_assert(qdict_haskey(resp, "return"));
> +        g_assert(!qdict_haskey(resp, "event"));
> +        QDECREF(resp);

Should we also be sending unique ids, and ensure that the responses 
arrive with ids in the same order?  Again, idea for a followup.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
