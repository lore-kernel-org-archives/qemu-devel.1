Received: from eggs.gnu.org ([2001:4830:134:3::10]:33951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHvvU-0001IQ-1K
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 12:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHvvQ-0006n8-2D
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 12:04:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cHvvP-0006mm-TH
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 12:04:04 -0500
Date: Fri, 16 Dec 2016 17:03:57 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20161216170357.GD2642@work-vm>
References: <1478265017-5700-1-git-send-email-thuth@redhat.com>
	<87wpg5di5o.fsf@emacs.mitica>
	<20161117034511.GG18808@umbus.fritz.box>
	<b20c6b22-fc3a-b37a-6ea0-169be815864a@redhat.com>
	<401600f0-8a1c-22c7-b9f3-7424426ec699@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401600f0-8a1c-22c7-b9f3-7424426ec699@redhat.com>
Subject: Re: [Qemu-devel] Is block_save_iterate() dead code? (was:
 migration: Fix return code of ram_save_iterate() )
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Juan Quintela <quintela@redhat.com>, Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org

* Thomas Huth (thuth@redhat.com) wrote:
> On 18.11.2016 09:13, Thomas Huth wrote:
> > On 17.11.2016 04:45, David Gibson wrote:
> >> On Mon, Nov 14, 2016 at 07:34:59PM +0100, Juan Quintela wrote:
> >>> Thomas Huth <thuth@redhat.com> wrote:
> >>>> qemu_savevm_state_iterate() expects the iterators to return 1
> >>>> when they are done, and 0 if there is still something left to do.
> >>>> However, ram_save_iterate() does not obey this rule and returns
> >>>> the number of saved pages instead. This causes a fatal hang with
> >>>> ppc64 guests when you run QEMU like this (also works with TCG):
> >>>>
> >>>>  qemu-img create -f qcow2  /tmp/test.qcow2 1M
> >>>>  qemu-system-ppc64 -nographic -nodefaults -m 256 \
> >>>>                    -hda /tmp/test.qcow2 -serial mon:stdio
> >>>>
> >>>> ... then switch to the monitor by pressing CTRL-a c and try to
> >>>> save a snapshot with "savevm test1" for example.
> >>>>
> >>>> After the first iteration, ram_save_iterate() always returns 0 here,
> >>>> so that qemu_savevm_state_iterate() hangs in an endless loop and you
> >>>> can only "kill -9" the QEMU process.
> >>>> Fix it by using proper return values in ram_save_iterate().
> >>>>
> >>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>>
> >>> Reviewed-by: Juan Quintela <quintela@redhat.com>
> >>>
> >>> Applied.
> >>>
> >>> I don't know how we broked this so much.
> >>
> >> Note that block save iterate has the same bug...
> > 
> > I think you're right. Care to send a patch?
> 
> Looking at this issue again ... could it be that block_save_iterate() is
> currently just dead code?
> As far as I can see, the ->save_live_iterate() handlers are only called
> from qemu_savevm_state_iterate(), right? And qemu_savevm_state_iterate()
> only calls the handlers if se->ops->is_active(se->opaque) returns true.
> But block_is_active() seems to only return 0 during savevm, most likely
> because qemu_savevm_state() explicitly sets the "blk" and "shared"
> MigrationParams to zero.
> So to me, it looks like we could also just remove block_save_iterate()
> completely ... or did I miss something here?

Doesn't it get called by migrate -b ?

Dave

>  Thomas
> 
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
