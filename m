Received: from eggs.gnu.org ([2001:4830:134:3::10]:45062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dooMB-0006Dp-Gu
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 06:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dooM5-0001pM-Vf
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 06:11:51 -0400
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:33390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <batmanustc@gmail.com>)
	id 1dooM5-0001oj-Nx
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 06:11:45 -0400
Received: by mail-qk0-x22a.google.com with SMTP id o129so200534qkd.0
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 03:11:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170904093623.GB7186@redhat.com>
References: <CAOE=1Z3xuudQenX+Oe11fPDZfrC_d02S50HQ9mJ=RfnJ0B5DUg@mail.gmail.com>
	<20170904093623.GB7186@redhat.com>
From: Sam <batmanustc@gmail.com>
Date: Mon, 4 Sep 2017 18:11:44 +0800
Message-ID: <CAOE=1Z2HFVhD8b1TXaQFd8sGvqoddOeJoSds1ZxwzKSw8im7ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] How to use monitor socket in python to connect VM?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Actually I use qga socket first(send json format command like {'execute':
'chardev-add', 'arguments': {'id': id, 'type': type}, 'params': params} by
qga socket, which is
/opt/cloud/workspace/servers/1925a92d-f003-4d77-871c-bce8f85229aa/qga.sock,
using the same script as first mail), but it response me "netdev_add is not
valid command"(it's reasonable, as guest OS could not operate 'netdev_add'
command), so I thought qga could not do this work, then I change to monitor.

After your explain, I still have few questions:
1. As in my thought, add net device is out of control of VM guest OS,
that's the reason why I got failed first time. But you said I could do this
work by QMP command, so your QMP command is different of my? And what this
command is?
2. The socket you refer above(like 'unix:/some/path/qemu.sock'), is it the
same socket of qga socket?

Thank you~

2017-09-04 17:36 GMT+08:00 Daniel P. Berrange <berrange@redhat.com>:

> On Mon, Sep 04, 2017 at 02:17:39PM +0800, Sam wrote:
> > Hi all,
> >
> > I'm using python socket to connect VM's monitor socket like this:
> >
> > [root@yf-mos-test-net09 tests]# python
> > > Python 2.7.5 (default, Jun 24 2015, 00:41:19)
> > > [GCC 4.8.3 20140911 (Red Hat 4.8.3-9)] on linux2
> > > Type "help", "copyright", "credits" or "license" for more information.
> > > >>> from socket import *
> > > >>> sock = socket(AF_INET, SOCK_STREAM, 0)
> > > >>> sock.connect(('127.0.0.1', 55902))
>
> NB, running the QEMU monitor on an IP socket is not secure. There
> is no authentication, and a monitor connection allows you do fully
> exploit the user account QEMU is running under (because the user
> can attach arbitrary files as virtual disks and thus access their
> content).  You always want to use a UNIX domain socket connection.
>
> > > >>> sock.recv(1024)
> > > "QEMU 2.6.0 monitor - type 'help' for more information\r\n(qemu) "
> > > >>> sock.recv(1024)
>
> [snip]
>
> > But as we see, there are problems:
> > 1. commands like '>>> sock.send('chardev-add
> > socket,id=char-vhost_test_intf1,path=/usr/local/var/run/
> openvswitch/vhost_test_intf1,server=on')
> > 106'  does not work, this I'm very sure and I use some method to verify
> it.
> > 2. commands like '>>> sock.recv(1024)' got a lot of unknown characters.
>
> You're trying to interact with the *human* monitor here, so all the
> garbage you see is the result of the readline library trying to
> do interactive command processing for you.
>
> To automate QEMU you should always use the QMP monitor. eg
>
>   $QEMU -qmp unix:/some/path/qemu.sock
>
> >
> > So is there some one who use python(or shell) to connect monitor socket
> of
> > VM? Could you please share the code or tell me the way to operate?
>
> You might want to look at scripts/qemu.py in the QEMU git tree. It is the
> python code we use for communicating with QMP monitor in QEMU test suites.
> You can probably use it as a starting point.
>
> > For example, should I send command with '(qemu) ' before my command?
> Should
> > I recv result by the end of '\r\n' or something?
>
> No, you should use QMP and avoid this pain entirely :-)
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/
> dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/
> dberrange :|
>
