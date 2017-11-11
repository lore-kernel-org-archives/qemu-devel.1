Received: from eggs.gnu.org ([2001:4830:134:3::10]:40699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eDJMD-00011b-D9
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 19:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eDJM2-0003qs-40
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 19:09:03 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20171110172545.32609-1-mreitz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e4501a6c-3643-d0cb-4b6f-a6569646edad@redhat.com>
Date: Sat, 11 Nov 2017 01:08:51 +0100
MIME-Version: 1.0
In-Reply-To: <20171110172545.32609-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11] block: Make bdrv_next() keep
 strong references
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 10/11/2017 18:25, Max Reitz wrote:
>          if (bs) {
> +            bdrv_ref(bs);
> +            bdrv_unref(old_bs);
>              return bs;
>          }

Maybe instead goto...

>          it->phase = BDRV_NEXT_MONITOR_OWNED;
> +    } else {
> +        old_bs = it->bs;
>      }
>  
>      /* Then return the monitor-owned BDSes without a BB attached. Ignore all
> @@ -467,18 +483,46 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it)
>          bs = it->bs;
>      } while (bs && bdrv_has_blk(bs));

... here?

Paolo

> +    if (bs) {
> +        bdrv_ref(bs);
> +    }
> +    bdrv_unref(old_bs);
> +
>      return bs;
