Received: from eggs.gnu.org ([2001:4830:134:3::10]:43825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffWFJ-0003Yg-Nt
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffWFI-0003og-TV
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:06:53 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:34584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffWFI-0003oa-No
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:06:52 -0400
Received: by mail-oi0-x233.google.com with SMTP id 13-v6so4438212ois.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 13:06:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180717195028.GA6691@localhost.localdomain>
References: <20180717195028.GA6691@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 21:06:31 +0100
Message-ID: <CAFEAcA-pPsvfn7ARu_pn0HH03rZh05fLP=wr+p=hx5douSf7vA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Why do we typedef every struct on QEMU?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 17 July 2018 at 20:50, Eduardo Habkost <ehabkost@redhat.com> wrote:
> I have been looking at patches that touch typedefs.h and
> wondering: why do we make typedefs.h necessary at all?  Why do we
> always add typedefs for every struct and union type in QEMU?
>
> Why do we prefer to write this:
>
> ----- qemu/typedefs.h:
> typedef struct SomeType SomeType;
> ----------------------
>
> ----- qemu/somecode.h:
> #include <qemu/typedefs.h>
>
> int some_function(SomeType *a);
> ----------------------
>
>
> ...instead of simply writing this:?
>
> ----- qemu/somecode.h:
> struct SomeType;
> int some_function(struct SomeType *a);
> ----------------------
>
> Is the maintenance burden of typedefs.h worth it?

Personally I don't like typing "struct " all the time
when I'm using the type...

Note also that most typedefed structs don't go in
typedefs.h -- the typedef is defined with the struct.
A quick rough count suggests less than 10% are in
typedefs.h. We only put in the ones where there's
a lot of code that wants to use pointers to them
as opaque types and isn't pulling in the header where
the full struct is defined.

Also, this is one of the few bits of QEMU coding style
where we're pretty consistent, so I'd rather not
let it open to more free variation.

thanks
-- PMM
