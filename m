Received: from eggs.gnu.org ([2001:4830:134:3::10]:50491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eMWLe-0002im-3U
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eMWLd-0005ls-8N
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:50:38 -0500
References: <20171128071409.21887-1-vsementsov@virtuozzo.com>
	<20171128071409.21887-4-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9ddd977f-ece1-7022-0e66-78b377621b20@virtuozzo.com>
Date: Wed, 6 Dec 2017 12:50:24 +0300
MIME-Version: 1.0
In-Reply-To: <20171128071409.21887-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 3/4] scripts/qemu.py: tiny enhancement for
 event_wiat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

let's just drop this patch.

28.11.2017 10:14, Vladimir Sementsov-Ogievskiy wrote:
> - add comment
> - allow int timeout and disallow bool (which has special
>    meaning for pull_event())
> - remove unreachable 'return None'
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   scripts/qemu.py | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 9bfdf6d37d..8763335254 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -291,7 +291,13 @@ class QEMUMachine(object):
>           branch processing on match's value None
>              {"foo": {"bar": 1}} matches {"foo": None}
>              {"foo": {"bar": 1}} does not matches {"foo": {"baz": None}}
> +
> +        @raise QMPTimeoutError: If timeout period elapses.
> +        @raise QMPConnectError: If some other error occurred.
>           '''
> +
> +        assert isinstance(timeout, float) or isinstance(timeout, int)
> +
>           def event_match(event, match=None):
>               if match is None:
>                   return True
> @@ -316,13 +322,11 @@ class QEMUMachine(object):
>   
>           # Poll for new events
>           while True:
> -            event = self._qmp.pull_event(wait=timeout)
> +            event = self._qmp.pull_event(wait=float(timeout))
>               if (event['event'] == name) and event_match(event, match):
>                   return event
>               self._events.append(event)
>   
> -        return None
> -
>       def get_log(self):
>           '''
>           After self.shutdown or failed qemu execution, this returns the output


-- 
Best regards,
Vladimir
