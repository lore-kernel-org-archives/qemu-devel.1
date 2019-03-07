Received: from eggs.gnu.org ([209.51.188.92]:41868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1tkN-0000Yr-76
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1tkL-000382-BT
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:11:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1h1tkG-0002nB-Ot
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:11:37 -0500
Date: Thu, 7 Mar 2019 15:11:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190307141125.GD5786@linux.fritz.box>
References: <20190307072025.8041-1-elena.ufimtseva@oracle.com>
	<20190307072251.9823-1-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307072251.9823-1-elena.ufimtseva@oracle.com>
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
To: elena.ufimtseva@oracle.com
Cc: qemu-devel@nongnu.org, john.g.johnson@oracle.com, sstabellini@kernel.org, jag.raman@oracle.com, konrad.wilk@oracle.com, dgilbert@redhat.com, armbru@redhat.com, ross.lagerwall@citrix.com, liran.alon@oracle.com, stefanha@redhat.com, kanth.ghatraju@oracle.com

Am 07.03.2019 um 08:22 hat elena.ufimtseva@oracle.com geschrieben:
> From: Jagannathan Raman <jag.raman@oracle.com>
> 
> Adds rblock_resize QMP/HMP commands to resize block devices on the remote
> process.
> 
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Up to this patch, I thought that maybe the block layer related things
would only need a few changes, like:

* Have -rblockdev instead of -rdrive
* Add QMP version for HMP-only only commands

But this one got me thinking. If I understand this correctly, the
current design means that we have to duplicate every single QMP command
to have a remote variant. This just doesn't scale.

I'm not entirely sure what the final design should look like, but I
think we need to have a separate QMP connection to the process that owns
the block device so that the normal existing QMP commands can be used to
managed it.

In the long run, I think you'll want to separate the block backends from
the device emulation anyway. The thing I have in mind is the storage
daemon idea that was occasionally mentioned here and there; and the
process that owns the device would connect to the backend process, maybe
using the vhost-user protocol (or an extension of it with more
management stuff). For the start, that separate process could in fact be
the main process.

For a limited prototype, maybe we could even use NBD, which is already
existing (both server and client parts), but will obviously impact
performance. Then we'd need a way to configure the remote device process
to connect to either an external NBD server (e.g. qemu-nbd) or to the
main process, which would manage the real storage and export it to the
remote processes over NBD.

In a second step, we could switch it over to a different protocol that
is more feature complete and can provide better performance.

This probably needs some more thought, but what do you think in general?

Kevin
