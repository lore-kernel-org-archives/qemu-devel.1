Received: from eggs.gnu.org ([2001:4830:134:3::10]:33361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gC7Pt-0006zl-MO
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gC7Pp-0001PN-I7
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:16:33 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gC7Pn-0001Kq-3t
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:16:29 -0400
Received: by mail-wm1-x343.google.com with SMTP id 185-v6so20685526wmt.2
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:16:15 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-17-alex.bennee@linaro.org>
	<7ec86ef7-5205-52df-61de-11b79480c4bc@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <7ec86ef7-5205-52df-61de-11b79480c4bc@linaro.org>
Date: Mon, 15 Oct 2018 19:16:13 +0100
Message-ID: <87h8hn3wk2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 16/21] trace: add infrastructure for
 building plugins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, cota@braap.org, vilanova@ac.upc.edu, Pavel.Dovgaluk@ispras.ru


Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/5/18 8:49 AM, Alex Benn=C3=A9e wrote:
>> +GLIB_CFLAGS =3D $(shell pkg-config --cflags glib-2.0)
>> +CFLAGS =3D -I$(QEMU_SRC)/include/plugins $(GLIB_CFLAGS) -fno-PIE -fPIC =
-O3 -g
>> +LDFLAGS =3D $(shell pkg-config --libs glib-2.0) -shared
>
> I'm not keen on defaulting to -O3.

Fair enough... I'll drop it down if not set...

> I'd prefer if we passed up the flags from top-level, but I know you're al=
so
> trying to support out-of-tree builds.
>
> Perhaps
>
> CFLAGS ?=3D -O2 -g
> QEMU_CFLAGS =3D $(CFLAGS) $(GLIB_CFLAGS) -I$(QEMU_SRC)/... -fno-PIE -fPIC
>
>> +SRC =3D $(wildcard *.c)
>> +PLUGINS =3D $(addprefix $(BUILD_DIR)/,$(SRC:.c=3D.so))
>> +
>> +$(BUILD_DIR)/%.so: %.c
>> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<
>> +
>> +all: $(PLUGINS)
>
> Do you really want one plugin per source file rather than one plugin per
> directory?  I think the latter makes more sense...
>
> And of course you know the second thing people are going to want is to wr=
ite
> these plugins in C++...
>
>
> r~


--
Alex Benn=C3=A9e
