Received: from eggs.gnu.org ([2001:4830:134:3::10]:44571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fH9wY-0005kl-HT
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fH9wV-00017x-B0
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:26:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44042 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fH9wV-00017l-5L
	for qemu-devel@nongnu.org; Fri, 11 May 2018 11:26:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7259A40006EC
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 15:26:46 +0000 (UTC)
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
	<1525423069-61903-6-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8d2aedd6-58b3-9b36-c97f-4b4fe742d061@redhat.com>
Date: Fri, 11 May 2018 10:26:45 -0500
MIME-Version: 1.0
In-Reply-To: <1525423069-61903-6-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 05/11] qapi: introduce new cmd option
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
Cc: ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com

On 05/04/2018 03:37 AM, Igor Mammedov wrote:

Subject line is stale, needs to be updated to match new spelling...

> New option will be used to allow commands, which are prepared/need
> to run, during preconfig state. Other commands that should be able
> to run in preconfig state, should be amended to not expect machine
> in initialized state or deal with it.
> 
> For compatibility reasons, commands that don't use new flag
> 'allowed-in-preconfig' explicitly are not permitted to run in

another stale comment...

> preconfig state but allowed in all other states like they used
> to be.
> 
> Within this patch allow following commands in preconfig state:
>     qmp_capabilities
>     query-qmp-schema
>     query-commands
>     query-command-line-options
>     query-status
>     exit-preconfig
> to allow qmp connection, basic introspection and moving to the next
> state.
> 
> PS:
> set-numa-node and query-hotpluggable-cpus will be enabled later in
> a separate patches.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v7:
>    - (Eric Blake <eblake@redhat.com>)
>      * s/allowed-in-preconfig/allow-preconfig/

...used in the rest of the patch.

>      * s/allowed_in_preconfig/allow_preconfig/
>      * move here QCO_ALLOWED_IN_PRECONFIG declaration from
>         'cli: add --preconfig option'
>        and put this patch before it as well
>      * s/QCO_ALLOWED_IN_PRECONFIG/QCO_ALLOW_PRECONFIG/
>      * wording fixes in doc

> +++ b/include/qapi/qmp/dispatch.h
> @@ -23,6 +23,7 @@ typedef enum QmpCommandOptions
>       QCO_NO_OPTIONS            =  0x0,
>       QCO_NO_SUCCESS_RESP       =  (1U << 0),
>       QCO_ALLOW_OOB             =  (1U << 1),
> +    QCO_ALLOW_PRECONFIG       =  (1U << 2),
>   } QmpCommandOptions;
>   
>   typedef struct QmpCommand
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index a569d24..0f9fbea 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -559,7 +559,7 @@ following example objects:
>   Usage: { 'command': STRING, '*data': COMPLEX-TYPE-NAME-OR-DICT,
>            '*returns': TYPE-NAME, '*boxed': true,
>            '*gen': false, '*success-response': false,
> -         '*allow-oob': true }
> +         '*allow-oob': true, '*allow-preconfig': true }

Thanks for taking on the bikeshed renaming; it does look better now that 
the two flags have similar spellings.

>   
>   Commands are defined by using a dictionary containing several members,
>   where three members are most common.  The 'command' member is a
> @@ -683,6 +683,14 @@ OOB command handlers must satisfy the following conditions:
>   
>   If in doubt, do not implement OOB execution support.
>   
> +A command may use optional 'allow-preconfig' key to permit its execution

s/use/use the/

> +at early runtime configuration stage (preconfig runstate).
> +If not specified then a command defaults to 'allow-preconfig': false

trailing '.'

> +
> +An example of declaring a command that is enabled during preconfig:
> + { 'command': 'qmp_capabilities',
> +   'allow-preconfig': true }

It might be worth having this example match our current schema, as in:

{ 'command': 'qmp_capabilities',
   'allow-preconfig': true,
   'data': { '*enable': [ 'QMPCapability' ] } }

> +++ b/qapi/misc.json
> @@ -35,7 +35,8 @@
>   #
>   ##
>   { 'command': 'qmp_capabilities',
> -  'data': { '*enable': [ 'QMPCapability' ] } }
> +  'data': { '*enable': [ 'QMPCapability' ] },
> +  'allow-preconfig': true }

Or the way you actually wrote it ;)

Otherwise looks pretty good.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
