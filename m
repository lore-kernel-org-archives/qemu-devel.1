Received: from eggs.gnu.org ([2001:4830:134:3::10]:57301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQ7vx-0004Fx-Es
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 04:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQ7vu-0006xF-CQ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 04:02:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dQ7vu-0006wp-4d
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 04:02:42 -0400
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
	<23ec1642-053c-a15a-c03f-d9e48d1447e7@linux.vnet.ibm.com>
	<c664ff99-e98d-459d-2b07-306e0d00c5b7@redhat.com>
	<29018087-c00b-abb2-47e6-4ebfc954ff1f@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b1bf85e6-20b8-a77c-d20b-ffc6fe570e9b@redhat.com>
Date: Wed, 28 Jun 2017 10:02:34 +0200
MIME-Version: 1.0
In-Reply-To: <29018087-c00b-abb2-47e6-4ebfc954ff1f@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 00/14] Implement network booting
 directly into the s390-ccw BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Jens Freimann <jfreiman@redhat.com>, David Hildenbrand <david@redhat.com>

On 28.06.2017 09:28, Viktor Mihajlovski wrote:
> On 27.06.2017 23:40, Thomas Huth wrote:
> [...]
>>>> - Is it OK to require loading an .INS file first? Or does anybody
>>>>   have a better idea how to load multiple files (kernel, initrd,
>>>>   etc. ...)?
>>> It would be nice to support PXE-style boot, because the majority of b=
oot
>>> servers is set up that way. A straightforward way would be to do a PX=
E
>>> emulation by attempting to download a pxelinux.cfg from the well-know=
n
>>> locations, parsing the content (menu) and finally load the kernel,
>>> initrd and set the kernel command line as specified there. (I know, b=
ut
>>> you're already parsing the INS-File).
>>
>> Please, don't mix up PXE and pxelinux (since you've used both terms in
>> above paragraph). Assuming that you're only talking about pxlinux conf=
ig
>> files... are they that common on s390x already? Using the pxelinux
>> config file syntax sounds like we would be completely bound to only
>> loading Linux guests to me, since the boot loader has to know where to
>> load the initrd and how to patch the kernel so that it can find the in=
itrd.
>> Using .INS files sounds more flexible to me instead, since you can als=
o
>> specify the addresses here - so you can theoretically also load other
>> guest kernels, and that's IMHO the better approach since a firmware
>> should stay as generic as possible.
>>
> In order to be consumable, the network boot should support the most
> common configurations. I would think that most network boot servers are
> setup as PXE boot servers using pxelinux configs.

Are you really sure about the popularity of pxelinux? It's just one
flavor of secondary stage network boot loaders - which also only exist
on x86 so far, as far as I know. You can also use other loaders like
grub2 or gPXE there instead. And other architectures also do not use
pxelinux. For example on PowerPC, you normally use yaboot or grub2 as
secondary stage boot loader via network instead.
 > It will do no good to tell system administrators to have a totally>
different setup for s390 boot clients.

Trying to mimic pxelinux in the firmware still sounds wrong to me. That
might also cause some confusion, e.g. if something in the config file is
not fully supported (like menus?), or people might start wondering where
to get the pxelinux binary itself for s390x ...
Maybe it would be better to port the pxelinux binary to s390x?

> If the firmware doesn't support it we will have to fall
> back to provide a Linux-based fat netboot image to the pxelinux handlin=
g
> :-(.

So far I haven't seen such a Linux-based netboot image yet ([1] mentions
pxelinux, but not what software should be used to parse the config
file), ... do you have a pointer to the software that parses the
pxelinux config file there?

 Thomas

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg04333.html
