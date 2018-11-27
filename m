Received: from eggs.gnu.org ([2001:4830:134:3::10]:36479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gRkak-00054C-Hb
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:08:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gRkaj-0004FN-IO
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 16:08:22 -0500
References: <20181127184929.20065-1-jsnow@redhat.com>
	<f2257e95-b17c-55d4-1d5f-cc09db3d6a58@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d0d5c570-cbfb-60a1-5e20-1be83b25c8a9@redhat.com>
Date: Tue, 27 Nov 2018 16:08:13 -0500
MIME-Version: 1.0
In-Reply-To: <f2257e95-b17c-55d4-1d5f-cc09db3d6a58@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scsi: Address spurious clang warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>



On 11/27/18 2:02 PM, Eric Blake wrote:
> On 11/27/18 12:49 PM, John Snow wrote:
>> Some versions of Clang prior to 6.0 (and some builds of clang after,
>> such as 6.0.1-2.fc28) fail to recognize { 0 } as a valid initializer
>> for a struct with subobjects when -Wmissing-braces is enabled.
>>
>> https://bugs.llvm.org/show_bug.cgi?id=3D21689 and
>> https://reviews.llvm.org/rL314499 suggests this should be fixed in 6.0=
,
>> but it might not be the case for older versions or downstream versions=
.
>>
>> For now, follow the precedent of ebf2a499 and replace the standard { 0=
 }
>> with the accepted { } to silence this warning and allow the build to
>> work under clang 6.0.1-2.fc28, and builds prior to 6.0.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>>
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> I'm okay if this goes into -rc3 as a build-fix; I'm also okay if it
> slips to 4.0.
>=20
>> ---
>>
>> What I am actually less clear on is why this appears to be a problem
>> only now; since the introduction of { 0 } was in 2.11. It might be
>> a regression only in the fedora distribution of Clang 6.0.
>=20
> Or even a redefinition of struct dm_ioctl in some header where you are
> just now picking up a new struct layout that tickles the Clang issue in
> relation to the previous layout (since it is possible to have two
> structs that are ABI-compatible but where only one of the two has a
> nested substruct).
>=20
>> +++ b/scsi/qemu-pr-helper.c
>> @@ -236,7 +236,7 @@ static void dm_init(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror("Cannot =
open " CONTROL_PATH);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 struct dm_ioctl dm =3D { 0 };
>> +=C2=A0=C2=A0=C2=A0 struct dm_ioctl dm =3D { };
>=20
> Random thought: would it be worth having "qemu/compiler.h" define a mac=
ro:
>=20
> #if ...broken clang
> #define ZERO_INIT {}
> #else
> #define ZERO_INIT {0}
> #endif
>=20
> and then rewrite all our '=3D { 0? }' initializers into '=3D ZERO_INIT'=
?=C2=A0 Or
> is that aesthetically too ugly?
>=20

Obscures perfectly legitimate C code without solving anything, IMO. As
much code as can reflect "naked" C89/C99/GNU99, the better.

--js
