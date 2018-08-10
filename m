Received: from eggs.gnu.org ([2001:4830:134:3::10]:46516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo2sI-000733-P3
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 04:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo2sD-0004pL-Rl
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 04:34:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47382 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fo2sD-0004p2-LS
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 04:34:17 -0400
References: <20180809160011.17225-1-peter.maydell@linaro.org>
	<19a9c0c6-03eb-d368-d8c8-fb62102556a4@redhat.com>
	<CAFEAcA_rRW7qbtiM4c-sBVmQhFMSuKnVqU6+oXsdXPwJ3GKv6A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9da04e7f-bd0c-9d50-fb7c-026b5aaa674c@redhat.com>
Date: Fri, 10 Aug 2018 10:34:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_rRW7qbtiM4c-sBVmQhFMSuKnVqU6+oXsdXPwJ3GKv6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts/checkpatch.pl: Enforce multiline
 comment syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Thomas Huth <thuth@redhat.com>

On 09/08/2018 19:03, Peter Maydell wrote:
> On 9 August 2018 at 17:43, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> I'm still not used to the leeading-/*-on-it's-own style,
>>> so having checkpatch catch my lapses is handy...
>>
>> ... if it's not what we are using, why enforce it?
>=20
> See the enormous long threads on the recent changes to CODING_STYLE:
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg00696.html
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg02717.html
>=20
> Basically, I wanted to rule out things like
>=20
>   /* this
>      weirdness */
>=20
> and lots of other people wanted (a) to not have
>=20
>   /* this thing
>    * which I think is fine
>    */
>=20
> and (b) to consistently define only one format as OK.
>=20
> So I accepted having my personal preferred format not being
> permitted in order to get consensus on getting rid of the
> formats I think are really ugly :-)

This is one of the cases where we are decently consistent:

Lone "/*" or "/**": 9986 cases
	of which in the first column: 7617
	of which the first line in the file (license headers): 2834
	regex: ^[ \t]*/\*\*?[ \t]*$

"/*" with the first line of the comment: 11246
	of which in the first column: 4985
	of which the first line in the file: 97
	regex: ^[ \t]*/\*\*?+(?:(?!\*/).)+?$

License headers almost always have the "lone /*" format.  Apart from
license headers, 63% of the comments have the now-deprecated format.

Inside functions, 73% of the comments have the now-deprecated format.
Outside functions it's 50-50.  That's because there are 2024 doc
comments, which in turn are 50% of the comments that are 1) outside the
functions 2) using a lone "/*".

So my proposal, which is actually consistent with what QEMU is doing, is
the following:

1) the first line of a file should always be "/*", otherwise warn

2) a comment that starts with "/**" should have it on a lone line

3) every other multiline comment should start with
"/*<whitespace><something>"

Yes, there is overlap between QEMU and Linux developers, but really only
in a few subsystems (s390, pSeries, networking---which uses the "other"
comment style), and I don't see why we should pretend that QEMU and
Linux use similar coding styles.  In fact they couldn't be more
different: spaces vs. tabs, indent-4 vs. indent-8, camelcase struct
names with typedefs...  Basically the only thing that is the same is
lowercase for variable names and braces on the same line as the
statement.  Linux's checkpatch was a useful base not because Linux and
QEMU are similar, but only because of the complex expression parsing
stuff that really is the same for _any_ sane coding style (even GNU ;)).

Paolo
