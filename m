Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED39BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E692063A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bf3f+6KP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E692063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkqo0-0004Au-0I
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 11:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jkqn6-0003SO-1Q
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:12:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39497
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jkqn3-0007xv-Uj
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592233966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ak41TMq1pbJiNMvoos07P36SHvt/NQ8xEDyDsmYJCF0=;
 b=Bf3f+6KPQk5zNl21ig90gLwGdCEXPgBPkbwaGqcvscnd3I9VtOeq8GtLyiK80JI6BWaWeO
 7R/VAil99Ey6ao2FWqV2TmbI/ap2+5cg67rIJRNRdxIR4mf1QCgEGSI7y15UVWt4JbPj61
 TOpVlvQk3uywtMJTwGj26Ewaxpg/gOM=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-bJJvPZHdNfmWuaowSE4X-A-1; Mon, 15 Jun 2020 11:12:44 -0400
X-MC-Unique: bJJvPZHdNfmWuaowSE4X-A-1
Received: by mail-il1-f197.google.com with SMTP id j71so12301509ilg.9
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 08:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ak41TMq1pbJiNMvoos07P36SHvt/NQ8xEDyDsmYJCF0=;
 b=k6EyOVOxmkkoEl50quDTNIMO+mmOKEAixykM7njve07Ssgm2dswe2LKulVEGUwhc5l
 oy6jHmCHLv3YTwFSrNzozn+8PpExdNxOw5jmLHFlCIY+CV0WSQcEcEMsJS6v9Hc4ev8s
 mo0soawGkozMkPqUyz31iNlcOovty6FrtlWS7I/lCOJaC4RsDx7cIp9hfyrORdQRoZNj
 UnuiMdV/3BQny7/LEj6rnKEaw882wHhurq2CoQbBvr8KF6lJu8cbnLePO18v6XSrAtUv
 M92CUuY93CyJ7SrONptPU09R3tCe+i3j4LlxlBRc7URnspwv+HiZJYgnXkawvzU2fAWK
 A5nw==
X-Gm-Message-State: AOAM532W5lwSK6aubNNS7gsbFUfjFx4uvJLiUtUwSIIFVT7g0Tmw0cPW
 JgwPAanutor2Y4tOSL4svswC1I/bsgn1bfc3Uq665A7OPwMZBTWuW0zIRF0xfdZsf4RC4TBizQ7
 bB9pzmlimiLsHCqrVLAPOJXFaHrUqWxI=
X-Received: by 2002:a92:8419:: with SMTP id l25mr25580608ild.182.1592233957718; 
 Mon, 15 Jun 2020 08:12:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz38GAOd0wxYh6kYwxYNQIh9KmzEQX409Ofdsne0Fmr7CEyYiUg2Y0Gfo6gQUNQDGoaZO/gMGxS1LCP6oDIH4c=
X-Received: by 2002:a92:8419:: with SMTP id l25mr25580584ild.182.1592233957455; 
 Mon, 15 Jun 2020 08:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200615142327.671546-1-stefanb@linux.vnet.ibm.com>
 <20200615142327.671546-4-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200615142327.671546-4-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 15 Jun 2020 19:12:26 +0400
Message-ID: <CAMxuvawn9WTf2XJikrRj=iHSuOcYw+o-B-vtfhs7irSN2D9rsA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] tests: Temporarily ignore DSDT table differences
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:43:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger@redhat.com>, "Bonzini, Paolo" <pbonzini@redhat.com>,
 Philippe Mathieu Daude <philmd@redhat.com>,
 Marek Kedzierski <mkedzier@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 15, 2020 at 6:27 PM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> Ignore DSDT table differences before enabling IRQ support for TPM.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> CC: Michael S. Tsirkin <mst@redhat.com>

make sense, to split implementation & test commits:

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index dfb8523c8b..bb4ce8967b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/q35/DSDT.tis",
> --
> 2.24.1
>


