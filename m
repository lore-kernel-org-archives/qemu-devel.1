Received: from eggs.gnu.org ([209.51.188.92]:50115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqNR-0002U3-52
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:23:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqNP-0006EY-8s
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:23:01 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:33796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gvqNN-0006B3-6D
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:22:59 -0500
Received: by mail-wr1-f49.google.com with SMTP id f14so19993969wrg.1
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 13:22:45 -0800 (PST)
References: <20190218180646.30282-1-mreitz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <39f0048c-c2df-2e4e-9967-5f59af077b37@redhat.com>
Date: Mon, 18 Feb 2019 22:22:43 +0100
MIME-Version: 1.0
In-Reply-To: <20190218180646.30282-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] iotests: Skip 211 on insufficient memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 2/18/19 7:06 PM, Max Reitz wrote:
> VDI keeps the whole bitmap in memory, and the maximum size (which is
> tested here) is 2 GB.  This may not be available on all machines, and it
> rarely is available when running a 32 bit build.
> 
> Fix this by making VM.run_job() return the error string if an error
> occurred, and checking whether that contains "Could not allocate bmap"
> in 211.  If so, the test is skipped.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/qemu-iotests/211        | 4 +++-
>  tests/qemu-iotests/iotests.py | 5 ++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/211 b/tests/qemu-iotests/211
> index 5d285450b5..6afc894f76 100755
> --- a/tests/qemu-iotests/211
> +++ b/tests/qemu-iotests/211
> @@ -32,7 +32,9 @@ def blockdev_create(vm, options):
>  
>      if 'return' in result:
>          assert result['return'] == {}
> -        vm.run_job('job0')
> +        error = vm.run_job('job0')
> +        if error and 'Could not allocate bmap' in error:
> +            iotests.notrun('Insufficient memory')
>      iotests.log("")
>  
>  with iotests.FilePath('t.vdi') as disk_path, \
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 387e026556..4910fb2005 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -532,7 +532,9 @@ class VM(qtest.QEMUQtestMachine):
>          log(result, filters, indent=indent)
>          return result
>  
> +    # Returns None on success, and an error string on failure
>      def run_job(self, job, auto_finalize=True, auto_dismiss=False):
> +        error = None
>          while True:
>              for ev in self.get_qmp_events_filtered(wait=True):
>                  if ev['event'] == 'JOB_STATUS_CHANGE':
> @@ -541,13 +543,14 @@ class VM(qtest.QEMUQtestMachine):
>                          result = self.qmp('query-jobs')
>                          for j in result['return']:
>                              if j['id'] == job:
> +                                error = j['error']
>                                  log('Job failed: %s' % (j['error']))
>                      elif status == 'pending' and not auto_finalize:
>                          self.qmp_log('job-finalize', id=job)
>                      elif status == 'concluded' and not auto_dismiss:
>                          self.qmp_log('job-dismiss', id=job)
>                      elif status == 'null':
> -                        return
> +                        return error
>                  else:
>                      iotests.log(ev)
>  
> 
