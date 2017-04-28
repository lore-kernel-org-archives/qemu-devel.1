Received: from eggs.gnu.org ([2001:4830:134:3::10]:41159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d44zz-0004dN-JD
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d44zw-0005jS-ER
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:27:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d44zw-0005ih-7w
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:27:44 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170428084237.23960-1-kraxel@redhat.com>
Date: Fri, 28 Apr 2017 14:27:39 +0200
In-Reply-To: <20170428084237.23960-1-kraxel@redhat.com> (Gerd Hoffmann's
	message of "Fri, 28 Apr 2017 10:42:37 +0200")
Message-ID: <87h918iuo4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] input: limit kbd queue depth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Huawei PSIRT <PSIRT@huawei.com>, P J P <ppandit@redhat.com>

Gerd Hoffmann <kraxel@redhat.com> writes:

> Apply a limit to the number of items we accept into the keyboard queue.
>
> Impact: Without this limit vnc clients can exhaust host memory by
> sending keyboard events faster than qemu feeds them to the guest.
>
> Cc: P J P <ppandit@redhat.com>
> Cc: Huawei PSIRT <PSIRT@huawei.com>
> Reported-by: jiangxin1@huawei.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/input.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/ui/input.c b/ui/input.c
> index ed88cda6d6..fb1f404095 100644
> --- a/ui/input.c
> +++ b/ui/input.c
> @@ -41,6 +41,8 @@ static QTAILQ_HEAD(QemuInputEventQueueHead, QemuInputEventQueue) kbd_queue =
>      QTAILQ_HEAD_INITIALIZER(kbd_queue);
>  static QEMUTimer *kbd_timer;
>  static uint32_t kbd_default_delay_ms = 10;
> +static uint32_t queue_count;
> +static uint32_t queue_limit = 1024;

Drive-by comment, feel free to ignore: I'd be tempted to lower the limit
to something comparable to actual hardware, then dumb down the queue to
an array.

[...]
