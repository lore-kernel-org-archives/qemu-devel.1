Received: from eggs.gnu.org ([2001:4830:134:3::10]:35262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1cqmIT-0007FS-9t
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 15:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1cqmIQ-0008HR-6t
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 15:51:53 -0400
Received: from mail-db5eur01on0129.outbound.protection.outlook.com
	([104.47.2.129]:45792
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <janne.huttunen@nokia.com>)
	id 1cqmIP-0008H8-OR
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 15:51:50 -0400
Message-ID: <1490195960.19055.105.camel@nokia.com>
From: Janne Huttunen <janne.huttunen@nokia.com>
Date: Wed, 22 Mar 2017 17:19:20 +0200
In-Reply-To: <8616b7ec-8306-25b4-267c-449f94261502@redhat.com>
References: <cover.1489494746.git.janne.huttunen@nokia.com>
	<1489510640.8844.18.camel@redhat.com>
	<1489561105.24841.25.camel@nokia.com>
	<11a3eab4-77f8-87ea-9558-299fbfc77a07@redhat.com>
	<1490164614.19055.31.camel@nokia.com>
	<1558854179.6445757.1490172190685.JavaMail.zimbra@redhat.com>
	<1490173225.19055.48.camel@nokia.com>
	<c1a80bf6-1379-8402-06d4-01247825fcf0@redhat.com>
	<1490191138.19055.92.camel@nokia.com>
	<8616b7ec-8306-25b4-267c-449f94261502@redhat.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC][PATCH 0/6] "bootonceindex" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Wed, 2017-03-22 at 15:36 +0100, Laszlo Ersek wrote:
>=C2=A0
> To my knowledge, currently the bootindex properties cannot be changed
> dynamically (for example with monitor commands) after they have been
> specified on the QEMU command line.

Yes they can, via QMP:

{'execute': 'qom-get', 'arguments': { 'path': 'scsi0.0/child[0]',
'property': 'bootindex' }}
{"return": 10}

{'execute': 'qom-set', 'arguments': { 'path': 'scsi0.0/child[0]',
'property': 'bootindex', 'value': 11 }}
{"return": {}}

{'execute': 'qom-get', 'arguments': { 'path': 'scsi0.0/child[0]',
'property': 'bootindex' }}
{"return": 11}


I have no idea if doing so breaks something, like e.g.
migration, but it definitely can be done.

> And, even if some settings can be changed, the question is what agent
> changes them. If the management layer (libvirt etc) changes them
> using
> monitor commands, then libvirt itself can keep track of that state,
> and
> then start the QEMU process on the destination=C2=A0=C2=A0host with a sui=
tably
> modified command line.
>=20
> Whereas, if it is the guest that changes device state, memory state
> etc,
> then those things have to be part of the migration stream.

True.

> > If it
> > is, migrating the "bootonceindex" values the same way should
> > be sufficient, no?
> To my knowledge, "bootindex" properties are not migrated now, and
> they
> also need not to, because they never change at runtime.

Like demonstrated above, they can change, but of course
there might be an assumption that they won't change
"unexpectedly".

> If the second system sets a temporary boot order for the first system
> "every now and then", which I guess entails on-demand talking to the
> first system's management processor, then how can you replace that
> with
> a static QEMU command line (with the proposed bootonceindex
> property)?

I'm not. I'm using QMP to change the index dynamically.

> I'm not saying that the use case is without merit. My point is that
> this
> new property would introduce obscure interactions with other
> components
> in the virt stack around QEMU, and it could have a significant
> maintenance footprint, while the feature does look niche (to me
> anyway).

Maybe, and it is definitely good to analyze it. Like I
already admitted, I did not think about migration at all
and there may very well have been other things I have
overlooked too.
