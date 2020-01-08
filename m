Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F65C33C99
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 01:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 341832075A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 01:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341832075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=winaoe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip0bF-0007nR-86
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 20:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mail@winaoe.org>) id 1ip0aX-0007Ir-SG
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 20:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mail@winaoe.org>) id 1ip0aW-0001Tl-5S
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 20:56:49 -0500
Received: from vanadinet.nl ([95.170.90.142]:34066)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mail@winaoe.org>) id 1ip0aV-0001NE-SN
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 20:56:48 -0500
Received: from [10.0.0.114] ([87.214.188.202]) (authenticated bits=0)
 by vanadinet.nl (8.14.9/8.14.9) with ESMTP id 0081sV8h001736
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
 for <qemu-devel@nongnu.org>; Wed, 8 Jan 2020 02:54:33 +0100
To: qemu-devel@nongnu.org
From: "V." <mail@winaoe.org>
Subject: [PATCH/RFC 0/1] Vhost User Cross Cable: Intro
Message-ID: <98d1e1f0-0e53-d207-78ce-ea9717673985@winaoe.org>
Date: Wed, 8 Jan 2020 02:54:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by vanadinet.nl id
 0081sV8h001736
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 95.170.90.142
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi List,

For my VM setup I tend to use a lot of VM to VM single network links to d=
o routing, switching and bridging in VM's instead of the host.
Also stemming from a silly fetish to sometimes use some OpenBSD VMs as fi=
rewall, but that is besides the point here.
I am using the standard, tested and true method of using a whole bunch=C2=
=A0 of bridges, having 2 vhost taps each.
This works and it's fast, but it is a nightmare to manage with all the in=
terfaces on the host.

So, I looked a bit into how I can improve this, basically coming down to =
"How to connect 2 VM's together in a really fast and easy way".
This however, is not as straightforward as I thought, without going the w=
hole route of OVS/Snabb/any other big feature bloated
software switch.
Cause really, all I want is to connect 2 VM's in a fast and easy way. Sho=
uldn't be that hard right?

Anyways, I end up finding tests/vhost-user-bridge.c, which is very nicely=
 doing half of what I wanted.
After some doubling of the vhosts and eliminating udp, I came up with a V=
host User Cross Cable. (patch in next post).
It just opens 2 vhost sockets instead of 1 and does the forwarding betwee=
n them.
A terrible hack and slash of vhost-user-bridge.c, probably now with bugs =
causing the dead of many puppies and the end of humanity,
but it works!

However... I now am left with some questions, which I hope some of you ca=
n answer.

1.
I looked, googled, read and tried things, but it is likely that I am an c=
omplete and utter moron and my google-fu has just been awful...
Very likely... But is there really no other way then I have found to just=
 link up 2 QEMU's in a fast non-bridge way? (No, not sockets.)
Not that OVS and the likes are not fine software, but do we really need t=
he whole DPDK to do this?

2.
In the unlikely chance that I'm not an idiot, then I guess now we have a =
nice simple cross cable.
However, I am still a complete vhost/virtio idiot who has no clue how it =
works and just randomly brute-forced code into submission.
Maybe not entirely true, but I would still appreciate it very much if som=
eone with more knowledge into vhost to have a quick look at
how things are done in cc.

Specifically this monstrosity in TX (speed_killer is a 1MB buffer and kil=
ls any speed):
=C2=A0 ret =3D iov_from_buf(sg, num, 0, speed_killer,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iov_to_buf(out_sg, out_num,=
 0, speed_killer,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIN(iov_size(out_sg, out_num), sizeo=
f speed_killer)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 );

=C2=A0 vs. the commented:
=C2=A0 //ret =3D iov_copy(sg, num, out_sg, out_num, 0,
=C2=A0 //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 MIN(iov_size(sg, num), iov_size(out_sg, out_num)));

The first is obviously a quick fix to get things working, however, in my =
meager understanding, should the 2nd one not work?
Maybe I'm messing up my vectors here, or I am messing up my understanding=
 of iov_copy, but shouldn't the 2nd form be the way to zero
copy?

3.
Now if Cross Cable is actually a new and (after a code-rewrite of 10) a v=
iable way to connect 2 QEMU's together, could I actually
suggest a better way?
I am thinking of a '-netdev vhost-user-slave' option to connect (as clien=
t or server) to a master QEMU running '-netdev vhost-user'.
This way there is no need for any external program at all, the master can=
 have it's memory unshared and everything would just work
and be fast.
Also the whole thing can fall back to normal virtio if memory is not shar=
ed and it would even work in pure usermode without any
context switch.

Building a patch for this idea I could maybe get around to, don't clearly=
 have an idea how much work this would be but I've done
crazier things.
But is this is something that someone might be able to whip up in an hour=
 or two? Someone who actually does have a clue about vhost
and virtio maybe? ;-)

4.
Hacking together cc from bridge I noticed the use of container_of() to ge=
t from vudev to state in the vu callbacks.
Would it be an idea to add a context pointer to the callbacks (possibly g=
otten from VuDevIface)?
And I know. First post and I have the forwardness to even suggest an API =
change! I know!
But it makes things a bit simpler to avoid globals and it makes sense to =
have some context in a callback to know what's going on,
right? ;-)

5.
Last one, promise.
I'm very much in the church of "less software =3D=3D less bugs =3D=3D les=
s security problems".
Running cc or a vhost-user-slave means QEMU has fast networking in usermo=
de without the need for anything else then AF_UNIX + shared
mem.
So might it be possible to weed out any modern fancy stuff like the Inter=
net Protocol, TCP, taps, bridges, ethernet and tokenring
from a kernel and run QEMU on that?
The idea here is a kernel with storage, a serial console, AF_UNIX and vfi=
o-pci, only running QEMU.
Would this be feasible? Or does QEMU need a kernel which at least has a g=
rasp of understanding of what AF_INET and ethernet is?
(Does a modern kernel even still support tokenring? No idea, Probably doe=
s.)


Finally, an example and some numbers.

Compiling and starting the cross cable:
./configure
make tests/vhost-user-cc
tests/vhost-user-cc -l /tmp/left.sock -r /tmp/right.sock

(Note, the cross cable will quit if one of the vm's quits, but the VM's w=
ill reconnect when cc starts again.)

2 VM's, host1 and host2, Linux guests, run like this:

host1:
/qemu/bin/qemu-system-x86_64 \
=C2=A0 -accel kvm -nodefaults -k en-us -vnc none -machine q35 -cpu host -=
smp 8,cores=3D8 -m 2G -vga std \
=C2=A0 -object memory-backend-file,id=3Dmemory,mem-path=3D/hugetlbfs,shar=
e=3Don,size=3D2G \
=C2=A0 -numa node,memdev=3Dmemory \
=C2=A0 -drive if=3Dnone,cache=3Dnone,format=3Draw,aio=3Dnative,file=3D/de=
v/lvm/host1,id=3Dsda \
=C2=A0 -device virtio-scsi-pci,id=3Dscsi0 -device scsi-hd,drive=3Dsda,bus=
=3Dscsi0.0 \
=C2=A0 -nic tap,vhost=3Don,helper=3D/usr/libexec/qemu-bridge-helper,id=3D=
eth0,model=3Dvirtio-net-pci,mac=3D52:54:00:aa:aa:aa,br=3Dbr0 \
=C2=A0 -chardev socket,id=3Dleft,path=3D/tmp/left.sock,reconnect=3D1 \
=C2=A0 -nic vhost-user,chardev=3Dleft,id=3Deth1,model=3Dvirtio-net-pci,ma=
c=3D52:54:00:bb:bb:bb

host2:
/qemu/bin/qemu-system-x86_64 \
=C2=A0 -accel kvm -nodefaults -k en-us -vnc none -machine q35 -cpu host -=
smp 8,cores=3D8 -m 2G -vga std \
=C2=A0 -object memory-backend-file,id=3Dmemory,mem-path=3D/hugetlbfs,shar=
e=3Don,size=3D2G \
=C2=A0 -numa node,memdev=3Dmemory \
=C2=A0 -drive if=3Dnone,cache=3Dnone,format=3Draw,aio=3Dnative,file=3D/de=
v/lvm/host2,id=3Dsda \
=C2=A0 -device virtio-scsi-pci,id=3Dscsi0 -device scsi-hd,drive=3Dsda,bus=
=3Dscsi0.0 \
=C2=A0 -nic tap,vhost=3Don,helper=3D/usr/libexec/qemu-bridge-helper,id=3D=
eth0,model=3Dvirtio-net-pci,mac=3D52:54:00:cc:cc:cc,br=3Dbr0 \
=C2=A0 -chardev socket,id=3Dright,path=3D/tmp/right.sock,reconnect=3D1 \
=C2=A0 -nic vhost-user,chardev=3Dright,id=3Deth1,model=3Dvirtio-net-pci,m=
ac=3D52:54:00:dd:dd:dd


First, speed via eth0 (bridged tap with vhost, host2 runs './iperf3 -s'):
=C2=A0 root@host1:~/iperf-3.1.3/src# ./iperf3 -c 192.168.0.2 -i 1 -t 10
=C2=A0 ...
=C2=A0 [=C2=A0 4]=C2=A0=C2=A0 0.00-10.00=C2=A0 sec=C2=A0 10.7 GBytes=C2=A0=
 9.22 Gbits/sec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 receiver

Second, speed via eth1 (Vhost Cross Cable):
=C2=A0 root@host1:~/iperf-3.1.3/src# ./iperf3 -c 192.168.1.2 -i 1 -t 10
=C2=A0 ...
=C2=A0 [=C2=A0 4]=C2=A0=C2=A0 0.00-10.00=C2=A0 sec=C2=A0 2.05 GBytes=C2=A0=
 1.76 Gbits/sec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 receiver

So, a factor of 6 slowdown against bridge. Not too bad, considering the b=
ad iovec mem-copying I do.
Lots of room for improvement though, but at least for me it's also 5 time=
s faster as socket.

V.


