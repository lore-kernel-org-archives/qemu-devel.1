Received: from eggs.gnu.org ([2001:4830:134:3::10]:48864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fNjPN-0005gb-8m
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fNjPM-00044J-Co
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:31:45 -0400
Date: Tue, 29 May 2018 14:31:36 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180529183136.GK6999@localhost.localdomain>
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-7-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525163327.23097-7-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 06/14] qemu-iotests: Add
 VM.qmp_log()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

On Fri, May 25, 2018 at 06:33:19PM +0200, Kevin Wolf wrote:
> This adds a helper function that logs both the QMP request and the
> received response before returning it.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 17aa7c88dc..319d898172 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -206,6 +206,10 @@ def filter_qmp_event(event):
>          event['timestamp']['microseconds'] = 'USECS'
>      return event
>  
> +def filter_testfiles(msg):
> +    prefix = os.path.join(test_dir, "%s-" % (os.getpid()))
> +    return msg.replace(prefix, 'TEST_DIR/')
> +

Either as-is, or with the suggestion by Max to add the PID to the output:

Reviewed-by: Jeff Cody <jcody@redhat.com>


>  def log(msg, filters=[]):
>      for flt in filters:
>          msg = flt(msg)
> @@ -389,6 +393,13 @@ class VM(qtest.QEMUQtestMachine):
>              result.append(filter_qmp_event(ev))
>          return result
>  
> +    def qmp_log(self, cmd, **kwargs):
> +        logmsg = "{'execute': '%s', 'arguments': %s}" % (cmd, kwargs)
> +        log(filter_testfiles(logmsg))
> +        result = self.qmp(cmd, **kwargs)
> +        log(result)
> +        return result
> +
>  
>  index_re = re.compile(r'([^\[]+)\[([^\]]+)\]')
>  
> -- 
> 2.13.6
> 
> 
