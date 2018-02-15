Received: from eggs.gnu.org ([2001:4830:134:3::10]:47108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emCdR-00038M-Sx
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 01:03:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emCdO-00057l-Ow
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 01:03:09 -0500
References: <1518629505-22480-1-git-send-email-thuth@redhat.com>
	<9a9ac3ae-5974-f462-7321-9ae2ad5b78ae@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <933068e0-7928-389b-f927-15df79506bc6@redhat.com>
Date: Thu, 15 Feb 2018 07:02:40 +0100
MIME-Version: 1.0
In-Reply-To: <9a9ac3ae-5974-f462-7321-9ae2ad5b78ae@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Add missing space when using
 --with-pkgversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>

On 14.02.2018 21:23, Eric Blake wrote:
> On 02/14/2018 11:31 AM, Thomas Huth wrote:
>> When running configure with --with-pkgversion=3Dfoo there is no
>> space anymore between the version number and the parentheses:
>>
>> $ m68k-softmmu/qemu-system-m68k -version
>> QEMU emulator version 2.11.50(foo)
>>
>> Fix it by moving the space from the configure script to the Makefile.
>>
>> Fixes: 67a1de0d195a6185c39b436159c9ffc7720bf979
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1673373
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 Makefile=C2=A0 | 2 +-
>> =C2=A0 configure | 2 +-
>> =C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 4ec7a3c..41adbc9 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -369,7 +369,7 @@ qemu-version.h: FORCE
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (cd $(SRC_PATH)=
; \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf '#define=
 QEMU_PKGVERSION '; \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if test -n "$(P=
KGVERSION)"; then \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
intf '"$(PKGVERSION)"\n'; \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
intf '" ($(PKGVERSION))"\n'; \
>=20
> I would argue that putting a space here is awkward; wouldn't it instead
> be easier to have all CLIENTS of QEMU_PKGVERSION in the source code
> assume that the macro does NOT have a leading space, and to supply a
> space themselves?
>=20
> That is, change THESE locations:
>=20
> bsd-user/main.c:=C2=A0=C2=A0=C2=A0 printf("qemu-" TARGET_NAME " version=
 " QEMU_VERSION
> QEMU_PKGVERSION
> linux-user/main.c:=C2=A0=C2=A0=C2=A0 printf("qemu-" TARGET_NAME " versi=
on "
> QEMU_VERSION QEMU_PKGVERSION
> qemu-img.c:#define QEMU_IMG_VERSION "qemu-img version " QEMU_VERSION
> QEMU_PKGVERSION \
> qemu-io.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 printf("%s version " QEMU_VERSION QEMU_PKGVERSION
> "\n"
> qemu-nbd.c:"%s " QEMU_VERSION QEMU_PKGVERSION "\n"
> qga/main.c:"QEMU Guest Agent " QEMU_VERSION QEMU_PKGVERSION "\n"
> scsi/qemu-pr-helper.c:"%s " QEMU_VERSION QEMU_PKGVERSION "\n"
> ui/cocoa.m:=C2=A0=C2=A0=C2=A0 @"QEMU emulator version %s%s", QEMU_VERSI=
ON,
> QEMU_PKGVERSION];
> vl.c:=C2=A0=C2=A0=C2=A0 printf("QEMU emulator version " QEMU_VERSION QE=
MU_PKGVERSION "\n"
>=20
> to instead supply the missing space, and have configure/Makefile always
> generate without a leading space.
>=20
>> +++ b/configure
>> @@ -1162,7 +1162,7 @@ for opt do
>> =C2=A0=C2=A0=C2=A0 ;;
>> =C2=A0=C2=A0=C2=A0 --disable-blobs) blobs=3D"no"
>> =C2=A0=C2=A0=C2=A0 ;;
>> -=C2=A0 --with-pkgversion=3D*) pkgversion=3D" ($optarg)"
>> +=C2=A0 --with-pkgversion=3D*) pkgversion=3D"$optarg"
>=20
> Hmm - here you're changing who supplies the ().=C2=A0 But that argues t=
hat
> maybe the callsites should supply " (" and ")" themselves.

Yeah, that's likely the saner way to do this. The question is: What
about the query-version QMP command? Should it report parentheses or
not? I think I'd look nicer if it reports "package": "foo" instead of
"package": "(foo)" - but we maybe could break some users who expect
parentheses there (no matter whether there is a preceding space or not)?

 Thomas
