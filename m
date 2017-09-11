Received: from eggs.gnu.org ([2001:4830:134:3::10]:39829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1drP24-0007MA-5M
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1drP1z-00079h-3z
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:45:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1drP1y-00078K-NA
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:45:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 705693672AF
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 13:45:41 +0000 (UTC)
References: <20170911132627.9505-1-cohuck@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <baffa9a3-f807-a6bf-2bed-eab9aab3b80a@redhat.com>
Date: Mon, 11 Sep 2017 15:45:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170911132627.9505-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] dump: do not dump non-existent guest memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com, dgilbert@redhat.com

On 11/09/2017 15:26, Cornelia Huck wrote:
> It does not really make sense to dump memory that is not there.
> 
> Moreover, that fixes a segmentation fault when calling dump-guest-memory
> with no filter for a machine with no memory defined.
> 
> New behaviour is:
> 
> (qemu) dump-guest-memory /dev/null
> dump: no guest memory to dump
> (qemu) dump-guest-memory /dev/null 0 4096
> dump: no guest memory to dump
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> Another unmaintained file. Joy. cc:ing some more-or-less random folks.
> 
> ---
>  dump.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/dump.c b/dump.c
> index a79773d0f7..d2093e141b 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -1536,6 +1536,12 @@ static void dump_init(DumpState *s, int fd, bool has_format,
>      fprintf(stderr, "DUMP: total memory to dump: %lu\n", s->total_size);
>  #endif
>  
> +    /* it does not make sense to dump non-existent memory */
> +    if (!s->total_size) {
> +        error_setg(errp, "dump: no guest memory to dump");
> +        goto cleanup;
> +    }
> +
>      s->start = get_start_block(s);
>      if (s->start == -1) {
>          error_setg(errp, QERR_INVALID_PARAMETER, "begin");
> 

We need to update test-hmp, as with this change dump-guest-memory will
do nothing with none machine, as by default memory size is 0 MB (I'm
working on that)

Tested-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
