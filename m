Received: from eggs.gnu.org ([2001:4830:134:3::10]:59081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dq9tK-0000dW-Nm
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 23:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dq9tF-0004Hz-N6
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 23:23:38 -0400
Received: from mail-qk0-x22f.google.com ([2607:f8b0:400d:c09::22f]:37765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <batmanustc@gmail.com>)
	id 1dq9tF-0004Gy-Hb
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 23:23:33 -0400
Received: by mail-qk0-x22f.google.com with SMTP id b82so3633491qkc.4
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 20:23:32 -0700 (PDT)
MIME-Version: 1.0
From: Sam <batmanustc@gmail.com>
Date: Fri, 8 Sep 2017 11:23:31 +0800
Message-ID: <CAOE=1Z0PxGGAkpO50rk1UtUDdLYX7kZZCLpb9rf87gZNVmGmLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Monitor socket will close after parse command error.
 Qemu-2.6.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

Hi all,

I'm using HMP socket to send command to add netdev, my command like this:

[gangyewei-3@yf-mos-test-net07 tests]$ sudo  python monitor.py 55919
> (qemu):
>  Connected to qemu monitor ...
> on_monitor_open
> ds
> (qemu):
> {'return': ["unknown command: 'ds'"]}
> chardev-add
> socket,id=char-test_intf1,path=/usr/local/var/run/openvswitch/test_intf1,server=on
> (qemu):
> \{'return': []}
> netdev_add vhost-user,id=test_intf1,chardev=char-test_intf1,vhostforce=on
> (qemu):
> {'return': ["unknown command: '\\netdev_add'"]}
> netdev_add vhost-user,id=test_intf1,chardev=char-test_intf1,vhostforce=on
> (qemu):
> {'return': []}
> device_add
> virtio-net-pci,netdev=test_intf1,mac=00:22:79:29:d2:6c,id=netdev-test_intf1
> (qemu):
> {'return': []}
> device_del netdev-test_intf1
> (qemu):
> {'return': []}
> netdev_del test_intf1
> (qemu):
> {'return': []}
> chardev-remove char-test_intf1
> (qemu):
> {'return': ["Chardev 'char-test_intf1' is busy"]}
> chardev-remove char-test_intf1
> (qemu):
> {'return': ["Chardev 'char-test_intf1' is busy"]}
> ds
> (qemu):
> {'return': ["unknown command: 'ds'"]}
> chardev-add
> socket,id=char-test_intf1,path=/usr/local/var/run/openvswitch/test_intf1,server=on
> (qemu):
> {'return': ["Duplicate ID 'char-test_intf1' for chardev", 'Parsing chardev
> args failed']}
> netdev_add vhost-user,id=test_intf1,chardev=char-test_intf1,vhostforce=on
> (qemu):
> on_monitor_close
> Disconnect ...
> Bye...
> [gangyewei-3@yf-mos-test-net07 tests]$ telnet 127.0.0.1 55919
> Trying 127.0.0.1...
> telnet: connect to address 127.0.0.1: Connection refused


the monitor.py is same like telnet, which send command to 127.0.0.1:55919
socket.
At the last 5th line, you could see "on_monitor_close", this is because
server side of 127.0.0.1:55919 socket is down.

I have few questions:
1. Why I got "{'return': ["Chardev 'char-test_intf1' is busy"]}" while
using "chardev-remove char-test_intf1"?
2. Why the server side will close while get "{'return': ["Duplicate ID
'char-test_intf1' for chardev", 'Parsing chardev args failed']}" and then
send same command?

Thank you~
