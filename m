Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F13C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8661D2224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6caBmem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8661D2224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUXhV-0005Ab-GW
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 12:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kUXd6-0000bW-VC
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wrampazz@redhat.com>)
 id 1kUXcz-0001L6-4Q
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603123388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Bi9sjHOa0uxH5bkCee0lahGvOxVqb36Li9D/axyP1c=;
 b=D6caBmemUiM2RpCZpQZsZUAvfyAKujvxsc06WyzDRSIE95ENjRC8rxe3MJmbsQY1CrU5V6
 3ch5dhKoBEKixcm2FdB5STzod7LAqeSw0+HMCrVXUhnzadOBw2cXUNx6tCEgey2oCDaZYS
 LT1aiXSk4cc0QW0Iru+dOkPrTnvzmO8=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-qPcwvg86NQK8hJSd32YlgQ-1; Mon, 19 Oct 2020 12:03:04 -0400
X-MC-Unique: qPcwvg86NQK8hJSd32YlgQ-1
Received: by mail-vk1-f198.google.com with SMTP id b14so90163vka.21
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 09:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9Bi9sjHOa0uxH5bkCee0lahGvOxVqb36Li9D/axyP1c=;
 b=Acy+sb5aY0cMBGOOD6Nsl0WQxPpPFGHBI3Ybpe/e5rkg7X2RNHraqAWrbV5h6F7iz3
 sx67nIbHu89UYQ3KkTXXY2bUtiwHJttdKQSbWQ0egFNbsqoQocDVWfeO1qFBiMrWBNCF
 TrF/fVC87xfhCp8ZYPRaashA2qBc+KHXTTyQ8fCusuwfrn0RLAeG8eKTbXseOQo8Nr09
 xXQouSwh2PVwIENSeTwmdmW6KwrqHg95dvK6/akzP2i/nDs1MJuw44CEaf0670oBS+Ny
 nN5KxsQSCLSX/2sEioRLQRwABmFTiW1Ya1Q++fHXxovxPQAEqbxi94eAIXy43GjU000t
 NrIQ==
X-Gm-Message-State: AOAM530UJ8ov+nwga5WmOHoB1YZXfKvEo64VvEmJ1vw37NbhtoIMEeAa
 U6WjcqWNdipQPpgtjuLlAdwyqh9rgVFv8Scg4m3ortBUlDegX3Vn8PlHK9n2J8NGDy0aVvxAj9o
 Xd4nW14G/xM4uO6kgwYrxzxKKjgkGzcg=
X-Received: by 2002:a67:6911:: with SMTP id e17mr636306vsc.45.1603123384380;
 Mon, 19 Oct 2020 09:03:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBgxhXG9NxtZ77ikiKGy2MHDiswf1359eiTU7bzAVSEr+88KyaP7bEyEfJD+wXDNG5lfpNP+1UH9JhSyxP2hM=
X-Received: by 2002:a67:6911:: with SMTP id e17mr636263vsc.45.1603123384052;
 Mon, 19 Oct 2020 09:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201009205513.751968-1-crosa@redhat.com>
 <20201009205513.751968-2-crosa@redhat.com>
In-Reply-To: <20201009205513.751968-2-crosa@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Mon, 19 Oct 2020 13:02:52 -0300
Message-ID: <CAKJDGDbp20MorcBs=J3FvKLQeEd+Sy-LVwz5cc20jPs_Kc_Z4Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] Acceptance tests: bump pycdlib version for easier
 installation
To: Cleber Rosa <crosa@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wrampazz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=wrampazz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Bug 1897783 <1897783@bugs.launchpad.net>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 9, 2020 at 5:55 PM Cleber Rosa <crosa@redhat.com> wrote:
>
> On with certain versions of "pip", package installations will attempt
> to create wheels.  And, on environments without a "complete" Python
> installation (as described in the acceptance tests requirements docs),
> that will fail.
>
> pycdlib, starting with version 1.11.0, is now being made available
> as wheels, so its instalation on those constrained environments is
> now possible.
>
> Cc: Bug 1897783 <1897783@bugs.launchpad.net>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1880189
> Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/requirements.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/requirements.txt b/tests/requirements.txt
> index 036691c922..a1c631fa59 100644
> --- a/tests/requirements.txt
> +++ b/tests/requirements.txt
> @@ -2,4 +2,4 @@
>  # in the tests/venv Python virtual environment. For more info,
>  # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
>  avocado-framework=3D=3D81.0
> -pycdlib=3D=3D1.9.0
> +pycdlib=3D=3D1.11.0
> --
> 2.25.4
>

Reviewed-by: Willian Rampazzo <willianr@redhat.com>


