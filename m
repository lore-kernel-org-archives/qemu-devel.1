Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A91C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D571A2080C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSCSBjYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D571A2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8k4W-0005xP-2C
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8k3G-0004Kg-Gh
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8k3A-0001sk-6v
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:20:01 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50528)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8k39-0001sL-VD
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:19:56 -0500
Received: by mail-wm1-x342.google.com with SMTP id a5so10940404wmb.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=u+JouUiAegCLLwsa79s/hXM6hpXtCJxnWo81QMCcaNU=;
 b=kSCSBjYXKIXhGZQgHwlBa2p47fEea8vkHEWdQHmOtf73sUF2FPW/6iWJkBpkLdHKnr
 YtZu/kYKZHFeiFttaoB49sSlyMISYnkyKpubEDCEf3182aKYGxQ6mCH/DA6MNUXGAfYM
 qjOjz7Z870YKe7dK//hEUwBAlQK5U3HyYfugxx+MHQTMzOc05wLVD7liFQodsLk5Ieu8
 38tiQkOEPdBrlz42pAW+uPDmSM6/8TabQsPOX7ztSsf/Ycms7H2DgllG+xzZalTW53+I
 NvIkMgyJwEGZKQe28S8akA4v+ahRZxGjy0MAg9L7BdBMoBS8I8Eim/w4VtgXtGF53avt
 IV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=u+JouUiAegCLLwsa79s/hXM6hpXtCJxnWo81QMCcaNU=;
 b=EYHWzYSxCWzLGtY1FtQnjg69k3X6nCa09ir2/aR+Pl/3Z0ByVDa1Z0JGZPfEwApOsQ
 5a2JEgtmW5US60fID2ipRsXkykX4zioZZWpLLFKwzMWS1NxZixcCfEaGx/Ymq8EBFu5H
 lDF1akWv60oKFD/O5NE2jUF+OYMgv30z1wuhrWXfJcgzmLPLriMAx0y5N//fNTaV0Xmd
 Netc1SYoLrVvL39eCnh/lPqcjHf37OJtsHUmhUAZBZYc0VjiE72GHQAWFneAhKICZPiW
 MTl+4OaOkI+zo+OSbnYtWsZF1cuj+mlYUSqp3qknZAUCvpOWG69SDak2T6MkeTGC07rg
 uNpw==
X-Gm-Message-State: APjAAAXqv1Vcgysk3jwX+h7nrIk/4+u/ORPRpAUN2q8MPRNTOGHHFV18
 AZQvTGQ8t72I7komNxtNZ03sNg==
X-Google-Smtp-Source: APXvYqwnokivCEtWgFhq9+MIfk3S0+fkSjDpFe3IhpLA2ymnrbUfI86y26QRtLvhtyjRF7x9xrPfWQ==
X-Received: by 2002:a1c:f707:: with SMTP id v7mr19481514wmh.121.1583151594896; 
 Mon, 02 Mar 2020 04:19:54 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v7sm20766417wrm.49.2020.03.02.04.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:19:53 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 225E91FF87;
 Mon,  2 Mar 2020 12:19:53 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-26-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 25/33] scripts/hxtool-conv: Archive script used in
 qemu-options.hx conversion
In-reply-to: <20200228153619.9906-26-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 12:19:53 +0000
Message-ID: <87h7z79ceu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> This commit archives the perl script used to do conversion of the
> STEXI/ETEXI blocks in qemu-options.hx. (The other .hx files were
> manually converted, but qemu-options.hx is complicated enough that
> I felt I needed some scripting.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> Please don't critique the script, it is purely for a one-off
> conversion job, and I then did manual fixups on the output
> to get the changes in the following patch. I merely felt it
> was potentially useful to archive a copy of the mechanism used.
> Or we could drop this patch if that's not needed.
> ---
>  scripts/hxtool-conv.pl | 137 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100755 scripts/hxtool-conv.pl
>
> diff --git a/scripts/hxtool-conv.pl b/scripts/hxtool-conv.pl
> new file mode 100755
> index 00000000000..eede40b3462
> --- /dev/null
> +++ b/scripts/hxtool-conv.pl
> @@ -0,0 +1,137 @@
> +#!/usr/bin/perl -w
> +#
> +# Script to convert .hx file STEXI/ETEXI blocks to SRST/ERST
> +#
> +# Copyright (C) 2020 Linaro
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# (at your option) any later version. See the COPYING file in the
> +# top-level directory.
> +
> +# This script was only ever intended as a one-off conversion operation.
> +# Please excuse the places where it is a bit hacky.
> +# Some manual intervention after the conversion is expected, as are
> +# some warnings from makeinfo.
> +# Warning: this script is not idempotent: don't try to run it on
> +# a .hx file that already has SRST/ERST sections.
> +
> +# Expected usage:
> +# scripts/hxtool-conv.pl file.hx > file.hx.new
> +
> +use utf8;
> +
> +my $reading_texi =3D 0;
> +my $texiblock =3D '';
> +my @tables =3D ();
> +
> +sub update_tables($) {
> +    my ($texi) =3D @_;
> +    # Update our list of open table directives: every @table
> +    # line in the texi fragment is added to the list, and every
> +    # @end table line means we remove an entry from the list.
> +    # If this fragment had a completely self contained table with
> +    # both the @table and @end table lines, this will be a no-op.
> +    foreach (split(/\n/, $texi)) {
> +        push @tables, $_ if /^\@table/;
> +        pop @tables if /^\@end table/;
> +    }
> +}
> +
> +sub only_table_directives($) {
> +    # Return true if every line in the fragment is a start or end table =
directive
> +    my ($texi) =3D @_;
> +    foreach (split(/\n/, $texi)) {
> +        return 0 unless /^\@table/ or /^\@end table/;
> +    }
> +    return 1;
> +}
> +
> +sub output_rstblock($) {
> +    # Write the output to /tmp/frag.texi, wrapped in whatever current @t=
able
> +    # lines we need.
> +    my ($texi) =3D @_;
> +
> +    # As a special case, if this fragment is only table directives and
> +    # nothing else, update our set of open table directives but otherwise
> +    # ignore it. This avoids emitting an empty SRST/ERST block.
> +    if (only_table_directives($texi)) {
> +        update_tables($texi);
> +        return;
> +    }
> +
> +    open(my $fragfh, '>', '/tmp/frag.texi');
> +    # First output the currently active set of open table directives
> +    print $fragfh join("\n", @tables);
> +    # Next, update our list of open table directives.
> +    # We need to do this before we emit the closing table directives
> +    # so that we emit the right number if this fragment had an
> +    # unbalanced set of directives.
> +    update_tables($texi);
> +    # Then emit the texi fragment itself.
> +    print $fragfh "\n$texi\n";
> +    # Finally, add the necessary closing table directives.
> +    print $fragfh "\@end table\n" x scalar @tables;
> +    close $fragfh;
> +
> +    # Now invoke makeinfo/pandoc on it and slurp the results into a stri=
ng
> +    open(my $fh, '-|', "makeinfo --force -o - --docbook "
> +         . "-D 'qemu_system_x86 QEMU_SYSTEM_X86_MACRO' "
> +         . "-D 'qemu_system     QEMU_SYSTEM_MACRO'  /tmp/frag.texi "
> +         . " | pandoc  -f docbook -t rst")
> +        or die "can't start makeinfo/pandoc: $!";
> +
> +    binmode $fh, ':encoding(utf8)';
> +
> +    print "SRST\n";
> +
> +    # Slurp the whole thing into a string so we can do multiline
> +    # string matches on it.
> +    my $rst =3D do {
> +        local $/ =3D undef;
> +        <$fh>;
> +    };
> +    $rst =3D~ s/^-  =E2=88=92 /-  /gm;
> +    $rst =3D~ s/=E2=80=9C/"/gm;
> +    $rst =3D~ s/=E2=80=9D/"/gm;
> +    $rst =3D~ s/=E2=80=98/'/gm;
> +    $rst =3D~ s/=E2=80=99/'/gm;
> +    $rst =3D~ s/QEMU_SYSTEM_MACRO/|qemu_system|/g;
> +    $rst =3D~ s/QEMU_SYSTEM_X86_MACRO/|qemu_system_x86|/g;
> +    $rst =3D~ s/(?=3D::\n\n +\|qemu)/.. parsed-literal/g;
> +    $rst =3D~ s/:\n\n::$/::/gm;
> +
> +    # Fix up the invalid reference format makeinfo/pandoc emit:
> +    # `Some string here <#anchorname>`__
> +    # should be:
> +    # :ref:`anchorname`
> +    $rst =3D~ s/\`[^<`]+\<\#([^>]+)\>\`__/:ref:`$1`/gm;
> +    print $rst;
> +
> +    close $fh or die "error on close: $!";
> +    print "ERST\n";
> +}
> +
> +# Read the whole .hx input file.
> +while (<>) {
> +    # Always print the current line
> +    print;
> +    if (/STEXI/) {
> +        $reading_texi =3D 1;
> +        $texiblock =3D '';
> +        next;
> +    }
> +    if (/ETEXI/) {
> +        $reading_texi =3D 0;
> +        # dump RST version of block
> +        output_rstblock($texiblock);
> +        next;
> +    }
> +    if ($reading_texi) {
> +        # Accumulate the texi into a string
> +        # but drop findex entries as they will confuse makeinfo
> +        next if /^\@findex/;
> +        $texiblock .=3D $_;
> +    }
> +}
> +
> +die "Unexpectedly still in texi block at EOF" if $reading_texi;


--=20
Alex Benn=C3=A9e

