Received: from eggs.gnu.org ([2001:4830:134:3::10]:57834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cvOVZ-0007Cc-Pv
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cvOVY-0000tU-P5
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:28:29 -0400
Date: Tue, 4 Apr 2017 15:28:15 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170404132815.aactqo2o5izpzclf@eukaryote>
References: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
	<0e1c78f3-1b82-58e4-035e-944484e66f29@redhat.com>
	<ef9e10c4-3986-32ba-da2d-1b8f71d58319@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef9e10c4-3986-32ba-da2d-1b8f71d58319@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon, Apr 03, 2017 at 03:38:36PM -0500, Eric Blake wrote:
> On 04/03/2017 03:29 PM, John Snow wrote:
> > On 03/24/2017 08:34 AM, Kashyap Chamarthy wrote:

[...]

> >>     "[...] There may be potential improvements to the snapshot code to
> >>     exploit block copy over multiple disks all at one point in time.
> >>     And, if 'block-job-cancel' were made part of 'transaction', you
> >>     could copy multiple disks at the same point in time without pausing
> >>     the domain. [...]"
> >>
> > 
> > Oh, you want a transactional cancel to basically capitalize on the
> > second completion mode of the mirror job.
> > 
> > I have never really cared for the way this job works, because I don't
> > think "canceling" a ready job is semantically valid (it's not canceled!
> > We completed successfully, just using a different completion mode) --
> > but if I am in the minority here I would cede that a transactional
> > cancel would be a worthwhile thing to have.
> > 
> > I think at other points we have discussed the concept of having a
> > configurable completion mode that jobs could have (and allowing this
> > setting to be adjusted at runtime) that changes which completion mode
> > they'll pursue.
> 
> Indeed, having a runtime-adjustable completion mode would allow what
> libvirt wants: libvirt doesn't know what mode the user wants until they
> request virDomainBlockJobAbort() (the name is scary, but it merely means
> that they are stopping what is otherwise an unending job), and pass a
> flag that says whether they want pivot or end-point-in-time copy
> semantics.  If they request pivot semantics, libvirt invokes
> block-job-complete to do its default completion mode, if they request
> copy semantics, libvirt then switches the completion mode and still
> calls block-job-complete (which _is_ valid in a transaction).

Thanks for the nice articulation of the problem at hand, and yes --
configurable / "runtime-adjustable completion mode" would be useful for
long-running block operations.
 
> > This would make a cancel unambiguously a cancellation. It would make
> > a non-pivot completion to a mirror action an unambiguous success,
> > too.
> > 
> > Minor nit, perhaps, but I want to be sure before we cement the
> > semantics of how mirror can be "successful."
> 
> Minor or not, it is a useful viewpoint. Either way, as long as the new
> way of getting a transactional non-pivot successful completion is
> something that libvirt can learn via introspection, 

Can you elaborate a little more on the above, for my own edification --
how might it be possible for "libvirt can learn via introspection"?  Is
it via some method using the QMP 'query-commands' /
'query-command-line-options'?

> it should solve what we are hoping for here.




-- 
/kashyap
