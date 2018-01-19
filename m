Received: from eggs.gnu.org ([2001:4830:134:3::10]:44548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecaqh-0007D0-TF
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:53:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecaqh-0007Yx-5F
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:53:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecaqg-0007Xb-VG
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:53:07 -0500
Date: Fri, 19 Jan 2018 15:52:49 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180119175249.GI15832@localhost.localdomain>
References: <20171114102246.22221-1-apahim@redhat.com>
	<20171114102246.22221-9-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171114102246.22221-9-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v11 8/8] qemu.py: don't launch again before
 shutdown()
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

On Tue, Nov 14, 2017 at 11:22:46AM +0100, Amador Pahim wrote:
> If a VM is launched, files are created and a cleanup is required before
> a new launch. This cleanup is executed by shutdown(), so shutdown() must
> be called even if the VM is manually terminated (i.e. using kill).
> 
> This patch creates a control to make sure launch() will not be executed
> again if shutdown() is not called after the previous launch().
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 0b0b61be39..862920099c 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -89,6 +89,7 @@ class QEMUMachine(object):
>          self._qemu_full_args = None
>          self._test_dir = test_dir
>          self._temp_dir = None
> +        self._launched = False
>  
>          # just in case logging wasn't configured by the main script:
>          logging.basicConfig()
> @@ -210,10 +211,14 @@ class QEMUMachine(object):
>          if self.is_running():
>              raise QEMUMachineError('VM already running')
>  
> +        if self._launched:
> +            raise QEMUMachineError('Shutdown pending after previous launch')

I believe "VM already launched" would be clearer than "shutdown
pending". 

-- 
Eduardo
