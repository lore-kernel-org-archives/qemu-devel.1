Received: from eggs.gnu.org ([2001:4830:134:3::10]:56946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fp8oi-0000s2-KI
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fp8of-0000Xx-Bv
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:07:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53598 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fp8of-0000Xr-5m
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:07:09 -0400
Date: Mon, 13 Aug 2018 10:07:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180813090705.GH22904@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180810171102.16451-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180810171102.16451-1-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH  0/3] tweaks for QEMU's C standard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On Fri, Aug 10, 2018 at 06:10:58PM +0100, Alex Benn=C3=A9e wrote:
> Hi,
>=20
> While I was reviewing Richard's SVE series I found Travis choking on
> some perfectly valid c99. It turns out that Travis default image is
> old enough that gcc defaults to -std=3Dgnu89 hence the problem. However
> switching to c99 isn't enough as we use GNUisms and even gnu99 still
> trips up on qemu-secomp.
>=20
> Of course we could just jump to C11 already?

We've always required GCC or a compatible compiler (CLang is only viable
alternative option really). We use a number of GCC extensions to the C
standard and I don't see a compelling reason to stop using them.

>From that POV I think we do *NOT* need to care about official C standards
(c89, c99, c11, etc), only the GNU C standards (gnu89, gnu99, gnu11, etc)=
.

> This is an RFC because this could descend into a C standards
> bike-shedding exercise but I thought I'd at least put it out there on
> a Friday afternoon ;-)

I did some archeology to inform our plans...

The default GCC C standards across various versions are:

  8.2.1: gnu17
  7.3.1: gnu11
  6.4.1: gnu11
  5.3.1: gnu11
  4.9.1: gnu89
  4.4.7: gnu89

Interesting to note that no version of GCC ever defaulted to gnu99. It wa=
s
not fully implemented initially and by the time the standard was fully
implemented, gnu11 was already good enough to be the default. So GCC jump=
ed
straight from gnu89 as default to gnu11 as default.

Across the various distros we aim to support we have:

      RHEL-7: 4.8.5
      Debian (Stretch): 6.3.0
      Debian (Jessie): 4.9.2
      OpenBSD (Ports): 4.9.4
      FreeBSD (Ports): 8.2.0
      OpenSUSE Leap 15: 7.3.1
      SLE12-SP2:
      Ubuntu (Xenial): 5.4.0
      macOS (Homebrew): 8.2.0

IOW plenty of our plaforms are still on 4.x which defaults to gnu89.

In GCC 4.x, gnu99 is said to be incomplete (but usable) and gnu11
are said to be incomplete and experimental (ie don't use it).

The lowest common denominator supported by all our platforms is thus
gnu89.

If we don't mind that gnu99 is not fully complete in 4.x, we could use
that standard.

We definitely can't use gnu11 any time soon.

Given that many modern platforms default to gnu11, I think we should
set an explicit -std=3Dgnu89, or -std=3Dgnu99, because otherwise we risk
accidentally introducing code that relies on gnu11 features.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
