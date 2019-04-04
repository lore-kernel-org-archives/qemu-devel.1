Received: from eggs.gnu.org ([209.51.188.92]:36897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hBwLJ-0001CG-Ib
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 02:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hBwLI-000449-D0
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 02:59:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hBwLI-00042C-2i
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 02:59:20 -0400
References: <20190403124948.GA14129@ls3530.dellerweb.de>
	<20190403161729.GW25150@redhat.com>
	<CAFEAcA-85Z9wtZrf2AddGkrPZFOPgxFZ5sNOZCCBkqZRp8M2Dg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <43102ef9-2f96-2863-00aa-b6f2906c2f4f@redhat.com>
Date: Thu, 4 Apr 2019 08:59:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-85Z9wtZrf2AddGkrPZFOPgxFZ5sNOZCCBkqZRp8M2Dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Relax check for libseccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 04/04/2019 03.53, Peter Maydell wrote:
> On Wed, 3 Apr 2019 at 23:27, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>>
>> On Wed, Apr 03, 2019 at 02:49:48PM +0200, Helge Deller wrote:
>>> diff --git a/configure b/configure
>>> index 1c563a7027..8632267049 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -2389,7 +2389,6 @@ if test "$seccomp" !=3D "no" ; then
>>>          libseccomp_minver=3D"2.3.0"
>>>          ;;
>>>      *)
>>> -        libseccomp_minver=3D""
>>>          ;;
>>>      esac
>>
>> This makes sense to me. From a QEMU source POV we are able to build wi=
th
>> libseccomp >=3D 2.2.0, which our default libseccomp_minver=3D env expr=
esses
>> a few lines earlier.
>>
>> If libseccomp isn't supported on a platform, then I think we should ju=
st
>> assume that libseccomp won't be present in the OS install we are build=
ing
>> against. I don't think QEMU needs to second-guess whether or not it is
>> supported on the given architecture.
>=20
> If we want to do this then we should handle all the archs which
> don't need to special case the seccomp version identically, ie
> remove the x86/mips case which with this patch would be the
> same as the default case.
>=20
>> In fact I'd go as far as to say we
>> could probably just remove all this per-arch checking and just have a
>> generic >=3D 2.2.0 check, and just rely on fact libseccomp won't exist
>> on a s390/ppc/etc host if the distro had version < 2.3.0
>=20
> The arm case at least is present because libseccomp 2.2.0 was
> being built but didn't actually work for us. See commit ae6e8ef11e6cb43=
ec83.

Looking at https://repology.org/project/libseccomp/versions it seems
like all major distro versions that we want to support feature at least
version 2.3.0 ... so I think we can simplify the check here for all
architectures and only test for a version >=3D 2.3.0.

 Thomas
