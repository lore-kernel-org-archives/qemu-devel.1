Received: from eggs.gnu.org ([2001:4830:134:3::10]:43022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1deyuk-0000oN-3h
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1deyuf-0004Uw-K2
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:26:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1deyuf-0004T1-AS
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 03:26:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41ACC883B9
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 07:26:48 +0000 (UTC)
References: <1502175607-9531-1-git-send-email-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3f0e8fe6-babd-df82-c690-de0f1ffdd460@redhat.com>
Date: Tue, 8 Aug 2017 09:26:43 +0200
MIME-Version: 1.0
In-Reply-To: <1502175607-9531-1-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11] rcu: init globals only once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On 08/08/2017 09:00, Peter Xu wrote:
> We were calling rcu_init_complete() twice in the child processes when
> fork happened. However the pthread library does not really suggest to d=
o
> it that way:
>=20
> http://pubs.opengroup.org/onlinepubs/7908799/xsh/pthread_mutex_init.htm=
l
>=20
> "Attempting to initialise an already initialised mutex results in
>  undefined behaviour."
>=20
> Actually, IMHO we can do it in a more natural way: Firstly, we only ini=
t
> the RCU globals once in rcu_init(). Then, in rcu_init_child(), we unloc=
k
> all the locks held in rcu_init_lock() just like what we do in the paren=
t
> process, then do the rest of RCU re-init (e.g., create the RCU thread).

This doesn't work for error-checking mutexes: rcu_init_child has a
different PID than the parent, so the mutexes aren't unlocked.  It's
also true that right now we don't use error-checking mutexes (commit
24fa90499f, "qemu-thread: do not use PTHREAD_MUTEX_ERRORCHECK",
2015-03-10); however, that's also a bit sad.

The reason for the undefined behavior is probably that some operating
systems allocate memory in pthread_mutex_init, and initializing twice
causes a memory leak.  One such operating system is OpenBSD. :(

Eric, you chimed in on the patch that became commit 24fa90499f, what do
you suggest?

Paolo

> CC: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> this is based on Paolo's series:
> "[PATCH for-2.10 0/2] RCU: forking fix and cleanups"
> ---
>  util/rcu.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/util/rcu.c b/util/rcu.c
> index ca5a63e..6fbbe4c 100644
> --- a/util/rcu.c
> +++ b/util/rcu.c
> @@ -299,15 +299,17 @@ void rcu_unregister_thread(void)
>      qemu_mutex_unlock(&rcu_registry_lock);
>  }
> =20
> -static void rcu_init_complete(void)
> +static void rcu_init_globals(void)
>  {
> -    QemuThread thread;
> -
>      qemu_mutex_init(&rcu_registry_lock);
>      qemu_mutex_init(&rcu_sync_lock);
>      qemu_event_init(&rcu_gp_event, true);
> -
>      qemu_event_init(&rcu_call_ready_event, false);
> +}
> +
> +static void rcu_init_complete(void)
> +{
> +    QemuThread thread;
> =20
>      /* The caller is assumed to have iothread lock, so the call_rcu th=
read
>       * must have been quiescent even after forking, just recreate it.
> @@ -357,6 +359,13 @@ static void rcu_init_child(void)
>          return;
>      }
> =20
> +    rcu_init_unlock();
> +
> +    /*
> +     * For the newly forked child, we need something extra: since
> +     * after fork the threads are all gone, we need to re-init the RCU
> +     * thread, along with the globals.
> +     */
>      memset(&registry, 0, sizeof(registry));
>      rcu_init_complete();
>  }
> @@ -367,5 +376,6 @@ static void __attribute__((__constructor__)) rcu_in=
it(void)
>  #ifdef CONFIG_POSIX
>      pthread_atfork(rcu_init_lock, rcu_init_unlock, rcu_init_child);
>  #endif
> +    rcu_init_globals();
>      rcu_init_complete();
>  }
>=20
