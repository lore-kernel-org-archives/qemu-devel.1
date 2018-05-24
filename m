Received: from eggs.gnu.org ([2001:4830:134:3::10]:54347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLsXa-0006bS-IE
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLsXW-0007GL-NA
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:52:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53816 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fLsXW-0007Fv-Hh
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:52:30 -0400
References: <1527176250-178968-1-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d0edcb79-3dae-c3a5-f9f4-50b3062f8cff@redhat.com>
Date: Thu, 24 May 2018 10:52:26 -0500
MIME-Version: 1.0
In-Reply-To: <1527176250-178968-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/1] libqtest: add more exit status
 checks
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

On 05/24/2018 10:38 AM, Michael S. Tsirkin wrote:
> Add more checks on how did QEMU exit.
> 
> Legal ways to exit right now:
> - exit(0) or return from main
> - kill(SIGTERM) - sent by testing infrastructure
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Changes from v1:
> - drop SIGTERM as suggested by Eric
> 

> +++ b/tests/libqtest.c
> @@ -110,7 +110,12 @@ static void kill_qemu(QTestState *s)
>           pid = waitpid(s->qemu_pid, &wstatus, 0);
>   
>           if (pid == s->qemu_pid && WIFSIGNALED(wstatus)) {

Wait a moment. If WIFSIGNALED() is true...

> +            /* Core dump is never OK */
>               assert(!WCOREDUMP(wstatus));
> +            /* Must exit normally */
> +            assert(WIFEXITED(wstatus));

...then WIFEXITED() is false.  This is bogus.

> +            /* If exited normally - check exit status */
> +            assert(!WIFEXITED(wstatus) || !WEXITSTATUS(wstatus));

And you have some redundancy - !WIFEXITED() is not possible if you just 
asserted WIFEXITED().

Better would be:

if (pid == s->qemu_pid) {
     /*
      * Since sending SIGTERM turns into a normal exit, we want to flag
      * any non-normal exit, whether or not it dumped core, as a test
      * failure (even if it was a SIGKILL from someone desperate to stop
      * the testsuite).
      */
     assert(WIFEXITED(wstatus) && !WEXITSTATUS(wstatus));
}

Also, since waitpid() can only return either s->qemu_pid or -1 as we 
aren't using WNOHANG, it may also be worth asserting that if pid == -1, 
we either have EAGAIN (but why aren't we looping in that case?) or ECHILD.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
