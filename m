Received: from eggs.gnu.org ([2001:4830:134:3::10]:53847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHtTV-0000Tk-6m
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 10:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHtTU-0004Bx-6b
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 10:31:37 -0500
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:42264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHtTU-0004Ay-19
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 10:31:36 -0500
Received: by mail-oi0-x236.google.com with SMTP id p23so10277915oie.9
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 07:31:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7733d617-0e56-acdc-ad6d-aafce0c7160d@redhat.com>
References: <20171106005656.GC84093@humpty.home.comstyle.com>
	<CAFEAcA_2i0p9C3amtoB0o9Y4K83aCP7Gkw1cDqmLjrkLwJTZxg@mail.gmail.com>
	<20171106112638.GF23361@redhat.com>
	<7733d617-0e56-acdc-ad6d-aafce0c7160d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Nov 2017 15:31:14 +0000
Message-ID: <CAFEAcA8DDdPUZRoA0dRVpP1vr9f7VdLmbvr19Pu9kC67Hd2j9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] osdep: Deal with TIME_MAX and OpenBSD
 64-bit time_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Brad Smith <brad@comstyle.com>

On 6 November 2017 at 17:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
> What about
>
> #define type_max(t)                   \
>     ((t) -1 > 0                       \
>      ? (t)~0                          \
>      : (((t)1) <<                     \
>          (sizeof(t) * 8 - 1)) - 1)    \
>
> #define TIME_MAX type_max(time_t)
>
> ?  We don't need it to be a cpp constant, do we?  Or if we did, we could
> assume it to be signed, it's enough for the three users.

GCC doesn't like this phrasing, it complains
qmp.c: In function =E2=80=98qmp_expire_password=E2=80=99:
qmp.c:334:89: error: integer overflow in expression [-Werror=3Doverflow]

because of the shift into the sign bit. Instead we can borrow the
TYPE_MAXIMUM macro from gnulib, which uses basically the same
approach but avoids the UB and the compiler warning. I'll send
a patch in a bit.

thanks
-- PMM
