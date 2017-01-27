Received: from eggs.gnu.org ([2001:4830:134:3::10]:36185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cX31O-0004bf-JN
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cX31L-0007kg-En
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:40:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cX31L-0007kI-7R
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 04:40:39 -0500
Date: Fri, 27 Jan 2017 09:40:33 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170127094033.GC26553@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAO_EM_kS-aGQdvPEO+7pkFWHOSiu8XMpZSduS=gPgUsDwJd9ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO_EM_kS-aGQdvPEO+7pkFWHOSiu8XMpZSduS=gPgUsDwJd9ig@mail.gmail.com>
Subject: Re: [Qemu-devel] [libvirt] char: Logging serial pty output when
 disconnected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com

On Thu, Jan 26, 2017 at 05:07:16PM -0800, Ed Swierk wrote:
> Interactive access to a guest serial console can be enabled by hooking
> the serial device to a pty backend, e.g. -device
> isa-serial,chardev=cs0 -chardev pty,id=cs0. With libvirt this can be
> configured via <console type='pty'><target type='serial'
> port='0'/></console>.
> 
> Output from the same serial device can also be logged to a file by
> adding logfile=/somefile to the -chardev option (<log file=/somefile/>
> in libvirt).
> 
> Unfortunately output gets logged only when a client like virsh console
> is connected to the pty; otherwise qemu drops it on the floor. This
> makes chardev logging much less useful than it could be for debugging
> guest problems after the fact.
> 
> Currently qemu_chr_fe_write() calls qemu_chr_fe_write_log() only for
> data consumed by the backend chr_write function. With the pty backend,
> pty_chr_write() returns 0 indicating that the data was not consumed
> when the pty is disconnected. Simply changing it to return len instead
> of 0 tricks the caller into logging the data even when the pty is
> disconnected. I don't know what problems this might cause, but one
> data point is that tcp_chr_write() already happens to work this way.
> 
> Alternatively, qemu_chr_fe_write() could be modified to log everything
> passed to it, regardless of how much data chr_write claims to have
> consumed. The trouble is that the serial device retries writing
> unconsumed data, so when the pty is disconnected you'd see every
> character duplicated 4 times in the log file.
> 
> Any opinions on either approach, or other suggestions? If there are no
> objections to the first one, I'll prepare a patch.

If the pty backend intends to just drop data into a blackhole when
no client is connected, then its chr_write() impl should return
the length of the data discarded, not zero.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
