Received: from eggs.gnu.org ([209.51.188.92]:40999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1gorng-0001dI-5x
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:29:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1gornf-00076D-7V
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:29:16 -0500
Received: from isrv.corpit.ru ([86.62.121.231]:59617)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mjt@tls.msk.ru>) id 1gornf-00072w-00
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:29:15 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
	by isrv.corpit.ru (Postfix) with ESMTP id 057E641191
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 18:29:05 +0300 (MSK)
Received: from [192.168.177.103] (mjtmob.vpn.tls.msk.ru [192.168.177.103])
	by tsrv.corpit.ru (Postfix) with ESMTP id DF40DE0
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 18:29:04 +0300 (MSK)
References: <1548847315066.52692@radarservices.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <ce2887d4-5e5d-bb33-77af-5ebb1e1c2463@msgid.tls.msk.ru>
Date: Wed, 30 Jan 2019 18:29:04 +0300
MIME-Version: 1.0
In-Reply-To: <1548847315066.52692@radarservices.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: ru-RU
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] SPICE session's connection_id's are not unique
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Forwarding to qemu-devel@ from http://bugs.debian.org/920897

Thanks,

/mjt

-------- Forwarded message --------
Subject: 	Bug#920897: SPICE session's connection_id's are not unique
Date: 	Wed, 30 Jan 2019 11:21:54 +0000
From: 	Philip Pum <Philip.Pum@radarservices.com>


Package: qemu-system-x86
Version: 1:2.8+dfsg-6+deb9u4


When creating a virtual machine with qemu (e.g. via libvirt) including a =
SPICE server, the client_id of the SPICE session is not unique. For examp=
le, starting multiple virtual machines on the same libvirtd, the client_i=
d is the same for all virtual machine's SPICE sessions.


A description of the client_id can be found in

https://www.spice-space.org/static/docs/spice_protocol.pdf=A0under sectio=
n 2.11. c) :


"UINT32 connection_id - In case of a new session (i.e., channel type is R=
ED_CHANNEL_MAIN) this field is set to zero, and in response the server wi=
ll allocate session id and will send it via the RedLinkReply message. In =
case of all other channel types, this field will be equal to the allocate=
d session id"


The relevant code for generating client ids in libspice-server1 can be fo=
und here: https://gitlab.freedesktop.org/spice/spice/blob/v0.12.8/server/=
reds.c#L1614

This uses rand() to generate the random id, but qemu (at least in the cas=
e of qemu-system-x86) fails to initialize the RNG seed (with e.g. srand()=
).


The result is, that every SPICE session started (by e.g. libvirtd) has th=
e same client_id. Usually, this is not a problem, but running something l=
ike a SPICE proxy, relying on the client_id to correctly route connection=
s, this creates problems.


Adding something like 'srand(time(NULL));' to qemu (in vl.c) solves this =
issue. Related (as seen in some VNC patches, e.g.=A0'CVE-2017-15124/04-ui=
-avoid-pointless-VNC-updates-if-framebuffer-isn-t-.patch/ui/vnc.c' ):=A0 =
srand(time(NULL)+getpid()+getpid()*987654+rand());


Tested on Debian 9.7 with kernel=A0 4.9.0-6-amd64 #1 SMP Debian 4.9.88-1+=
deb9u1 (2018-05-07) x86_64 GNU/Linux.
