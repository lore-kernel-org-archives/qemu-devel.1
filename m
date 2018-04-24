Received: from eggs.gnu.org ([2001:4830:134:3::10]:51081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fAyXS-0002yn-Hn
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fAyXL-0008FD-0O
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:03:22 -0400
References: <1524570294-23058-1-git-send-email-thuth@redhat.com>
	<d2a9fc1a-9696-f2bd-d603-03b23de62004@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <87f6ba73-2ded-06f2-c68f-d8ef4be50edf@redhat.com>
Date: Tue, 24 Apr 2018 16:02:59 +0200
MIME-Version: 1.0
In-Reply-To: <d2a9fc1a-9696-f2bd-d603-03b23de62004@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] hw/s390x: Allow to configure the
 consoles with the "-serial" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 24.04.2018 13:49, Christian Borntraeger wrote:
>=20
>=20
> On 04/24/2018 01:44 PM, Thomas Huth wrote:
>> The consoles ("sclpconsole" and "sclplmconsole") can only be configure=
d
>> with "-device" and "-chardev" so far. Other machines use the convenien=
ce
>> option "-serial" to configure the default consoles, too, even for virt=
ual
>> consoles like spapr-vty on the pseries machine. So let's support this
>> option on s390x, too, so we can easily enable the serial console here
>> again with "-nodefaults", for example. Also map the second -serial
>> option to the "sclplmconsole", so that there is now an easy way to
>> configure this second console on s390x, too.
>> Additionally, the new code is also smaller than the old one and we hav=
e
>> less s390x-specific code in vl.c :-)
>=20
> Can you show some new example command lines?

Sure. I'm mainly using this together with nodefaults:

qemu-system-s390x -no-shutdown -nographic -nodefaults -serial mon:stdio

That's way easier than typing:

qemu-system-s390x -no-shutdown -nographic -nodefaults \
  -chardev stdio,id=3Dc1,mux=3Don -device sclpconsole,chardev=3Dc1 \
  -mon chardev=3Dc1

Another example: You only want to see the QEMU monitor on stdio, but not
the serial output, without using -nodefaults (i.e. you still want to
have the other default devices). AFAIK that's pretty impossible with the
current code. But once you've got this patch applied, you can do:

qemu-system-s390x -no-shutdown -nographic -serial none

And to view the sclplm console, you can now simply do:

qemu-system-s390x -no-shutdown -nographic -serial null -serial mon:stdio

> I read that as "the current command lines continue to work". Correct?

Right. I was a little bit afraid that this might break migration, but I
gave it a quick check and it still seems to work fine here.
"info qom-tree" and "info qtree" at the HMP monitor show slightly
different output, though ... not sure whether that's critical or not?

 Thomas
