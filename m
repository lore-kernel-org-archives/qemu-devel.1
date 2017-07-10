Received: from eggs.gnu.org ([2001:4830:134:3::10]:42344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUbKy-0000cx-Qx
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUbKu-0002sR-T2
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:15:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUbKu-0002rx-Mq
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:15:00 -0400
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
	<1499238885-26161-23-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-B+aChqZBSnGws7RXheEyg+cutaqvXP8qVgNoUgzQAJA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4f304a14-572d-2835-cb0e-9d93c1c6dece@redhat.com>
Date: Mon, 10 Jul 2017 18:14:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-B+aChqZBSnGws7RXheEyg+cutaqvXP8qVgNoUgzQAJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 22/42] configure: factor out list of
 supported Xen/KVM/HAX targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony.perard@citrix.com>

On 10/07/2017 17:49, Peter Maydell wrote:
> On 5 July 2017 at 08:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> This will be useful when the functions are called, early in the config=
ure
>> process, to filter out targets that do not support hardware accelerati=
on.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
>> +supported_xen_target() {
>> +    test "$xen" =3D "yes" || return 1
>> +    glob "$1" "*-softmmu" || return 1
>> +    case "${1%-softmmu}:$cpu" in
>> +        arm:arm | aarch64:aarch64 | \
>> +        i386:i386 | i386:x86_64 | x86_64:i386 | x86_64:x86_64)
>> +            return 0
>> +        ;;
>=20
> This says that arm-on-arm and aarch64-on-aarch64 are supported
> Xen targets...

Hmm, this comes from my old patches.  IIRC the reason for the change,
when it wasn't a change (many conflicts ago) was that Xen folks were
using --disable-tcg because their device model for Xen PV on ARM was
actually an x86_64 QEMU.

Stefano and Anthony, is this still true?  If so, would it make sense to
add the Xen PV machine type to qemu-system-arm---that is, is it
something you can whip up easily, or should I just remove that line?

Paolo

> Alex points out that the shippable builds now fail for aarch64
> and arm. (I think that my test machines for aarch64 and arm
> don't fail like this because they happen not to have the Xen
> headers installed, so the overall "does Xen work on this host"
> check fails; the shippable configs do pass that test so they
> try to build the Xen code.)
