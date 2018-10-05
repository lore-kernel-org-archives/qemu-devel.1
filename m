Received: from eggs.gnu.org ([2001:4830:134:3::10]:54073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g8XQu-00035g-FF
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 17:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g8XOt-0008EO-JU
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 17:12:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g8XOt-0008E0-Br
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 17:12:43 -0400
References: <1538748792-19444-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8SJ8QBX9fHPm+DvtdpJYq_vwx0CGsH8Uyp_AV-KMqqDA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fcff0b1e-d3e1-4e8d-48e8-35d0420f5bf5@redhat.com>
Date: Fri, 5 Oct 2018 23:12:32 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8SJ8QBX9fHPm+DvtdpJYq_vwx0CGsH8Uyp_AV-KMqqDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] accel: Improve selection of the default
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 05/10/2018 16:22, Peter Maydell wrote:
> On 5 October 2018 at 15:13, Thomas Huth <thuth@redhat.com> wrote:
>> When compiling with "--disable-tcg", we currently still use "tcg"
>> as default accelerator. "kvm" should be used in this case instead.
>=20
> This part is non-controversial and makes good sense.

Though it probably should be extended to "whpx" and "hvf" (probably
"xen" too if !CONFIG_KVM).

>> Also, some downstream distros provide QEMU binaries which have "kvm"
>> in their names (e.g. "qemu-kvm" on RHEL or "kvm" on Ubuntu) that use
>> KVM by default - and some users might want to do something similar
>> with upstream binaries, too. Accomodate them by using "kvm:tcg" as
>> default when we detect such a binary name.
>=20
> This part is much riskier and less clearly a good plan --
> do we really want our behaviour to vary based on the name
> of the executable? Distros who want that sort of qemu-kvm
> wrapper generally are providing it already (the Ubuntu one
> is a 2-line shell script).

I think it makes sense.  At least RHEL has qemu-kvm but no
qemu-system-x86_64, so it has a non-upstream patch to change the
accelerator; for other distros there are two benefits:

1) now: they could switch to a symlink

2) later: right now, "-accel kvm:tcg" works but we should instead switch
that to "-accel kvm -accel tcg", and deprecate "-M accel=3Dkvm:tcg" (whic=
h
doesn't let you specify accelerator options).

I don't really like second guessing based on argv[0], because argv[0]
can actually be spoofed by the exec-ing program.  One idea could be to
pick the "best" KVM-enabled emulator that we can build, and also install
it as qemu-kvm with some magic to flip the default to kvm:tcg.  But that
can be done later; something like Thomas's patch is nice to have, and
good enough.

Paolo
