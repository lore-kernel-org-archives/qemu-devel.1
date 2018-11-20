Received: from eggs.gnu.org ([2001:4830:134:3::10]:37413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gPDhh-0000Q7-2d
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:37:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gPDhf-0004Nw-BJ
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:37:04 -0500
References: <20181120172252.17800-1-kwolf@redhat.com>
	<20181120172252.17800-2-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <acb65342-2927-90c1-dea3-52d373071d69@redhat.com>
Date: Tue, 20 Nov 2018 16:36:44 -0500
MIME-Version: 1.0
In-Reply-To: <20181120172252.17800-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] iotests: Replace
 time.clock() with Timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com



On 11/20/18 12:22 PM, Kevin Wolf wrote:
> time.clock() is deprecated since Python 3.3. Current Python versions
> warn that the function will be removed in Python 3.8, and those warnings
> make the test case 118 fail.
> 
> Replace it with the Timeout mechanism that is compatible with both
> Python 2 and 3, and makes the code even a little nicer.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/118 | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
> index ff3b2ae3e7..c4f4c213ca 100755
> --- a/tests/qemu-iotests/118
> +++ b/tests/qemu-iotests/118
> @@ -53,21 +53,17 @@ class ChangeBaseClass(iotests.QMPTestCase):
>          if not self.has_real_tray:
>              return
>  
> -        timeout = time.clock() + 3
> -        while not self.has_opened and time.clock() < timeout:
> -            self.process_events()
> -        if not self.has_opened:
> -            self.fail('Timeout while waiting for the tray to open')
> +        with iotests.Timeout(3, 'Timeout while waiting for the tray to open'):
> +            while not self.has_opened:
> +                self.process_events()
>  
>      def wait_for_close(self):
>          if not self.has_real_tray:
>              return
>  
> -        timeout = time.clock() + 3
> -        while not self.has_closed and time.clock() < timeout:
> -            self.process_events()
> -        if not self.has_opened:
> -            self.fail('Timeout while waiting for the tray to close')
> +        with iotests.Timeout(3, 'Timeout while waiting for the tray to close'):
> +            while not self.has_closed:
> +                self.process_events()
>  
>  class GeneralChangeTestsBaseClass(ChangeBaseClass):
>  
> 

I love the way that reads. Very cool!

Reviewed-by: John Snow <jsnow@redhat.com>
