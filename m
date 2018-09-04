Received: from eggs.gnu.org ([2001:4830:134:3::10]:35994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxH1t-0006rf-Fw
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 15:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxH1r-0000j1-Em
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 15:30:25 -0400
References: <20180831222907.16257-1-jsnow@redhat.com>
	<20180831222907.16257-6-jsnow@redhat.com>
	<b79cdffa-a0d4-824c-b9fd-b5aba38e61bd@redhat.com>
	<00da6ab1-d2ca-8d66-7e22-8fc848b9d861@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ab14bcff-ae29-f1ce-a694-8aa2a4b63ac9@redhat.com>
Date: Tue, 4 Sep 2018 14:30:00 -0500
MIME-Version: 1.0
In-Reply-To: <00da6ab1-d2ca-8d66-7e22-8fc848b9d861@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 05/15] block/mirror: don't install
 backing chain on abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jtc@redhat.com, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jeff Cody <jcody@redhat.com>

On 09/04/2018 02:15 PM, John Snow wrote:

> 
> post-script: I really, really hate the "fake cancel" we've implemented
> for mirror. It makes the job logic so much worse.

Mirror really does have a tri-state way to end the job (and accessible 
only after the job has moved into the sync state):

cancel (gracefully end the job by detaching the mirror, so that the 
original volume remains active - your "fake cancel")
complete (gracefully end the job by pivoting to the mirror, so that the 
original volume is now the backup)
cancel --force (end the job now, even though it means you did not 
actually create a mirrored copy) - only useful since commit b76e4458 (2.12)

The first two are conceptually similar - the job succeeds, and one of 
the two files used in the mirroring is now the state of the other at the 
time the job concluded.

Back-compat says we can't really change the block-job terminology 
without an adequate deprecation cycle (and I don't know if libvirt has 
even been taught about cancel --force yet); but for the newer 'job' 
functionality (which we tried to shoehorn existing block jobs into), it 
does seem like it would be nicer to have 'cancel' mean what blockjob 
cancel --force implies, and instead focus on teaching 'complete' to have 
a way to select which of the two completion modes are desired (complete 
by return to original, or complete by pivot to mirror).  It might even 
be nice to have a way to specify which completion mode to default to at 
job creation time, and/or to change that default as the job is running 
(which also implies being able to query which completion mode is 
currently tied to the job, if you can complete without requesting either 
of the two modes explicitly).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
