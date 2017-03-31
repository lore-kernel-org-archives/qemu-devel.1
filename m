Received: from eggs.gnu.org ([2001:4830:134:3::10]:45644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Ciprian.Barbu@enea.com>) id 1cu0Pn-0005w0-5f
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Ciprian.Barbu@enea.com>) id 1cu0Pi-0001LS-Fc
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:32:47 -0400
Received: from smtp-out10.electric.net ([185.38.180.47]:54622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Ciprian.Barbu@enea.com>)
	id 1cu0Pi-0001Kn-6N
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:32:42 -0400
From: Ciprian Barbu <Ciprian.Barbu@enea.com>
Date: Fri, 31 Mar 2017 17:32:37 +0000
Message-ID: <C885D0FF6A27744DB0B822E32DF6EF029B1CA239@SESTOEX04.enea.se>
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
In-Reply-To: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Alexandru Avadanii <Alexandru.Avadanii@enea.com>
Cc: Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, svc-armband <armband@enea.com>

I suspect the culprit here is [1]. I've started a git bisect between this c=
ommit and v2.8.0 and during this time I found similar erros "/root/qemu/nbd=
/server.c:nbd_receive_request():L706: read failed"

I suspect this fix tried to solve a bunch of these read fails, but broke wr=
ite requests.

[1] https://github.com/qemu/qemu/commit/8a7ce4f9338c475df1afc12502af704e430=
0a3e0

From: cosnos-bounces@list.enea.se [mailto:cosnos-bounces@list.enea.se] On B=
ehalf Of Ciprian Barbu
Sent: Friday, March 31, 2017 7:04 PM
To: qemu-devel@nongnu.org; Eric Blake <eblake@redhat.com>; Alexandru Avadan=
ii <Alexandru.Avadanii@enea.com>
Cc: Jeff Cody <jcody@redhat.com>; Markus Armbruster <armbru@redhat.com>; sv=
c-armband <armband@enea.com>
Subject: [Cosnos] [Qemu-devel] nbd: Possible regression in 2.9 RCs

Hello,

Similar to the other thread about possible regression with rbd, there might=
 be a regression with nbd.
This time we are launching an instance from an image (not volume) and try t=
o live migrate it:

nova live-migration <test_instance>

The nova-compute service complains with:

2017-03-31 15:32:56.179 7806 INFO nova.virt.libvirt.driver [req-15d79cbe-59=
56-4738-92df-3624e6b993ee d795de59fb9a4ea38776a11d20ae8469 cee03e74881f4ccb=
a3b83345fb652b2c - - -] [instance: 6a04508f-5d79-4582-8e2c-4cc368753f6c] Mi=
gration running for 0 secs, memory 100% remaining; (bytes processed=3D0, re=
maining=3D0, total=3D0)
2017-03-31 15:32:58.029 7806 WARNING stevedore.named [req-73bc0113-5555-4dd=
8-8903-d3540cc61b47 b9fbceeadd2d4d1bab9c90ae104db1f7 7e7db99b32c6467184701e=
9a0c2f1de7 - - -] Could not load instance_network_info
2017-03-31 15:32:59.038 7806 ERROR nova.virt.libvirt.driver [req-15d79cbe-5=
956-4738-92df-3624e6b993ee d795de59fb9a4ea38776a11d20ae8469 cee03e74881f4cc=
ba3b83345fb652b2c - - -] [instance: 6a04508f-5d79-4582-8e2c-4cc368753f6c] L=
ive Migration failure: internal error: unable to execute QEMU command 'nbd-=
server-add': Conflicts with use by drive-virtio-disk0 as 'root', which does=
 not allow 'write' on #block143
2017-03-31 15:32:59.190 7806 ERROR nova.virt.libvirt.driver [req-15d79cbe-5=
956-4738-92df-3624e6b993ee d795de59fb9a4ea38776a11d20ae8469 cee03e74881f4cc=
ba3b83345fb652b2c - - -] [instance: 6a04508f-5d79-4582-8e2c-4cc368753f6c] M=
igration operation has aborted

I will try and bisect it myself, but I thought I would paste this here firs=
t, just so you know there is this issue too.

Regards,
/Ciprian
