Received: from eggs.gnu.org ([2001:4830:134:3::10]:53493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezTyq-0001C0-RK
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezTym-0003tX-4f
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:12:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ezTyl-0003tD-WD
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:12:04 -0400
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-6-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7ff0f691-b682-61e0-ebfe-f484c87fbc8d@redhat.com>
Date: Fri, 23 Mar 2018 16:11:53 -0500
MIME-Version: 1.0
In-Reply-To: <1520860275-101576-6-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 5/9] qapi: introduce new cmd option
 "allowed-in-preconfig"
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
> New option will be used to allow commands, which are prepared/need
> to run run in preconfig state. Other commands that should be able

s/run run in/run, during/

> to run in preconfig state, should be ammeded to not expect machine

s/ammeded/amended/

> in initialized state or deal with it.
> 
> For compatibility reasons, commands, that don't use new flag

s/commands,/commands/

> 'allowed-in-preconfig' explicitly, are not permited to run in

s/explicitly,/explicitly/
s/permited/permitted/

> preconfig state but allowed in all other states like they used
> to be.
> 
> Within this patch allow following commands in preconfig state:
>     qmp_capabilities
>     query-qmp-schema
>     query-commands
>     query-status
>     cont
> to allow qmp connection, basic introspection and moving to the next
> state.

Looks like a reasonable list.  Maybe also query-command-line-options 
should be here?

> 
> PS:
> set-numa-node and query-hotpluggable-cpus will be enabled later in
> a separate patch.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v4:
>    * replaces complex "universal" approach
>       "[PATCH v3 5/9] QAPI: allow to specify valid runstates  per command"
>      with a simpler new command flag "allowed-in-preconfig".
>      (Eric Blake <eblake@redhat.com>)

Thanks; it looks a lot more maintainable now.  However, you need to 
rebase, now that 'allow-oob' has already landed.

> +++ b/qapi/introspect.json
> @@ -259,12 +259,16 @@
>   #
>   # @ret-type: the name of the command's result type.
>   #
> +# @allowed-in-preconfig: command could be executed  in preconfig runstate,

s/could/can/
double space before in

> +#                        default: 'false' (Since 2.12)

/me must resist the urge to call out softfreeze ;)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
