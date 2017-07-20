Received: from eggs.gnu.org ([2001:4830:134:3::10]:57144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dY1Oe-0002wj-MN
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 22:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dY1Ob-0000tl-Kd
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 22:41:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dY1Ob-0000st-E2
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 22:40:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E520C04B317
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 02:40:56 +0000 (UTC)
Date: Thu, 20 Jul 2017 10:40:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170720024027.GC11032@lemon>
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
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ldoktor@redhat.com, ehabkost@redhat.com, armbru@redhat.com, mreitz@redhat.com, crosa@redhat.com

On Wed, 07/19 18:31, Amador Pahim wrote:
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
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
