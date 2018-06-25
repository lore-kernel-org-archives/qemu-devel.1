Received: from eggs.gnu.org ([2001:4830:134:3::10]:42496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXYjY-0005On-ED
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 17:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXYjX-0000wM-Dh
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 17:09:12 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:33147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXYjX-0000sd-7F
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 17:09:11 -0400
Received: by mail-wm0-x229.google.com with SMTP id z6-v6so13578586wma.0
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 14:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180623022258.22158-1-programmingkidx@gmail.com>
	<ecf44486-09a4-9c9a-b96e-1db2d6a1bcbe@linaro.org>
	<1E63C3B2-7668-4D05-BC43-02E478FB493B@gmail.com>
	<bc3cd25b-bdd1-3bc7-8d2d-5c351f2c30d5@linaro.org>
	<4CC477CD-237F-480D-B9B5-B35FF507BD3C@gmail.com>
	<c6d132e2-b2e0-5bbb-7b71-9bd13253aa22@linaro.org>
	<2CAC99CF-A717-4A94-A68C-EEB76C727F87@gmail.com>
	<dbbebf00-9b32-4639-1e26-a888c48f6203@linaro.org>
	<CDA6AAA3-1452-4CBA-93A9-94CD83705E1A@gmail.com>
In-Reply-To: <CDA6AAA3-1452-4CBA-93A9-94CD83705E1A@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 25 Jun 2018 14:08:59 -0700
Message-ID: <CAFXwXrk+X_heyWnwAzLQ6E9+j5=AxJ-Dh+nM5e7zuQcJCEAsyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] fix fdiv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>

On Mon, Jun 25, 2018, 08:23 G 3 <programmingkidx@gmail.com> wrote:

> >
> > Try
> >
> >     uint64_t expected_answer = 0xffff0000deadbeef;
> >     ...
> >     c.i = expected_answer;
> >     asm volatile("fdiv %0, %1, %2" : "+f"(c.d) : "f"(1.0), "f"(0.0));
> >
> > to avoid depending on uninitialized data.  (This expected value is
> > an SNaN with a deadbeef marker Just to be Sure.)
> >
> >
> > r~
>
>
> Ok I made this program and tried it on my iMac G5 (PowerPC 970).
>
> #include <stdio.h>
> #include <stdint.h>
> #include <inttypes.h>
>
> // Used to convert unsigned integer <--> double
> union Converter
> {
>      double d;
>      uint64_t i;
> };
> typedef union Converter Converter;
>
> int main (int argc, const char * argv[]) {
>      Converter answer;
>      answer.i = 0xffff0000deadbeef;
>      //asm volatile("mtfsb1 27"); /* Set ZE bit */
>      asm volatile("fdiv %0, %1, %2" : "=f"(answer.d) : "f"(1.0),
> "f"(0.0));
>

Need +f for inout operand.
This didn't test what you expected.

r~
