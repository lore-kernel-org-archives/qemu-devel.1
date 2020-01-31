Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981CFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:15:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569F4214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vky973hz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569F4214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixYxA-000392-Gn
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ixY0O-0008FA-HS
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ixY0L-0005Br-FL
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:14:48 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ixY0L-00056M-70
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:14:45 -0500
Received: by mail-wr1-x444.google.com with SMTP id w15so9039731wru.4
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 07:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=w2X0DjYvTl+Huffu87kNbth7R3MRel+9eE0ZqHo7caI=;
 b=vky973hzjyMp/3TT+3EgEfT27+6uBeyqJetaT+siSX9tqrXVe7GRaS6lKSjf/iyeQa
 gjnj5JjDMVz80hcJEbbplpwFAP4UjBKMJLxr12Sfp3aEa6/Z4fQpy3Z6IJPQpJ7dsard
 dEyWq6NVg5hXexjQUBOFj0e6SbKAN0TLu5UOhCMACfGvpb8EnlI4UAhpYFmXGRbrS0/y
 QTpElxNWjUdlqrv+Tt65ILLWKrG8Mx8uuo75/+C+a57pp0bEmK2BSzizGlLafPv/mkEm
 iSsPVEy47XysrBL3Ux6WH44pK/FZ6kZPkS1t0Squz77p+XzvgJ0vNE/TCBjyS791NoPX
 QIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=w2X0DjYvTl+Huffu87kNbth7R3MRel+9eE0ZqHo7caI=;
 b=SkBM70kGEX2kDTXme1m6cqRw9+YZMMXyAl82cKts9YuM0QtsDrUxDmGyRz7VHJRwh0
 YhhKpdMC3VOy6r2SHEuUX00ffGfEi39yBW7q5KxZKBvIoN+kY6UJETqCpx8VeoDcltLe
 Y1vGTanDT/WWYTIlMY4BBvHYUNgDMMh1qbvX7HY64oeAphwic88XRoolCME886lK6ZOC
 0+rGWiNIKCk33NPsaFTLnLKZcw2MXimXneXKocISzcRSwJuJz0ibRnA6hW6clwkMkkJJ
 tKvSxTNqxXsyK8Dj5ViZUIo2GxHpKWxFqejrSrUtJjRV/bm85o4O9zZVMx2JEDGw7jsH
 OROw==
X-Gm-Message-State: APjAAAUAO0sSjx3PJQ0leFWY3TaiP00FGDJ3QPyobW9NXV+ZeAkXupks
 N3eMznH1q8CYMAK+nJCAswmkAw==
X-Google-Smtp-Source: APXvYqxnytKOz/2NmOY1h1qQr1Gpu/SjtWOrKh/UQBp0QS9slMlQ0FOogOoQetz55PbRpERCqwR53w==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr12373944wrt.367.1580483684020; 
 Fri, 31 Jan 2020 07:14:44 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c9sm11149999wmc.47.2020.01.31.07.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2020 07:14:42 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F10921FF87;
 Fri, 31 Jan 2020 15:14:41 +0000 (GMT)
References: <20200124162606.8787-1-peter.maydell@linaro.org>
 <20200124162606.8787-7-peter.maydell@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 6/8] qemu-img-cmds.hx: Remove texinfo document fragments
In-reply-to: <20200124162606.8787-7-peter.maydell@linaro.org>
Date: Fri, 31 Jan 2020 15:14:41 +0000
Message-ID: <87eevf8xpa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Now the qemu-img documentation has been converted to rST, we can
> remove the texinfo document fragments from qemu-img-cmds.hx, as
> they are no longer used.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  qemu-img-cmds.hx | 56 +++---------------------------------------------
>  1 file changed, 3 insertions(+), 53 deletions(-)
>
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index 0c8b210b3c3..32e999d0965 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -1,143 +1,93 @@
>  HXCOMM Keep the list of subcommands sorted by name.
>  HXCOMM Use DEFHEADING() to define headings in both help text and texi
> -HXCOMM Text between STEXI and ETEXI are copied to texi version and
> +HXCOMM Text between SRST and ERST are copied to rST version and
>  HXCOMM discarded from C version
>  HXCOMM DEF(command, callback, arg_string) is used to construct
>  HXCOMM command structures and help message.
> -HXCOMM HXCOMM can be used for comments, discarded from both texi and C
> +HXCOMM HXCOMM can be used for comments, discarded from both rST and C
>=20=20
> -HXCOMM When amending the TEXI sections, please remember to copy the usage
> +HXCOMM When amending the rST sections, please remember to copy the usage
>  HXCOMM over to the per-command sections in qemu-img.texi.
>=20=20
> -STEXI
> -@table @option
> -ETEXI
> -
>  DEF("amend", img_amend,
>      "amend [--object objectdef] [--image-opts] [-p] [-q] [-f fmt] [-t ca=
che] -o options filename")
> -STEXI
> -@item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var=
{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
> -ETEXI
>  SRST
>  .. option:: amend [--object OBJECTDEF] [--image-opts] [-p] [-q] [-f FMT]=
 [-t CACHE] -o OPTIONS FILENAME
>  ERST
>=20=20
>  DEF("bench", img_bench,
>      "bench [-c count] [-d depth] [-f fmt] [--flush-interval=3Dflush_inte=
rval] [-n] [--no-drain] [-o offset] [--pattern=3Dpattern] [-q] [-s buffer_s=
ize] [-S step_size] [-t cache] [-w] [-U] filename")
> -STEXI
> -@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-in=
terval=3D@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--patte=
rn=3D@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @v=
ar{cache}] [-w] [-U] @var{filename}
> -ETEXI
>  SRST
>  .. option:: bench [-c COUNT] [-d DEPTH] [-f FMT] [--flush-interval=3DFLU=
SH_INTERVAL] [-n] [--no-drain] [-o OFFSET] [--pattern=3DPATTERN] [-q] [-s B=
UFFER_SIZE] [-S STEP_SIZE] [-t CACHE] [-w] [-U] FILENAME
>  ERST
>  DEF("check", img_check,
>      "check [--object objectdef] [--image-opts] [-q] [-f fmt] [--output=
=3Dofmt] [-r [leaks | all]] [-T src_cache] [-U] filename")
> -STEXI
> -@item check [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt}=
] [--output=3D@var{ofmt}] [-r [leaks | all]] [-T @var{src_cache}] [-U] @var=
{filename}
> -ETEXI
>  SRST
>  .. option:: check [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [--o=
utput=3DOFMT] [-r [leaks | all]] [-T SRC_CACHE] [-U] FILENAME
>  ERST
>=20=20
>  DEF("commit", img_commit,
>      "commit [--object objectdef] [--image-opts] [-q] [-f fmt] [-t cache]=
 [-b base] [-d] [-p] filename")
> -STEXI
> -@item commit [--object @var{objectdef}] [--image-opts] [-q] [-f @var{fmt=
}] [-t @var{cache}] [-b @var{base}] [-d] [-p] @var{filename}
> -ETEXI
>  SRST
>  .. option:: commit [--object OBJECTDEF] [--image-opts] [-q] [-f FMT] [-t=
 CACHE] [-b BASE] [-d] [-p] FILENAME
>  ERST
>=20=20
>  DEF("compare", img_compare,
>      "compare [--object objectdef] [--image-opts] [-f fmt] [-F fmt] [-T s=
rc_cache] [-p] [-q] [-s] [-U] filename1 filename2")
> -STEXI
> -@item compare [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [=
-F @var{fmt}] [-T @var{src_cache}] [-p] [-q] [-s] [-U] @var{filename1} @var=
{filename2}
> -ETEXI
>  SRST
>  .. option:: compare [--object OBJECTDEF] [--image-opts] [-f FMT] [-F FMT=
] [-T SRC_CACHE] [-p] [-q] [-s] [-U] FILENAME1 FILENAME2
>  ERST
>=20=20
>  DEF("convert", img_convert,
>      "convert [--object objectdef] [--image-opts] [--target-image-opts] [=
-U] [-C] [-c] [-p] [-q] [-n] [-f fmt] [-t cache] [-T src_cache] [-O output_=
fmt] [-B backing_file] [-o options] [-l snapshot_param] [-S sparse_size] [-=
m num_coroutines] [-W] [--salvage] filename [filename2 [...]] output_filena=
me")
> -STEXI
> -@item convert [--object @var{objectdef}] [--image-opts] [--target-image-=
opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @va=
r{src_cache}] [-O @var{output_fmt}] [-B @var{backing_file}] [-o @var{option=
s}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutine=
s}] [-W] [--salvage] @var{filename} [@var{filename2} [...]] @var{output_fil=
ename}
> -ETEXI
>  SRST
>  .. option:: convert [--object OBJECTDEF] [--image-opts] [--target-image-=
opts] [-U] [-C] [-c] [-p] [-q] [-n] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-O =
OUTPUT_FMT] [-B BACKING_FILE] [-o OPTIONS] [-l SNAPSHOT_PARAM] [-S SPARSE_S=
IZE] [-m NUM_COROUTINES] [-W] [--salvage] FILENAME [FILENAME2 [...]] OUTPUT=
_FILENAME
>  ERST
>=20=20
>  DEF("create", img_create,
>      "create [--object objectdef] [-q] [-f fmt] [-b backing_file] [-F bac=
king_fmt] [-u] [-o options] filename [size]")
> -STEXI
> -@item create [--object @var{objectdef}] [-q] [-f @var{fmt}] [-b @var{bac=
king_file}] [-F @var{backing_fmt}] [-u] [-o @var{options}] @var{filename} [=
@var{size}]
> -ETEXI
>  SRST
>  .. option:: create [--object OBJECTDEF] [-q] [-f FMT] [-b BACKING_FILE] =
[-F BACKING_FMT] [-u] [-o OPTIONS] FILENAME [SIZE]
>  ERST
>=20=20
>  DEF("dd", img_dd,
>      "dd [--image-opts] [-U] [-f fmt] [-O output_fmt] [bs=3Dblock_size] [=
count=3Dblocks] [skip=3Dblocks] if=3Dinput of=3Doutput")
> -STEXI
> -@item dd [--image-opts] [-U] [-f @var{fmt}] [-O @var{output_fmt}] [bs=3D=
@var{block_size}] [count=3D@var{blocks}] [skip=3D@var{blocks}] if=3D@var{in=
put} of=3D@var{output}
> -ETEXI
>  SRST
>  .. option:: dd [--image-opts] [-U] [-f FMT] [-O OUTPUT_FMT] [bs=3DBLOCK_=
SIZE] [count=3DBLOCKS] [skip=3DBLOCKS] if=3DINPUT of=3DOUTPUT
>  ERST
>=20=20
>  DEF("info", img_info,
>      "info [--object objectdef] [--image-opts] [-f fmt] [--output=3Dofmt]=
 [--backing-chain] [-U] filename")
> -STEXI
> -@item info [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--o=
utput=3D@var{ofmt}] [--backing-chain] [-U] @var{filename}
> -ETEXI
>  SRST
>  .. option:: info [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=
=3DOFMT] [--backing-chain] [-U] FILENAME
>  ERST
>=20=20
>  DEF("map", img_map,
>      "map [--object objectdef] [--image-opts] [-f fmt] [--output=3Dofmt] =
[-U] filename")
> -STEXI
> -@item map [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--ou=
tput=3D@var{ofmt}] [-U] @var{filename}
> -ETEXI
>  SRST
>  .. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=
=3DOFMT] [-U] FILENAME
>  ERST
>=20=20
>  DEF("measure", img_measure,
>  "measure [--output=3Dofmt] [-O output_fmt] [-o options] [--size N | [--o=
bject objectdef] [--image-opts] [-f fmt] [-l snapshot_param] filename]")
> -STEXI
> -@item measure [--output=3D@var{ofmt}] [-O @var{output_fmt}] [-o @var{opt=
ions}] [--size @var{N} | [--object @var{objectdef}] [--image-opts] [-f @var=
{fmt}] [-l @var{snapshot_param}] @var{filename}]
> -ETEXI
>  SRST
>  .. option:: measure [--output=3DOFMT] [-O OUTPUT_FMT] [-o OPTIONS] [--si=
ze N | [--object OBJECTDEF] [--image-opts] [-f FMT] [-l SNAPSHOT_PARAM] FIL=
ENAME]
>  ERST
>=20=20
>  DEF("snapshot", img_snapshot,
>      "snapshot [--object objectdef] [--image-opts] [-U] [-q] [-l | -a sna=
pshot | -c snapshot | -d snapshot] filename")
> -STEXI
> -@item snapshot [--object @var{objectdef}] [--image-opts] [-U] [-q] [-l |=
 -a @var{snapshot} | -c @var{snapshot} | -d @var{snapshot}] @var{filename}
> -ETEXI
>  SRST
>  .. option:: snapshot [--object OBJECTDEF] [--image-opts] [-U] [-q] [-l |=
 -a SNAPSHOT | -c SNAPSHOT | -d SNAPSHOT] FILENAME
>  ERST
>=20=20
>  DEF("rebase", img_rebase,
>      "rebase [--object objectdef] [--image-opts] [-U] [-q] [-f fmt] [-t c=
ache] [-T src_cache] [-p] [-u] -b backing_file [-F backing_fmt] filename")
> -STEXI
> -@item rebase [--object @var{objectdef}] [--image-opts] [-U] [-q] [-f @va=
r{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-p] [-u] -b @var{backing_fil=
e} [-F @var{backing_fmt}] @var{filename}
> -ETEXI
>  SRST
>  .. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT=
] [-t CACHE] [-T SRC_CACHE] [-p] [-u] -b BACKING_FILE [-F BACKING_FMT] FILE=
NAME
>  ERST
>=20=20
>  DEF("resize", img_resize,
>      "resize [--object objectdef] [--image-opts] [-f fmt] [--preallocatio=
n=3Dprealloc] [-q] [--shrink] filename [+ | -]size")
> -STEXI
> -@item resize [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [-=
-preallocation=3D@var{prealloc}] [-q] [--shrink] @var{filename} [+ | -]@var=
{size}
> -ETEXI
>  SRST
>  .. option:: resize [--object OBJECTDEF] [--image-opts] [-f FMT] [--preal=
location=3DPREALLOC] [-q] [--shrink] FILENAME [+ | -]SIZE
>  ERST
> -
> -STEXI
> -@end table
> -ETEXI


--=20
Alex Benn=C3=A9e

