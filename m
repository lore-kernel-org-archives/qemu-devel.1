Received: from eggs.gnu.org ([2001:4830:134:3::10]:36899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=60423e6a7=stefano.panella@citrix.com>)
	id 1ew8XO-0005tP-4J
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=60423e6a7=stefano.panella@citrix.com>)
	id 1ew8XK-00030g-VV
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:41:58 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:29622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=60423e6a7=stefano.panella@citrix.com>)
	id 1ew8XK-0002zQ-Ji
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:41:54 -0400
From: Stefano Panella <stefano.panella@citrix.com>
Date: Wed, 14 Mar 2018 15:07:21 +0000
Message-ID: <1521040041089.43942@citrix.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] block-layer: questions on manipulation of internal
 nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi everybody,=0A=
=0A=
I am a relatively new user of qemu block layer. I am interested in it mainl=
y because it looks very powerful and general and I am hoping to integrate i=
t on our product and to contribute to it for new usecases.=0A=
=0A=
I have existing use cases where we work with a model of a disk process per =
VM disk and I am experimenting with qemu and qmp to  build something simila=
r.=0A=
=0A=
At the moment I have managed to build a new binary, called qemu-dp (probabl=
y should be called qemu-bl for block layer) which is basically starting as =
a qmp server and accepting qmp block layer commands to operate on disks.=0A=
=0A=
just to give you an example this is the kind of thing I am doing:=0A=
=0A=
EXTERNALLY:=0A=
/usr/lib64/xen/bin/qemu-img create -f qcow2 -o size=3D1M /root/a=0A=
/usr/lib64/xen/bin/qemu-img create -f qcow2 -b /root/a -o size=3D1M /root/b=
=0A=
/usr/lib64/xen/bin/qemu-img create -f qcow2 -b /root/b -o size=3D1M /root/c=
=0A=
/usr/lib64/xen/bin/qemu-img create -f qcow2 -b /root/c -o size=3D1M /root/d=
=0A=
/usr/lib64/xen/bin/qemu-img create -f qcow2 -b /root/d -o size=3D1M /root/e=
=0A=
=0A=
let's assume there were some data in every layer....=0A=
=0A=
Than:=0A=
=0A=
USING QMP:=0A=
{ "execute": "qmp_capabilities" }=0A=
{=0A=
	"execute": "blockdev-add",  =0A=
	"arguments": {=0A=
		"driver": "qcow2", =0A=
		"node-name": "qemu_node",=0A=
		"discard": "unmap",=0A=
		"cache": {=0A=
			"direct": true=0A=
		},=0A=
		"file": {=0A=
			"driver": "file",=0A=
			"filename": "/root/e"=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
{=0A=
	"execute": "nbd-server-start",=0A=
	"arguments": { =0A=
		"addr": {=0A=
			"type": "unix",=0A=
			"data": {=0A=
				"path": "/tmp/nbd.test1"=0A=
			}=0A=
		}=0A=
	}=0A=
}=0A=
=0A=
{=0A=
	"execute": "nbd-server-add",=0A=
	"arguments": { =0A=
		"device": "qemu_node",=0A=
		"writable": true=0A=
	}=0A=
}=0A=
=0A=
after this the chain looks like:=0A=
=0A=
a < b < c < d < e < NBD_server=0A=
=0A=
now I make a full copy of b and c which I call b1 and c1 and for example I =
run externally qemu-img commit c1 -> b1 while qemu-dp has still the chain o=
pened.=0A=
=0A=
I would now like to send a qmp command to tell qemu-dp to hold any IO from =
the NBD_server and forget about a, b, c and insert b1 as d's child, like th=
is:=0A=
=0A=
a < b1 < d < e < NBD_server=0A=
=0A=
I have tried to implement this qmp command and looked at =0A=
=0A=
qmp_change_backing_file()=0A=
qmp_x_blockdev_change()=0A=
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02660.html=0A=
=0A=
but did not figure out a way of doing that yet...=0A=
=0A=
I suspect my problem is that I am still very confused about the semantics o=
f the object model in the block layer, the ref counting, the graph manipula=
tion, the monitor etc. etc.=0A=
=0A=
I have tried to have some interactive chats on irc and they have been very =
useful so far (thanks again stefanha, kwolf, berto, eblake) but maybe a pro=
per email would be a good starting point as stefanha has suggested.=0A=
=0A=
Please if somebody could point me to a bit of code to achieve my example th=
at would be great, otherwise if there is no code for that kind of functiona=
lity, it would be good to have a little guide on the sequence of block prim=
iteve I should call and on which node, including refs, locking, drain, cach=
es, reopen etc...=0A=
=0A=
Thanks a lot,=0A=
=0A=
Stefano=0A=
