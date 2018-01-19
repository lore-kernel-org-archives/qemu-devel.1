Received: from eggs.gnu.org ([2001:4830:134:3::10]:40629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecabS-0007Ef-0C
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecabO-0006YP-Oq
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:37:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecabO-0006YA-IY
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:37:18 -0500
Date: Fri, 19 Jan 2018 15:37:05 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180119173705.GF15832@localhost.localdomain>
References: <20171114102246.22221-1-apahim@redhat.com>
	<20171114102246.22221-6-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171114102246.22221-6-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v11 5/8] qemu.py: use poll() instead of
 'returncode'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, crosa@redhat.com, muriloo@linux.vnet.ibm.com

On Tue, Nov 14, 2017 at 11:22:43AM +0100, Amador Pahim wrote:
> The 'returncode' Popen attribute is not guaranteed to be updated. It
> actually depends on a call to either poll(), wait() or communicate().
> 
> On the other hand, poll() will: "Check if child process has terminated.
> Set and return returncode attribute."
> 
> Let's use the poll() to check whether the process is running and to get
> the updated process exit code, when the process is finished.
> 
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 7bd10b1a1d..d3824a7a0b 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -149,12 +149,12 @@ class QEMUMachine(object):
>              raise
>  
>      def is_running(self):
> -        return self._popen is not None and self._popen.returncode is None
> +        return self._popen is not None and self._popen.poll() is None

This should be safe now, after patch 4/8.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
