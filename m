Received: from eggs.gnu.org ([2001:4830:134:3::10]:49518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa5q4-0004Bx-Fs
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa5pz-0007p0-QJ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:54:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50820 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fa5pz-0007ok-KA
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:54:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B98DB401EF07
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 20:54:18 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f9844106-6c8b-21fe-3560-4e0b7def0c60@redhat.com>
Date: Mon, 2 Jul 2018 15:54:13 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/32] docs/interop/qmp: Improve OOB
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

On 07/02/2018 11:21 AM, Markus Armbruster wrote:
> OOB documentation is spread over qmp-spec.txt sections 2.2.1
> Capabilities and 2.3 Issuing Commands.  The amount of detail is a bit
> distracting there.  Move the meat of the matter to new section 2.3.1
> Out of band execution.
> 
> Throw in a few other improvements while there:
> 
> * 2.2 Server Greetung: Drop advice to search entire capabilities

s/Greetung/Greeting/

>    array; should be obvious.
> 
> * 3. QMP Examples
> 
>    - 3.1 Server Greeting: Update greeting to current one.  Now shows
>      capability "oob".  Update qmp-intro.txt likewise.
> 
>    - 3.2 Capabilities negotiation: Show client accepting capability
>      "oob".
> 
>    - 3.7 Out-of-band execution: New.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   docs/interop/qmp-intro.txt | 13 +++----
>   docs/interop/qmp-spec.txt  | 74 +++++++++++++++++++++++++-------------
>   2 files changed, 56 insertions(+), 31 deletions(-)
> 
> diff --git a/docs/interop/qmp-intro.txt b/docs/interop/qmp-intro.txt
> index 900d69d612..3dafa35ea6 100644
> --- a/docs/interop/qmp-intro.txt
> +++ b/docs/interop/qmp-intro.txt
> @@ -52,13 +52,14 @@ Escape character is '^]'.
>       "QMP": {
>           "version": {
>               "qemu": {
> -                "micro": 50,
> -                "minor": 6,
> -                "major": 1
> -            },
> -            "package": ""
> -        },
> +                "micro": 50,
> +                "minor": 12,
> +                "major": 2
> +            },
> +            "package": "v2.12.0-1763-g4e022f5ccd"

Obviously tested during development rather than on a released version, 
but that's reasonable.


> +2.3.1 Out-of-band execution
> +---------------------------
> +
> +The server normally reads, executes and responds to one command after
> +the other.  The client therefore receives command respones in issue

s/respones/responses/

> +order.
> +
> +With out-of-band execution enabled via capability negotiation (section
> +4.), the server reads and queues commands as they arrive.  It executes
> +commands from the queue one after the other.  Commands executed
> +out-of-band jump the queue: they command get executed right away,

s/they command get/the command gets/

> +possibly overtaking prior in-band commands.  The client may therefore
> +receive such a command's response before responses from prior in-band
> +commands.
> +
> +To execute a command out-of-band, the client puts "run-oob": true into
> +execute's member "control".

Are we still hoping for a later patch to ditch "control" and add 
"exec-oob"?  But if we do that, building it on top of this patch (with 
appropriate doc tweaks at that time) makes sense.

> +3.7 Out-of-band execution
> +-------------------------
> +
> +C: { "execute": "migrate-pause", "id": 42, "control": { "run-oob": true } }
> +S: { "id": 42,
> +     "error": { "class": "GenericError",
> +      "desc": "migrate-pause is currently only supported during postcopy-active state" } }

Different from a successful command, but works for me.

With the typo fixes,
Reviewed-by: Eric Blake <eblake@redhat.com>

I don't know if this patch will make it in time for 3.0 soft freeze, but 
resolving missing documentation feels like enough of a bug fix to be 
included during freeze as needed.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
