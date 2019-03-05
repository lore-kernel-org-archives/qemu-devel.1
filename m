Received: from eggs.gnu.org ([209.51.188.92]:35069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1h13No-0007Tu-2M
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 01:16:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fangying1@huawei.com>) id 1h13Ne-00023Z-LP
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 01:16:53 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:47336 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fangying1@huawei.com>)
	id 1h13Nc-0001qS-LS
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 01:16:46 -0500
From: Ying Fang <fangying1@huawei.com>
Message-ID: <40ce0619-b2ac-1227-4a7b-5684648bc25f@huawei.com>
Date: Tue, 5 Mar 2019 14:16:22 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [BUG] VNC: client won't send FramebufferUpdateRequest
 if job in flight is aborted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: jianjay.zhou@huawei.com, "dengkai1@huawei.com" <dengkai1@huawei.com>

Hi Gerd, Daniel.

We noticed that if VncSharePolicy was configured with VNC_SHARE_POLICY_FORCE_SHARED mode and
multiple vnc clients opened vnc connections, some clients could go blank screen at high probability.
This problem can be reproduced when we regularly reboot suse12sp3 in graphic mode both
with RealVNC and noVNC client.

Then we dig into it and find out that some clients go blank screen because they don't
send FramebufferUpdateRequest any more. One step further, we notice that each time
the job in flight is aborted one client go blank screen.

The bug is triggered in the following procedure.
Guest reboot => graphic mode switch => graphic_hw_update =>  vga_update_display
=> vga_draw_graphic (full_update = 1) => dpy_gfx_replace_surface => vnc_dpy_switch =>
vnc_abort_display_jobs (client may have job in flight) => job removed from the queue
If one client has vnc job in flight, *vnc_abort_display_jobs* will wait until its job is abandoned.
This behavior is done in vnc_worker_thread_loop when 'if (job->vs->ioc == NULL || job->vs->abort == true)'
branch is taken.

As we can see, *vnc_abort_display_jobs* is intended to do some optimization to avoid unnecessary client update.
But if client sends FramebufferUpdateRequest for some graphic area and its FramebufferUpdate response job
is abandoned, the client may wait for the response and never send new FramebufferUpdateRequest, which may
case the client go blank screen forever.

So I am wondering whether we should drop the *vnc_abort_display_jobs*  optimization  or do some trick here
to push the client to send new FramebufferUpdateRequest. Do you have any idea ?
