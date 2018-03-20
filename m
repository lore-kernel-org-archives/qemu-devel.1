Received: from eggs.gnu.org ([2001:4830:134:3::10]:48964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyL2b-0002Vl-GJ
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyL2Y-0000Ge-CC
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:27:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyL2Y-0000GE-7L
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:27:14 -0400
References: <20180320165855.23258-1-fl@n621.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ca91c5dc-6ef8-773f-9ee5-6cf8d0bedcce@redhat.com>
Date: Tue, 20 Mar 2018 12:27:12 -0500
MIME-Version: 1.0
In-Reply-To: <20180320165855.23258-1-fl@n621.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] os: truncate pidfile on creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Florian Larysch <fl@n621.de>, qemu-devel@nongnu.org
Cc: sw@weilnetz.de

On 03/20/2018 11:58 AM, Florian Larysch wrote:
> qemu_create_pidfile does not truncate the pidfile when it creates it,
> but rather overwrites its contents with the new pid. This works fine as
> long as the length of the pid doesn't decrease, but this might happen in
> case of wraparounds, causing pidfiles to contain trailing garbage which
> breaks operations such as 'kill $(cat pidfile)'.
> 
> Instead, always truncate the file before writing it.
> 
> Note that the order is important here: We cannot simply use O_TRUNC in
> the open() call because another qemu process might truncate the pidfile
> of a process that is still running before reaching the lockf() barrier.
> 
> The Windows version suffers from a similar problem, but as it does not
> provide effective mutual exclusion anyway (because the file handle is
> closed immediately after writing to it), adopting this behavior still
> seems to be an improvement, as it at least prevents garbeled pidfiles.

s/garbeled/garbled/

> 
> Signed-off-by: Florian Larysch <fl@n621.de>
> ---
>   os-posix.c | 6 ++++++
>   os-win32.c | 2 +-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
