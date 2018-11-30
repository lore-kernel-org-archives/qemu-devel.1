Received: from eggs.gnu.org ([2001:4830:134:3::10]:60501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gSk5I-0006WP-A9
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:48:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gSk5D-0004Ku-MK
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:48:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gSk5D-0004KF-Ct
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:47:55 -0500
References: <1543513531-1151-1-git-send-email-pbonzini@redhat.com>
	<1389c712-2e02-80c0-b9e1-4c45b54d35df@redhat.com>
	<69af56c7-413d-857f-829b-37d4747d0d96@redhat.com>
	<852011bf-424c-4215-2cef-f7456e8ab9aa@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <b0d86936-bd72-56f3-7485-10c4f1cb6cd9@redhat.com>
Date: Fri, 30 Nov 2018 09:47:49 -0500
MIME-Version: 1.0
In-Reply-To: <852011bf-424c-4215-2cef-f7456e8ab9aa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/2] test: replace gtester with a
 TAP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>



On 11/30/18 4:58 AM, Paolo Bonzini wrote:
> On 30/11/18 08:21, Thomas Huth wrote:
>> On 2018-11-29 21:43, Eric Blake wrote:
>>> On 11/29/18 11:45 AM, Paolo Bonzini wrote:
>>>> gtester is deprecated by upstream glib and it does not support tests
>>>> that call g_test_skip in some glib stable releases.
>>>>
>>>> glib suggests instead using Automake's TAP support.=C2=A0 We do not =
support
>>>> Automake, but we can copy the code that beautifies the TAP output an=
d
>>>> use it.=C2=A0 I chose to use the Perl copy rather than the shell/awk=
 one,
>>>> in order to reuse Perl's TAP parsing package, but I'm open to sugges=
tions
>>>> about which language to use.
>>>
>>> I'm less familiar with the TAP protocol than I'd like to admit, but I
>>> did find:
>>>
>>> https://blog.gtk.org/2018/07/11/news-from-glib-2-58/
>>>
>>> which corroborates your claim that switching to Automake's TAP parser=
 is
>>> indeed a recommended approach to avoid the now-deprecated gtester.
>>
>> Hmm, do we really have to maintain our own version of a test runner no=
w?
>=20
> Well, that's what you get for using a custom build system but it's
> "just" an output beautifier really.  I could just "grep -ve ^# -e ^ok"
> but it wouldn't look very nice (plus things that start as 1-line shell
> scripts end up being the same as the thing you're trying to replace).
>=20
> I don't think it will be a big maintenance headache---just like most
> other files in scripts/, some of which have had exactly zero commits
> since they were added.  In fact, Automake has hardly changed its driver
> since the first commit.
>=20
>> There's already some effort going on to use avocado in "make
>> check-acceptance" ... maybe we could use avocado as replacement for
>> gtester, too?
>=20
> Avocado does not have the required functionality, unfortunately.  It ca=
n
> produce TAP, but not consume it.  Also, Python libraries for TAP do not
> abound and are generally not shipped with the OS (apart from Perl, whic=
h
> basically invented TAP, the language with the most TAP libraries seem t=
o
> be JavaScript!).
>=20

Avocado can't currently consume TAP (it produces it, though), but it has
some integration with glib based tests:

https://avocado-framework.readthedocs.io/en/66.0/optional_plugins/glib.ht=
ml

But, there may be bits missing to fully replae gtests.  Given that we
have been adding features to Avocado based on QEMU requirements, we can
certainly look at adding missing pieces there.  If this sounds like
something you'd be interested in, I can come up with an integration
proposal.

> Paolo
>=20

Cheers,
- Cleber.
