Received: from eggs.gnu.org ([2001:4830:134:3::10]:51456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euLaN-0005nM-Qe
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:13:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euLaK-0007oK-KI
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:13:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34634 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1euLaK-0007o3-E5
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:13:36 -0500
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-2-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1eb00cad-0f88-4c62-15da-c209b1f9df8a@redhat.com>
Date: Fri, 9 Mar 2018 11:13:23 -0600
MIME-Version: 1.0
In-Reply-To: <20180309090006.10018-2-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 01/23] docs: update QMP documents for
 OOB commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 03/09/2018 02:59 AM, Peter Xu wrote:
> Update both the developer and spec for the new QMP OOB (Out-Of-Band)
> command.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   docs/devel/qapi-code-gen.txt | 65 ++++++++++++++++++++++++++++++++++++++++----
>   docs/interop/qmp-spec.txt    | 30 +++++++++++++++++---
>   2 files changed, 86 insertions(+), 9 deletions(-)

If all goes well, I'm planning on taking this series through my QAPI 
tree, with a pull request either late today or early Monday in order to 
make the soft freeze deadline.  We'll see what my review turns up, but 
hopefully at this point it's either clean or minor enough tweaks that I 
can polish it without a v9.

> +
> + { 'command': 'migrate_recover',
> +   'data': { 'uri': 'str' }, 'allow-oob': true }
> +
> +To execute a command in Out-Of-Band way, we need to specify the

Either 'execute a command in an Out-Of-Band way,' or 'execute a command 
in Out-Of-Band order,'.

> +"control" field in the request, with "run-oob" set to true. Example:
> +
> + => { "execute": "command-support-oob",
> +      "arguments": { ... },
> +      "control": { "run-oob": true } }
> + <= { "return": { } }
> +
> +Without it, even the commands that support out-of-band execution will
> +still be run In-Band.
> +
> +--- About Out-Of-Band (OOB) Command Execution ---
> +
> +Out-Of-Band does not mean a special kind of command. Instead, it's a
> +special way to execute the command.  One normal command can be

Perhaps s/One normal command can be/A normal command is/

> +declared to support Out-Of-Band execution when 'allow-oob' field is

s/when/when the/

> +set to true when defining the command.  With that, it can be run in an

s/when defining the command/in the command definition/

> +Out-Of-Band way if 'run-oob' is specified in 'control' field of
> +command request.
> +
> +Under normal QMP command execution, the following apply to each
> +command:
> +
> +- They are executed in order,
> +- They run only in main thread of QEMU,
> +- They have the BQL taken during execution.
> +
> +When a command is executed with OOB, the following changes occur:
> +
> +- They can be completed before a pending in-band command,
> +- They run in a monitor dedicated thread,

s/monitor dedicated/dedicated monitor/

> +- They do not take the BQL during execution.
> +
> +OOB command handlers must satisfy the following conditions:
> +
> +- It executes extremely fast,
> +- It does not take any lock, or, it can take very small locks if all
> +  critical regions also follow the rules for OOB command handler code,
> +- It does not invoke system calls that may block,
> +- It does not access guest RAM that may block when userfaultfd is
> +  enabled for postcopy live migration.
> +
> +If in doubt, do not implement OOB execution support.
>   
>   === Events ===
>   
> @@ -739,10 +792,12 @@ references by name.
>   QAPI schema definitions not reachable that way are omitted.
>   
>   The SchemaInfo for a command has meta-type "command", and variant
> -members "arg-type" and "ret-type".  On the wire, the "arguments"
> -member of a client's "execute" command must conform to the object type
> -named by "arg-type".  The "return" member that the server passes in a
> -success response conforms to the type named by "ret-type".
> +members "arg-type", "ret-type" and "allow-oob".  On the wire, the
> +"arguments" member of a client's "execute" command must conform to the
> +object type named by "arg-type".  The "return" member that the server
> +passes in a success response conforms to the type named by
> +"ret-type".  When "allow-oob" is set, it means the command supports
> +out-of-band execution.

We're inconsistent on whether it is capitalized 'Out-Of-Band'.  I'm 
probably okay with the first mention being capitalized (next to the 
first use of the OOB acronym), and all subsequent uses being lower case.

>   
>   If the command takes no arguments, "arg-type" names an object type
>   without members.  Likewise, if the command returns nothing, "ret-type"
> diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt
> index f8b5356015..9a208589f6 100644
> --- a/docs/interop/qmp-spec.txt
> +++ b/docs/interop/qmp-spec.txt
> @@ -83,16 +83,27 @@ The greeting message format is:
>   2.2.1 Capabilities
>   ------------------
>   
> -As of the date this document was last revised, no server or client
> -capability strings have been defined.
> +Currently supported capabilities are:
>   
> +- "oob": it means the QMP server supports "Out-Of-Band" command

s/it means //

> +  execution.  For more details, please see "run-oob" parameter in

s/see/see the/

> +  "Issuing Commands" section below.  Not all commands allow this "oob"
> +  execution.  The "query-qmp-schema" command can be used to inspect
> +  which commands support "oob" execution.
> +
> +QMP clients can get a list of supported QMP capabilities of the QMP
> +server in the greeting message mentioned above.  By default, all the
> +capabilities are off.  To enable any QMP capabilities, the QMP client
> +needs to send the "qmp_capabilities" command with an extra parameter
> +for the requested capabilities.
>   
>   2.3 Issuing Commands
>   --------------------
>   
>   The format for command execution is:
>   
> -{ "execute": json-string, "arguments": json-object, "id": json-value }
> +{ "execute": json-string, "arguments": json-object, "id": json-value,
> +  "control": json-dict }

s/json-dict/json-object/

(The JSON term is Object, even though dictionary is a common term for 
the typical data representation of an object)

>   
>    Where,
>   
> @@ -102,10 +113,16 @@ The format for command execution is:
>     required. Each command documents what contents will be considered
>     valid when handling the json-argument
>   - The "id" member is a transaction identification associated with the
> -  command execution, it is optional and will be part of the response if
> +  command execution.  It is required if OOB is enabled, and optional
> +  if not.  The same "id" field will be part of the response if

Ambiguous on whether this is the per-command 'run-oob', or whether this 
is the generic QMP capability requested during qmp_capabilities.  I 
think the intent is that if you enabled the QMP capability up front, ALL 
commands must have an "id", even if they are run in-band without 
'run-oob', because the 'id' in the response is what will distinguish 
whether a later OOB request overtook a pending in-band reply.

>     provided. The "id" member can be any json-value, although most
>     clients merely use a json-number incremented for each successive
>     command
> +- The "control" member is optional, and currently only used for
> +  "out-of-band" execution ("oob" as shortcut). The handling or

A bit late to be introducing "oob" as shortcut, given that you've 
already used the abbreviation oob earlier in the document.

> +  response of an "oob" command can overtake prior in-band commands.
> +  To enable "oob" handling of a particular command, just provide a
> +  control field with: { "control": { "run-oob": true } }
>   
>   2.4 Commands Responses
>   ----------------------
> @@ -113,6 +130,11 @@ The format for command execution is:
>   There are two possible responses which the Server will issue as the result
>   of a command execution: success or error.
>   
> +As long as the commands were issued with a proper "id" field, then the
> +same "id" field will be attached in the corresponding response message
> +so that requests and responses can match.  Clients should drop all the
> +responses that are with unknown "id" field.

s/are with/have an/

I've got quite a few wording tweaks, but the general concept is good. 
If you need to respin for other reasons, feel free to make those 
improvements, but I also don't mind making tweaks myself as part of 
queuing for a pull request, so:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
