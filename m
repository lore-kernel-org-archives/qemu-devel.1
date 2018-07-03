Received: from eggs.gnu.org ([2001:4830:134:3::10]:35967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faNRe-0006ch-VQ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faNRe-0002dq-52
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:42:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36322 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faNRd-0002dN-VG
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:42:22 -0400
References: <20180703085358.13941-1-armbru@redhat.com>
	<20180703085358.13941-13-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9d72249f-bc55-5c60-2e07-82d19d801910@redhat.com>
Date: Tue, 3 Jul 2018 10:42:20 -0500
MIME-Version: 1.0
In-Reply-To: <20180703085358.13941-13-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/32] qmp: Redo how the client requests
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
Cc: peterx@redhat.com, stefanha@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com

On 07/03/2018 03:53 AM, Markus Armbruster wrote:
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

s/simper/simpler/

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
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
