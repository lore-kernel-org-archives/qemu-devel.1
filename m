Received: from eggs.gnu.org ([2001:4830:134:3::10]:59817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.de_backer@nokia.com>) id 1gXQn0-0005AA-VJ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.de_backer@nokia.com>) id 1gXQmx-0007F6-K7
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:12:30 -0500
Received: from mail-eopbgr00121.outbound.protection.outlook.com
	([40.107.0.121]:30336
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fred.de_backer@nokia.com>)
	id 1gXQmu-00077n-L8
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:12:26 -0500
From: "De Backer, Fred (Nokia - BE/Antwerp)" <fred.de_backer@nokia.com>
Date: Thu, 13 Dec 2018 13:12:12 +0000
Message-ID: <DB6PR07MB3333E95C513AF2EF14AAE615AEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
References: <DB6PR07MB33330E3562B0AF0ECC8307BCAEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
In-Reply-To: <DB6PR07MB33330E3562B0AF0ECC8307BCAEA00@DB6PR07MB3333.eurprd07.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] Request for clarification on qemu-img convert behavior
 zeroing target host_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Aamir T, Owais (Nokia - IN/Chennai)" <owais.aamir_t@nokia.com>

Hi,

We're using Openstack Ironic to deploy baremetal servers. During the deploy=
ment process an agent (ironic-python-agent) running on Fedora linux uses qe=
mu-img to write a qcow2 file to a blockdevice.

Recently we saw a change in behavior of qemu-img. Previously we were using =
Fedora 27 containing a fedora packaged version of qemu-img v2.10.2 (qemu-im=
g-2.10.2-1.fc27.x86_64.rpm); now we use Fedora 29 containing a fedora packa=
ged version of qemu-img v3.0.0 (qemu-img-3.0.0-2.fc29.x86_64.rpm).

The command that is run by the ironic-python-agent (the same in both FC27 a=
nd FC29) is: qemu-img -t directsync -O host_device /tmp/image.qcow2 /dev/sd=
a

We observe that in Fedora 29 the qemu-img, before imaging the disk, it full=
y zeroes it. Taking into account the disk size, the whole process now takes=
 35 minutes instead of 50 seconds. This causes the ironic-python-agent oper=
ation to time-out. The Fedora 27 qemu-img doesn't do that.

Scanning through the qemu-img source code, we found that adding -S 0 to the=
 command on Fedora 29 qemu-img restores the behavior as observed in Fedora =
27 qemu-img.

Looking through the changelogs of qemu I couldn't find this behavior change=
 documented.

Now the questions:
* Is this the expected/required behavior that qemu-img first zeroes the com=
plete target disk before writing the image. In other words: is this a qemu-=
img bug?
* Is applying the -S 0 parameter a safe/sound/sensible thing to do to rever=
t to the old behavior. In other words: can I write a bug against the ironic=
-python-agent to start using this parameter?
* If the behavior is expected: is there some pointer to documentation/chang=
elogs I can read about this?

Thanks,
Regards,

Fred De Backer
SME Video Integration Engineer,
IP/Optical Networks, Nokia
fred.de_backer@nokia.com

Nokia Bell NV I Copernicuslaan 50, 2018 Antwerpen I BTW BE 0404 621 642 RPR=
 Antwerpen I BNP Paribas Fortis 220-0002334-42 I IBAN BE 77 2200 0023 3442 =
I BIC GEBABEBB

<<
This message (including any attachments) contains confidential information =
intended for a specific individual and purpose, and is protected by law. If=
 you are not the intended recipient, you should delete this message. Any di=
sclosure, copying, or distribution of this message, or the taking of any ac=
tion based on it, is strictly prohibited without the prior consent of its a=
uthor.
>>
