Received: from eggs.gnu.org ([2001:4830:134:3::10]:59191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY9xM-00035Z-0l
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dY9xL-0002Qa-83
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:49:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dY9xL-0002QI-1g
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:49:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E6871C058EDC
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 11:49:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170720091902.22476-1-apahim@redhat.com>
	<20170720091902.22476-2-apahim@redhat.com>
Date: Thu, 20 Jul 2017 13:49:15 +0200
In-Reply-To: <20170720091902.22476-2-apahim@redhat.com> (Amador Pahim's
	message of "Thu, 20 Jul 2017 11:19:00 +0200")
Message-ID: <87inin1g78.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qemu.py: fix is_running()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ldoktor@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, crosa@redhat.com, famz@redhat.com

Amador Pahim <apahim@redhat.com> writes:

> Current implementation is broken. It does not really test if the child
> process is running.

What usage exactly is broken by this?  Got a reproducer for me?

> The Popen.returncode will only be set after by a poll(), wait() or
> communicate(). If the Popen fails to launch a VM, the Popen.returncode
> will not turn to None by itself.

Hmm.  What is the value of .returncode then?

> Instead of using Popen.returncode, let's use Popen.poll(), which
> actually checks if child process has terminated.
>
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
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
               return None
           return self._popen.returncode

Why is this one safe?
