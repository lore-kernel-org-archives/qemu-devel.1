Received: from eggs.gnu.org ([2001:4830:134:3::10]:52311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqm2K-0001IH-O9
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqm2H-0002vQ-JO
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:39:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37328 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eqm2H-0002vB-Dp
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:39:41 -0500
References: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
	<1518784641-43151-4-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ef81e2f1-1c6a-82ad-86fd-fab56ab92c78@redhat.com>
Date: Tue, 27 Feb 2018 14:39:22 -0600
MIME-Version: 1.0
In-Reply-To: <1518784641-43151-4-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/9] CLI: add -preconfig option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, david@gibson.dropbear.id.au, peter.maydell@linaro.org, pbonzini@redhat.com, cohuck@redhat.com

On 02/16/2018 06:37 AM, Igor Mammedov wrote:
> Option allows to pause QEMU at new RUN_STATE_PRECONFIG time,
> which would allow to configure QEMU from QMP before machine
> jumps into board initialization code machine_run_board_init().

Grammar suggestion:

This option allows pausing QEMU in the new RUN_STATE_PRECONFIG state, 
allowing the configuration of QEMU from QMP before the machine jumps 
into board initialization code of machine_run_board_init().

> 
> Intent is to allow management to query machine state and
> additionally configure it using previous query results
> within one QEMU instance (i.e. eliminate need to start QEMU
> twice, 1st to query board specific parameters and 2nd for
> for actual VM start using query result for additional
> parameters).
> 
> Initially it's planned to be used for configuring numa
> topology depending on cpu layout.

It may be worth mentioning in the commit message how this differs from 
-S, and what the QMP client must do to get the guest started in this 
mode to enter the normal lifecycle that it used to have when using -S.

> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   include/sysemu/sysemu.h |  1 +
>   qapi/run-state.json     |  3 ++-
>   qemu-options.hx         | 11 +++++++++++
>   qmp.c                   |  5 +++++
>   vl.c                    | 35 ++++++++++++++++++++++++++++++++++-
>   5 files changed, 53 insertions(+), 2 deletions(-)
> 

> +++ b/qapi/run-state.json
> @@ -49,12 +49,13 @@
>   # @colo: guest is paused to save/restore VM state under colo checkpoint,
>   #        VM can not get into this state unless colo capability is enabled
>   #        for migration. (since 2.8)
> +# @preconfig: QEMU is paused before machine is created.

Needs a '(since 2.12)' tag.  Probably also be worth mentioning that this 
state is only visible for clients that pass the new CLI option.

> +++ b/qemu-options.hx
> @@ -3283,6 +3283,17 @@ STEXI
>   Run the emulation in single step mode.
>   ETEXI
>   
> +DEF("preconfig", 0, QEMU_OPTION_preconfig, \
> +    "-preconfig      pause QEMU before machine is initialized\n",
> +    QEMU_ARCH_ALL)
> +STEXI
> +@item -preconfig
> +@findex -preconfig
> +Pause QEMU for interactive configuration before machine is created,
> +which allows to query and configure properties affecting machine
> +initialization. Use QMP command 'cont' to exit paused state.

Pause QEMU for interactive configuration before the machine is created, 
which allows querying and configuring properties that will affect 
machine initialization.  Use the QMP command 'cont' to exit the 
preconfig state.

Hmm - can you also transition from preconfig to the normal paused state 
via 'stop', which you would do to emit other commands that you used to 
issue between the older 'qemu -S' and the 'cont'?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
