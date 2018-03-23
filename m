Received: from eggs.gnu.org ([2001:4830:134:3::10]:51863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezTpa-0004Wg-8b
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:02:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezTpV-0004dw-JS
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:02:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42124 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ezTpV-0004cF-Dc
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:02:29 -0400
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-4-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <65581cce-bb5c-9fc7-4947-5b51b7c4aae0@redhat.com>
Date: Fri, 23 Mar 2018 16:02:17 -0500
MIME-Version: 1.0
In-Reply-To: <1520860275-101576-4-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/9] cli: add -preconfig option
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

On 03/12/2018 08:11 AM, Igor Mammedov wrote:

I know you wrote this before softfreeze, but I'm only just now getting a 
chance to review. ...[1]

> This option allows pausing QEMU in the new RUN_STATE_PRECONFIG state,
> allowing the configuration of QEMU from QMP before the machine jumps
> into board initialization code of machine_run_board_init()
> 
> Intent is to allow management to query machine state and additionally

s/Intent/The intent/

> configure it using previous query results within one QEMU instance
> (i.e. eliminate need to start QEMU twice, 1st to query board specific

s/need/the need/

> parameters and 2nd for actual VM start using query results for
> additional parameters).
> 
> New option complements -S option and could be used with or without

s/New/The new/


> it. Difference is that -S pauses QEMU when machine is completely

s/Difference/The difference/
s/when/when the/

> build with all devices wired up and ready run (QEMU need only to

s/build/built/
s/ready/ready to/

> unpause CPUs to let guest execute its code).
> And "preconfig" option pauses QEMU early before board specific init

s/. And/; while the/

> callback (machine_run_board_init) is executed and will allow to
> configure machine parameters which will be used by board init code.

s/allow to configure/allow the configuration of/

> 
> When early introspection/configuration is done, command 'cont' should
> be used to exit RUN_STATE_PRECONFIG and transition to the next
> requested state (i.e. if -S is used then QEMU will pause the second
> time when board/device initialization is completed or start guest
> execution if -S isn't provided on CLI)
> 
> PS:
> Initially 'preconfig' is planned to be used for configuring numa
> topology depending on board specified possible cpus layout.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v4:
>    * Explain more on behaviour in commit message and use suggested
>      wording in message and patch (Eric Blake <eblake@redhat.com>)

Well, I'm still coming up with wording tweaks, but it is getting better ;)

> ---
>   include/sysemu/sysemu.h |  1 +
>   qapi/run-state.json     |  5 ++++-
>   qemu-options.hx         | 13 +++++++++++++
>   qmp.c                   |  5 +++++
>   vl.c                    | 35 ++++++++++++++++++++++++++++++++++-
>   5 files changed, 57 insertions(+), 2 deletions(-)
> 

> +++ b/qapi/run-state.json
> @@ -49,12 +49,15 @@
>   # @colo: guest is paused to save/restore VM state under colo checkpoint,
>   #        VM can not get into this state unless colo capability is enabled
>   #        for migration. (since 2.8)
> +# @preconfig: QEMU is paused before board specific init callback is executed.
> +#             The state is reachable only if -preconfig CLI option is used.
> +#             (Since 2.12)

[1]... So are you still trying to cram this in 2.12 as a bugfix? It 
feels enough like a feature that at this point, you'll want to change 
that to 2.13 on your v5 spin.  (Probably a similar comment throughout 
the series, so I'll only mention it this once).

s/if -preconfig/if the --preconfig/

spelling --preconfig with two dashes may make sense; we have a 
bite-sized task that mentions that common options like -object/--object 
should prefer the two-dash form, at which point consistency where all 
our other options use the two-dash form may be worth doing.  But even if 
you stick with the one-dash form, inserting 'the' sounds better to a 
native speaker.

>   ##
>   { 'enum': 'RunState',
>     'data': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'paused',
>               'postmigrate', 'prelaunch', 'finish-migrate', 'restore-vm',
>               'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
> -            'guest-panicked', 'colo' ] }
> +            'guest-panicked', 'colo', 'preconfig' ] }
>   
>   ##
>   # @StatusInfo:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 6585058..7c8aaa5 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3302,6 +3302,19 @@ STEXI
>   Run the emulation in single step mode.
>   ETEXI
>   
> +DEF("preconfig", 0, QEMU_OPTION_preconfig, \
> +    "-preconfig      pause QEMU before machine is initialized\n",

More places for two-dash spelling consideration.

> +    QEMU_ARCH_ALL)
> +STEXI
> +@item -preconfig
> +@findex -preconfig
> +Pause QEMU for interactive configuration before the machine is created,
> +which allows querying and configuring properties that will affect
> +machine initialization. Use the QMP command 'cont' to exit the preconfig
> +state and move to the next state (ie. run guest if -S isn't used or
> +pause the second time is -S is used).

s/is -S/if -S/

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
