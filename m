Received: from eggs.gnu.org ([2001:4830:134:3::10]:41300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecCWx-0004VG-KL
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:55:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecCWt-000424-Lx
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:55:07 -0500
Received: from mail-io0-x234.google.com ([2607:f8b0:4001:c06::234]:36910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecCWt-00041r-GV
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:55:03 -0500
Received: by mail-io0-x234.google.com with SMTP id f89so17254815ioj.4
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 07:55:03 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <cf2b427d-a8a0-a124-16dd-598d4f7eea46@redhat.com>
References: <20180118025245.13042-1-famz@redhat.com>
	<d1dd1750-c487-be35-05eb-ffb12f18e805@redhat.com>
	<a81a812f-065c-e8be-0d6d-92525a379a82@amsat.org>
	<cf2b427d-a8a0-a124-16dd-598d4f7eea46@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 18 Jan 2018 12:55:02 -0300
Message-ID: <CAAdtpL4kR9qWjWHBuYYbZXv=FBoKXRgLE5tzaaC1nZyJZNHXNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scsi-generic: Simplify error handling code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Jan 18, 2018 at 9:03 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 18/01/2018 12:21, Philippe Mathieu-Daud=C3=A9 wrote:
>>> I'm not a fan of bool return types, in general (because "!" is often
>>> success while "< 0" is failure) and especially when there is an Error**=
;
>>> I disagree with commit 9d3b155186.  But the function is not in an area =
I
>>> maintain so I'm queuing this, thanks.
>> Do you prefer "if (local_err)" and "if (errp && *errp)" ?
>
> The latter is wrong.  I do prefer

Ok so my 253674981e24 missed that train too.

>
>     if (local_err) {
>         error_propagate(errp, local_err);
>         return;
>     }
>
> or maybe (but only if there is a meaning to a zero vs. positive return
> value, or if errno is an important part of the returned Error *)
>
>     ret =3D f(..., errp);
>     if (ret < 0) {
>         return;
>     }
>
>> I wondered once if a macro might improve this pattern but thought the
>> code would get more obscure.
>
> Eduardo had a series to avoid error_propagate, where NULL was replaced
> by a (non-NULL) IGNORED_ERRORS macro.  Then you could do:
>
>     f(..., errp);
>     if (error_is_set(errp)) {
>         return;
>     }
>
> See here:
> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg03139.html

This series never hit /master!

Reading the thread I'm not sure what was the expected outcome.
