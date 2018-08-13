Received: from eggs.gnu.org ([2001:4830:134:3::10]:32857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fp96q-0000ex-Gk
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fp96l-0007kD-Fp
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:25:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49408 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fp96l-0007k1-AS
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:25:51 -0400
References: <20180810171102.16451-1-alex.bennee@linaro.org>
	<20180813090705.GH22904@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5ad932dc-6447-42b5-edf4-1b9cacbaac0c@redhat.com>
Date: Mon, 13 Aug 2018 11:25:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180813090705.GH22904@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] tweaks for QEMU's C standard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On 08/13/2018 11:07 AM, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Aug 10, 2018 at 06:10:58PM +0100, Alex Benn=C3=A9e wrote:
>> Hi,
>>
>> While I was reviewing Richard's SVE series I found Travis choking on
>> some perfectly valid c99. It turns out that Travis default image is
>> old enough that gcc defaults to -std=3Dgnu89 hence the problem. Howeve=
r
>> switching to c99 isn't enough as we use GNUisms and even gnu99 still
>> trips up on qemu-secomp.
>>
>> Of course we could just jump to C11 already?
>=20
> We've always required GCC or a compatible compiler (CLang is only viabl=
e
> alternative option really). We use a number of GCC extensions to the C
> standard and I don't see a compelling reason to stop using them.
>=20
> From that POV I think we do *NOT* need to care about official C standar=
ds
> (c89, c99, c11, etc), only the GNU C standards (gnu89, gnu99, gnu11, et=
c).
>=20
>> This is an RFC because this could descend into a C standards
>> bike-shedding exercise but I thought I'd at least put it out there on
>> a Friday afternoon ;-)
>=20
> I did some archeology to inform our plans...
>=20
> The default GCC C standards across various versions are:
>=20
>   8.2.1: gnu17
>   7.3.1: gnu11
>   6.4.1: gnu11
>   5.3.1: gnu11
>   4.9.1: gnu89
>   4.4.7: gnu89
>=20
> Interesting to note that no version of GCC ever defaulted to gnu99. It =
was
> not fully implemented initially and by the time the standard was fully
> implemented, gnu11 was already good enough to be the default. So GCC ju=
mped
> straight from gnu89 as default to gnu11 as default.
>=20
> Across the various distros we aim to support we have:
>=20
>       RHEL-7: 4.8.5
>       Debian (Stretch): 6.3.0
>       Debian (Jessie): 4.9.2
>       OpenBSD (Ports): 4.9.4
>       FreeBSD (Ports): 8.2.0
>       OpenSUSE Leap 15: 7.3.1
>       SLE12-SP2:
>       Ubuntu (Xenial): 5.4.0
>       macOS (Homebrew): 8.2.0
>=20
> IOW plenty of our plaforms are still on 4.x which defaults to gnu89.

Thanks for the great summary!

> In GCC 4.x, gnu99 is said to be incomplete (but usable) and gnu11
> are said to be incomplete and experimental (ie don't use it).
>=20
> The lowest common denominator supported by all our platforms is thus
> gnu89.
>=20
> If we don't mind that gnu99 is not fully complete in 4.x, we could use
> that standard.
>=20
> We definitely can't use gnu11 any time soon.
>=20
> Given that many modern platforms default to gnu11, I think we should
> set an explicit -std=3Dgnu89, or -std=3Dgnu99, because otherwise we ris=
k
> accidentally introducing code that relies on gnu11 features.

Sounds good. What about trying -std=3Dgnu99 first, and if we run into
problems, switch back to -std=3Dgnu89 later?

 Thomas
