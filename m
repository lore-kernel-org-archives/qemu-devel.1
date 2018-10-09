Received: from eggs.gnu.org ([2001:4830:134:3::10]:46205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g9u3D-0003VE-Ss
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g9u38-0002qy-Pc
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:35:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g9u38-0002qa-Fw
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:35:54 -0400
References: <1538748792-19444-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8SJ8QBX9fHPm+DvtdpJYq_vwx0CGsH8Uyp_AV-KMqqDA@mail.gmail.com>
	<875zybzdzm.fsf@dusky.pond.sub.org> <87zhvntg6k.fsf@dusky.pond.sub.org>
	<20181009154312.771c276a.cohuck@redhat.com>
	<CAFEAcA-EV4YO7TtTqC74LfeLnceM7nphxsYc7WT9nPWTdap22g@mail.gmail.com>
	<20181009142309.GH22838@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7d69f6c1-e493-8013-3045-fe71ffa0f283@redhat.com>
Date: Tue, 9 Oct 2018 17:35:44 +0200
MIME-Version: 1.0
In-Reply-To: <20181009142309.GH22838@redhat.com>
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
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 09/10/2018 16:23, Daniel P. Berrang=C3=A9 wrote:
>>>
>>> (And I'd prefer kvm to be first in that list; anything that relies on
>>> tcg being used should specify it explicitly... a normal user will
>>> likely always want the fast variant.)
>> tcg should be the default for binaries without KVM compiled in,
>> of course... But as Thomas points out, the reason for our current
>> default is the usual "because we tend not to change things that
>> would break existing working command lines".

... and because we rely on people that want KVM using almost always the
distro qemu-kvm.

> Putting KVM first shouldn't break existing working command lines
> in general.
>=20
> If user doesn't have KVM it won't have any impact as it'll still
> fallback to TCG. If user does have KVM, their VMs will be faster.=20
>=20
> It could conceivably break if
>=20
>   - TCG had some different behaviour to KVM that
>     the guest relied upon (we should fix such differences)

TCG can emulate stuff that doesn't exist in the host processor (e.g.
MPX, PKRU, and on older processors SMEP/SMAP though those should be
ubiquitous).  There are (or were) CI systems for the kernel that were
using it that way.

Paolo

>   - KVM kmod was buggy (eg broken nested virt, again should be
>     something we fix)
>   - If the guest OS relied on things being slow (that's already
>     fragile)
>=20
> IMHO we should assume that TCG & KVM are functionally equivalent
> and non-broken, and thus changing default accelerator should not
> be considered an incompatible change.
