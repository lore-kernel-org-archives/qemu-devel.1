Received: from eggs.gnu.org ([2001:4830:134:3::10]:51587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1drpyI-0004Wx-SY
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1drpyE-0006mH-Pf
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:31:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1drpyE-0006lH-H2
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:31:38 -0400
Date: Tue, 12 Sep 2017 19:31:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170912183133.GF2225@work-vm>
References: <CAOE=1Z0PxGGAkpO50rk1UtUDdLYX7kZZCLpb9rf87gZNVmGmLA@mail.gmail.com>
	<CAOE=1Z2=dQ_HNjokhXb_Kvf=63YTjoNeX=-aUvDA_VfmSW0i8Q@mail.gmail.com>
	<CAOE=1Z0O9fWKYVaHtb5aws4DrvqKYc2cSZDTU_7Qrz5ZzfT6ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOE=1Z0O9fWKYVaHtb5aws4DrvqKYc2cSZDTU_7Qrz5ZzfT6ew@mail.gmail.com>
Subject: Re: [Qemu-devel] Monitor socket will close after parse command
 error. Qemu-2.6.2
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

* Sam (batmanustc@gmail.com) wrote:
> [gangyewei-3@yf-mos-test-net07 tests]$ telnet 127.0.0.1 55919
> Trying 127.0.0.1...
> Connected to 127.0.0.1.
> Escape character is '^]'.
> QEMU 2.6.2 monitor - type 'help' for more information
> (qemu) chardev-add
> socket,id=char-test_intf1,path=/usr/local/var/run/openvswitch/test_intf1,server=on
> chardev-add
> socket,id=char-test_intf1,path=/usr/local/var/run/openvswitch/test_intf1,server=on
> (qemu)
> (qemu) netdev_add
> vhost-user,id=test_intf1,chardev=char-test_intf1,vhostforce=on
> netdev_add vhost-user,id=test_intf1,chardev=char-test_intf1,vhostforce=on
> (qemu)
> (qemu) device_add
> virtio-net-pci,netdev=test_intf1,mac=00:22:79:29:d2:6c,id=netdev-test_intf1
> device_add
> virtio-net-pci,netdev=test_intf1,mac=00:22:79:29:d2:6c,id=netdev-test_intf1
> (qemu)
> (qemu) device_del netdev-test_intf1
> device_del netdev-test_intf1
> (qemu)
> (qemu) netdev_del test_intf1
> netdev_del test_intf1
> (qemu)
> (qemu) chardev-remove char-test_intf1
> chardev-remove char-test_intf1
> Chardev 'char-test_intf1' is busy
> (qemu)
> (qemu) chardev-remove char-test_intf1
> chardev-remove char-test_intf1
> Chardev 'char-test_intf1' is busy
> (qemu)
> (qemu) chardev-remove char-test_intf1
> chardev-remove char-test_intf1
> Chardev 'char-test_intf1' is busy
> (qemu)
> (qemu) chardev-add
> socket,id=char-test_intf1,path=/usr/local/var/run/openvswitch/test_intf1,server=on
> chardev-add
> socket,id=char-test_intf1,path=/usr/local/var/run/openvswitch/test_intf1,server=on
> Duplicate ID 'char-test_intf1' for chardev
> Parsing chardev args failed
> (qemu)
> (qemu) ^[[A^[[A
> chardev-remove char-test_intf1
> Chardev 'char-test_intf1' is busy
> (qemu)
> (qemu)
> 
> (qemu)
> (qemu)
> 
> (qemu)
> (qemu) netdev_add
> vhost-user,id=test_intf1,chardev=char-test_intf1,vhostforce=on
> netdev_add vhost-user,id=test_intf1,chardev=char-test_intf1,vhostforce=on
> Connection closed by foreign host.

Is QEMU just crashing at that point?  i.e. segfaulting or aborting?

Dave

> 2017-09-08 11:32 GMT+08:00 Sam <batmanustc@gmail.com>:
> 
> > BTW, same result while using `telnet 127.0.0.1 55919`, which means also
> > have the two problem in the email before.
> >
> > 2017-09-08 11:23 GMT+08:00 Sam <batmanustc@gmail.com>:
> >
> >> Hi all,
> >>
> >> I'm using HMP socket to send command to add netdev, my command like this:
> >>
> >> [gangyewei-3@yf-mos-test-net07 tests]$ sudo  python monitor.py 55919
> >>> (qemu):
> >>>  Connected to qemu monitor ...
> >>> on_monitor_open
> >>> ds
> >>> (qemu):
> >>> {'return': ["unknown command: 'ds'"]}
> >>> chardev-add socket,id=char-test_intf1,path=/usr/local/var/run/openvswitc
> >>> h/test_intf1,server=on
> >>> (qemu):
> >>> \{'return': []}
> >>> netdev_add vhost-user,id=test_intf1,chardev=char-test_intf1,vhostforce=
> >>> on
> >>> (qemu):
> >>> {'return': ["unknown command: '\\netdev_add'"]}
> >>> netdev_add vhost-user,id=test_intf1,chardev=char-test_intf1,vhostforce=
> >>> on
> >>> (qemu):
> >>> {'return': []}
> >>> device_add virtio-net-pci,netdev=test_intf1,mac=00:22:79:29:d2:6c,id=
> >>> netdev-test_intf1
> >>> (qemu):
> >>> {'return': []}
> >>> device_del netdev-test_intf1
> >>> (qemu):
> >>> {'return': []}
> >>> netdev_del test_intf1
> >>> (qemu):
> >>> {'return': []}
> >>> chardev-remove char-test_intf1
> >>> (qemu):
> >>> {'return': ["Chardev 'char-test_intf1' is busy"]}
> >>> chardev-remove char-test_intf1
> >>> (qemu):
> >>> {'return': ["Chardev 'char-test_intf1' is busy"]}
> >>> ds
> >>> (qemu):
> >>> {'return': ["unknown command: 'ds'"]}
> >>> chardev-add socket,id=char-test_intf1,path=/usr/local/var/run/openvswitc
> >>> h/test_intf1,server=on
> >>> (qemu):
> >>> {'return': ["Duplicate ID 'char-test_intf1' for chardev", 'Parsing
> >>> chardev args failed']}
> >>> netdev_add vhost-user,id=test_intf1,chardev=char-test_intf1,vhostforce=
> >>> on
> >>> (qemu):
> >>> on_monitor_close
> >>> Disconnect ...
> >>> Bye...
> >>> [gangyewei-3@yf-mos-test-net07 tests]$ telnet 127.0.0.1 55919
> >>> Trying 127.0.0.1...
> >>> telnet: connect to address 127.0.0.1: Connection refused
> >>
> >>
> >> the monitor.py is same like telnet, which send command to 127.0.0.1:55919
> >> socket.
> >> At the last 5th line, you could see "on_monitor_close", this is because
> >> server side of 127.0.0.1:55919 socket is down.
> >>
> >> I have few questions:
> >> 1. Why I got "{'return': ["Chardev 'char-test_intf1' is busy"]}" while
> >> using "chardev-remove char-test_intf1"?
> >> 2. Why the server side will close while get "{'return': ["Duplicate ID
> >> 'char-test_intf1' for chardev", 'Parsing chardev args failed']}" and then
> >> send same command?
> >>
> >> Thank you~
> >>
> >
> >
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
