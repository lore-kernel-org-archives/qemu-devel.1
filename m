Received: from eggs.gnu.org ([2001:4830:134:3::10]:35548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dBAfA-0005CL-6k
	for qemu-devel@nongnu.org; Wed, 17 May 2017 21:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dBAf6-0005bc-AX
	for qemu-devel@nongnu.org; Wed, 17 May 2017 21:55:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dBAf6-0005bY-2P
	for qemu-devel@nongnu.org; Wed, 17 May 2017 21:55:32 -0400
References: <1495035337-13337-1-git-send-email-thuth@redhat.com>
	<0721f18a-fc66-0be3-7462-76eb60de7f55@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <394772e4-949a-b92f-6879-7b9e343e10d3@redhat.com>
Date: Thu, 18 May 2017 03:55:25 +0200
MIME-Version: 1.0
In-Reply-To: <0721f18a-fc66-0be3-7462-76eb60de7f55@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] target/s390x/cpu_models: Set some
 additional feature bits for the "qemu" CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: mmarek@suse.com, mbenes@suse.cz, Aurelien Jarno <aurelien@aurel32.net>

On 17.05.2017 18:49, David Hildenbrand wrote:
> On 17.05.2017 17:35, Thomas Huth wrote:
>> Currently we only present the plain z900 feature bits to the guest,
>> but QEMU already emulates some additional features (but not all of
>> the next CPU generation, so we can not use the next CPU level as
>> default yet). Since newer Linux kernels are checking the feature bits
>> and refuse to work if a required feature is missing, we should present
>> as much of the supported features as possible when we are running
>> with the default "qemu" CPU.
>> This patch now adds the "stfle", "extended immediate" and "stckf"
>> facility bits to the "qemu" CPU, which are already supported facilitie=
s.
>> It is unfortunately still not enough to run e.g. recent Fedora kernels=
,
>> but at least it's a first step into the right direction.
>>
>=20
> Three things:
>=20
> 1. Should we care about backwards compatibility? I think so. This shoul=
d
> be fixed up using compat machine properties. (qemu model is a
> migration-safe model and could e.g. be used in KVM setups, too).

Theoretically, I agree, but do we really care about backwards
compatibility at this point in time? All major distro kernels (except
Debian, I think) currently do not work in QEMU, so there is currently
not that much that can be migrated...
And currently, the "qemu" CPU is the very same as the "z900" CPU, so you
might also get along with simply using "-cpu z900" on the destination
instead, I guess.

> 2. I would recommend to not enable STFLE for now. Why?
>=20
> It is/was an indication that the system is running on a z9 (and
> implicitly has the basic features). This was not only done because
> people were lazy, but because this bit was implicitly connected to othe=
r
> machine properties.

Uh, that's ugly!

> One popular example is the "DAT-enhancement facility 2". It introduced
> the "LOAD PAGE TABLE ENTRY ADDRESS" instruction, but no facility bit wa=
s
> introduced. SO there is no way to check if the instruction is available
> and actually working.

Does the Linux kernel use this instruction at all? I just grep'ed
through the kernel sources and did not find it. If the Linux kernel does
not use it, I think we should ignore this interdependency and just
provide the STFLE feature bit to the guest - since recent Linux kernels
depend on it.

> Please note that we added a feature representation for this facility,
> because this would allow us later on to at least model removal of such =
a
> facility (if HW actually would drop it) on a CPU model level.

What about STFLE bit 78, according to my version of the POP, it says:

"The enhanced-DAT facility 2 is installed in the
 z/Architecture architectural mode."

?

> 3. This introduces some inconsistency. s390x/cpu_models.c:set_feature()
> explicitly tests for such inconsistencies.
>=20
> So your QEMU CPU model would have a feature, but you would not be able
> to run that model using QEMU when manually specifying it on the command
> line. Especially, expanding the "qemu" model and feeding it back to QEM=
U
> will fail.

I've checked that I can also successfully disable the features again at
the command line, using "-cpu qemu,eimm=3Dfalse" for example, so not sure
what exactly you're talking about here. Could you please elaborate?

> So I am not sure if we should introduce such inconsistencies at that
> point. Rather fix up the basics and then move the CPU model to a
> consistent model.

I think we're very far away from being able to use the next official CPU
model generation in QEMU TCG, so having at least something that let's us
run other recent distro kernels apart from the Debian ones would be very
helpful. I also understand the "qemu" CPU this way: "Simply give me the
best CPU features that TCG currently can provide". If you want to have a
"consistent" CPU state, you can simply use an official model like "z900"
instead.

 Thomas
