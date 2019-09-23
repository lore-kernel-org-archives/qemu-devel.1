Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8845C4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D5120820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hjhGikXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D5120820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCR2F-00060v-4x
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCR0B-0004nV-4v
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCR05-0005bB-Oy
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:15:50 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCR03-0005Xk-JV
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:15:44 -0400
Received: by mail-wr1-x442.google.com with SMTP id r3so14661368wrj.6
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=905fg85mXotWkndsf9/tYxO8GqAW4/0SR9bLYBe7vQQ=;
 b=hjhGikXD+VwvsiFmAKRSFul4PtQ9NMNOrqLk8RvGX1uiVtVxod75XECMfNRPA3XXb4
 YCv+2MEmHOQe0HAY9dtFsorVC0MSZFzeTcU1h54IIsb8/c9T0fK+7NgtG5F0xEz0UE2N
 AkHt5FRMuMtULW+Ttcoy+bMfgtqD5kfG/87gvARa+MMxvzzi9Pzg2EmPKTZDSjqSlUXR
 JnEuI0GEQnEQhZDGzkQx67VLgc/FviEi2gNZuEgZ7W+BdGc2tjbFIJGOyJ9KwdTnF6F4
 6TvwmxvFIOd7gmUGfHoo99OvFNr/U1boNgeC6Z3pGhK5wu1cR1p4OxDbqRox0Rs1oABl
 zKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=905fg85mXotWkndsf9/tYxO8GqAW4/0SR9bLYBe7vQQ=;
 b=JSw77zlkTDSY/MLMZuZIDGbydd9lxECkDl7P1Ry/GtPmSsaJLnZyLPNitxCg6WcsR+
 CPvqMbcEBKQ3aLlmm4FwR7u7FEeyPhzBpyylQKQ38jc+Txk/iAh8ONUWtLwpHQjER19G
 b/08FUT7wsUIcBTK+irsfgSO3x/sRTfvOm1IgIHJyVaw7CWvS2GWvenNaKOgrKeAiBZx
 d7hqJ0VrJwN4p0UT6xEvn+R7L5kTPQPoWmd/Ld/Mk7xiZnNShbESpUlv+wuSF6KbNuY4
 96DXGuyTGcRRiU5myZlTh4dvBS5MEadgIrngbmxs2IfN6CQBqpoVYocEXzSZqhlAHrI9
 9mIw==
X-Gm-Message-State: APjAAAUMPV7WFSRMUVlgw+9OnoexWiKkZx+0TuK3x0TYmz5dLIdzGUHU
 Y8Rio1RZItDU2i2M1Nq6GfPgnZwWk8Tp4g==
X-Google-Smtp-Source: APXvYqxYFKLTQfmFFNrPFhhv+UCL74NlMHvK/BHp9Mpe0nPtAS/R8hvr4SX6frQiQyl9A8LnZ+PfkQ==
X-Received: by 2002:adf:ec85:: with SMTP id z5mr188616wrn.374.1569255339149;
 Mon, 23 Sep 2019 09:15:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a7sm12196119wra.43.2019.09.23.09.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 09:15:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B16CF1FF87;
 Mon, 23 Sep 2019 17:15:37 +0100 (BST)
References: <20190923131022.15498-1-dgilbert@redhat.com>
 <20190923131022.15498-3-dgilbert@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>
Subject: Re: [PATCH 2/2] tests/migration/postcopy: trim migration bandwidth
In-reply-to: <20190923131022.15498-3-dgilbert@redhat.com>
Date: Mon, 23 Sep 2019 17:15:37 +0100
Message-ID: <87tv93at06.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Dr. David Alan Gilbert (git) <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> On slow hosts with tcg we were sometimes finding that the migration
> would complete during precopy and never get into the postcopy test.
> Trim back the bandwidth a bit to make that much less likely.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/migration-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 9c62ee5331..221a33d083 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -753,7 +753,7 @@ static int migrate_postcopy_prepare(QTestState **from=
_ptr,
>       * quickly, but that it doesn't complete precopy even on a slow
>       * machine, so also set the downtime.
>       */
> -    migrate_set_parameter_int(from, "max-bandwidth", 100000000);
> +    migrate_set_parameter_int(from, "max-bandwidth", 30000000);
>      migrate_set_parameter_int(from, "downtime-limit", 1);
>
>      /* Wait for the first serial output from the source */


--
Alex Benn=C3=A9e

