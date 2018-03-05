Received: from eggs.gnu.org ([2001:4830:134:3::10]:57285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rpalethorpe@suse.de>) id 1esrGJ-00008g-6I
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 09:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rpalethorpe@suse.de>) id 1esrGI-0005qF-6Y
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 09:38:47 -0500
References: <20180227115651.30762-1-rpalethorpe@suse.com>
	<20180302161536.GA2454@rkaganb.sw.ru>
From: Richard Palethorpe <rpalethorpe@suse.de>
Reply-To: rpalethorpe@suse.de
In-reply-to: <20180302161536.GA2454@rkaganb.sw.ru>
Date: Mon, 05 Mar 2018 15:38:36 +0100
Message-ID: <87fu5ewpsj.fsf@rpws.prws.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 0/2] Increase usability of
 external snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: rpalethorpe@suse.de, qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, quintela@redhat.com

Hello Roman,

Roman Kagan writes:

> On Tue, Feb 27, 2018 at 12:56:49PM +0100, Richard Palethorpe wrote:
>> Following on from the discussion about creating savevm/loadvm QMP
>> equivalents. I decided to take the advice given that we should use external
>> snapshots. However reverting to a snapshot currently requires QEMU to be
>> restarted with "-incoming".  Restarting QEMU requires a fair bit of
>> book keeping to be done by the management application and may take
>> measurably more time.
>
> AFAICT "-incoming" is not the only reason for starting QEMU anew.  The
> block devices will need to be pointed at different nodes in the backing
> chains.  Moreover the snapshot you're reverting to may have been taken
> at a point where the VM had different configuration than it has now.

OK, so contrary to what I thought, it looks like there is no QMP command
to simply drop the current active layer and repoint the block device to
the previous node in the chain. We would have to recreate the block
device with the desired backing store and overlays or create a new
command. I am not sure that is a showstopper though.

>
> So the management application will need to do a lot of bookkeeping stuff
> anyway, and it'll probably have harder time applying all of the
> configuration changes to a live QEMU instance.

Well in our use case, configuration changes between snapshots would not
be possible. For other use cases the management app will have to restart
QEMU when necessary. AFAICT, with or without this patch it is possible for
someone to try accepting an incoming migration with an invalid
configuration. So I would hope that this is not introducing a new
problem?

>
> Is the cost of killing the old QEMU process and starting a new one big
> enough to be worth all the hassle?

I doubt I can justify it based on performance, atleast not for our use
case, but terminating the QEMU process will interrupt a number of socket
connections and such. I am sure this is a technically easier problem to
solve than modifying QEMU, but there is one QEMU and many management
apps so *maybe* the effort is better spent on QEMU if it avoids more work
in the management apps and is not introducing features to QEMU outside
of its scope. QEMU already supports reverting to internal snapshots in a
live instance, so I don't think I am increasing its scope.

>
> Thanks,
> Roman.

--
Thank you,
Richard.
