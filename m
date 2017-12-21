Received: from eggs.gnu.org ([2001:4830:134:3::10]:57441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eS0R8-0003Gf-Lm
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 07:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eS0R5-0002qi-D2
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 07:58:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eS0R5-0002pd-6m
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 07:58:55 -0500
Date: Thu, 21 Dec 2017 20:58:46 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171221125846.GU10812@lemon>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-25-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-25-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 24/27] qmp: add command "x-oob-test"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, 12/19 16:45, Peter Xu wrote:
> This command is only used to test OOB functionality.  It should not be
> used for any other purposes.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi-schema.json | 18 ++++++++++++++++++
>  qmp.c            | 16 ++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 447ab25572..a63cd42cdd 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3259,3 +3259,21 @@
>  ##
>  { 'event': 'COMMAND_DROPPED' ,
>    'data': { 'id': 'any', 'reason': 'CommandDropReason' } }
> +
> +##
> +# @x-oob-test:
> +#
> +# Test OOB functionality.  When send this command with lock=true,
> +# it'll try to hang the dispatcher.  When send it with lock=false,
> +# it'll try to notify the locked thread to continue.  Note: it should
> +# only be used by QMP test program rather than anything else.
> +#
> +# Since: 2.12
> +#
> +# Example:
> +#
> +# { "execute": "x-oob-test",
> +#   "arguments": { "lock": true } }
> +##
> +{ 'command': 'x-oob-test', 'data' : { 'lock': 'bool' },
> +  'allow-oob': true }
> diff --git a/qmp.c b/qmp.c
> index e8c303116a..ca2968aad2 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -722,3 +722,19 @@ MemoryInfo *qmp_query_memory_size_summary(Error **errp)
>  
>      return mem_info;
>  }
> +
> +static QemuSemaphore x_oob_test_sem;
> +
> +static void __attribute__((constructor)) x_oob_test_init(void)
> +{
> +    qemu_sem_init(&x_oob_test_sem, 0);
> +}
> +
> +void qmp_x_oob_test(bool lock, Error **errp)
> +{
> +    if (lock) {
> +        qemu_sem_wait(&x_oob_test_sem);
> +    } else {
> +        qemu_sem_post(&x_oob_test_sem);
> +    }
> +}
> -- 
> 2.14.3
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
