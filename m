Received: from eggs.gnu.org ([2001:4830:134:3::10]:46553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC6bE-0003rg-B4
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC6b8-0002k0-C6
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:24:12 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC6b7-0002fq-OU
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:24:06 -0400
Received: by mail-pl1-x643.google.com with SMTP id 1-v6so9625637plv.7
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 10:24:05 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-17-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7ec86ef7-5205-52df-61de-11b79480c4bc@linaro.org>
Date: Mon, 15 Oct 2018 10:24:01 -0700
MIME-Version: 1.0
In-Reply-To: <20181005154910.3099-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, cota@braap.org, vilanova@ac.upc.edu, Pavel.Dovgaluk@ispras.ru

On 10/5/18 8:49 AM, Alex Bennée wrote:
> +GLIB_CFLAGS = $(shell pkg-config --cflags glib-2.0)
> +CFLAGS = -I$(QEMU_SRC)/include/plugins $(GLIB_CFLAGS) -fno-PIE -fPIC -O3 -g
> +LDFLAGS = $(shell pkg-config --libs glib-2.0) -shared

I'm not keen on defaulting to -O3.
I'd prefer if we passed up the flags from top-level, but I know you're also
trying to support out-of-tree builds.

Perhaps

CFLAGS ?= -O2 -g
QEMU_CFLAGS = $(CFLAGS) $(GLIB_CFLAGS) -I$(QEMU_SRC)/... -fno-PIE -fPIC

> +SRC = $(wildcard *.c)
> +PLUGINS = $(addprefix $(BUILD_DIR)/,$(SRC:.c=.so))
> +
> +$(BUILD_DIR)/%.so: %.c
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<
> +
> +all: $(PLUGINS)

Do you really want one plugin per source file rather than one plugin per
directory?  I think the latter makes more sense...

And of course you know the second thing people are going to want is to write
these plugins in C++...


r~
