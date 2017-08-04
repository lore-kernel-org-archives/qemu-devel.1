Received: from eggs.gnu.org ([2001:4830:134:3::10]:58546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ddfyS-0006t8-PL
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ddfyO-0001KD-81
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:01:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ddfyN-0001JK-VB
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:01:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2FF3E80E75
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 17:01:14 +0000 (UTC)
Date: Fri, 4 Aug 2017 18:01:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170804170110.GD2087@work-vm>
References: <20170804161452.17413-1-pbonzini@redhat.com>
	<20170804161452.17413-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170804161452.17413-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] rcu: completely disable pthread_atfork
 callbacks as soon as possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> Because of -daemonize, system mode QEMU sometimes needs to fork() and
> keep RCU enabled in the child.  However, there is a possible deadlock
> with synchronize_rcu:
> 
> - the CPU thread is inside a RCU critical section and wants to take
>   the BQL in order to do MMIO
> 
> - the monitor thread, which is owning the BQL, calls rcu_init_lock
>   which tries to take the rcu_sync_lock
> 
> - the call_rcu thread has taken rcu_sync_lock in synchronize_rcu, but
>   synchronize_rcu needs the CPU thread to end the critical section
>   before returning.
> 
> This cannot happen for user-mode emulation, because it does not have
> a BQL.
> 
> To fix it, assume that system mode QEMU only forks in preparation for
> exec (except when daemonizing) and disable pthread_atfork as soon as
> the double fork has happened.
> 
> Reported-by: David Gilbert <dgilbert@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

That seems to fix that issue (not tested it any more than that though),
so for fixing that issue:

Tested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/qemu/rcu.h |  6 ++++++
>  util/rcu.c         | 20 ++++++++++++++++++++
>  vl.c               |  1 +
>  3 files changed, 27 insertions(+)
> 
> diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
> index 83ae2808be..c0da9907e8 100644
> --- a/include/qemu/rcu.h
> +++ b/include/qemu/rcu.h
> @@ -105,6 +105,12 @@ extern void synchronize_rcu(void);
>   */
>  extern void rcu_register_thread(void);
>  extern void rcu_unregister_thread(void);
> +
> +/*
> + * Support for fork().  fork() support is enabled at startup.
> + */
> +extern void rcu_enable_atfork(void);
> +extern void rcu_disable_atfork(void);
>  extern void rcu_after_fork(void);
>  
>  struct rcu_head;
> diff --git a/util/rcu.c b/util/rcu.c
> index 9adc5e4a36..2142ddd93b 100644
> --- a/util/rcu.c
> +++ b/util/rcu.c
> @@ -318,15 +318,35 @@ static void rcu_init_complete(void)
>      rcu_register_thread();
>  }
>  
> +static int atfork_depth = 1;
> +
> +void rcu_enable_atfork(void)
> +{
> +    atfork_depth++;
> +}
> +
> +void rcu_disable_atfork(void)
> +{
> +    atfork_depth--;
> +}
> +
>  #ifdef CONFIG_POSIX
>  static void rcu_init_lock(void)
>  {
> +    if (atfork_depth < 1) {
> +        return;
> +    }
> +
>      qemu_mutex_lock(&rcu_sync_lock);
>      qemu_mutex_lock(&rcu_registry_lock);
>  }
>  
>  static void rcu_init_unlock(void)
>  {
> +    if (atfork_depth < 1) {
> +        return;
> +    }
> +
>      qemu_mutex_unlock(&rcu_registry_lock);
>      qemu_mutex_unlock(&rcu_sync_lock);
>  }
> diff --git a/vl.c b/vl.c
> index 99fcfa0442..8967115514 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4121,6 +4121,7 @@ int main(int argc, char **argv, char **envp)
>      set_memory_options(&ram_slots, &maxram_size, machine_class);
>  
>      os_daemonize();
> +    rcu_disable_atfork();
>  
>      if (pid_file && qemu_create_pidfile(pid_file) != 0) {
>          error_report("could not acquire pid file: %s", strerror(errno));
> -- 
> 2.13.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
