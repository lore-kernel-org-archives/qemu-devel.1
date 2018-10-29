Received: from eggs.gnu.org ([2001:4830:134:3::10]:53973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHDvg-00012g-I6
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHDvZ-0002Pt-Mt
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:14:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gHDvW-0002Nu-Tw
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 16:14:19 -0400
References: <87mur0ls8o.fsf@dusky.pond.sub.org>
	<20181026142216.GB493@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5fe24aeb-bf5c-a840-2f0a-6997187e4d28@redhat.com>
Date: Mon, 29 Oct 2018 16:14:11 -0400
MIME-Version: 1.0
In-Reply-To: <20181026142216.GB493@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Minutes of KVM Forum BoF on deprecating stuff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Pino Toscano <ptoscano@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>, Christophe de Dinechin <cdupontd@redhat.com>, qemu-devel@nongnu.org, Laine Stump <laine@redhat.com>, Thomas Huth <thuth@redhat.com>, Andrea Bolognani <abologna@redhat.com>



On 10/26/2018 10:22 AM, Daniel P. Berrang=C3=A9 wrote:
>=20
> On Fri, Oct 26, 2018 at 04:03:51PM +0200, Markus Armbruster wrote:
>> This is from my (imperfect) notes, corrections welcome.
>>
>> Motivation: QEMU contains stuff of dubious value, which gets in the wa=
y
>> in various (sometimes painful and expensive) ways.
>>
>> Deprecation is the marking of an external interface as "we intend to
>> remove this, you should stop using it" (preferably with advice on what
>> to use instead).  We have a deprecation policy to guide us through thi=
s
>> process.
>=20
>=20
> Something I meant to bring up but forgot is about the classification
> of devices, especially with a view towards security. It is not directly
> about deprecation, but it is somewhat related as it is related  to the
> state of maintainence and quality level
>=20
> We've got alot of devices, but only a subset are written and maintained
> to a level where we'd consider them robust wrt malcious guests. Other
> devices are only suitable for friendly guest environments. We should
> clearly document which are the devices that we consider to provide
> a secure boundary to guests, so users can make suitably informed choice=
s.
> I'd guess this means all virtio devices, and then few of the emulated
> devices that are commonly used & maintained in a KVM environment.
>=20
> This would be useful for distros/vendors/users who wish to limit their
> potential attack surface once we have a KConfig system for fine grained
> disablement of features.
>=20

It would be really helpful to describe which devices receive which kind
of support.

At the highest tier of support, we offer some kind of guarantee: this
device is secure (as far as we know), and will receive CVE patches prompt=
ly.

At the next tier of support, we expect that the device works, but it may
be best-effort.

At the lowest tier, the devices are experimental and absolutely should
not show up in a production environment.

Of course, RHEL's configuration has made some assessments as to what's
safe and what isn't -- but this information isn't reflected here in our
upstream configuration.

It would be nice to effectively convert everything over to qdev, make
the support level a metadata construct, and even allow configurations
like ./configure --enterprise-devices-only that disable the ability to
load or interface with anything we don't promise support for.

>> Topics we covered, reordered for readability:
>>
>> * Dropping features inconveniences their users.  Keeping them impedes
>>   forward movement, and thus inconveniences other users.  We need to
>>   engage with the tradeoffs.
>>
>> * The cost of keeping both old and new for a deprecation grace period
>>   (currently two releases) can be painfully high.  Tradeoff again.
>>   However, there's rough consensus not to mess with the deprecation
>>   policy right now.
>>
>> * When something has been broken for the customary deprecation grace
>>   period, removing it without going through the deprecation process
>>   should be okay.
>>
>> * We may have to deprecate interfaces, but we may also have a need to
>>   deprecate guarantees interfaces provide.  Worse when the guarantees
>>   are tacit.  No good answers.  Let's attack less thorny problems firs=
t.
>>
>> * One obvious class of candidates for removal is machines we don't kno=
w
>>   how to boot, or can't boot, say because we lack required firmware
>>   and/or OS.
>>
>>   Of course, "can boot" should be an automated test.  As a first step
>>   towards that, we should at least document how to boot each machine.
>>   We're going to ask machine maintainers to do that.
>>
>> * We need to communicate "you're using something that is deprecated".
>>   How?  Right now, we print a deprecation message.  Okay when humans u=
se
>>   QEMU directly in a shell.  However, when QEMU sits at the bottom of =
a
>>   software stack, the message will likely end up in a log file that is
>>   effectively write-only.
>> =20
>>   - The one way to get people read log files is crashing their
>>     application.  A command line option --future could make QEMU crash
>>     right after printing a deprecation message.  This could help with
>>     finding use of deprecated features in a testing environment.
>>
>>   - A less destructive way to grab people's attention is to make thing=
s
>>     run really, really slow: have QEMU go to sleep for a while after
>>     printing a deprecation message.
>>    =20
>>   - We can also pass the buck to the next layer up: emit a QMP event.
>>
>>     Sadly, by the time the next layer connects to QMP, plenty of stuff
>>     already happened.  We'd have to buffer deprecation events somehow.
>>
>>     What would libvirt do with such an event?  Log it, taint the domai=
n,
>>     emit a (libvirt) event to pass it on to the next layer up.
>>
>>   - A completely different idea is to have a configuratin linter.  To
>>     support doing this at the libvirt level, QEMU could expose "is
>>     deprecated" in interface introspection.  Feels feasible for QMP,
>>     where we already have sufficiently expressive introspection.  For
>>     CLI, we'd first have to provide that (but we want that anyway).
>>
>>   - We might also want to dispay deprecation messages in QEMU's GUI
>>     somehow, or on serial consoles.
>=20
> Regards,
> Daniel
>=20
