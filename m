Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7F7C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:45:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97DF1233A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ql9wTHqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DF1233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0oKi-0006sM-Et
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 10:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i0oHF-0003Tu-E2
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i0oHD-0002Q6-VD
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:41:25 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34641)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i0oHD-0002Pg-K6
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:41:23 -0400
Received: by mail-wr1-x443.google.com with SMTP id s18so5707046wrn.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=pJNguMv23aDELdz/i/JA9gXNH838QBw/VvuRPcJ6lp0=;
 b=Ql9wTHquMPo5pu0ftBNPiNQY4DxfXVVhMO604RoGCMqsXdP9102fKrCCRq7hdbHyKh
 I8GKVclfYziFLWsQUQrHPL5ybIYJAoMoWHodUDI8DFSGWZAzU/qyYsaVFQ0F/adhwidT
 ubfEssxZaTNSgFRSaAOXFRqhI9k9aN+cH+gooL+l7xdn7YktmnSSb6TjpmUnxlClDaAw
 DT/2QAU4XmfVyfTqhw6DSVTqtvI3Z86JggzVxxjueUKHXawrIAhQOE2h0OxwlOxKrsjg
 Ioatg6ajGJlZiQwWmZH4xK6E760Wcfh47YfsaRlRBphCFcYQv/He8G5ypUAcskUkYa5Y
 OPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pJNguMv23aDELdz/i/JA9gXNH838QBw/VvuRPcJ6lp0=;
 b=D9u3xiZHrh/9EGkC33VV1WvaxRkYykefukORNTuSKcJZdkv0/Mq5XdCxr5dwjCqItu
 xQU8GDyav516Xt+ZumWyTdsZhc46M1Fp7/ekshJfA/J4jvVbbNK188uuG2UfiuYYoPky
 GBLkzYPHsNTL7Hov10IBnU32DG0nM4z5yRQvWFoylWCBkciZ+SiM9lcsO3REI84P/FDs
 UmciHzMOTaN8Yn0Tt/svmT9pWPO4kEj1sdl97RjiafMA2spwMiQYDbVTWr9BPQXqC23G
 0hg9ieisLN5EDysohQN8stbhHHibidvSZDdZF9gZt+/hrVpzVRM3NtHpQyVS/NMFmW0m
 yqWw==
X-Gm-Message-State: APjAAAV/JT5WpUCOOv1okzSyL+TDZfYxAmCMmS7buci29Sy5O+OGc+Vx
 ao28Ct1dXAeHX8YyWulGqoU=
X-Google-Smtp-Source: APXvYqzV1EALoJ9jkeBXw699NQRXGiIE8XW8IspQ85vM/IFNQYk65BsHlVOYqRHtH/7kBrdIpvXngA==
X-Received: by 2002:a5d:6ccd:: with SMTP id c13mr41760385wrc.4.1566484882429; 
 Thu, 22 Aug 2019 07:41:22 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a23sm6076767wma.24.2019.08.22.07.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2019 07:41:21 -0700 (PDT)
Date: Thu, 22 Aug 2019 15:41:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Message-ID: <20190822144120.GM20491@stefanha-x1.localdomain>
References: <20190815023725.2659-1-vandersonmr2@gmail.com>
 <20190815023725.2659-2-vandersonmr2@gmail.com>
 <20190815144036.GG10996@stefanha-x1.localdomain>
 <87lfvummhe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nrXiCraHbXeog9mY"
Content-Disposition: inline
In-Reply-To: <87lfvummhe.fsf@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: vandersonmr <vandersonmr2@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--nrXiCraHbXeog9mY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2019 at 05:17:49PM +0100, Alex Benn=E9e wrote:
>=20
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>=20
> > On Wed, Aug 14, 2019 at 11:37:24PM -0300, vandersonmr wrote:
> >> This commit adds support to Linux Perf in order
> >> to be able to analyze qemu jitted code and
> >> also to able to see the TBs PC in it.
> >
> > Is there any reference to the file format?  Please include it in a code
> > comment, if such a thing exists.
> >
> >> diff --git a/accel/tcg/perf/jitdump.c b/accel/tcg/perf/jitdump.c
> >> new file mode 100644
> >> index 0000000000..6f4c0911c2
> >> --- /dev/null
> >> +++ b/accel/tcg/perf/jitdump.c
> >> @@ -0,0 +1,180 @@
> >
> > License header?
> >
> >> +#ifdef __linux__
> >
> > If the entire source file is #ifdef __linux__ then Makefile.objs should
> > probably contain obj-$(CONFIG_LINUX) +=3D jitdump.o instead.  Letting t=
he
> > build system decide what to compile is cleaner than ifdeffing large
> > amounts of code.
> >
> >> +
> >> +#include <stdint.h>
> >> +
> >> +#include <stdio.h>
> >> +#include <unistd.h>
> >> +#include <time.h>
> >> +#include <sys/syscall.h>
> >> +#include <elf.h>
> >> +
> >> +#include "jitdump.h"
> >> +#include "qemu-common.h"
> >
> > Please follow QEMU's header ordering conventions.  See ./HACKING "1.2.
> > Include directives".
> >
> >> +void start_jitdump_file(void)
> >> +{
> >> +    GString *dumpfile_name =3D g_string_new(NULL);;
> >> +    g_string_printf(dumpfile_name, "./jit-%d.dump", getpid());
> >
> > Simpler:
> >
> >   gchar *dumpfile_name =3D g_strdup_printf("./jit-%d.dump", getpid());
> >   ...
> >   g_free(dumpfile_name);
> >
> >> +    dumpfile =3D fopen(dumpfile_name->str, "w+");
> >
> > getpid() and the global dumpfile variable make me wonder what happens
> > with multi-threaded TCG?
> >
> >> +
> >> +    perf_marker =3D mmap(NULL, sysconf(_SC_PAGESIZE),
> >
> > Please mention the point of this mmap in a comment.  My best guess is
> > that perf stores the /proc/$PID/maps and this is how it finds the
> > jitdump file?
> >
> >> +                          PROT_READ | PROT_EXEC,
> >> +                          MAP_PRIVATE,
> >> +                          fileno(dumpfile), 0);
> >> +
> >> +    if (perf_marker =3D=3D MAP_FAILED) {
> >> +        printf("Failed to create mmap marker file for perf %d\n", fil=
eno(dumpfile));
> >> +        fclose(dumpfile);
> >> +        return;
> >> +    }
> >> +
> >> +    g_string_free(dumpfile_name, TRUE);
> >> +
> >> +    struct jitheader *header =3D g_new0(struct jitheader, 1);
> >
> > Why g_new this struct?  It's small and can be declared on the stack.
> >
> > Please use g_free() with g_malloc/new/etc().  It's not safe to mismatch
> > glib and libc memory allocation functions.
> >
> >> +    header->magic =3D 0x4A695444;
> >> +    header->version =3D 1;
> >> +    header->elf_mach =3D get_e_machine();
> >> +    header->total_size =3D sizeof(struct jitheader);
> >> +    header->pid =3D getpid();
> >> +    header->timestamp =3D get_timestamp();
> >> +
> >> +    fwrite(header, header->total_size, 1, dumpfile);
> >> +
> >> +    free(header);
> >> +    fflush(dumpfile);
> >> +}
> >> +
> >> +void append_load_in_jitdump_file(TranslationBlock *tb)
> >> +{
> >> +    GString *func_name =3D g_string_new(NULL);
> >> +    g_string_printf(func_name, "TB virt:0x"TARGET_FMT_lx"%c", tb->pc,=
 '\0');
> >
> > The explicit NUL character looks strange to me.  I think the idea is to
> > avoid func_name->len + 1?  Adding NUL characters to C strings can be a
> > source of bugs, I would stick to convention and do len + 1 instead of
> > putting NUL characters into the GString.  This is a question of style
> > though.
>=20
> The glib functions always add null characters so you shouldn't need to
> manually.

Yep, just remember to do func_name->len + 1 since glib doesn't count the
NUL character that gets added automatically.

--nrXiCraHbXeog9mY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1eqZAACgkQnKSrs4Gr
c8jEkAf/efrOhnUDfhiCIsi950AWLCOXLgQzY3SGNWLmEsq28mODsO09TcbKFBsY
ulx3Rbz2eDFK6uYfP0j51LR81GOlJFzcnN3WccAM5f6kQBeDS7t5vVNK3CwsvdD+
qOC2UCVbjRRSEXvgPqV3+IrCUrqx8lsX2ay7K4o+W50aeHoFkKsm6RH/5YNJQLaR
lS2O6Xagz/7H5vXkiqf/aiGokpwBTfcv5cW9jzSqkk2ieo6uVq0pmmKuYgIaulfx
w2lEXELvMIQK0TX4NN99po6CtCIZxEDILRYm4BYkeN7pQHfJLR1s6JZtj4il9WzW
jw1xaC5hcx0bVEr1B80WIz9Erf3HLQ==
=fBE8
-----END PGP SIGNATURE-----

--nrXiCraHbXeog9mY--

