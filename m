Received: from eggs.gnu.org ([2001:4830:134:3::10]:52683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5Z1f-0004j2-QA
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5Z1b-0007PI-Qx
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:43:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d5Z1b-0007OL-Ko
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:43:35 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1493732857-10721-1-git-send-email-den@openvz.org>
Date: Tue, 02 May 2017 16:43:32 +0200
In-Reply-To: <1493732857-10721-1-git-send-email-den@openvz.org> (Denis
	V. Lunev's message of "Tue, 2 May 2017 16:47:37 +0300")
Message-ID: <87bmrbgvzf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/1] monitor: increase amount of data for
 monitor to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

"Denis V. Lunev" <den@openvz.org> writes:

> Right now QMP and HMP monitors read 1 byte at a time from the socket, which
> is very inefficient. With 100+ VMs on the host this easily reasults in
> a lot of unnecessary system calls and CPU usage in the system.
>
> This patch changes the amount of data to read to 4096 bytes, which matches
> buffer size on the channel level. Fortunately, monitor protocol is
> synchronous right now thus we should not face side effects in reality.

Can you explain briefly why this relies on "synchronous"?  I've spent
all of two seconds on the question myself...

> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> ---
>  monitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/monitor.c b/monitor.c
> index be282ec..00df5d0 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3698,7 +3698,7 @@ static int monitor_can_read(void *opaque)
>  {
>      Monitor *mon = opaque;
>  
> -    return (mon->suspend_cnt == 0) ? 1 : 0;
> +    return (mon->suspend_cnt == 0) ? 4096 : 0;
>  }
>  
>  static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
