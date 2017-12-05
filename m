Received: from eggs.gnu.org ([2001:4830:134:3::10]:44191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMEjo-0007wA-2a
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:02:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMEjk-00019b-Fa
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:02:24 -0500
References: <20171205145424.24598-1-kwolf@redhat.com>
	<20171205145424.24598-2-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7ef6de08-0fe1-99e4-1620-ae9a92b6017d@redhat.com>
Date: Tue, 5 Dec 2017 16:02:06 +0100
MIME-Version: 1.0
In-Reply-To: <20171205145424.24598-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] block: Make bdrv_drain_invoke()
 recursive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On 05/12/2017 15:54, Kevin Wolf wrote:
>      }
>  
> +    bdrv_drain_invoke(bs, true);
>      bdrv_drain_recurse(bs, true);
>  }
>  
> @@ -294,6 +298,7 @@ void bdrv_drained_end(BlockDriverState *bs)
>      }
>  
>      bdrv_parent_drained_end(bs);
> +    bdrv_drain_invoke(bs, false);
>      bdrv_drain_recurse(bs, false);
>      aio_enable_external(bdrv_get_aio_context(bs));

I think invoke should be done after recurse from bdrv_drain*end.  In the
end aio_enable_external is a special kind of drain_end callback, so
bdrv_drain_invoke should go together with it.

Thanks,

Paolo
