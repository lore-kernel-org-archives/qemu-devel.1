Received: from eggs.gnu.org ([2001:4830:134:3::10]:57276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dEWZy-0002kg-Pv
	for qemu-devel@nongnu.org; Sat, 27 May 2017 03:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dEWZy-0000H5-4f
	for qemu-devel@nongnu.org; Sat, 27 May 2017 03:56:06 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dEWZx-0000Gl-St
	for qemu-devel@nongnu.org; Sat, 27 May 2017 03:56:06 -0400
Received: by mail-wm0-x22f.google.com with SMTP id b84so9778178wmh.0
	for <qemu-devel@nongnu.org>; Sat, 27 May 2017 00:56:05 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 27 May 2017 09:56:03 +0200
Message-ID: <CAJSP0QU1gHgZbeBfL1y15FL9muD4G6r3MBYvVMVXTMj=GCB7oA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Throttling groups vs filter nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Manos Pitsidianakis <el13635@mail.ntua.gr>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

Throttling groups allow multiple drives to share the same throttling
state (i.e. budget) between them.  Manos is working on moving the
throttling code into a block filter driver so it is no longer
hardcoded into the I/O code path.

Throttling groups are not defined explicitly using -object syntax.
Instead they are brought into existence by referring to them by name:
-drive throttling.group=group0.

A quirk in the current implementation is that the throttling limits
for the group are overwritten by each -drive throttling.group=group0.
Limits for all but the last -drive in a group are ignored.

There is no way to associate with an existing throttling group while
keeping current limits in place.  The caller must pass in desired
limits with at least the last -drive (and with every hotplugged
drive).

The new throttling filter node could do things differently:
If *no* limits were specified (i.e. iops, bps, etc) then keep existing
limits for the group in place.

These semantics are more convenient - especially for hotplugging
drives after the guest has launched.

Manos: I suggest implementing this new behavior when you write the
throttling filter driver.  The code needs to check that all throttle
cfg fields are 0.  There are no backwards compatibility concerns since
the throttle filter is new and existing users don't rely on it.

Thoughts?

Stefan
