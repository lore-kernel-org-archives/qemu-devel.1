Received: from eggs.gnu.org ([2001:4830:134:3::10]:42477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWXI-0005X9-MR
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:34:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWXF-00028N-Iz
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:34:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWXF-00028B-Cu
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:34:29 -0500
Date: Fri, 6 Jan 2017 15:34:23 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170106153423.GQ31112@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170106152930.6779-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170106152930.6779-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qga: add systemd socket activation
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On Fri, Jan 06, 2017 at 03:29:30PM +0000, Stefan Hajnoczi wrote:
> AF_UNIX and AF_VSOCK listen sockets can be passed in by systemd on
> startup.  This allows systemd to manage the listen socket until the
> first client connects and between restarts.  Advantages of socket
> activation are that parallel startup of network services becomes
> possible and that unused daemons do not consume memory.
> 
> The key to achieving this is the LISTEN_FDS environment variable, which
> is a stable ABI as shown here:
> https://www.freedesktop.org/wiki/Software/systemd/InterfacePortabilityAndStabilityChart/
> 
> We could link against libsystemd and use sd_listen_fds(3) but it's easy
> to implement the tiny LISTEN_FDS ABI so that qemu-ga does not depend on
> libsystemd.  Some systems may not have systemd installed and wish to
> avoid the dependency.  Other init systems or socket activation servers
> may implement the same ABI without systemd involvement.
> 
> Test as follows:
> 
>   $ cat ~/.config/systemd/user/qga.service
>   [Unit]
>   Description=qga
> 
>   [Service]
>   WorkingDirectory=/tmp
>   ExecStart=/path/to/qemu-ga --logfile=/tmp/qga.log --pidfile=/tmp/qga.pid --statedir=/tmp
> 
>   $ cat ~/.config/systemd/user/qga.socket
>   [Socket]
>   ListenStream=/tmp/qga.sock
> 
>   [Install]
>   WantedBy=default.target
> 
>   $ systemctl --user daemon-reload
>   $ systemctl --user start qga.socket
>   $ nc -U /tmp/qga.sock
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Drop libsystemd dependency [danpb]
> 
>  qga/channel.h       |  3 ++-
>  qga/channel-posix.c | 66 ++++++++++++++++++++++++++---------------------
>  qga/channel-win32.c |  2 +-
>  qga/main.c          | 74 +++++++++++++++++++++++++++++++++++++++++++++++++----
>  4 files changed, 109 insertions(+), 36 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>



Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
