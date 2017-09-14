Received: from eggs.gnu.org ([2001:4830:134:3::10]:42075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsVx2-00039r-PC
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:21:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsVww-0006eZ-Qr
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:21:12 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:53474)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsVww-0006e8-Fy
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:21:06 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
	<150506107741.19604.8328467942268087647.stgit@frigg.lan>
	<3fb9d3ac-db86-2ff7-d6e1-988982d1eb18@linaro.org>
Date: Thu, 14 Sep 2017 18:20:56 +0300
In-Reply-To: <3fb9d3ac-db86-2ff7-d6e1-988982d1eb18@linaro.org> (Richard
	Henderson's message of "Wed, 13 Sep 2017 10:34:05 -0700")
Message-ID: <8760clpaqv.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/7] trace: Add event "guest_bbl_after"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Richard Henderson writes:

> On 09/10/2017 09:31 AM, Llu=C3=ADs Vilanova wrote:
>> +void translator__gen_goto_tb(TCGContext *ctx)
>> +{
>> +    if (ctx->disas.in_guest_code &&
>> +        (TRACE_GUEST_BBL_AFTER_ENABLED)) {
>> +        if (ctx->disas.inline_label =3D=3D NULL) {
>> +            ctx->disas.inline_label =3D gen_new_inline_label();
>> +        }
>> +        gen_set_inline_point(ctx->disas.inline_label);
>> +        /* disable next exit_tb */
>> +        ctx->disas.seen_goto_tb =3D true;
>> +    }
>> +}
>> +
>> +void translator__gen_exit_tb(TCGContext *ctx)
>> +{
>> +    if (ctx->disas.in_guest_code && !ctx->disas.seen_goto_tb &&
>> +        (TRACE_GUEST_BBL_AFTER_ENABLED)) {
>> +        if (ctx->disas.inline_label =3D=3D NULL) {
>> +            ctx->disas.inline_label =3D gen_new_inline_label();
>> +        }
>> +        gen_set_inline_point(ctx->disas.inline_label);
>> +        /* enable next exit_tb */
>> +        ctx->disas.seen_goto_tb =3D false;
>> +    }
>> +}

> I don't understand why you wouldn't just modify tcg_gen_goto_tb and
> tcg_gen_exit_tb instead.

I prefer to keep all generic translation-related tracing on a single file, =
where
it is easier to reason about.

Cheers,
  Lluis
