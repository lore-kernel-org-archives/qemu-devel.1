Received: from eggs.gnu.org ([2001:4830:134:3::10]:33836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fe2Nm-0000MQ-6r
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 14:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fe2Nj-0007Ae-4x
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 14:01:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43094 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fe2Ni-0007AQ-W9
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 14:01:27 -0400
Date: Fri, 13 Jul 2018 19:01:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180713180120.GD2434@work-vm>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-9-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180604095520.8563-9-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 08/12] migration: do not
 flush_compressed_data at the end of each iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

* guangrong.xiao@gmail.com (guangrong.xiao@gmail.com) wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>=20
> flush_compressed_data() needs to wait all compression threads to
> finish their work, after that all threads are free until the
> migration feed new request to them, reducing its call can improve
> the throughput and use CPU resource more effectively
>=20
> We do not need to flush all threads at the end of iteration, the
> data can be kept locally until the memory block is changed
>=20
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  migration/ram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index f9a8646520..0a38c1c61e 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1994,6 +1994,7 @@ static void ram_save_cleanup(void *opaque)
>      }
> =20
>      xbzrle_cleanup();
> +    flush_compressed_data(*rsp);
>      compress_threads_save_cleanup();
>      ram_state_cleanup(rsp);
>  }

I'm not sure why this change corresponds to the other removal.
We should already have sent all remaining data in ram_save_complete()'s
call to flush_compressed_data - so what is this one for?

> @@ -2690,7 +2691,6 @@ static int ram_save_iterate(QEMUFile *f, void *opaq=
ue)
>          }
>          i++;
>      }
> -    flush_compressed_data(rs);
>      rcu_read_unlock();

Hmm - are we sure there's no other cases that depend on ordering of all
of the compressed data being sent out between threads?
I think the one I'd most worry about is the case where:

  iteration one:
     thread 1: Save compressed page 'n'

  iteration two:
     thread 2: Save compressed page 'n'

What guarantees that the version of page 'n'
=66rom thread 2 reaches the destination first without
this flush?

Dave

>      /*
> --=20
> 2.14.4
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
