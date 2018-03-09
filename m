Received: from eggs.gnu.org ([2001:4830:134:3::10]:53184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1euIUv-0005gA-Gz
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1euIUs-0001oQ-GB
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:55:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40348 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1euIUs-0001oC-B7
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:55:46 -0500
Date: Fri, 9 Mar 2018 14:55:37 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180309135537.vnrsyup73dtatj23@sirius.home.kraxel.org>
References: <20180309110152.16109-1-kraxel@redhat.com>
	<CAFEAcA8e43LTexse9Dq_V-d-4zb5YeT6hUQ8xH1YZ-fCWL0qTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8e43LTexse9Dq_V-d-4zb5YeT6hUQ8xH1YZ-fCWL0qTg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] build: try improve handling of clang
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>

On Fri, Mar 09, 2018 at 11:32:30AM +0000, Peter Maydell wrote:
> On 9 March 2018 at 11:01, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > This patch disables the pragma diagnostic -Wunused-but-set-variable for
> > clang in util/coroutine-ucontext.c.
> >
> > This in turn allows us to remove it from the configure check, so the
> > CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE will succeed for clang.
> >
> > With that in place clang builds (linux) will use -Werror by default,
> > which breaks the build due to warning about unaligned struct members.
> >
> > Given that our structs are often dictated by the hardware qemu emulates
> > and the file formats we use this can't be fixed easily, so I think it is
> > reasonaable to turn off this warning.  Do so by adding
> > -Wno-address-of-packed-member to our list of warning flags.
> 
> I disagree with this part. Everywhere we do this is at least
> plausibly a bug, and we should fix the bugs. Taking addresses of
> members in packed structs and then passing them to functions will
> break on some architectures, because it drops the information that
> the field is not at an aligned address.

Ok, I guess I pick up Thomas' idea then and turn it into a warning using
-Wno-error=address-of-packed-member.  That way it will not fail the
build with -Werror, but we still see it in the logs.

cheers,
  Gerd
