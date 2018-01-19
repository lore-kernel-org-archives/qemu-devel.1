Received: from eggs.gnu.org ([2001:4830:134:3::10]:36668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecaTs-0002Kn-6S
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecaTo-0000h9-TQ
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:29:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecaTo-0000go-L3
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:29:28 -0500
Date: Fri, 19 Jan 2018 15:29:21 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180119172921.GD15832@localhost.localdomain>
References: <20171114102246.22221-1-apahim@redhat.com>
	<20171114102246.22221-4-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171114102246.22221-4-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v11 3/8] qemu.py: refactor launch()
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

On Tue, Nov 14, 2017 at 11:22:41AM +0100, Amador Pahim wrote:
> This is just an refactor to separate the exception handler from the
> actual launch procedure, improving the readability and making future
> maintenances in this piece of code easier.
> 
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Amador Pahim <apahim@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

The only thing preventing me from queueing it right now is the
dependency on patch 2/8.

> ---
>  scripts/qemu.py | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index d5b1cde044..28aa3712c7 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -202,20 +202,14 @@ class QEMUMachine(object):
>              self._temp_dir = None
>  
>      def launch(self):
> -        '''Launch the VM and establish a QMP connection'''
> +        """
> +        Launch the VM and make sure we cleanup and expose the
> +        command line/output in case of exception
> +        """
>          self._iolog = None
>          self._qemu_full_args = None
> -        devnull = open(os.path.devnull, 'rb')
>          try:
> -            self._pre_launch()
> -            self._qemu_full_args = (self._wrapper + [self._binary] +
> -                                    self._base_args() + self._args)
> -            self._popen = subprocess.Popen(self._qemu_full_args,
> -                                           stdin=devnull,
> -                                           stdout=self._qemu_log_file,
> -                                           stderr=subprocess.STDOUT,
> -                                           shell=False)
> -            self._post_launch()
> +            self._launch()
>          except:
>              if self.is_running():
>                  self._popen.kill()
> @@ -230,6 +224,19 @@ class QEMUMachine(object):
>                  LOG.debug('Output: %r', self._iolog)
>              raise
>  
> +    def _launch(self):
> +        '''Launch the VM and establish a QMP connection'''
> +        devnull = open(os.path.devnull, 'rb')
> +        self._pre_launch()
> +        self._qemu_full_args = (self._wrapper + [self._binary] +
> +                                self._base_args() + self._args)
> +        self._popen = subprocess.Popen(self._qemu_full_args,
> +                                       stdin=devnull,
> +                                       stdout=self._qemu_log_file,
> +                                       stderr=subprocess.STDOUT,
> +                                       shell=False)
> +        self._post_launch()
> +
>      def wait(self):
>          '''Wait for the VM to power off'''
>          self._popen.wait()
> -- 
> 2.13.6
> 
> 

-- 
Eduardo
