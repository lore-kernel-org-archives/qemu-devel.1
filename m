Received: from eggs.gnu.org ([2001:4830:134:3::10]:44258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecapJ-0006M7-Tr
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecapG-0006iQ-RQ
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:51:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecapG-0006i4-Kg
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:51:38 -0500
Date: Fri, 19 Jan 2018 15:51:22 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180119175122.GH15832@localhost.localdomain>
References: <20171114102246.22221-1-apahim@redhat.com>
	<20171114102246.22221-8-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171114102246.22221-8-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v11 7/8] qemu.py: launch vm only if it's
 not running
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

On Tue, Nov 14, 2017 at 11:22:45AM +0100, Amador Pahim wrote:
> If we allow launching VM again we will loose track of the first launched
> VM.
> 
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 305d7bd098..0b0b61be39 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -207,6 +207,9 @@ class QEMUMachine(object):
>          Launch the VM and make sure we cleanup and expose the
>          command line/output in case of exception
>          """
> +        if self.is_running():
> +            raise QEMUMachineError('VM already running')

Patch 8/8 seems to make this redundant, as is_running() can't
return True if _launched is True.

I suggest replacing this and patch 8/8 with a single check:

        if self._launched:
            raise QEMUMachineError('VM already launched')

-- 
Eduardo
