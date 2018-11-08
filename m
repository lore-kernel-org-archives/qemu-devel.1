Received: from eggs.gnu.org ([2001:4830:134:3::10]:38226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gKn8R-00006N-5E
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gKn8H-0001ch-5E
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:26:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gKn8G-0001YF-Sq
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:26:13 -0500
Date: Thu, 8 Nov 2018 17:26:06 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181108172606.38672769.cohuck@redhat.com>
In-Reply-To: <20181108160818.5485-20-yuval.shaia@oracle.com>
References: <20181108160818.5485-1-yuval.shaia@oracle.com>
	<20181108160818.5485-20-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 19/22] vl: Introduce shutdown_notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com

On Thu,  8 Nov 2018 18:08:15 +0200
Yuval Shaia <yuval.shaia@oracle.com> wrote:

> Notifier will be used for signaling shutdown event to inform system is
> shutdown. This will allow devices and other component to run some
> cleanup code needed before VM is shutdown.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>  include/sysemu/sysemu.h |  1 +
>  vl.c                    | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 

> @@ -1809,6 +1811,12 @@ static void qemu_system_powerdown(void)
>      notifier_list_notify(&powerdown_notifiers, NULL);
>  }
>  
> +static void qemu_system_shutdown(bool by_guest)

I would pass the shutdown reason here directly (instead of only whether
this was triggered by the guest or not)...

> +{
> +    qapi_event_send_shutdown(by_guest);
> +    notifier_list_notify(&shutdown_notifiers, NULL);

...and also pass it to the notifiers here. If we have the info anyway,
why not simply pass it along.

> +}
> +
>  void qemu_system_powerdown_request(void)
>  {
>      trace_qemu_system_powerdown_request();
> @@ -1821,6 +1829,11 @@ void qemu_register_powerdown_notifier(Notifier *notifier)
>      notifier_list_add(&powerdown_notifiers, notifier);
>  }
>  
> +void qemu_register_shutdown_notifier(Notifier *notifier)
> +{
> +    notifier_list_add(&shutdown_notifiers, notifier);
> +}
> +
>  void qemu_system_debug_request(void)
>  {
>      debug_requested = 1;
> @@ -1848,7 +1861,7 @@ static bool main_loop_should_exit(void)
>      request = qemu_shutdown_requested();
>      if (request) {
>          qemu_kill_report();
> -        qapi_event_send_shutdown(shutdown_caused_by_guest(request));
> +        qemu_system_shutdown(shutdown_caused_by_guest(request));
>          if (no_shutdown) {
>              vm_stop(RUN_STATE_SHUTDOWN);
>          } else {
