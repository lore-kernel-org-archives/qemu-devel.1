Received: from eggs.gnu.org ([2001:4830:134:3::10]:40463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evMoi-000243-9W
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evMod-0006K8-BI
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:44:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51068 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1evMod-0006HW-61
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:44:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E4318190282
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 12:44:23 +0000 (UTC)
References: <1520839658-20499-1-git-send-email-thuth@redhat.com>
	<2a85941f-48bf-9e9b-0d6d-832a270d882b@redhat.com>
	<7413bf34-63ec-837d-d418-af2cfd1038d7@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bc5f376b-ee95-5ce9-8c7c-32e75df97ec3@redhat.com>
Date: Mon, 12 Mar 2018 13:44:16 +0100
MIME-Version: 1.0
In-Reply-To: <7413bf34-63ec-837d-d418-af2cfd1038d7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qemu-doc: Rework the network options
 chapter to make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

On 12/03/2018 13:18, Eric Blake wrote:
> On 03/12/2018 04:07 AM, Paolo Bonzini wrote:
>> On 12/03/2018 08:27, Thomas Huth wrote:
>>> "-net" is clearly a legacy option. Yet we still use it in almost all
>>> examples in the qemu documentation, and many other spots in the netwo=
rk
>>> chapter. We should make it less prominent that users are not lured in=
to
>>> using it so often anymore. So instead of starting the network chapter
>>> with
>>> "-net nic" and documenting "-net <backend>" below "-netdev <backend>"
>>> everywhere, all the "-net" related documentation is now moved to the =
end
>>> of the chapter. The new "--nic" option is moved to the beginning of t=
he
>>> chapter instead, with a new example that should demonstrate how "--ni=
c"
>>> can be used to shortcut "--device" with "--netdev". The examples in t=
his
>>> chapter are changed to use the "--device" and "--netdev" options or
>>> "--nic" instead of "-net nic -net <backend>".
>>>
>>> While we're at it, also remove a legacy remark about very old Linux
>>> distributions. Also remove the "[...]" from the examples in this chap=
ter
>>> since we are not using this ellipsis in any other examples in our doc=
u-
>>> mentation.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>> =C2=A0 v2:
>>> =C2=A0 - Fixed the bad "--device=3De1000" example
>>
>> Frankly I think this is the proof that double-dash option names are a
>> bad idea.=C2=A0 The reason to do that was to make qemu-img and qemu co=
mmand
>> lines more similar in the documentation, but the truth is they are not
>> similar and shouldn't be made similar.=C2=A0 The equal sign is one exa=
mple,
>> where qemu-img supports "--format=3Draw" but QEMU doesn't support
>> "--device=3De1000", but it's not the only one.
>=20
> Our hand-rolled parser sucks.=C2=A0 We should fix it to be more like ge=
topt,
> at which point --device=3De1000 would work.

"--device=3De1000,netdev=3Duser0" is also pretty confusing, as is
"--machine=3Dkernel_irqchip=3Doff".

>> qemu-img supports things such as "-fraw", qemu doesn't---for example
>> "-m1024" doesn't work).
>=20
> Our hand-rolled parser sucks.=C2=A0 We should fix it to be more like ge=
topt,
> at which point -m1024 would work.

For -m1024 it makes sense, but what about -d?  How do you explain that
"-din_asm" is a short form of "-d in_asm", but "-device" is not a short
form of "-d evice"?

I agree that having a non-standard option parser is bad, but
getopt_long_only always seemed to me like the worst of both worlds.
"All options are 'long', cannot be abbreviated, must be separated from
their argument" is pretty easy.

All that matters for "-object" and "--object", I'd argue, is that the
syntax of the key-value list is the same for the two (and also the same
for the object_add HMP command).  Whether to spell it with one or two
dashes should not be an issue; we could perhaps take a hint for git's
"commit -amend" behavior and print a special error message if the user
writes "qemu-img -object" with one dash.

   $ qemu-img convert -object ~/chipsec.img bar
   qemu-img: Invalid parameter 'bject'

Instead it could be something like:

   $ qemu-img convert -object ~/chipsec.img bar
   qemu-img: did you mean '--object' (with two dashes)?

Thanks,

> For -object vs. --object (which IS used identically between qemu-img an=
d
> qemu proper), we really do want to favor a common spelling (which
> perhaps means we need to first fix our hand-rolled parser to not suck s=
o
> much - possibly by rewriting it to use getopt_long_only()).=C2=A0 For o=
ptions
> like -nic vs. --nic, which have no (current) counterpart in qemu-img,
> it's a harder sell (as you continue to argue), but Dan's original
> suggestion to prefer double-dash in the documentation was because
> consistency helps (and if that means improving our parser to behave mor=
e
> consistently, that's a good thing).
