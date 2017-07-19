Received: from eggs.gnu.org ([2001:4830:134:3::10]:54247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXtoK-0006Zh-E2
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXtoF-0005We-Hf
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:35:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXtoF-0005WP-B1
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:34:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E3FF4A701
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 18:34:54 +0000 (UTC)
Date: Wed, 19 Jul 2017 15:34:47 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170719183447.GJ2757@localhost.localdomain>
References: <20170719163108.26943-1-apahim@redhat.com>
	<20170719163108.26943-2-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170719163108.26943-2-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qemu.py: fix is_running()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com

On Wed, Jul 19, 2017 at 06:31:06PM +0200, Amador Pahim wrote:
> Current implementation is broken. It does not really test if the child
> process is running.
> 
> The Popen.returncode will only be set after by a poll(), wait() or
> communicate(). If the Popen fails to launch a VM, the Popen.returncode
> will not turn to None by itself.
> 
> Instead of using Popen.returncode, let's use Popen.poll(), which
> actually checks if child process has terminated.
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>

I vaguely remember I had a version of that code using poll() and
it broke scripts for some reason.  I will try to find out why, so
we can either fix the script or document the reason why poll()
isn't a good choice here.

> ---
>  scripts/qemu.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 880e3e8219..f0fade32bd 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -86,7 +86,7 @@ class QEMUMachine(object):
>              raise
>  
>      def is_running(self):
> -        return self._popen and (self._popen.returncode is None)
> +        return self._popen and (self._popen.poll() is None)
>  
>      def exitcode(self):
>          if self._popen is None:
> -- 
> 2.13.3
> 

-- 
Eduardo
