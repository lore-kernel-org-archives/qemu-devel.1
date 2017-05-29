Received: from eggs.gnu.org ([2001:4830:134:3::10]:35567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dFPx0-0002rZ-2A
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dFPwy-00018u-Qd
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:03:34 -0400
Date: Mon, 29 May 2017 21:03:22 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170529190322.xc2e2uh7wp6hlcs6@eukaryote>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [RFC] Making 'block-stream',
 and 'block-commit' accept node-name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, berto@igalia.com

Observe the following ('qmp-shell', for brevity) invocation of the four
major types (stream, commit, mirror, backup) of live block operations:

    (QEMU) block-stream device=node-D base=a.qcow2 job-id=job-block-stream
    (QEMU) block-commit device=node-D base=a.qcow2 top=b.qcow2 job-id=job-block-commit
    (QEMU) drive-mirror device=node-D target=e.qcow2 sync=full job-id=job-drive-mirror
    (QEMU) drive-backup device=node-D sync=full target=e.qcow2 job-id=job-drive-backup
    (QEMU) blockdev-backup device=node-B target=node-E sync=full job-id=job-blockdev-backup
    (QEMU) blockdev-mirror device=node-D target=node-E sync=full job-id=job-blockdev-mirror

While we have `blockdev-{mirror, backup}` as 'node-name'-alternatives
for `drive-{mirror, backup}`, as the eagle-eyed will, the `block-stream`
and `block-commit` commands still operate on file names for parameters
'base' and 'top'. 

When I brought it up on #qemu, OFTC, where Max gave some context, and
even said: "We just shouldn't use filenames there ['commit', 'stream'],
simple as that".

Does upstream have a plan here for 2.10 / 3.0?  Will there be new
`blockdev-stream`, and `blockdev-commit`, or will `block-{stream,
commit}` will be adjusted to take 'node-name'?

* * *

Then I _vaguely_ remembered reading a thread on the upstream list about
creating a new 'blockdev-stream' (but I didn't find anything about
'blockdev-commit'), even if a bit confusing.  Sure enough, when I went
digging the archives, I found, where Alberto extended the 'device'
parameter to take 'node-name', and there was an ensuing discussion about
a new 'blockdev-stream':

    https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg03236.html
    -- [PATCH v11 00/19] Support streaming to an intermediate layer

And this patch had the said discussion:

    https://lists.gnu.org/archive/html/qemu-block/2016-10/msg00117.html

tl;dr seemed to be: "add a new `blockdev-stream` [and
`blockdev-commit`?] because it is easy to introspect, and is a 'saner'
interface".

To recap from that thread, Kevin wrote[1]:

    "Oh, we still have those filename-based parameters? :-/

    "Should we introduce a new, clean blockdev-stream command that fixes
    this and matches the common name pattern? Of course, block-stream
    vs.  blockdev-stream could be a bit confusing, too..."

And, Eric seemed agreeable to a new command[2], saying, "a new command
is easy to introspect".

Markus chimed in[3] with some background context, and a design
discussion aobut whether it makes sense to extend existing commands vs.
adding new, giving pros / cons of both.

Finally, Kevin concluded[4]:

    "It has never been a sane interface in the first place (identifying
    a backing file node by its filename).
    
    "We ended up having two versions of all block job commands anyway
    (one that creates an image file, and later one that just takes a
    node-name of an existing node), except for image streaming so far.
    So it would be consistent (and enable consistent naming for the
    preferred commands) to have it here, too."

[1] https://lists.gnu.org/archive/html/qemu-block/2016-10/msg00319.html
[2] https://lists.gnu.org/archive/html/qemu-block/2016-10/msg00328.html 
[3] https://lists.gnu.org/archive/html/qemu-block/2016-10/msg00333.html
[4] https://lists.gnu.org/archive/html/qemu-block/2016-10/msg00354.html

-- 
/kashyap
