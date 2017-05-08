Received: from eggs.gnu.org ([2001:4830:134:3::10]:56129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d7ksA-0006Io-Kn
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d7ks7-0002XS-Sa
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:46:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d7ks7-0002XM-Jz
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:46:51 -0400
Date: Mon, 8 May 2017 16:46:43 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170508154643.GV18871@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <87pofj8kek.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pofj8kek.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Future of SoftFloat use in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <aleksandar.markovic@imgtec.com>, Pranith Kumar <bobby.prani@gmail.com>, qemu-devel <qemu-devel@nongnu.org>

On Mon, May 08, 2017 at 03:58:59PM +0100, Alex Benn=C3=A9e wrote:
> Of course the softfloat in QEMU's tree hasn't been static either. We've
> made numerous changes over the years to add and fix various features,
> including features that have since been added to the upstream softfloat=
.

Based on way Peter achieved the switch to softfloat 2a, we can
reasonably identify the set of custom QEMU changes to the
original 2a code base.  From that diff, plus the subsequent
git history, it is within realm of practicality to at least
identify areas where we might need enhance/customize version 3.

> It seems unlikely we could switch to the newer softfloat without riskin=
g
> breaking something. However if we look at back-porting stuff from the
> newer library we essentially get to own our version of softfloat
> forever.

Maintaining our own fork forever certainly feels unappealing,
particularly with the big feature gap you identify for FP16

> So what else can we do?
>=20
> We could investigate having both libraries included in QEMU. It seems
> the API has changed quite a bit so that might be possible although ther=
e
> would be hackage involved in having two different softfloat.h's
> involved.
>=20
> This would be useful if we wanted to take a piecemeal approach to
> updating the library. For example we could just use softfloat3 when we
> need the newer features (e.g. FP16).
>
> Or we could convert one architecture at a time so each qemu binary link=
s
> against either a version 2 or version 3 softfloat library. Of course
> that does run the risk of permanently holding two versions of softfloat
> in the code if the less maintained guest architectures don't convert
> quickly.
>=20
> So any thoughts about what would make the best approach?

WRT to supporting the FP16 feature, I'd certainly vote for using softfloa=
t3,
over trying to re-implement FP16 ourselves in the old codebase we have a =
fork
of, even if that means us carrying both versions forever (provided having
both versions present in QEMU doesn't cause us symbol clashes ?).

Incrementally converting existing usage to softfloat3 is reasonable, but
doesn't seem like a decision that needs to be an immediate blocker for
FP16 usage. Given our desire to kill off areas of code which are not acti=
vely
maintained, it could be reasonable to set a timebox on softfloat3 convers=
ion
for architectures eg must be completed within 3 release cycles, or we'll
consider the architecture unmaintained and subject for removal.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
