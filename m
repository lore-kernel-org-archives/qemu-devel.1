Received: from eggs.gnu.org ([2001:4830:134:3::10]:45055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fNspy-0001XR-9g
	for qemu-devel@nongnu.org; Wed, 30 May 2018 00:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fNspx-0005cB-EA
	for qemu-devel@nongnu.org; Wed, 30 May 2018 00:35:50 -0400
Date: Wed, 30 May 2018 00:35:41 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180530043541.GG9904@localhost.localdomain>
References: <20180529203910.7615-1-kwolf@redhat.com>
	<20180529203910.7615-9-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529203910.7615-9-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 08/16] qemu-iotests: Add VM.run_job()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

On Tue, May 29, 2018 at 10:39:02PM +0200, Kevin Wolf wrote:
> Add an iotests.py function that runs a job and only returns when it is
> destroyed. An error is logged when the job failed and job-finalize and
> job-dismiss commands are issued if necessary.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  tests/qemu-iotests/iotests.py | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index edcd2bb701..8b612cb891 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -418,6 +418,25 @@ class VM(qtest.QEMUQtestMachine):
>          log(str(result), filters)
>          return result
>  
> +    def run_job(self, job, auto_finalize=True, auto_dismiss=False):
> +        while True:
> +            for ev in self.get_qmp_events_filtered(wait=True):
> +                if ev['event'] == 'JOB_STATUS_CHANGE':
> +                    status = ev['data']['status']
> +                    if status == 'aborting':
> +                        result = self.qmp('query-jobs')
> +                        for j in result['return']:
> +                            if j['id'] == job:
> +                                log('Job failed: %s' % (j['error']))
> +                    elif status == 'pending' and not auto_finalize:
> +                        self.qmp_log('job-finalize', id=job)
> +                    elif status == 'concluded' and not auto_dismiss:
> +                        self.qmp_log('job-dismiss', id=job)
> +                    elif status == 'null':
> +                        return
> +                else:
> +                    iotests.log(ev)
> +
>  
>  index_re = re.compile(r'([^\[]+)\[([^\]]+)\]')
>  
> -- 
> 2.13.6
> 
