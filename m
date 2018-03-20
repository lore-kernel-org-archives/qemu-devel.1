Received: from eggs.gnu.org ([2001:4830:134:3::10]:59664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyLZ8-00049C-TG
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyLZ5-0007yR-0k
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:00:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50332 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyLZ4-0007x7-Rk
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:00:50 -0400
References: <20180320173324.30844-1-fl@n621.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <48d11603-23ba-ddbb-34a6-8ba345ac5d28@redhat.com>
Date: Tue, 20 Mar 2018 13:00:40 -0500
MIME-Version: 1.0
In-Reply-To: <20180320173324.30844-1-fl@n621.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] os: truncate pidfile on creation
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

On 03/20/2018 12:33 PM, Florian Larysch wrote:
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
> seems to be an improvement, as it at least prevents garbled pidfiles.
> 
> Signed-off-by: Florian Larysch <fl@n621.de>
> ---

Here after the --- is a nice place to summarize how v3 differs from v2, 
to save reviewers some time.  In this particular case, it looks like all 
you did was correct a commit message typo in v2; at which point, since I 
gave Reviewed-by on v2, you could have pasted that into your amended v3 
commit message to make it obvious that you didn't change the code.  At 
any rate, my R-b still stands.

Also, if all that is wrong is a typo in the commit message, a maintainer 
is often willing to fix that up without you having to send a new 
revision, especially since the maintainer has to edit the commit message 
anyways to add their Signed-off-by.  But you are also correct that a new 
revision CAN save a maintainer time, in part because adding S-o-b can be 
done by machine alone, so it is not a worthless exercise on your part to 
send a respin just for typos.

>   os-posix.c | 6 ++++++
>   os-win32.c | 2 +-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
