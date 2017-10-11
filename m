Received: from eggs.gnu.org ([2001:4830:134:3::10]:51226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2C1B-0004CT-OD
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2C17-00088J-4x
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:05:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e2C16-00087B-Sj
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:05:25 -0400
Date: Wed, 11 Oct 2017 10:05:16 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171011100516.3bb6c6d9.cohuck@redhat.com>
In-Reply-To: <20170928203708.9376-11-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-11-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/30] target/s390x: interpret
 PSW_MASK_WAIT only for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>

On Thu, 28 Sep 2017 22:36:48 +0200
David Hildenbrand <david@redhat.com> wrote:

> KVM handles the wait PSW itself and triggers a WAIT ICPT in case it
> really want to sleep (disabled wait).

s/want/wants/

(fixing up while applying)

> 
> This will later allow us to change the order of loading a restart
> interrupt and setting a CPU to OPERATING on SIGP RESTART without
> changing KVM behavior.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index 2d7df83c59..baa18777f1 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -147,7 +147,8 @@ void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr)
>          s390_cpu_recompute_watchpoints(CPU(s390_env_get_cpu(env)));
>      }
>  
> -    if (mask & PSW_MASK_WAIT) {
> +    /* KVM will handle all WAITs and trigger a WAIT exit on disabled_wait */
> +    if (tcg_enabled() && (mask & PSW_MASK_WAIT)) {
>          s390_handle_wait(s390_env_get_cpu(env));
>      }
>  }
