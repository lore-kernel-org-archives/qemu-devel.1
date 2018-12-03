Received: from eggs.gnu.org ([2001:4830:134:3::10]:41011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=86815d540=anthony.perard@citrix.com>)
	id 1gTr1P-0002Gw-GU
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=86815d540=anthony.perard@citrix.com>)
	id 1gTr1K-0000pC-9E
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:24:35 -0500
Date: Mon, 3 Dec 2018 16:24:24 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181203162424.GM14786@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-8-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181121151211.15997-8-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 07/18] xen: add event channel interface for
 XenDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>

On Wed, Nov 21, 2018 at 03:12:00PM +0000, Paul Durrant wrote:
> The legacy PV backend infrastructure provides functions to bind, unbind
> and send notifications to event channnels. Similar functionality will be
> required by XenDevice implementations so this patch adds the necessary
> support.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> +void xen_device_notify_event_channel(XenDevice *xendev,
> +                                     XenEventChannel *channel)
> +{
> +    xenevtchn_notify(xendev->xeh, channel->local_port);

Since xenevtchn_notify and xenevtchn_unbind below can fail, it will be
nice to check for error and grab the errno.

Users of xen_device_notify_event_channel could simply ignore the error,
or just print a warning/error and continue
(warn_report_err/error_report_err).

> +}
> +
> +void xen_device_unbind_event_channel(XenDevice *xendev,
> +                                     XenEventChannel *channel)
> +{
> +    notifier_remove(&channel->notifier);
> +
> +    xenevtchn_unbind(xendev->xeh, channel->local_port);
> +
> +    g_free(channel);
> +}
> +


> +static void xen_device_event(void *opaque)
> +{
> +    XenDevice *xendev = opaque;
> +    unsigned long port = xenevtchn_pending(xendev->xeh);
> +
> +    notifier_list_notify(&xendev->event_notifiers, (void *)port);

I wonder if a Notifier is a good fit for XenDevice, like here for the
events or the xenstore watches in previous patches, as NotifierLists are
normaly used when every Notifiers want to do something, but here there
is only one that is going to do something. But I guess it might not be
much better to write a loop in here rather than use the one in
notifier_list_notify.

> +
> +    xenevtchn_unmask(xendev->xeh, port);
> +}
> +

-- 
Anthony PERARD
