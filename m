Received: from eggs.gnu.org ([2001:4830:134:3::10]:52877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cv8bJ-0002xM-6c
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 16:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cv8bH-0004k9-TW
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 16:29:21 -0400
References: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
From: John Snow <jsnow@redhat.com>
Message-ID: <0e1c78f3-1b82-58e4-035e-944484e66f29@redhat.com>
Date: Mon, 3 Apr 2017 16:29:11 -0400
MIME-Version: 1.0
In-Reply-To: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] Making QMP 'block-job-cancel'
 transactionable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org



On 03/24/2017 08:34 AM, Kashyap Chamarthy wrote:
> While debugging some other issue, I happened to stumble across an old
> libvirt commit[*] that adds support for pivot (whether QEMU should
> switch to a target copy or not) operation as a result of issuing QMP
> 'block-job-cancel' to a 'drive-mirror' (in libvirt parlance, "block
> copy").
> 
> In the libvirt commit message[*] Eric Blake writes:
> 
>     "[...] There may be potential improvements to the snapshot code to
>     exploit block copy over multiple disks all at one point in time.
>     And, if 'block-job-cancel' were made part of 'transaction', you
>     could copy multiple disks at the same point in time without pausing
>     the domain. [...]"
> 

Oh, you want a transactional cancel to basically capitalize on the
second completion mode of the mirror job.

I have never really cared for the way this job works, because I don't
think "canceling" a ready job is semantically valid (it's not canceled!
We completed successfully, just using a different completion mode) --
but if I am in the minority here I would cede that a transactional
cancel would be a worthwhile thing to have.

I think at other points we have discussed the concept of having a
configurable completion mode that jobs could have (and allowing this
setting to be adjusted at runtime) that changes which completion mode
they'll pursue.

This would make a cancel unambiguously a cancellation. It would make a
non-pivot completion to a mirror action an unambiguous success, too.

Minor nit, perhaps, but I want to be sure before we cement the semantics
of how mirror can be "successful."

--js

> I realize that 'block-job-cancel' is currently not part of the
> @TransactionAction.  Is it worthwhile to do so?
> 
> Given the current behavior of QMP 'drive-mirror':
> 
>   - Upon 'block-job-complete', synchronization will end, and live QEMU
>     pivots to the target (i.e. the copy)
> 
>   - Upon 'block-job-cancel', a point-in-time (at the time of cancel)
>     copy gets created, and live QEMU will _not_ pivot.
> 
> I realize that it is not possible to perform a "block copy" of multiple
> disks at the same point in time without pausing QEMU.  From a brief chat
> with Stefan Hajnoczi on IRC, he does confirm that there's no current API
> for doing it atomically across multiple disks.
> 
> Since Stefan asked if a bug exists for adding 'transaction' support to
> 'block-job-cancel', thought I might bring it up here first.
> 
> 
> [*] https://libvirt.org/git/?p=libvirt.git;a=commit;h=eaba79d --
>     blockjob: support pivot operation on cancel
> 
