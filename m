Received: from eggs.gnu.org ([2001:4830:134:3::10]:46843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLs6h-0006dL-PX
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLs6d-0000F1-3m
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:24:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33980 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fLs6c-0000DJ-US
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:24:43 -0400
References: <1527174955-160019-1-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <009bd837-74de-46a3-ffb8-9685213ba9c4@redhat.com>
Date: Thu, 24 May 2018 10:24:40 -0500
MIME-Version: 1.0
In-Reply-To: <1527174955-160019-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/1] libqtest: add more exit status checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>

On 05/24/2018 10:17 AM, Michael S. Tsirkin wrote:
> Add more checks on how did QEMU exit.
> 
> Legal ways to exit right now:
> - exit(0) or return from main
> - kill(SIGTERM) - sent by testing infrastructure

Yes, but kill(SIGTERM) causes qemu proper to exit with status 0, because 
we handle the signal rather than letting it have default behavior or 
rethrowing it.

> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> ---
> 
> TODO: refactor testing infrastructure to stop
> QEMU through QMP as opposed to SIGTERM.

>           if (pid == s->qemu_pid && WIFSIGNALED(wstatus)) {
> +            /* Core dump is never OK */
>               assert(!WCOREDUMP(wstatus));
> +            /* Either exit normally or get killed */
> +            assert((WIFEXITED(wstatus) || WIFSIGNALED(wstatus)));

Eww. This is true if someone does SIGKILL, but not if someone does SIGTERM.

> +            /* Exited normally - check exit status. */
> +            assert(!WIFEXITED(wstatus) || WEXITSTATUS(wstatus) == 0);

This is fine.

> +            /* Killed - we only ever send SIGTERM. */
> +            assert(!WIFSIGNALED(wstatus) || WTERMSIG(wstatus) == SIGTERM);

But this is bogus.  Sending SIGTERM does NOT cause WIFSIGNALED(); you'd 
be hard-pressed to get qemu to exit with WTERMSIG(wstatus) == SIGTERM.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
