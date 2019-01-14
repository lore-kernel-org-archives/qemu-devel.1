Received: from eggs.gnu.org ([209.51.188.92]:36771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1giyZy-0002M3-KL
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1giyZw-0005X6-MI
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:30:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:46856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1giyZu-0005VZ-Fw
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:30:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1giyZs-0004kL-Vt
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 09:30:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ED24E2E8058
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 09:30:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Jan 2019 09:15:58 -0000
From: feihu <feihu929@sina.com>
Reply-To: Bug 1811653 <1811653@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154745735839.19444.13981937275377739043.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1811653] [NEW] usbredir slow when multi bulk
 packet per second
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

QEMU Ver: all version
Client: virt-viewer by spice
Guest VM: win7
Bug description:
=C2=A0=C2=A0Use Qemu 2.1 or later with usbredir, When I redirect a bulk usb=
-device from virt-viewer client,the bulk-usb-device driver or app in GuestV=
M will send 50 bulk-urb per times.
=C2=A0=C2=A0In VM, using the usblyzer to monitor the usb packet, it show th=
ese 50 bulk-urb packet (24576 bytes per urb) send in 1ms, But in the QEMU V=
M log, It shows as below
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2019-01-14T08:27:26.096809Z qemu-kvm: usb-redir: bulk-out ep 86 stream 0 le=
n 49152 id 2114122112 0x7f0ffa300b40
2019-01-14T08:27:26.105680Z qemu-kvm: usb-redir: bulk-in status 0 ep 86 str=
eam 0 len 49152 id 2114122112 0x7f0ffa300b40
2019-01-14T08:27:26.108219Z qemu-kvm: usb-redir: bulk-out ep 86 stream 0 le=
n 49152 id 2114122112 0x7f0ffa300b40
2019-01-14T08:27:26.116742Z qemu-kvm: usb-redir: bulk-in status 0 ep 86 str=
eam 0 len 49152 id 2114122112 0x7f0ffa300b40
2019-01-14T08:27:26.119242Z qemu-kvm: usb-redir: bulk-out ep 86 stream 0 le=
n 49152 id 2114122112 0x7f0ffa300b40
2019-01-14T08:27:26.129851Z qemu-kvm: usb-redir: bulk-in status 0 ep 86 str=
eam 0 len 49152 id 2114122112 0x7f0ffa300b40
2019-01-14T08:27:26.132349Z qemu-kvm: usb-redir: bulk-out ep 86 stream 0 le=
n 49152 id 2114122112 0x7f0ffa300b40
2019-01-14T08:27:26.141248Z qemu-kvm: usb-redir: bulk-in status 0 ep 86 str=
eam 0 len 49152 id 2114122112 0x7f0ffa300b40
2019-01-14T08:27:26.144932Z qemu-kvm: usb-redir: bulk-out ep 86 stream 0 le=
n 49152 id 2114122112 0x7f0ffa300b40
2019-01-14T08:27:26.154035Z qemu-kvm: usb-redir: bulk-in status 0 ep 86 str=
eam 0 len 49152 id 2114122112 0x7f0ffa300b40
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=C2=A0It shows that the bulk packet is single thread send and recv, per bulk
packet will use 10-20ms, all 50 bulk-packets will use 500~1000ms, so the
in the VM, bulk-urb will timeout always!

=C2=A0=C2=A0How to send the bulk packet by multithread to speedup the bulk-=
urb send and recv, for example:
------------
=C2=A0bulk-out ep 86 stream 0 len 49152 id xxxx1
=C2=A0bulk-out ep 86 stream 0 len 49152 id xxxx2
=C2=A0bulk-out ep 86 stream 0 len 49152 id xxxx3
=C2=A0bulk-out ep 86 stream 0 len 49152 id xxxx4
=C2=A0bulk-out ...
=C2=A0bulk-out ep 86 stream 0 len 49152 id xxxx50
...
=C2=A0bulk-in status 0 ep 86 stream 0 len 49152 id xxxx1
=C2=A0bulk-in status 0 ep 86 stream 0 len 49152 id xxxx2
=C2=A0bulk-in status 0 ep 86 stream 0 len 49152 id xxxx3
=C2=A0bulk-in status 0 ep 86 stream 0 len 49152 id xxxx4
=C2=A0bulk-out ...
=C2=A0bulk-in status 0 ep 86 stream 0 len 49152 id xxxx50
------------

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  QEMU Ver: all version
  Client: virt-viewer by spice
  Guest VM: win7
  Bug description:
-   Use Qemu 2.1 or later with usbredir, When I redirect a bulk usb-device =
from virt-viewer client, =

- the bulk-usb-device driver or app in GuestVM will send 50 bulk-urb per ti=
mes.
-   In VM, using the usblyzer to monitor the usb packet, it show these 50 b=
ulk-urb packet send in 1ms, =

+ =C2=A0=C2=A0Use Qemu 2.1 or later with usbredir, When I redirect a bulk u=
sb-device from virt-viewer client,the bulk-usb-device driver or app in Gues=
tVM will send 50 bulk-urb per times.
+ =C2=A0=C2=A0In VM, using the usblyzer to monitor the usb packet, it show =
these 50 bulk-urb packet send in 1ms,
  But in the QEMU VM log, It shows as below
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  2019-01-14T08:27:26.096809Z qemu-kvm: usb-redir: bulk-out ep 86 stream 0 =
len 49152 id 2114122112 0x7f0ffa300b40
  2019-01-14T08:27:26.105680Z qemu-kvm: usb-redir: bulk-in status 0 ep 86 s=
tream 0 len 49152 id 2114122112 0x7f0ffa300b40
  2019-01-14T08:27:26.108219Z qemu-kvm: usb-redir: bulk-out ep 86 stream 0 =
len 49152 id 2114122112 0x7f0ffa300b40
  2019-01-14T08:27:26.116742Z qemu-kvm: usb-redir: bulk-in status 0 ep 86 s=
tream 0 len 49152 id 2114122112 0x7f0ffa300b40
  2019-01-14T08:27:26.119242Z qemu-kvm: usb-redir: bulk-out ep 86 stream 0 =
len 49152 id 2114122112 0x7f0ffa300b40
  2019-01-14T08:27:26.129851Z qemu-kvm: usb-redir: bulk-in status 0 ep 86 s=
tream 0 len 49152 id 2114122112 0x7f0ffa300b40
  2019-01-14T08:27:26.132349Z qemu-kvm: usb-redir: bulk-out ep 86 stream 0 =
len 49152 id 2114122112 0x7f0ffa300b40
  2019-01-14T08:27:26.141248Z qemu-kvm: usb-redir: bulk-in status 0 ep 86 s=
tream 0 len 49152 id 2114122112 0x7f0ffa300b40
  2019-01-14T08:27:26.144932Z qemu-kvm: usb-redir: bulk-out ep 86 stream 0 =
len 49152 id 2114122112 0x7f0ffa300b40
  2019-01-14T08:27:26.154035Z qemu-kvm: usb-redir: bulk-in status 0 ep 86 s=
tream 0 len 49152 id 2114122112 0x7f0ffa300b40
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  =

-  It shows that the bulk packet is single thread send and recv, per bulk
+ =C2=A0It shows that the bulk packet is single thread send and recv, per b=
ulk
  packet will use 10-20ms, all 50 bulk-packets will use 500~1000ms, so the
  in the VM, bulk-urb will timeout always!
  =

-   How to send the bulk packet by multithread to speedup the bulk-urb send=
 and recv, for example:
+ =C2=A0=C2=A0How to send the bulk packet by multithread to speedup the bul=
k-urb send and recv, for example:
  ------------
-  bulk-out ep 86 stream 0 len 49152 id xxxx1
-  bulk-out ep 86 stream 0 len 49152 id xxxx2
-  bulk-out ep 86 stream 0 len 49152 id xxxx3
-  bulk-out ep 86 stream 0 len 49152 id xxxx4
-  bulk-out ...
-  bulk-out ep 86 stream 0 len 49152 id xxxx50
+ =C2=A0bulk-out ep 86 stream 0 len 49152 id xxxx1
+ =C2=A0bulk-out ep 86 stream 0 len 49152 id xxxx2
+ =C2=A0bulk-out ep 86 stream 0 len 49152 id xxxx3
+ =C2=A0bulk-out ep 86 stream 0 len 49152 id xxxx4
+ =C2=A0bulk-out ...
+ =C2=A0bulk-out ep 86 stream 0 len 49152 id xxxx50
  ...
-  bulk-in status 0 ep 86 stream 0 len 49152 id xxxx1
-  bulk-in status 0 ep 86 stream 0 len 49152 id xxxx2
-  bulk-in status 0 ep 86 stream 0 len 49152 id xxxx3
-  bulk-in status 0 ep 86 stream 0 len 49152 id xxxx4
-  bulk-out ...
-  bulk-in status 0 ep 86 stream 0 len 49152 id xxxx50
+ =C2=A0bulk-in status 0 ep 86 stream 0 len 49152 id xxxx1
+ =C2=A0bulk-in status 0 ep 86 stream 0 len 49152 id xxxx2
+ =C2=A0bulk-in status 0 ep 86 stream 0 len 49152 id xxxx3
+ =C2=A0bulk-in status 0 ep 86 stream 0 len 49152 id xxxx4
+ =C2=A0bulk-out ...
+ =C2=A0bulk-in status 0 ep 86 stream 0 len 49152 id xxxx50
  ------------

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1811653

Title:
  usbredir slow when multi bulk packet per second

Status in QEMU:
  New

Bug description:
  QEMU Ver: all version
  Client: virt-viewer by spice
  Guest VM: win7
  Bug description:
  =C2=A0=C2=A0Use Qemu 2.1 or later with usbredir, When I redirect a bulk u=
sb-device from virt-viewer client,the bulk-usb-device driver or app in Gues=
tVM will send 50 bulk-urb per times.
  =C2=A0=C2=A0In VM, using the usblyzer to monitor the usb packet, it show =
these 50 bulk-urb packet (24576 bytes per urb) send in 1ms, But in the QEMU=
 VM log, It shows as below
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  2019-01-14T08:27:26.096809Z qemu-kvm: usb-redir: bulk-out ep 86 stream 0 =
len 49152 id 2114122112 0x7f0ffa300b40
  2019-01-14T08:27:26.105680Z qemu-kvm: usb-redir: bulk-in status 0 ep 86 s=
tream 0 len 49152 id 2114122112 0x7f0ffa300b40
  2019-01-14T08:27:26.108219Z qemu-kvm: usb-redir: bulk-out ep 86 stream 0 =
len 49152 id 2114122112 0x7f0ffa300b40
  2019-01-14T08:27:26.116742Z qemu-kvm: usb-redir: bulk-in status 0 ep 86 s=
tream 0 len 49152 id 2114122112 0x7f0ffa300b40
  2019-01-14T08:27:26.119242Z qemu-kvm: usb-redir: bulk-out ep 86 stream 0 =
len 49152 id 2114122112 0x7f0ffa300b40
  2019-01-14T08:27:26.129851Z qemu-kvm: usb-redir: bulk-in status 0 ep 86 s=
tream 0 len 49152 id 2114122112 0x7f0ffa300b40
  2019-01-14T08:27:26.132349Z qemu-kvm: usb-redir: bulk-out ep 86 stream 0 =
len 49152 id 2114122112 0x7f0ffa300b40
  2019-01-14T08:27:26.141248Z qemu-kvm: usb-redir: bulk-in status 0 ep 86 s=
tream 0 len 49152 id 2114122112 0x7f0ffa300b40
  2019-01-14T08:27:26.144932Z qemu-kvm: usb-redir: bulk-out ep 86 stream 0 =
len 49152 id 2114122112 0x7f0ffa300b40
  2019-01-14T08:27:26.154035Z qemu-kvm: usb-redir: bulk-in status 0 ep 86 s=
tream 0 len 49152 id 2114122112 0x7f0ffa300b40
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

  =C2=A0It shows that the bulk packet is single thread send and recv, per
  bulk packet will use 10-20ms, all 50 bulk-packets will use 500~1000ms,
  so the in the VM, bulk-urb will timeout always!

  =C2=A0=C2=A0How to send the bulk packet by multithread to speedup the bul=
k-urb send and recv, for example:
  ------------
  =C2=A0bulk-out ep 86 stream 0 len 49152 id xxxx1
  =C2=A0bulk-out ep 86 stream 0 len 49152 id xxxx2
  =C2=A0bulk-out ep 86 stream 0 len 49152 id xxxx3
  =C2=A0bulk-out ep 86 stream 0 len 49152 id xxxx4
  =C2=A0bulk-out ...
  =C2=A0bulk-out ep 86 stream 0 len 49152 id xxxx50
  ...
  =C2=A0bulk-in status 0 ep 86 stream 0 len 49152 id xxxx1
  =C2=A0bulk-in status 0 ep 86 stream 0 len 49152 id xxxx2
  =C2=A0bulk-in status 0 ep 86 stream 0 len 49152 id xxxx3
  =C2=A0bulk-in status 0 ep 86 stream 0 len 49152 id xxxx4
  =C2=A0bulk-out ...
  =C2=A0bulk-in status 0 ep 86 stream 0 len 49152 id xxxx50
  ------------

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1811653/+subscriptions
