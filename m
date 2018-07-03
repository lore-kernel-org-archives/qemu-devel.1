Received: from eggs.gnu.org ([2001:4830:134:3::10]:45067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAZP-0005Bb-DT
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faAZK-0001sw-PF
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:57:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37738 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faAZK-0001sK-Je
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:57:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0BE8E87A7D
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 01:57:26 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-13-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <760da7f7-7600-5299-f006-5649b3c368c4@redhat.com>
Date: Mon, 2 Jul 2018 20:57:20 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-13-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/32] qmp: Redo how the client requests
 out-of-band execution
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
> Commit cf869d53172 "qmp: support out-of-band (oob) execution" added a
> general mechanism for command-independent arguments just for an
> out-of-band flag:
> 
>      The "control" key is introduced to store this extra flag.  "control"
>      field is used to store arguments that are shared by all the commands,
>      rather than command specific arguments.  Let "run-oob" be the first.
> 
> However, it failed to reject unknown members of "control".  For
> instance, in QMP command
> 
>      {"execute": "query-name", "id": 42, "control": {"crap": true}}
> 
> "crap" gets silently ignored.
> 
> Instead of fixing this, revert the general "control" mechanism
> (because YAGNI), and do it the way I initially proposed, with key
> "exec-oob".  Simpler code, simper interface.
> 
> An out-of-band command
> 
>      {"execute": "migrate-pause", "id": 42, "control": {"run-oob": true}}
> 
> becomes
> 
>      {"exec-oob": "migrate-pause", "id": 42}
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Yay!

> @@ -106,9 +110,6 @@ The format for command execution is:
>     command execution, it is optional and will be part of the response
>     if provided.  The "id" member can be any json-value.  A json-number
>     incremented for each successive command works fine.
> -- The optional "control" member further specifies how the command is
> -  to be executed.  Currently, its only member is optional "run-oob".
> -  See section "2.3.1 Out-of-band execution" for details.

Still could use a mention that 'id' is a VERY good idea when using 
'exec-oob' - but as 7/32 made it optional, you could tweak that part of 
the doc in a later patch when making 'id' required for 'exec-oob'.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
