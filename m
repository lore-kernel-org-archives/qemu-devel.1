Received: from eggs.gnu.org ([2001:4830:134:3::10]:44024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erLBG-0001cw-6o
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:11:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erLBF-0000Vl-4L
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:11:18 -0500
Date: Thu, 1 Mar 2018 11:10:57 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180301101057.GC4862@localhost.localdomain>
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-22-jsnow@redhat.com>
	<3dfe950d-6e46-fc41-d91a-3a6c4a6a4df1@redhat.com>
	<20180228182915.GO4855@localhost.localdomain>
	<49305409-e541-d0c2-4088-4929530c9f1b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49305409-e541-d0c2-4088-4929530c9f1b@redhat.com>
Subject: Re: [Qemu-devel] [RFC v4 21/21] blockjobs: add manual_mgmt option
 to transactions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

Am 28.02.2018 um 20:24 hat John Snow geschrieben:
> 
> 
> On 02/28/2018 01:29 PM, Kevin Wolf wrote:
> > Am 27.02.2018 um 21:24 hat Eric Blake geschrieben:
> >> On 02/23/2018 05:51 PM, John Snow wrote:
> >>> This allows us to easily force the option for all jobs belonging
> >>> to a transaction to ensure consistency with how all those jobs
> >>> will be handled.
> >>>
> >>> This is purely a convenience.
> >>>
> >>> Signed-off-by: John Snow <jsnow@redhat.com>
> >>> ---
> >>
> >>> +++ b/qapi/transaction.json
> >>> @@ -79,7 +79,8 @@
> >>>   ##
> >>>   { 'struct': 'TransactionProperties',
> >>>     'data': {
> >>> -       '*completion-mode': 'ActionCompletionMode'
> >>> +       '*completion-mode': 'ActionCompletionMode',
> >>> +       '*manual-mgmt': 'bool'
> >>
> >> Missing QAPI documentation (what you have elsewhere in the C code can
> >> probably be copied here, though).
> >>
> >> The UI aspect makes sense (I can declare one manual at the transaction level
> >> instead of multiple manual declarations per member level within the
> >> transaction).
> > 
> > I'm not so sure if I like the interface, it duplicates functionality in
> > two places.
> > 
> > At th very least I would make job creation without BLOCK_JOB_MANUAL an
> > error if the transaction requires it instead of silently overriding the
> > option that was given to the individual job. But honestly, it might be
> > better to just leave this one away.
> > 
> > Kevin
> > 
> 
> Sure, I put it in the trailing position here because I see it as
> optional. I don't like the idea of having to specify manual for each and
> every item in a transaction, but if mixed-mode is possible then this is
> less important.

For management tools it shouldn't really matter if they have that one
line of code when creating TransactionProperties or in the loop that
creates the individual jobs.

> I'll leave it off for now, but I will always fondly remember it, and
> then maybe try to sneak it back in for v6.

:-)

If you try to sneak it in, just make sure that conflicting settings
result in an error rather than one of them being silently overridden.

Kevin
