Received: from eggs.gnu.org ([2001:4830:134:3::10]:53232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1frcgX-0000Ey-5H
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 01:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1frcgU-0001QZ-Hj
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 01:25:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39840 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1frcgU-0001QL-E6
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 01:24:58 -0400
Date: Mon, 20 Aug 2018 07:24:56 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180820052456.tt6joujlmhehr7aa@sirius.home.kraxel.org>
References: <20180819043509.12888-1-programmingkidx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180819043509.12888-1-programmingkidx@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/input/ps2.c: fix erratic mouse behavior
 for Windows 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org

On Sun, Aug 19, 2018 at 12:35:09AM -0400, John Arbuckle wrote:
> When the user moves the mouse and moves the scroll wheel at the same
> time, the mouse cursor's movement becomes erratic in Windows 3.1. With
> this patch if the mouse is in ps/2 mode and the scroll wheel is used,
> the command queue is reset. This does not fix the erratic mouse
> problem in Windows NT 4.0.

I don't think we need to reset the queue.  Just ignoring the z axis
value for type 0 should do.  Can you try this?

--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -661,6 +661,8 @@ static int ps2_mouse_send_packet(PS2MouseState *s)
     /* extra byte for IMPS/2 or IMEX */
     switch(s->mouse_type) {
     default:
+        s->mouse_dz = 0;
+        dz1 = 0;
         break;
     case 3:
         if (dz1 > 127)

cheers,
  Gerd
