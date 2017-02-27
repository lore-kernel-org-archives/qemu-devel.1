Received: from eggs.gnu.org ([2001:4830:134:3::10]:37038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xzhou@redhat.com>) id 1ciKki-00087z-Ia
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:50:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xzhou@redhat.com>) id 1ciKkf-0001dJ-FX
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:50:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xzhou@redhat.com>) id 1ciKkf-0001cl-9H
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:50:05 -0500
Date: Mon, 27 Feb 2017 20:50:03 +0800
From: Xiong Zhou <xzhou@redhat.com>
Message-ID: <20170227125003.fegyd7gbrfdvrwjv@XZHOUW.usersys.redhat.com>
References: <20170227094050.ia6nrkvtvzmg7b2q@XZHOUW.usersys.redhat.com>
	<20170227101104.GB28403@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170227101104.GB28403@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] Fail to start 2nd guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Xiong Zhou <xzhou@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Mon, Feb 27, 2017 at 10:11:04AM +0000, Stefan Hajnoczi wrote:
> On Mon, Feb 27, 2017 at 05:40:50PM +0800, Xiong Zhou wrote:
> > It worked fine on Linus tree commit:
> >   7bb0338 Merge tag 'rodata-v4.11-rc1' of git://git.kernel.org/pub/scm/..
> > 
> > failed to start 2nd domain on this commit:
> > 37c8596 Merge tag 'tty-4.11-rc1' of git://git.kernel.org/pub/scm/..
> > (this commit probably is not the first bad, i didn't do the bisecting)
> > 
> > 
> > sh-4.2# uname -r
> > 4.10.0-master-37c8596+
> > sh-4.2# rpm -qv qemu
> > qemu-2.0.0-1.el7.6.x86_64
> > sh-4.2# ps ajxf | grep qemu
> > ...
> > sh-4.2# virsh list
> >  Id    Name                           State
> > ----------------------------------------------------
> >  1     73h                            running
> > 
> > sh-4.2# virsh start 73us
> > error: Failed to start domain 73us
> > error: internal error: qemu unexpectedly closed the monitor: ((null):11497): Spice-Warning **: reds.c:2499:reds_init_socket: listen: Address already in use
> > 2017-02-27T09:33:42.335708Z qemu-kvm: failed to initialize spice server
> 
> The error message says that the spice remote desktop cannot listen on
> -spice port=5900,addr=127.0.0.1.
> 
> Did you hardcode port 5900 in the domain XML?  That could explain why
No.
> the second guest fails to launch - you need to use unique port numbers
> or let libvirt automatically assign them.  Check the domain XML:
> 
>   <graphics type='spice' port='-1' tlsPort='-1' autoport='yes'>

It looks like:

    <graphics type='spice' autoport='yes'>
      <listen type='address'/>
      <image compression='off'/>
    </graphics>


> 
> Another possibility is that a process running on the host is already
> using port 5900.  Perhaps a guest or VNC server that was launched
> outside of libvirt?  You can check this with:
> 
>   netstat -alpn | grep 5900
# netstat -alpn | grep 5900
tcp        0      0 127.0.0.1:5900          0.0.0.0:*               LISTEN      11065/qemu-kvm      
> 
> Stefan
