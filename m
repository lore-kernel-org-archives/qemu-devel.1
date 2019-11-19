Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88656C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 07:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52FF72230E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 07:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dbseAAxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FF72230E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWyMd-0007Aa-Gg
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 02:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iWyLq-0006e3-Lh
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:55:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iWyLm-0001tf-AN
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:55:06 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iWyLm-0001sV-0u
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:55:02 -0500
Received: by mail-wr1-x443.google.com with SMTP id n1so22543979wra.10
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 23:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2dKO6dUFhZhKhbonLsTaigSqlt0OLIgJrad20H6Bfcg=;
 b=dbseAAxhZSzCkiwFz/fQ0BT17hzJG+EVOanx7aVDdgNwT1EGEDwZsQriyVZOeW1ljw
 hvdzaDl06ARLceqCSriWfnPDJ2A46n11LkadP9JvGm2hhof4HTTeFTBrtk2gCUDlgv1y
 hoQKvuiA1f+q+vAdMGmp2kOgc7L2UJsPFB/0Fjx9xx5A9ch7Wg1nUg+qkI4cs9L1TAlc
 U/udTTH0qcJJLPkv610qqGLrTAEsU1XS/SDPTh0HOArFLQjNzq/DYjzgYK0rlU0aU9tx
 40wOV38cgGAVAYwe62IPTXZSwAISl7FOXOaM1evyK4EktYaRMfGMHZlDp/2Ji0PQTd8z
 ah5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2dKO6dUFhZhKhbonLsTaigSqlt0OLIgJrad20H6Bfcg=;
 b=uAWDXhZaptnIiUL01WJP3v+oytxcF8V8wxGv4ctaPIFmvLLqfcsozXd3Hvl5dQskIM
 kUVhnIDtFLL1vtFCibzwjGQybZIdEEy7mNBXqESBS5b4kGi4yNh63hBx7thxV9tuZzV7
 V59oJfI9mccUxLXq2m14l//rlfDdm7S3xtSNffcdmVlY9klKnJOFB5P3NUkeOZMG73WJ
 7CsY+g43nfV88SIC0WhTreomV0xjor7X2Zbjx6r5KqxyjN46zge1FF9NGegWqoRT3wGY
 AQ76opFv3Lrve5Cmjg0x/NbBGYlcyE9bGB1ZfnGGLbm6hE3aPTB/Sv80mDXv3udgHsM/
 WS6g==
X-Gm-Message-State: APjAAAWfuRaGLVpeK0rFdiNwEzj0N50K6JoG1OqPRut7D0IQHKlmZ9KF
 WLB6360sMdAIkIveX1VsAnd6tw==
X-Google-Smtp-Source: APXvYqxlvQF09Bt7gLYcwp51LHhP+qFaWCjFD0AYPwDiO05nR/O/Q/dlmGgH8C3NJ/ACV/VaMtl5ew==
X-Received: by 2002:adf:a3d5:: with SMTP id m21mr21214981wrb.386.1574150100228; 
 Mon, 18 Nov 2019 23:55:00 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n23sm2213674wmc.18.2019.11.18.23.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 23:54:59 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 53DCA1FF87;
 Tue, 19 Nov 2019 07:54:58 +0000 (GMT)
References: <20191113142101.30280-1-alex.bennee@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: pbonzini@redhat.com
Subject: Re: [RFC PATCH] scripts/tap-driver: report "slow" tests (HACK)
In-reply-to: <20191113142101.30280-1-alex.bennee@linaro.org>
Date: Tue, 19 Nov 2019 07:54:58 +0000
Message-ID: <871ru4gv1p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Some tests seem to run slower on CI systems but we don't really get
> visibility of which it is unless we happen to hang the test at the end
> of a run. This hacky change exposes "slow" tests in the tap output.
>
> [AJB: my perl is rusty, I'm sure this could be more idiomatic]
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

ping? It would be nice to get this or something similar in 4.2

> ---
>  scripts/tap-driver.pl | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/tap-driver.pl b/scripts/tap-driver.pl
> index 6621a5cd671..0fe748d5de6 100755
> --- a/scripts/tap-driver.pl
> +++ b/scripts/tap-driver.pl
> @@ -29,6 +29,7 @@ use strict;
>  use Getopt::Long ();
>  use TAP::Parser;
>  use Term::ANSIColor qw(:constants);
> +use Time::HiRes qw( time );
>
>  my $ME =3D "tap-driver.pl";
>  my $VERSION =3D "2018-11-30";
> @@ -111,7 +112,7 @@ sub decorate_result ($);
>  sub extract_tap_comment ($);
>  sub handle_tap_bailout ($);
>  sub handle_tap_plan ($);
> -sub handle_tap_result ($);
> +sub handle_tap_result ($$);
>  sub is_null_string ($);
>  sub main ();
>  sub report ($;$);
> @@ -220,12 +221,18 @@ sub testsuite_error ($)
>    report "ERROR", "- $_[0]";
>  }
>
> -sub handle_tap_result ($)
> +sub handle_tap_result ($$)
>  {
>    $testno++;
>    my $result_obj =3D shift;
> +  my $time =3D shift;
>
>    my $test_result =3D stringify_result_obj $result_obj;
> +
> +  if ($time > 1.0) {
> +    $test_result =3D $test_result . sprintf(" (%0.1fs)", $time);
> +  }
> +
>    my $string =3D $result_obj->number;
>
>    my $description =3D $result_obj->description;
> @@ -312,6 +319,9 @@ sub main ()
>  {
>    my $iterator =3D TAP::Parser::Iterator::Stream->new(\*STDIN);
>    my $parser =3D TAP::Parser->new ({iterator =3D> $iterator });
> +  my ($start, $end);
> +
> +  $start =3D time();
>
>    STDOUT->autoflush(1);
>    while (defined (my $cur =3D $parser->next))
> @@ -325,7 +335,9 @@ sub main ()
>          }
>        elsif ($cur->is_test)
>          {
> -          handle_tap_result ($cur);
> +          $end =3D time();
> +          handle_tap_result ($cur, $end - $start);
> +          $start =3D time();
>          }
>        elsif ($cur->is_bailout)
>          {


--
Alex Benn=C3=A9e

