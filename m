Received: from eggs.gnu.org ([2001:4830:134:3::10]:56305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVGwC-0005fl-82
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVGw9-00066M-N3
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:44:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35368 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVGw9-00066C-Im
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:44:45 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180619053426.13065-1-peterx@redhat.com>
	<20180619053426.13065-3-peterx@redhat.com>
Date: Tue, 19 Jun 2018 15:44:30 +0200
In-Reply-To: <20180619053426.13065-3-peterx@redhat.com> (Peter Xu's message of
	"Tue, 19 Jun 2018 13:34:21 +0800")
Message-ID: <87h8lyvqkh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 2/7] monitor: rename *_pop_one to
 *_pop_any
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Eric Auger <eric.auger@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> The old names are confusing since both of the old functions are poping
> an item from multiple queues rather than a single queue.  In that
> sense, *_pop_any() suites better than *_pop_one().
>
> Since at it, touch up the function monitor_qmp_response_pop_any() a bit
> to let the callers pass in a QMPResponse struct instead of returning a
> struct.  Change the return value to boolean to mark whether we have
> poped a valid response instead.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 6d0cec552e..d4a463f707 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -513,10 +513,10 @@ struct QMPResponse {
>  typedef struct QMPResponse QMPResponse;
>  
>  /*
> - * Return one QMPResponse.  The response is only valid if
> - * response.data is not NULL.
> + * Pop a QMPResponse from any monitor's response queue into @response.
> + * Return false if all the queues are empty; else true.
>   */
> -static QMPResponse monitor_qmp_response_pop_one(void)
> +static bool monitor_qmp_response_pop_any(QMPResponse *response)
>  {
>      Monitor *mon;
>      QObject *data = NULL;

I'd return @response.  Matter of taste.

With Eric's spelling fixes:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

[...]
