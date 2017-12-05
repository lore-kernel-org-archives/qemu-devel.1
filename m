Received: from eggs.gnu.org ([2001:4830:134:3::10]:36001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eMMBj-0006iH-NV
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 17:59:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eMMBi-0002aR-Sh
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 17:59:43 -0500
References: <20171128071409.21887-1-vsementsov@virtuozzo.com>
	<20171128071409.21887-4-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <59dccfee-7c47-61d0-40a0-b67f0b7fd8cf@redhat.com>
Date: Tue, 5 Dec 2017 17:59:33 -0500
MIME-Version: 1.0
In-Reply-To: <20171128071409.21887-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/4] scripts/qemu.py: tiny
 enhancement for event_wiat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, crosa@redhat.com, den@openvz.org



On 11/28/2017 02:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> - add comment
> - allow int timeout and disallow bool (which has special
>   meaning for pull_event())
> - remove unreachable 'return None'
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  scripts/qemu.py | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 9bfdf6d37d..8763335254 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -291,7 +291,13 @@ class QEMUMachine(object):
>          branch processing on match's value None
>             {"foo": {"bar": 1}} matches {"foo": None}
>             {"foo": {"bar": 1}} does not matches {"foo": {"baz": None}}
> +
> +        @raise QMPTimeoutError: If timeout period elapses.
> +        @raise QMPConnectError: If some other error occurred.
>          '''
> +
> +        assert isinstance(timeout, float) or isinstance(timeout, int)
> +
>          def event_match(event, match=None):
>              if match is None:
>                  return True
> @@ -316,13 +322,11 @@ class QEMUMachine(object):
>  
>          # Poll for new events
>          while True:
> -            event = self._qmp.pull_event(wait=timeout)
> +            event = self._qmp.pull_event(wait=float(timeout))

Before this patch you *could* ask for no timeout, and this would block
waiting for an event. After, you can't.

Are you making the argument that it is *never* correct to ask for no
timeout?

>              if (event['event'] == name) and event_match(event, match):
>                  return event
>              self._events.append(event)
>  
> -        return None
> -
>      def get_log(self):
>          '''
>          After self.shutdown or failed qemu execution, this returns the output
> 
