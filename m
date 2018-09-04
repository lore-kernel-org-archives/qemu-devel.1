Received: from eggs.gnu.org ([2001:4830:134:3::10]:46476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fx8xl-0007ZB-Dc
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 06:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fx8xi-0003do-0C
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 06:53:37 -0400
References: <1536044538-22507-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8uVksn0w5Z6WBS8jXc8KtZjMgNuTk+TOPtsVgnXK4C0A@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ed01225b-b948-9429-a2d7-f9a5095499de@redhat.com>
Date: Tue, 4 Sep 2018 12:53:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8uVksn0w5Z6WBS8jXc8KtZjMgNuTk+TOPtsVgnXK4C0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Save PKG_CONFIG_LIBDIR and
 WINDRES in config.status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>

On 2018-09-04 12:35, Peter Maydell wrote:
> On 4 September 2018 at 08:02, Thomas Huth <thuth@redhat.com> wrote:
>> When cross-compiling QEMU for a target that significantly differs from
>> the host, the current information in config.status is not enough to
>> properly re-create the configuration. For example when I try to test
>> my build with the mingw32 cross-compiler, I regularly get this error
>> after the build system tried to re-create the configuration with the
>> config.status file:
>>
>> ERROR: sizeof(size_t) doesn't match GLIB_SIZEOF_SIZE_T.
>>        You probably need to set PKG_CONFIG_LIBDIR
>>        to point to the right pkg-config files for your
>>        build target
>> RAND
>> A similar problem exists for the "windres" tool, where you have to
>> set the WINDRES variable in case it has a different name.
>> So let's fix these issues by storing the configuration for theseq
>> variables in the config.status file, too.
>=20
> This is also true if the user set CC or RANLIB or any of a bunch
> of other environment variables that configure uses. If we're going
> to store those settings in config.status we should consistently
> do it for all environment variables we care about, I think.

Ok, never mind, forget about WINDRES (and the other tools like RANLIB),
that's not required, I just noticed that I simply forgot to specify
"--cross-prefix=3Di686-w64-mingw32-" when running configure. With that
option, i686-w64-mingw32-windres is properly used, and the pkg-config
problem also goes away since i686-w64-mingw32-pkg-config is used instead.

But still, I think at least the PKG_CONFIG_LIBDIR part could be useful,
since the same problem e.g. also occurs when trying do a 32-bit build on
a 64-bit host, i.e. when running configure with "--extra-cflags=3D-m32".
Or is there also another configure switch that can help to get
PKG_CONFIG_LIBDIR right here?

 Thomas
