Received: from eggs.gnu.org ([2001:4830:134:3::10]:54367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1crOQz-0000n9-SW
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 08:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1crOQy-0003h9-SI
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 08:35:13 -0400
Date: Fri, 24 Mar 2017 13:34:58 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Making QMP 'block-job-cancel' transactionable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, eblake@redhat.com

While debugging some other issue, I happened to stumble across an old
libvirt commit[*] that adds support for pivot (whether QEMU should
switch to a target copy or not) operation as a result of issuing QMP
'block-job-cancel' to a 'drive-mirror' (in libvirt parlance, "block
copy").

In the libvirt commit message[*] Eric Blake writes:

    "[...] There may be potential improvements to the snapshot code to
    exploit block copy over multiple disks all at one point in time.
    And, if 'block-job-cancel' were made part of 'transaction', you
    could copy multiple disks at the same point in time without pausing
    the domain. [...]"

I realize that 'block-job-cancel' is currently not part of the
@TransactionAction.  Is it worthwhile to do so?

Given the current behavior of QMP 'drive-mirror':

  - Upon 'block-job-complete', synchronization will end, and live QEMU
    pivots to the target (i.e. the copy)

  - Upon 'block-job-cancel', a point-in-time (at the time of cancel)
    copy gets created, and live QEMU will _not_ pivot.

I realize that it is not possible to perform a "block copy" of multiple
disks at the same point in time without pausing QEMU.  From a brief chat
with Stefan Hajnoczi on IRC, he does confirm that there's no current API
for doing it atomically across multiple disks.

Since Stefan asked if a bug exists for adding 'transaction' support to
'block-job-cancel', thought I might bring it up here first.


[*] https://libvirt.org/git/?p=libvirt.git;a=commit;h=eaba79d --
    blockjob: support pivot operation on cancel

-- 
/kashyap
