Received: from eggs.gnu.org ([209.51.188.92]:34400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1uus-0004BX-C9
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1uur-0006IA-GX
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:26:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1uur-0006HN-1P
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:26:37 -0500
Date: Thu, 7 Mar 2019 15:26:22 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190307152622.GH2811@work-vm>
References: <20190307072025.8041-1-elena.ufimtseva@oracle.com>
	<20190307072251.9823-1-elena.ufimtseva@oracle.com>
	<20190307141125.GD5786@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307141125.GD5786@linux.fritz.box>
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 35/37] multi-process:
 QMP/HMP commands to resize block device on remote process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org, john.g.johnson@oracle.com, sstabellini@kernel.org, jag.raman@oracle.com, konrad.wilk@oracle.com, armbru@redhat.com, ross.lagerwall@citrix.com, liran.alon@oracle.com, stefanha@redhat.com, kanth.ghatraju@oracle.com

* Kevin Wolf (kwolf@redhat.com) wrote:
> Am 07.03.2019 um 08:22 hat elena.ufimtseva@oracle.com geschrieben:
> > From: Jagannathan Raman <jag.raman@oracle.com>
> > 
> > Adds rblock_resize QMP/HMP commands to resize block devices on the remote
> > process.
> > 
> > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> 
> Up to this patch, I thought that maybe the block layer related things
> would only need a few changes, like:
> 
> * Have -rblockdev instead of -rdrive
> * Add QMP version for HMP-only only commands
> 
> But this one got me thinking. If I understand this correctly, the
> current design means that we have to duplicate every single QMP command
> to have a remote variant. This just doesn't scale.
> 
> I'm not entirely sure what the final design should look like, but I
> think we need to have a separate QMP connection to the process that owns
> the block device so that the normal existing QMP commands can be used to
> managed it.
> 
> In the long run, I think you'll want to separate the block backends from
> the device emulation anyway. The thing I have in mind is the storage
> daemon idea that was occasionally mentioned here and there; and the
> process that owns the device would connect to the backend process, maybe
> using the vhost-user protocol (or an extension of it with more
> management stuff). For the start, that separate process could in fact be
> the main process.
> 
> For a limited prototype, maybe we could even use NBD, which is already
> existing (both server and client parts), but will obviously impact
> performance. Then we'd need a way to configure the remote device process
> to connect to either an external NBD server (e.g. qemu-nbd) or to the
> main process, which would manage the real storage and export it to the
> remote processes over NBD.
> 
> In a second step, we could switch it over to a different protocol that
> is more feature complete and can provide better performance.
> 
> This probably needs some more thought, but what do you think in general?

Yeh I was noticing something similar; in a way it feels like you
should be able to do something like make this a property of a bus - i.e.
adding a drive to the bus that's on the remote controller routes it over
to the remote process rather than needing a special command.

Dave

> Kevin
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
