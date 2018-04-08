Received: from eggs.gnu.org ([2001:4830:134:3::10]:55598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f56Eg-0001hR-4b
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 05:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f56Eb-0001ti-5Q
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 05:03:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f56Eb-0001rT-0K
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 05:03:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EEB6C81A88A1
	for <qemu-devel@nongnu.org>; Sun,  8 Apr 2018 09:03:31 +0000 (UTC)
Date: Sun, 8 Apr 2018 17:03:21 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180408090321.GA2862@lemon.usersys.redhat.com>
References: <20180408030542.17855-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408030542.17855-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] iotests: fix wait_until_completed()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On Sun, 04/08 11:05, Peter Xu wrote:
> If there are more than one events, wait_until_completed() might return
> the 2nd event even if the 1st event is JOB_COMPLETED, since the for loop
> will continue to run even if completed is set to True.
> 
> It never happened before, but it can be triggered when OOB is enabled
> due to the RESUME startup message. Fix that up.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index b5d7945af8..119c8e270a 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -470,18 +470,15 @@ class QMPTestCase(unittest.TestCase):
>  
>      def wait_until_completed(self, drive='drive0', check_offset=True):
>          '''Wait for a block job to finish, returning the event'''
> -        completed = False
> -        while not completed:
> +        while True:
>              for event in self.vm.get_qmp_events(wait=True):
>                  if event['event'] == 'BLOCK_JOB_COMPLETED':
>                      self.assert_qmp(event, 'data/device', drive)
>                      self.assert_qmp_absent(event, 'data/error')
>                      if check_offset:
>                          self.assert_qmp(event, 'data/offset', event['data']['len'])
> -                    completed = True
> -
> -        self.assert_no_active_block_jobs()
> -        return event
> +                    self.assert_no_active_block_jobs()
> +                    return event
>  
>      def wait_ready(self, drive='drive0'):
>          '''Wait until a block job BLOCK_JOB_READY event'''
> -- 
> 2.14.3
> 
> 

Reviewed-by: Fam Zheng <famz@redhat.com>
