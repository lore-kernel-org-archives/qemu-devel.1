Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB24C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187B6215EA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 10:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQcuZTz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187B6215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4jGY-0007Io-9j
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 06:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i4jFg-0006qF-2G
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i4jFe-0005rI-Uu
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:08:00 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35557)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i4jFe-0005qs-OK
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 06:07:58 -0400
Received: by mail-wm1-x343.google.com with SMTP id n10so3271255wmj.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 03:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=HMm1cMzg6Z1mRIXLcB654xqbgrTIZUnqJnXVbmW4JgA=;
 b=OQcuZTz5dFn9/6/XyjFUSNs/iTz0rL/x5YUziDz6OVzbwjTEc5TP81q8VO1Cyol3DO
 ZmOLQZNHoE6P76q6wtfgjcjJ3/dlp5w86k6FSkVXSggppEgfPa/TsoE2F6cMgQeg5ZX1
 u2xhPqIbzh9gn1ZgRNwyJKrpbrTbTkW83NvkhzbKbTwWjnPvm57gbpEgluXR8bY/6+bW
 BAHmkIPJbBkwXTd5dcKLbOUbuS2mUn0ovXLsbjYbchWscBqnESLsOifrETcAb9nmhSrx
 OJuJKQVP6q+XKSpLWh0KXhPzlYXIoy3sa8Y/1lc1Lah4bTSdScUtdfNurqmxWWZSHHb6
 /mVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HMm1cMzg6Z1mRIXLcB654xqbgrTIZUnqJnXVbmW4JgA=;
 b=oDdvxakWGikOoduqJzEIFSW9Mp5nriP8YIkGVUXfa8ly2L5lWaNBvo5cCHZ7QvRpXI
 +lcfhEUegnt+u7L03zdEU5AIb2z2Y9r1CkREPeTslKIqLQ84V9jd8V5D5uEr30hdqrQX
 lGgtl4bTcPpqPnv6uTSTfoHlRGqEgLmn0myGYLzo/ZB4ReQagoB5f7Win3LHyaoS8GLA
 2jRjWksUbv4ziDpr3l5PHUhZaUsiG1+RyW+hQRx1+VTCAZzoK2O7dTg1Q6+Idws5Baay
 acX1QKnowF1HWcv+pBrT/tjL9Fw2W33p3GtkxJpoUJHDHltNecfrqv2xD3Vl1YdL44hN
 8Seg==
X-Gm-Message-State: APjAAAU1olGlBL4I7YdWEIMdxV48lRkeWNhw2jTFb//DFxBbl3U4YiBu
 +//N2TLSvygdBqzpqugGlv4=
X-Google-Smtp-Source: APXvYqwwUEXAh5fRjNJJRM13SmQkyFd6Bk8H7M1V5HI+fWeTWZSz/9L7G6xC3HyUPm9n41XiOjV1Nw==
X-Received: by 2002:a1c:7c17:: with SMTP id x23mr14386726wmc.26.1567418877522; 
 Mon, 02 Sep 2019 03:07:57 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b15sm30606475wmb.28.2019.09.02.03.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 03:07:56 -0700 (PDT)
Date: Mon, 2 Sep 2019 11:07:55 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: vandersonmr <vandersonmr2@gmail.com>
Message-ID: <20190902100755.GG9069@stefanha-x1.localdomain>
References: <20190830121903.17585-1-vandersonmr2@gmail.com>
 <20190830121903.17585-2-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/Zw+/jwnNHcBRYYu"
Content-Disposition: inline
In-Reply-To: <20190830121903.17585-2-vandersonmr2@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v2 1/2] accel/tcg: adding integration with
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


--/Zw+/jwnNHcBRYYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2019 at 09:19:02AM -0300, vandersonmr wrote:
> This commit adds support to Linux Perf in order
> to be able to analyze qemu jitted code and
> also to able to see the TBs PC in it.
>=20
> When using "-perf" qemu creates a jitdump file in
> the current working directory. The file format
> specification can be found in:
> https://github.com/torvalds/linux/blob/master/tools/perf/Documentation/ji=
tdump-specification.tx

Oops, the link is broken: .txt

> +struct jr_code_close {
> +    struct jr_prefix p;
> +};

Unused?

> +
> +struct jr_code_move {

Unused?

> +static uint32_t get_e_machine(void)
> +{
> +    uint32_t e_machine =3D EM_NONE;
> +    Elf64_Ehdr elf_header;
> +    FILE *exe =3D fopen("/proc/self/exe", "r");
> +
> +    if (exe =3D=3D NULL) {
> +        return e_machine;
> +    }
> +
> +    if (fread(&elf_header, sizeof(Elf64_Ehdr), 1, exe) !=3D 1) {

What if this is a 32-bit binary because QEMU was built for a 32-bit
host?

> +        goto end;
> +    }
> +
> +    e_machine =3D elf_header.e_machine;
> +
> +end:
> +    fclose(exe);
> +    return e_machine;
> +}
> +
> +void start_jitdump_file(void)
> +{
> +    gchar *dumpfile_name =3D g_strdup_printf("./jit-%d.dump", getpid());

You can now use g_autofree:

  g_autofree gchar *dumpfile_name =3D g_strdup_printf(...);

and then the explicit g_free() isn't necessary anymore (and the memory
leak in the mmap error case is also solved).

> +void append_load_in_jitdump_file(TranslationBlock *tb)
> +{
> +    gchar *func_name =3D g_strdup_printf("TB virt:0x"TARGET_FMT_lx, tb->=
pc);
> +
> +    struct jr_code_load load_event;
> +    load_event.p.id =3D JIT_CODE_LOAD;
> +    load_event.p.total_size =3D
> +        sizeof(struct jr_code_load) + strlen(func_name) + 1 + tb->tc.siz=
e;
> +    load_event.p.timestamp =3D get_timestamp();
> +    load_event.pid =3D getpid();
> +    load_event.tid =3D syscall(SYS_gettid);
> +    load_event.vma =3D tb->pc;
> +    load_event.code_addr =3D (uint64_t) tb->tc.ptr;
> +    load_event.code_size =3D tb->tc.size;
> +    load_event.code_index =3D tb->pc;
> +
> +    fwrite(&load_event, sizeof(struct jr_code_load), 1, dumpfile);
> +    fwrite(func_name, strlen(func_name) + 1, 1, dumpfile);
> +    fwrite(tb->tc.ptr, tb->tc.size, 1, dumpfile);
> +
> +    g_free(func_name);
> +    fflush(dumpfile);
> +}

I didn't see a reply to my question on the previous patch series:

  "append_load_in_jitdump_file() calls fwrite() multiple times.  What
  guarantees they will not be interleaved when multiple threads call
  this function?"

Does TCG ever throw away TBs and is it necessary to record this in the
file so perf knows about it?

--/Zw+/jwnNHcBRYYu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1s6foACgkQnKSrs4Gr
c8hx5wf+L+8PpbLSNyXfgABNaDpFia/WQqsY+jNHcBVtIgqDqbLnTrf8KLiPFTSB
c1wq+v4+J9wmkrrfio2aIJp1K9JyeNAZ73QQtIrzOoR9tYI6ViC9P/ZaDgtQ1R43
qN7cORL+BNJn2tk4vqq/eMlbRyKx5530m653cSJIeKC8rxbhHPiTBEbqy0Vx97Oi
A2C4ofMTJG8ma1/J6yU6l1JIIkB0MWpW8Nw491SO0/CKd5SzvmfVLxGoitrNC5ZH
07pXWfHoB/LHGNxuxdgbs8Dh6zs7uOTjU1W8qt7y3EJA0LTy9iY5jC8CtT8EnKyY
ecH2oHOhuAi+O4Z6A6DluFLB2+sPag==
=m+Dc
-----END PGP SIGNATURE-----

--/Zw+/jwnNHcBRYYu--

