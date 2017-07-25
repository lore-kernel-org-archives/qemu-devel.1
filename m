Received: from eggs.gnu.org ([2001:4830:134:3::10]:54247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1da5rP-0003Kr-Do
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1da5rL-0005K5-DH
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:51:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1da5rL-0005Jf-6l
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 15:51:11 -0400
Date: Tue, 25 Jul 2017 16:51:04 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170725195104.GT2757@localhost.localdomain>
References: <20170725171014.25193-1-apahim@redhat.com>
	<20170725171014.25193-4-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170725171014.25193-4-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 3/6] qemu.py: cleanup message on
 negative exit code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, famz@redhat.com, berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com

On Tue, Jul 25, 2017 at 07:10:11PM +0200, Amador Pahim wrote:
> The message contains the self._args, which has only part of the
> options used in the qemu command line and is not representative
> enough to figure out what happened to the process.
> 
> This patch drops the self._args part of the message.
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>

I actually think it is a very useful debugging message as is,
because the command-line arguments are often all we need to
reproduce a QEMU crash.

That said, sys.stderr.write doesn't belong to the QEMUMachine
code, as callers should decide if/when/how/where to print
information about a QEMU crash.

I think a QEMUCrashed exception class would be the best way to
report that to callers.  Including the full QEMU command-line on
the exception __str__ method would make it helpful when debugging
crashes: existing code that doesn't catch launch() exceptions
will crash with a more helpful stack trace, and code that already
catches exceptions is probably going to print exception info
somewhere.


> ---
>  scripts/qemu.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index f37e2fe58e..56142ed59b 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -154,7 +154,8 @@ class QEMUMachine(object):
>  
>              exitcode = self._popen.wait()
>              if exitcode < 0:
> -                sys.stderr.write('qemu received signal %i: %s\n' % (-exitcode, ' '.join(self.args)))
> +                sys.stderr.write('qemu received signal %i\n' % -exitcode)
> +
>              self._load_io_log()
>              self._post_shutdown()
>  
> -- 
> 2.13.3
> 

-- 
Eduardo
