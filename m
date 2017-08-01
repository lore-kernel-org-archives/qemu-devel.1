Received: from eggs.gnu.org ([2001:4830:134:3::10]:45035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dcaH2-0003Cb-Bt
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dcaGx-0003uY-Be
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:44:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dcaGx-0003tD-1s
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:43:55 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v71GhpBd136109
	for <qemu-devel@nongnu.org>; Tue, 1 Aug 2017 12:43:52 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c2v82bgba-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 12:43:51 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 1 Aug 2017 12:43:45 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
References: <9E79D1C9A97CFD4097BCE431828FDD311571D704@SHSMSX103.ccr.corp.intel.com>
In-Reply-To: <9E79D1C9A97CFD4097BCE431828FDD311571D704@SHSMSX103.ccr.corp.intel.com>
Date: Tue, 01 Aug 2017 11:43:38 -0500
Message-Id: <150160581804.32118.1248845549166324825@loki>
Subject: Re: [Qemu-devel] Does qemu guest agent support 'guest-exec'?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Hu, Robert" <robert.hu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>

Quoting Hu, Robert (2017-08-01 02:15:01)
> Hi,
> =

> qemu/scripts/qmp/qemu-ga-client seems only support "cat, fsfreeze, fstrim=
, halt, ifconfig, info, ping, powerdown, reboot, shutdown, suspend".
> =

> But from qemu/qga/commands.c seems at least Linux guest should already su=
pport this. Despite qemu-ga-client, how can I talk to guest-agent in guest =
to execute some program? any other utils?

qemu-ga-client is more of a helper script to make it easier to execute
things from cmdline and hasn't been updated to support guest-exec. But
the official API is documented in qga/qapi-schema.json and involves
talking to qemu-ga directly via JSON commands. A simple example for
guest-exec would be something like:

mdroth@loki:~$ sudo nc -U /tmp/vm3-qga.sock
{'execute':'guest-exec','arguments':{'path':'ip','arg': ['addr', 'show', 'e=
th0'],'capture-output':true}}
{"return": {"pid": 1462}}
{'execute':'guest-exec-status','arguments':{'pid':1462}}
{"return": {"exitcode": 0, "out-data": "MjogZXRoMDogPEJST0FEQ0FTVCxNVUxUSUN=
BU1QsVVAsTE9XRVJfVVA+IG10dSAxNTAwIHFkaXNjIHBmaWZvX2Zhc3Qgc3RhdGUgVVAgZ3JvdX=
AgZGVmYXVsdCBxbGVuIDEwMDAKICAgIGxpbmsvZXRoZXIgNTI6NTQ6MDA6MTI6MzQ6MDMgYnJkI=
GZmOmZmOmZmOmZmOmZmOmZmCiAgICBpbmV0IDE5Mi4xNjguMTIyLjEzLzI0IGJyZCAxOTIuMTY4=
LjEyMi4yNTUgc2NvcGUgZ2xvYmFsIGR5bmFtaWMgZXRoMAogICAgICAgdmFsaWRfbGZ0IDMwNjR=
zZWMgcHJlZmVycmVkX2xmdCAzMDY0c2VjCiAgICBpbmV0NiBmZTgwOjo1MDU0OmZmOmZlMTI6Mz=
QwMy82NCBzY29wZSBsaW5rIAogICAgICAgdmFsaWRfbGZ0IGZvcmV2ZXIgcHJlZmVycmVkX2xmd=
CBmb3JldmVyCg=3D=3D", "exited": true}}
^C
mdroth@loki:~$ cat <<EOF | base64 -d
MjogZXRoMDogPEJST0FEQ0FTVCxNVUxUSUNBU1QsVVAsTE9XRVJfVVA+IG10dSAxNTAwIHFkaXN=
jIHBmaWZvX2Zhc3Qgc3RhdGUgVVAgZ3JvdXAgZGVmYXVsdCBxbGVuIDEwMDAKICAgIGxpbmsvZX=
RoZXIgNTI6NTQ6MDA6MTI6MzQ6MDMgYnJkIGZmOmZmOmZmOmZmOmZmOmZmCiAgICBpbmV0IDE5M=
i4xNjguMTIyLjEzLzI0IGJyZCAxOTIuMTY4LjEyMi4yNTUgc2NvcGUgZ2xvYmFsIGR5bmFtaWMg=
ZXRoMAogICAgICAgdmFsaWRfbGZ0IDMwNjRzZWMgcHJlZmVycmVkX2xmdCAzMDY0c2VjCiAgICB=
pbmV0NiBmZTgwOjo1MDU0OmZmOmZlMTI6MzQwMy82NCBzY29wZSBsaW5rIAogICAgICAgdmFsaW=
RfbGZ0IGZvcmV2ZXIgcHJlZmVycmVkX2xmdCBmb3JldmVyCg=3D=3D
EOF
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state =
UP group default qlen 1000
    link/ether 52:54:00:12:34:03 brd ff:ff:ff:ff:ff:ff
    inet 192.168.122.13/24 brd 192.168.122.255 scope global dynamic eth0
       valid_lft 3064sec preferred_lft 3064sec
    inet6 fe80::5054:ff:fe12:3403/64 scope link =

       valid_lft forever preferred_lft forever


> =

> Best Regards,
> Robert Hoo
> =

>=20
