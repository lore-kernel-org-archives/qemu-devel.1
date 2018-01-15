Received: from eggs.gnu.org ([2001:4830:134:3::10]:53919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eb99d-0004Ak-Dz
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eb99a-0000RF-9z
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:06:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eb99a-0000Qj-3t
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:06:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18EAD883CA
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 18:06:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
References: <1515594755-12138-1-git-send-email-thuth@redhat.com>
	<73e534aa-ba61-e3ca-6730-3382f1c1ce1a@redhat.com>
	<848373da-2010-d38b-fd88-91cd61dec91e@redhat.com>
Message-ID: <28cccfd1-dca4-c074-0f74-1cf29c143a9c@redhat.com>
Date: Mon, 15 Jan 2018 19:06:27 +0100
MIME-Version: 1.0
In-Reply-To: <848373da-2010-d38b-fd88-91cd61dec91e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: Allow hubports to connect to other
 netdevs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>

On 15.01.2018 18:36, Thomas Huth wrote:
> On 15.01.2018 08:40, Jason Wang wrote:
[...]
>> And since it was a hub, do we need to send to its netdev too inside
>> net_hub_receive()?
>=20
> I currently don't think so, but I'll check again...

OK, I now think we're definitely fine here. The check is really just
there to make sure that we do not send the packet back to the same
sender. And I've checked with a command line like this that network
traffic (TFTP booting in this case) works as expected:

qemu-system-ppc64 -vga none -nographic \
 -netdev user,id=3Ds1,tftp=3D/path/to/tftpdir,bootfile=3Dppc64.img \
 -netdev hubport,hubid=3D1,id=3Dh1,netdev=3Ds1  \
 -netdev hubport,hubid=3D1,id=3Dh3 -device virtio-net-pci,netdev=3Dh3 \
 -boot n -object filter-dump,id=3Df1,netdev=3Ds1,file=3D/tmp/dump.dat

Both, the behaviour of the TFTP boot in the guest and the wireshark dump
looked fine, there were no missing packets here.

 Thomas
