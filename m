Received: from eggs.gnu.org ([2001:4830:134:3::10]:44614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqnZ7-0004ur-Jg
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqnZ3-0005Jb-KN
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:17:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35648 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eqnZ3-0005Iz-Fd
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:17:37 -0500
References: <1518784641-43151-1-git-send-email-imammedo@redhat.com>
	<1518784641-43151-9-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <39a0a6a7-5432-1ae8-f275-bd172ef15854@redhat.com>
Date: Tue, 27 Feb 2018 16:17:20 -0600
MIME-Version: 1.0
In-Reply-To: <1518784641-43151-9-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 8/9] QMP: add set-numa-node command
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
> Command is allowed to run only in preconfig stage and
> will allow to configure numa mapping for CPUs depending
> on possible CPUs layout (query-hotpluggable-cpus) for
> given machine instance.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   numa.c           |  5 +++++
>   qapi-schema.json | 14 ++++++++++++++
>   tests/qmp-test.c |  6 ++++++
>   3 files changed, 25 insertions(+)
> 

> +++ b/qapi-schema.json
> @@ -3201,3 +3201,17 @@
>   # Since: 2.11
>   ##
>   { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
> +
> +##
> +# @set-numa-node:
> +#
> +# Runtime equivalent of '-numa' CLI option, available at
> +# preconfigure stage to configure numa mapping before initializing
> +# machine.
> +#
> +# Since 2.12
> +##
> +{ 'command': 'set-numa-node', 'boxed': true,
> +  'data': 'NumaOptions',
> +  'runstates': [ 'preconfig' ]
> +}

Oh, so you ARE trying to do fine-grained control of which commands are 
valid in which states.  Still, would that be easier through a 
three-state enum (or pair of bools) instead of making every client 
enumerate an array of 'all states', 'all but preconfig', and 'preconfig 
only'?

Also, while preconfig is special (not every command can be made to run 
during preconfig, so having the state rejection logic centralized makes 
some sense), there are a lot fewer commands that are preconfig-only - 
could those commands (just set-numa-node at the moment) be made to 
perform state checks themselves rather than relying on centralized 
logic, and then you still only need a single bool in the QAPI schema 
(safe for preconfig, unsafe for preconfig in central logic; unsafe in 
other states in a per-command code).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
