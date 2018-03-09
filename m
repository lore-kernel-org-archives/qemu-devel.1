Received: from eggs.gnu.org ([2001:4830:134:3::10]:57763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1euLgy-00036S-Tq
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:20:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1euLgt-0003Hn-Pw
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:20:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34858 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1euLgt-0003Gg-BF
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:20:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78FE7406E97D
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 17:20:18 +0000 (UTC)
References: <1520576005-27647-1-git-send-email-thuth@redhat.com>
	<5464ff65-85d4-4537-a603-fd20074d375f@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c89e8a02-7ca8-2059-8fa7-3de6e554e59d@redhat.com>
Date: Fri, 9 Mar 2018 18:20:11 +0100
MIME-Version: 1.0
In-Reply-To: <5464ff65-85d4-4537-a603-fd20074d375f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Rework the network options
 chapter to make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>

On 09.03.2018 15:41, Paolo Bonzini wrote:
> On 09/03/2018 07:13, Thomas Huth wrote:
>> +
>> +@item --nic none
>> +Indicate that no network devices should be configured. It is used to =
override
>> +the default configuration (default NIC with @option{--net user} backe=
nd) which
>=20
> the default @option{--nic user} configuration (default model and
> user-mode networking backend), which...

Technically, this isn't true, is it? The default configuration is still
"-net nic -net user", i.e. you still get a "vlan" hub inbetween the two,
don't you?

>> +is activated if no other networking options are provided.
>> +
>=20
>> -qemu-system-i386 -net user,hostfwd=3Dtcp::5555-:23 [...]
>> +qemu-system-i386 --device e1000,netdev=3Dn1 --netdev user,id=3Dn1,hos=
tfwd=3Dtcp::5555-:23
>=20
> I would use --nic here.  --device/--netdev is covered by
> docs/qdev-device-use.txt, which should be updated separately (it even
> has -usbdevice still).

I don't think that the average user looks at qdev-device-use.txt, so
IMHO we should give examples for both, --nic and --netdev/--device in
our qemu-doc.html. But ok, I've got a dedicated example in the first
paragraph about "--nic" already, so I think it should be fine to use
--nic in even more places.

>> -qemu -net 'user,guestfwd=3Dtcp:10.0.2.100:1234-cmd:netcat 10.10.1.1 4=
321'
>> +qemu-system-i386 --device e1000,netdev=3Dn1 \
>> +  --netdev 'user,id=3Dn1,guestfwd=3Dtcp:10.0.2.100:1234-cmd:netcat 10=
.10.1.1 4321'
>=20
> Same here.
>=20
> Single vs. double-dash options is a confusing one and I'm not sure how
> to proceed.  On one hand single-dash is what everyone uses, on the othe=
r
> double-dash is a bit more consistent with e.g. qemu-img.

I guess that QEMU newbies are also rather using double dashes since this
is what you're used to from other command line tools.

> But:
>=20
> 1) the command-line of qemu-img is anyway completely different from QEM=
U's

Sure, but at least the basic handling should IMHO be similar.

> 2) mixing them is the worst of both worlds.
>=20
> I honestly would use single-dashes, and add a note that double-dash
> options are supported as well.

If we decide to go with single dashes forever, we should urgently remove
the BiteSizeTask from the Wiki again.
But I think we rather should try to do switch to double dashes. It's
really just more consistent and less confusing for newbies.

 Thomas
