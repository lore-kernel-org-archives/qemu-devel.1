Received: from eggs.gnu.org ([2001:4830:134:3::10]:57920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ckx6l-0003Fv-9d
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ckx6j-00041K-1l
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:11:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ckx6i-000419-SM
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:11:40 -0500
References: <20170306140541.10600-1-hangaohuai@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a3354e81-8671-6951-42a3-ff5c1dc5b55a@redhat.com>
Date: Mon, 6 Mar 2017 19:11:38 +0100
MIME-Version: 1.0
In-Reply-To: <20170306140541.10600-1-hangaohuai@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Fix the vm state after vm migration when
 vm panic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hangaohuai <hangaohuai@huawei.com>, qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com



On 06/03/2017 15:05, hangaohuai wrote:
> Bug steps:
> 1. windows VM with pvpanic device:<panic model='isa'/>in xml
> 2. inject the panic in windows, the vm state is paused (guest-panicked)
> 3. migrate the vm to other host, vm state is running
> 
> Check the vmstate before runstate_set(RUN_STATE_RUNNING)

What's the backtrace for runstate_set(RUN_STATE_RUNNING)?

This should be triggered:

    if (!global_state_received() ||
        global_state_get_runstate() == RUN_STATE_RUNNING) {
        if (autostart) {
            vm_start();
        } else {
            runstate_set(RUN_STATE_PAUSED);
        }
    } else {
        runstate_set(global_state_get_runstate());   /* <<<< */
    }

I also suggest a testcase to tests/pvpanic-test.c.

Paolo

> Signed-off-by: hangaohuai <hangaohuai@huawei.com>
> ---
>  cpus.c                  | 3 +++
>  include/sysemu/sysemu.h | 1 +
>  vl.c                    | 5 +++++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/cpus.c b/cpus.c
> index c857ad2..37b93aa 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1734,6 +1734,9 @@ int vm_prepare_start(void)
>      if (runstate_is_running()) {
>          qapi_event_send_stop(&error_abort);
>          res = -1;
> +    } else if (runstate_is_paniced()) {
> +        qemu_system_guest_panicked(NULL);
> +        res = -1;
>      } else {
>          replay_enable_events();
>          cpu_enable_ticks();
