Received: from eggs.gnu.org ([2001:4830:134:3::10]:43942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5sYz-0002Xu-C6
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5sYv-0001tE-H6
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:35:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d5sYv-0001rp-7P
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:35:17 -0400
Date: Wed, 3 May 2017 12:35:07 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170503113507.GB3985@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1493732857-10721-1-git-send-email-den@openvz.org>
	<87bmrbgvzf.fsf@dusky.pond.sub.org>
	<e90d1680-6212-862e-bd3b-fdc415ec1890@openvz.org>
	<877f1zcjcf.fsf@dusky.pond.sub.org> <20170502163629.GA5640@work-vm>
	<20170502164838.GL16624@redhat.com>
	<1dda0b40-e473-638e-7a89-891f578d3186@openvz.org>
	<87shkm2n62.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87shkm2n62.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 1/1] monitor: increase amount of data for
 monitor to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

On Wed, May 03, 2017 at 01:29:57PM +0200, Markus Armbruster wrote:
> "Denis V. Lunev" <den@openvz.org> writes:
> 
> > On 05/02/2017 07:48 PM, Daniel P. Berrange wrote:
> >> On Tue, May 02, 2017 at 05:36:30PM +0100, Dr. David Alan Gilbert wrote:
> >>> * Markus Armbruster (armbru@redhat.com) wrote:
> >>>> "Denis V. Lunev" <den@openvz.org> writes:
> >>>>
> >>>>> On 05/02/2017 05:43 PM, Markus Armbruster wrote:
> >>>>>> "Denis V. Lunev" <den@openvz.org> writes:
> >>>>>>
> >>>>>>> Right now QMP and HMP monitors read 1 byte at a time from the socket, which
> >>>>>>> is very inefficient. With 100+ VMs on the host this easily reasults in
> >>>>>>> a lot of unnecessary system calls and CPU usage in the system.
> >>>>>>>
> >>>>>>> This patch changes the amount of data to read to 4096 bytes, which matches
> >>>>>>> buffer size on the channel level. Fortunately, monitor protocol is
> >>>>>>> synchronous right now thus we should not face side effects in reality.
> >>>>>> Can you explain briefly why this relies on "synchronous"?  I've spent
> >>>>>> all of two seconds on the question myself...
> >>>>> Each command is processed in sequence as it appears in the
> >>>>> channel. The answer to the command is sent and only after that
> >>>>> next command is processed.
> >>>> Yes, that's how QMP works.
> >>>>
> >>>>> Theoretically tith asynchronous processing we can have some side
> >>>>> effects due to changed buffer size.
> >>>> What kind of side effects do you have in mind?
> >>>>
> >>>> It's quite possible that this obviously inefficient way to read had some
> >>>> deep reason back when it was created.  Hmm, git-blame is our friend:
> >>>>
> >>>> commit c62313bbdc48f72e93fa8196f2fff96ba35e4e9d
> >>>> Author: Jan Kiszka <jan.kiszka@siemens.com>
> >>>> Date:   Fri Dec 4 14:05:29 2009 +0100
> >>>>
> >>>>     monitor: Accept input only byte-wise
> >>>>     
> >>>>     This allows to suspend command interpretation and execution
> >>>>     synchronously, e.g. during migration.
> >>>>     
> >>>>     Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>     Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
> >>> I don't think I understand why that's a problem; if we read more bytes,
> >>> we're not going to interpret them and execute them until after the previous
> >>> command returns are we?
> >> Actually it sees we might do, due to the way the "migrate" command works
> >> in HMP when you don't give the '-d' flag.
> >>
> >> Most monitors commands will block the caller until they are finished,
> >> but "migrate" is different. The hmp_migrate() method will return
> >> immediately, but we call monitor_suspend() to block processing of
> >> further commands. If another command has already been read off
> >> the wire though (due to "monitor_read" having a buffer that contains
> >> multiple commands), we would in fact start processing this command
> >> despite having suspended the monitor.
> >>
> >> This is only a problem, however, if the client app has issued "migrate"
> >> followed by another command, at the same time without waiting for the
> >> respond to "migrate". So in practice the only way you'd hit the bug
> >> is probably if you just cut+paste a big chunk of commands into the
> >> monitor at once without waiting for completion and one of the commands
> >> was "migrate" without "-d".
> >>
> >> Still, I think we would need to figure out a proper fix for this before
> >> we could increase the buffer size.
> >>
> >> Regards,
> >> Daniel
> >
> > There is one thing, which simplifies things a lot.
> > - suspend_cnt can be increased only from 2 places:
> >   1) monitor_event(), which is called for real HMP monitor only
> >
> >   2) monitor_suspend(), which can increment suspend_cnt
> >       only if mon->rs != NULL, which also means that the
> >       monitor is specifically configured HMP monitor.
> 
> I think you're right.  Monitor member suspend_cnt could use a comment.
> 
> If there are more members that apply only to HMP, we should collect them
> in a MonitorHMP struct, similar to MonitorQMP.
> 
> > So, we can improve the patch (for now) with the following
> > tweak:
> >
> > static int monitor_can_read(void *opaque)
> > {
> >     Monitor *mon = opaque;
> >    
> >     if (monitor_is_qmp(mon))
> >         return 4096;   
> >     return (mon->suspend_cnt == 0) ? 1 : 0;
> > }
> 
> Instead of adding the conditional, I'd split this into two functions,
> one for HMP and one for QMP, just like we split the other two callbacks.
> 
> > This will solve my case completely and does not break any
> > backward compatibility.
> 
> No change for HMP.  Okay.
> 
> For QMP, monitor_qmp_read() feeds whatever it gets to the JSON lexer.
> It currently gets one character at a time, because that's how much
> monitor_can_read() returns.  With your change, it gets up to 4KiB.
> 
> The JSON lexer feeds tokens to the JSON streamer one at a time until it
> has consumed everything it was fed.
> 
> The JSON streamer accumulates tokens, parsing them just enough to know
> when it has a complete expression.  It pushes the expression to the QMP
> expression handler immediately.
> 
> The QMP expression handler calls the JSON parser to parse the tokens
> into a QObject, then dispatches to QMP command handlers accordingly.
> 
> Everything's synchronous.  When a QMP command handler runs, the calling
> JSON streamer invocation is handling the command's final closing brace,
> and so is the calling JSON lexer.  After the QMP command handler
> returns, the JSON streamer returns.  The JSON lexer then looks at the
> next character if there are more, else it returns.
> 
> The only difference to before that I can see is that we can read ahead.
> That's a feature.
> 
> Looks safe to me.  Opinions?

Yes, I concur, it looks safe for QMP.

I might suggest putting an assert(!qmp) in monitor_suspend() to guarantee
no one accidentally introduces usage of the suspend feature in QMP in
future.


I think we could make it safe for HMP too, eventually, if we really wanted
to. In monitor_read(), we feed bytes 1 at a time into the parser. After
each byte is processed, we would need to check whether the monitor is now
suspended or not. If it is suspended, we would have to stop feeding bytes
into the parser, and stash them in the Monitor object for later use. When
the monitor_resume was triggered, then we could carry on processing the
stashed bytes.

Of course, that's not a blocker for doing the quick change for QMP only
right now.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
