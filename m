Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB6EC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0B620644
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ptu68Wl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0B620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyGwU-00051i-Qv
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 10:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1hyGvj-0004Yq-Te
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hyGvg-0000JS-Gl
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:40:43 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hyGvg-0000GQ-9J
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:40:40 -0400
Received: by mail-wr1-x441.google.com with SMTP id r3so2445382wrt.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 07:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=LUrjubN1G5MJi5k8S6ggI5Bp3QK9HWaT8QIkjRMSK9g=;
 b=Ptu68Wl6mRI/Yx32kvLrQEVR9lrqpriRgGHnOslNhA/DQgNp3Z9WiQx6ptrZZYAZLp
 zYXYPZOacIpLV1EXfNgkNvtIEmbVP4h3ehCF5QNnSHqY/ulWfXqg1tytF8H9HOlBJtx1
 CsVf+BVw5IXlNFZwiJM8ZZ7aNQIEfOXLCR3OGrWpMfM/LxxVcJRMDfXf7Vz5dANnQCq6
 EChHwdcXYHulKyBaU8EsXgqrZnpK1zZSkyyRLUZTLQdqqpKYlfB41dcphakqFQ5kTok7
 9HehMdfaW58ecM8PCNpxPXPpcCT72BRiPfnxWtC2L2hhqf/M7KSa351X7B7JjZDff/BV
 scMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LUrjubN1G5MJi5k8S6ggI5Bp3QK9HWaT8QIkjRMSK9g=;
 b=miF2LilI1LHE94jX190tXZaNZjxCaLguy2beeI/W9uLugfLiMEpVJM26UoDp2weyYC
 WkPXEDMNndP8nExd/eEl2cuJMprGsWQDIjiFNyKJQxVKeTIRHHhTh8znhIw18GurwuP+
 7zKFKi3hbTDJL2ZwBOPfZSXkxw5ZmW90PyII4XhCsIeQsP7xvBdMh5CTip5iMHQwiaZT
 /SYX2HPbchDh8qf2tJ8Ftnb/KZjuLQ2DuQ9Fe/+k/Nu/4PYGPXOy/T3UuGtIOMCSBXN0
 nnHA5alAY87TzwUU40RmfaE5hDPeqFYPxLQnpHgrvslJvhNDwRjO7JbC4sxcJMrAcRAg
 wkIw==
X-Gm-Message-State: APjAAAUG1dPKaeg9zk8/akIXpsr18gk+FXe/fZ8DVljP3HhM4y/weF+5
 ZHQeAgi02UThAPE/HW6Bxq4=
X-Google-Smtp-Source: APXvYqyNlR0xoEOu31CXmHFypXm4X1hiHX3NE9FXSjTLE4AkNkMpfPvEeEqVTHJliZGcy2ODgHPRGg==
X-Received: by 2002:adf:dd88:: with SMTP id x8mr6159495wrl.331.1565880038690; 
 Thu, 15 Aug 2019 07:40:38 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id t24sm1448637wmj.14.2019.08.15.07.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2019 07:40:38 -0700 (PDT)
Date: Thu, 15 Aug 2019 15:40:36 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: vandersonmr <vandersonmr2@gmail.com>
Message-ID: <20190815144036.GG10996@stefanha-x1.localdomain>
References: <20190815023725.2659-1-vandersonmr2@gmail.com>
 <20190815023725.2659-2-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UKNXkkdQCYZ6W5l3"
Content-Disposition: inline
In-Reply-To: <20190815023725.2659-2-vandersonmr2@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v1 1/2] accel/tcg: adding integration with
 linux perf
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UKNXkkdQCYZ6W5l3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2019 at 11:37:24PM -0300, vandersonmr wrote:
> This commit adds support to Linux Perf in order
> to be able to analyze qemu jitted code and
> also to able to see the TBs PC in it.

Is there any reference to the file format?  Please include it in a code
comment, if such a thing exists.

> diff --git a/accel/tcg/perf/jitdump.c b/accel/tcg/perf/jitdump.c
> new file mode 100644
> index 0000000000..6f4c0911c2
> --- /dev/null
> +++ b/accel/tcg/perf/jitdump.c
> @@ -0,0 +1,180 @@

License header?

> +#ifdef __linux__

If the entire source file is #ifdef __linux__ then Makefile.objs should
probably contain obj-$(CONFIG_LINUX) +=3D jitdump.o instead.  Letting the
build system decide what to compile is cleaner than ifdeffing large
amounts of code.

> +
> +#include <stdint.h>
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <time.h>
> +#include <sys/syscall.h>
> +#include <elf.h>
> +
> +#include "jitdump.h"
> +#include "qemu-common.h"

Please follow QEMU's header ordering conventions.  See ./HACKING "1.2.
Include directives".

> +void start_jitdump_file(void)
> +{
> +    GString *dumpfile_name =3D g_string_new(NULL);;
> +    g_string_printf(dumpfile_name, "./jit-%d.dump", getpid());

Simpler:

  gchar *dumpfile_name =3D g_strdup_printf("./jit-%d.dump", getpid());
  ...
  g_free(dumpfile_name);

> +    dumpfile =3D fopen(dumpfile_name->str, "w+");

getpid() and the global dumpfile variable make me wonder what happens
with multi-threaded TCG?

> +
> +    perf_marker =3D mmap(NULL, sysconf(_SC_PAGESIZE),

Please mention the point of this mmap in a comment.  My best guess is
that perf stores the /proc/$PID/maps and this is how it finds the
jitdump file?

> +                          PROT_READ | PROT_EXEC,
> +                          MAP_PRIVATE,
> +                          fileno(dumpfile), 0);
> +
> +    if (perf_marker =3D=3D MAP_FAILED) {
> +        printf("Failed to create mmap marker file for perf %d\n", fileno=
(dumpfile));
> +        fclose(dumpfile);
> +        return;
> +    }
> +
> +    g_string_free(dumpfile_name, TRUE);
> +
> +    struct jitheader *header =3D g_new0(struct jitheader, 1);

Why g_new this struct?  It's small and can be declared on the stack.

Please use g_free() with g_malloc/new/etc().  It's not safe to mismatch
glib and libc memory allocation functions.

> +    header->magic =3D 0x4A695444;
> +    header->version =3D 1;
> +    header->elf_mach =3D get_e_machine();
> +    header->total_size =3D sizeof(struct jitheader);
> +    header->pid =3D getpid();
> +    header->timestamp =3D get_timestamp();
> +
> +    fwrite(header, header->total_size, 1, dumpfile);
> +
> +    free(header);
> +    fflush(dumpfile);
> +}
> +
> +void append_load_in_jitdump_file(TranslationBlock *tb)
> +{
> +    GString *func_name =3D g_string_new(NULL);
> +    g_string_printf(func_name, "TB virt:0x"TARGET_FMT_lx"%c", tb->pc, '\=
0');

The explicit NUL character looks strange to me.  I think the idea is to
avoid func_name->len + 1?  Adding NUL characters to C strings can be a
source of bugs, I would stick to convention and do len + 1 instead of
putting NUL characters into the GString.  This is a question of style
though.

> +
> +    struct jr_code_load *load_event =3D g_new0(struct jr_code_load, 1);

No need to allocate load_event on the heap.

> diff --git a/qemu-options.hx b/qemu-options.hx
> index 9621e934c0..1c26eeeb9c 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4147,6 +4147,18 @@ STEXI
>  Enable FIPS 140-2 compliance mode.
>  ETEXI
> =20
> +#ifdef __linux__
> +DEF("perf", 0, QEMU_OPTION_perf,
> +    "-perf    dump jitdump files to help linux perf JIT code visualizati=
on\n",
> +    QEMU_ARCH_ALL)
> +#endif
> +STEXI
> +@item -perf
> +@findex -perf
> +Dumps jitdump files to help linux perf JIT code visualization

Suggestions on expanding the documentation:

Where are the jitdump files dumped?  The current working directory?

Anything to say about the naming scheme for these files?

Can you include an example of how to load them into perf(1)?

--UKNXkkdQCYZ6W5l3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1VbuQACgkQnKSrs4Gr
c8hKdAf3X2YbRC+vFntjIhFPpE2g/BM6fbrk4GnbApLxXGjRW6c0pATQ+zQ3ce17
KlRiYlSkozSgWO6QRaH8WiWj0MXaROiGL/qdxJVUMwDdCuwWKoXxivJtq5sQhjt2
duUjXoiA9qEAuN1ylbPEFBqMKFfws+bvtb+g9eZtsGO2YbqCdXnEfV+WOh9beBhy
CopsohgzbbulO4/4ZqWhtJex0W0DtsvY1ZkPTU5w84AYJamTpwxhS2RW5tZIImM8
Izc8h8qSJFcws6xM75MpDZ6MGb4eNLmVr8qs8liJ6MDxISJkKiFSxWO7cFnrr9k3
TYz/fApW+IygauWIYDMOjz2JzCkI
=ZDuQ
-----END PGP SIGNATURE-----

--UKNXkkdQCYZ6W5l3--

