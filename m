Received: from eggs.gnu.org ([2001:4830:134:3::10]:49048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dono0-0000NZ-QA
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 05:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1donnw-0002Ap-Nt
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 05:36:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1donnw-00029b-Hu
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 05:36:28 -0400
Date: Mon, 4 Sep 2017 10:36:23 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170904093623.GB7186@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAOE=1Z3xuudQenX+Oe11fPDZfrC_d02S50HQ9mJ=RfnJ0B5DUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOE=1Z3xuudQenX+Oe11fPDZfrC_d02S50HQ9mJ=RfnJ0B5DUg@mail.gmail.com>
Subject: Re: [Qemu-devel] How to use monitor socket in python to connect VM?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam <batmanustc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, Sep 04, 2017 at 02:17:39PM +0800, Sam wrote:
> Hi all,
> 
> I'm using python socket to connect VM's monitor socket like this:
> 
> [root@yf-mos-test-net09 tests]# python
> > Python 2.7.5 (default, Jun 24 2015, 00:41:19)
> > [GCC 4.8.3 20140911 (Red Hat 4.8.3-9)] on linux2
> > Type "help", "copyright", "credits" or "license" for more information.
> > >>> from socket import *
> > >>> sock = socket(AF_INET, SOCK_STREAM, 0)
> > >>> sock.connect(('127.0.0.1', 55902))

NB, running the QEMU monitor on an IP socket is not secure. There
is no authentication, and a monitor connection allows you do fully
exploit the user account QEMU is running under (because the user
can attach arbitrary files as virtual disks and thus access their
content).  You always want to use a UNIX domain socket connection.

> > >>> sock.recv(1024)
> > "QEMU 2.6.0 monitor - type 'help' for more information\r\n(qemu) "
> > >>> sock.recv(1024)

[snip]

> But as we see, there are problems:
> 1. commands like '>>> sock.send('chardev-add
> socket,id=char-vhost_test_intf1,path=/usr/local/var/run/openvswitch/vhost_test_intf1,server=on')
> 106'  does not work, this I'm very sure and I use some method to verify it.
> 2. commands like '>>> sock.recv(1024)' got a lot of unknown characters.

You're trying to interact with the *human* monitor here, so all the
garbage you see is the result of the readline library trying to
do interactive command processing for you.

To automate QEMU you should always use the QMP monitor. eg

  $QEMU -qmp unix:/some/path/qemu.sock

> 
> So is there some one who use python(or shell) to connect monitor socket of
> VM? Could you please share the code or tell me the way to operate?

You might want to look at scripts/qemu.py in the QEMU git tree. It is the
python code we use for communicating with QMP monitor in QEMU test suites.
You can probably use it as a starting point.

> For example, should I send command with '(qemu) ' before my command? Should
> I recv result by the end of '\r\n' or something?

No, you should use QMP and avoid this pain entirely :-)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
