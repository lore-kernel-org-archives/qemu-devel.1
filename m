Received: from eggs.gnu.org ([2001:4830:134:3::10]:44967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dFMEX-0008Su-Qo
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:05:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dFMEU-00061g-LX
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:05:25 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:43505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dFMEU-00061c-8Z
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:05:22 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <CAJSP0QU1gHgZbeBfL1y15FL9muD4G6r3MBYvVMVXTMj=GCB7oA@mail.gmail.com>
References: <CAJSP0QU1gHgZbeBfL1y15FL9muD4G6r3MBYvVMVXTMj=GCB7oA@mail.gmail.com>
Date: Mon, 29 May 2017 17:05:17 +0200
Message-ID: <w517f0z4sb6.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Throttling groups vs filter nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Manos Pitsidianakis <el13635@mail.ntua.gr>, Kevin Wolf <kwolf@redhat.com>

On Sat 27 May 2017 09:56:03 AM CEST, Stefan Hajnoczi wrote:
> A quirk in the current implementation is that the throttling limits
> for the group are overwritten by each -drive throttling.group=group0.
> Limits for all but the last -drive in a group are ignored.
>
> There is no way to associate with an existing throttling group while
> keeping current limits in place.  The caller must pass in desired
> limits with at least the last -drive (and with every hotplugged
> drive).

I actually just realized that passing throttling.group=group0 but no
actual limits is allowed but does nothing.

> The new throttling filter node could do things differently: If *no*
> limits were specified (i.e. iops, bps, etc) then keep existing limits
> for the group in place.

Yes, that sounds good to me. The problem here is block_set_io_throttle
(the QMP command), becuase the bps / iops parameters are mandatory, and
setting them to 0 disables the I/O limits for that device.

We can of course make them optional and if all limits are unset then we
can add a device to a throttling group. I'm not sure if that would make
the command a bit too complicated, as there are already different ways
to use it:

   - bps or iops != 0   -> set the I/O limits of a throttling group. The
                           selected device is moved to that group if it
                           wasn't there yet.

   - bps and iops == 0  -> remove a device from a throttling group
                           without touching that group's I/O limits.

and a new one would be:

   - bps and iops unset -> add a device to a throttling group, without
                           touching that group's I/O limits.

Berto
