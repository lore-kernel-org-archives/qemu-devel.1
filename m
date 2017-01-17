Received: from eggs.gnu.org ([2001:4830:134:3::10]:42165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTYiu-0007nH-RY
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:43:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTYiq-0000iP-R5
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:43:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cTYiq-0000i0-Ig
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:43:08 -0500
Date: Tue, 17 Jan 2017 20:43:06 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170117204140-mutt-send-email-mst@kernel.org>
References: <1484270047-24579-1-git-send-email-felipe@nutanix.com>
	<20170116202220-mutt-send-email-mst@kernel.org>
	<A2D5F9F5-0EB2-4295-9233-FB1A28E8A2F3@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A2D5F9F5-0EB2-4295-9233-FB1A28E8A2F3@nutanix.com>
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: Start VQs on SET_VRING_CALL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

On Mon, Jan 16, 2017 at 06:27:12PM +0000, Felipe Franciosi wrote:
> Hi Michael,
> 
> > On 16 Jan 2017, at 10:22, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Thu, Jan 12, 2017 at 05:14:07PM -0800, Felipe Franciosi wrote:
> >> Currently, VQs are started as soon as a SET_VRING_KICK is received. That
> >> is too early in the VQ setup process, as the backend might not yet have
> >> a callfd to notify in case it received a kick and fully processed the
> >> request/command. This patch only starts a VQ when a SET_VRING_CALL is
> >> received.
> >> 
> >> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> > 
> > Doesn't look right to me.
> > It should happen when the fd supplies becomes readable.
> 
> Apologies, but I'm confused now. What should happen when which fd becomes readable? I thought we were discussing this further down in the thread. My last comments are here:
> 
> http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg02755.html
> 
> I pointed out what appears to be a race and am looking forward to your comments. There is definitely a problem with the current code, so it's a matter of finding out exactly what's happening and what's the correct (and spec-compliant) way to fix it.
> 
> Felipe


Pls review "Starting and stopping rings" (pls review all of it not just my
snippet) which has this text:
...

Client must start ring upon receiving a kick (that is, detecting that file
descriptor is readable) on the descriptor specified by
VHOST_USER_SET_VRING_KICK, and stop ring upon receiving
VHOST_USER_GET_VRING_BASE.



> > 
> >> ---
> >> contrib/libvhost-user/libvhost-user.c | 26 +++++++++++++-------------
> >> 1 file changed, 13 insertions(+), 13 deletions(-)
> >> 
> >> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> >> index af4faad..a46ef90 100644
> >> --- a/contrib/libvhost-user/libvhost-user.c
> >> +++ b/contrib/libvhost-user/libvhost-user.c
> >> @@ -607,19 +607,6 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
> >>         DPRINT("Got kick_fd: %d for vq: %d\n", vmsg->fds[0], index);
> >>     }
> >> 
> >> -    dev->vq[index].started = true;
> >> -    if (dev->iface->queue_set_started) {
> >> -        dev->iface->queue_set_started(dev, index, true);
> >> -    }
> >> -
> >> -    if (dev->vq[index].kick_fd != -1 && dev->vq[index].handler) {
> >> -        dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
> >> -                       vu_kick_cb, (void *)(long)index);
> >> -
> >> -        DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
> >> -               dev->vq[index].kick_fd, index);
> >> -    }
> >> -
> >>     return false;
> >> }
> >> 
> >> @@ -661,6 +648,19 @@ vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
> >> 
> >>     DPRINT("Got call_fd: %d for vq: %d\n", vmsg->fds[0], index);
> >> 
> >> +    dev->vq[index].started = true;
> >> +    if (dev->iface->queue_set_started) {
> >> +        dev->iface->queue_set_started(dev, index, true);
> >> +    }
> >> +
> >> +    if (dev->vq[index].kick_fd != -1 && dev->vq[index].handler) {
> >> +        dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
> >> +                       vu_kick_cb, (void *)(long)index);
> >> +
> >> +        DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
> >> +               dev->vq[index].kick_fd, index);
> >> +    }
> >> +
> >>     return false;
> >> }
> >> 
> >> -- 
> >> 1.9.4
