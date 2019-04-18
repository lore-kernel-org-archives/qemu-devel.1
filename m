Received: from eggs.gnu.org ([209.51.188.92]:46851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hH2WI-0002bm-TY
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hH2WH-0004bg-LT
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:35:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hH2WH-0004av-CL
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:35:45 -0400
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87v9zbpvtk.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1ae50a8a-b669-db47-f1e6-995097c556f3@redhat.com>
Date: Thu, 18 Apr 2019 10:35:36 +0200
MIME-Version: 1.0
In-Reply-To: <87v9zbpvtk.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>

On 18/04/19 10:21, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> Hi all,
>>
>> lately I have been thinking of converting the QEMU build system to
>> Meson.  Meson is a relatively new build system that can replace
>> Autotools or hand-written Makefiles such as QEMU; as a die-hard
>> Autotools fan, I must say that Meson is by far better than anything el=
se
>> that has ever tried to replace Autotools, and actually has the potenti=
al
>> to do so.
>>
>> Advantages of Meson that directly matter for QEMU include:
>>
>> - build definitions in a very readable and user friendly DSL, which
>> supports looping and conditions.
>>
>> - ability to introspect the build definitions so that you can find out
>> what is built without building it (the DSL is not Turing complete and
>> most objects in it are immutable, so it cannot be abused that much :))
>>
>> - support for a non-recursive build from per-subdirectory input (simil=
ar
>> to Makefile.objs)
>=20
> Could Meson build the $(TARGET_DIRS) non-recursively?

Yes.  It doesn't support recursive builds at all, in fact.

If you can stand the C++, you can find a "testcase slash example with
obvious QEMU inspiration" at
https://github.com/mesonbuild/meson/pull/5028/commits/9495ea241aaca5c2242=
dac1654ef3168bee1657a.
 In fact, that pull request is basically the last obvious missing piece
before one could seriously try Meson for QEMU.  Then of course there are
the non-obvious missing pieces, but those are more bugfixes than
anything else.

Paolo

>=20
> I'm asking because I find the make recursion there annoying.  As usual
> with recursion, we have to dumb down dependencies: if anything made by
> the recursion needs X, then everything does.  If making X fails, we
> don't recurse.  Defeats -k.
>=20
>> - ease of distributing a full copy of Meson to support distros that sh=
ip
>> an older version (no dependencies apart from Python 3.5).  At 40000
>> lines of Python, Meson is relatively small.
>=20
> [...]
>=20
