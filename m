Received: from eggs.gnu.org ([2001:4830:134:3::10]:47532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXnAN-0002GU-22
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXnAI-0004fw-54
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:33:51 -0400
Date: Tue, 26 Jun 2018 14:33:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180626143342.194e62ec.cohuck@redhat.com>
In-Reply-To: <20180625115352.6889-10-david@redhat.com>
References: <20180625115352.6889-1-david@redhat.com>
	<20180625115352.6889-10-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 9/9] s390x/tcg: fix CPU hotplug with
 single-threaded TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>

On Mon, 25 Jun 2018 13:53:52 +0200
David Hildenbrand <david@redhat.com> wrote:

> run_on_cpu() doesn't seem to work reliably until the CPU has been fully
> created if the single-threaded TCG main loop is already running.
> 
> Therefore, hotplugging a CPU under single-threaded TCG does currently
> not work. We should use the direct call instead of going via
> run_on_cpu().
> 
> So let's use run_on_cpu() for KVM only - KVM requires it due to the initial
> CPU reset ioctl. As a nice side effect, we get rif of the ifdef.

s/rif/rid/

{Although "we get rif the thing" would be a nice contraction of "rid of" :}

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 40d6980229..271c5ce652 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -218,11 +218,18 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
>  #endif
>      s390_cpu_gdb_init(cs);
>      qemu_init_vcpu(cs);
> -#if !defined(CONFIG_USER_ONLY)
> -    run_on_cpu(cs, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
> -#else
> -    cpu_reset(cs);
> -#endif
> +
> +    /*
> +     * KVM requires the initial CPU reset ioctl to be executed on the target
> +     * CPU thread. CPU hotplug under single-threaded TCG will not work with
> +     * run_on_cpu(), as run_on_cpu() will not work properly if called while
> +     * the main thread is already running but the CPU hasn't been realized.
> +     */
> +    if (kvm_enabled()) {
> +        run_on_cpu(cs, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
> +    } else {
> +        cpu_reset(cs);
> +    }
>  
>      scc->parent_realize(dev, &err);
>  out:
