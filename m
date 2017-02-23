Received: from eggs.gnu.org ([2001:4830:134:3::10]:42408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cgorN-00071j-Au
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:34:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cgorM-00014O-3I
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:34:45 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cgorL-00014A-Of
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 03:34:44 -0500
Received: by mail-lf0-x241.google.com with SMTP id j2so553158lfe.0
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 00:34:43 -0800 (PST)
MIME-Version: 1.0
References: <20170222180423.26571-1-pbonzini@redhat.com>
In-Reply-To: <20170222180423.26571-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Feb 2017 08:34:31 +0000
Message-ID: <CAJ+F1CL_gVsYSwx7JXF07rjmeQTPXiJFRcLo0KSt3k3xR_iuOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] simplify struct QOM properties and
 use the result for GUEST_PANICKED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Wed, Feb 22, 2017 at 10:07 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> This is an alternative approach to simplifying the crash information
> patches.
>
> Currently, crash information is exposed twice, through a QOM property
> and through a method.  This is because accessing QOM properties with
> QAPI struct types is a huge pain in the neck.  Patch 1 fixes this by
> providing a simple and well-tested API, that takes care of integrating
> the QOM->QObject->QAPI steps into a single function.
>
> Patch 2 then eliminates the get_crash_info method.  Patch 3 finally
> cleans up qemu_system_guest_panicked by passing a CPUState* argument
> instead of a GuestPanicInformation struct.
>
> Paolo
>
> v1->v2:
>        include missing changes to tests/qapi-schema/qapi-schema-test.out
>        tweaks to doc comments
>        wrap long lines
>
> Paolo Bonzini (3):
>   qom-qobject: introduce object_property_{g,s}et_ptr
>   cpu: implement get_crash_info through QOM properties
>   vl: pass CPUState to qemu_system_guest_panicked
>


With the test leaks fixed,

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>
>
>  include/qom/cpu.h                       |   1 -
>  include/qom/qom-qobject.h               |  68 +++++++++++-
>  include/sysemu/sysemu.h                 |   2 +-
>  kvm-all.c                               |   2 +-
>  qom/cpu.c                               |  11 +-
>  qom/qom-qobject.c                       |  52 ++++++++++
>  target/i386/cpu.c                       |   2 +-
>  tests/Makefile.include                  |   2 +-
>  tests/check-qom-proplist.c              | 177
> +++++++++++++++++++++++++++++++-
>  tests/qapi-schema/qapi-schema-test.json |   8 ++
>  tests/qapi-schema/qapi-schema-test.out  |   6 ++
>  vl.c                                    |  13 ++-
>  12 files changed, 326 insertions(+), 18 deletions(-)
>
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
