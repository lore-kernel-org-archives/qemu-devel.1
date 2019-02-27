Received: from eggs.gnu.org ([209.51.188.92]:42238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyxfb-0002nz-D4
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gyxfa-00075U-Hc
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:46:39 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gyxfa-0006um-8U
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:46:38 -0500
Received: by mail-wr1-x441.google.com with SMTP id g12so5501885wrm.5
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 03:46:26 -0800 (PST)
References: <20190227111411.22890-1-david@redhat.com>
	<20190227111411.22890-2-david@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190227111411.22890-2-david@redhat.com>
Date: Wed, 27 Feb 2019 11:46:23 +0000
Message-ID: <87lg21lai8.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] tests/tcg: Allow targets to set
 the optimization level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


David Hildenbrand <david@redhat.com> writes:

> We sometimes want basic optimizations, e.g. for constant propagation
> into inlined functions.
>
> Especially for inline asm with immediates;

I agree you need this, but...

<snip>
>  # Start with a blank slate, the build targets get to add stuff first
> -CFLAGS=3D
> +CFLAGS=3D-O0
>  QEMU_CFLAGS=3D
>  LDFLAGS=3D
>
> @@ -70,7 +70,7 @@ ifneq ($(TARGET_BASE_ARCH),$(TARGET_NAME))
>  endif
>
>  # Add the common build options
> -CFLAGS+=3D-Wall -O0 -g -fno-strict-aliasing
> +CFLAGS+=3D-Wall -g -fno-strict-aliasing


You don't need to do this - we already have EXTRA_CFLAGS which will
always be at the end of the compile invocation:

  # enable vectors and optimisation to vectorise for this test
  vglv: CFLAGS+=3D-march=3Dz13 -m64
  vglv: EXTRA_CFLAGS+=3D-O2


>  ifeq ($(BUILD_STATIC),y)
>  LDFLAGS+=3D-static
>  endif


--
Alex Benn=C3=A9e
