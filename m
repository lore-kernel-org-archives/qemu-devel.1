Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A2BC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 09:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED0E20731
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 09:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnS8qcGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED0E20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWyxU-0005u4-GH
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 05:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWywd-0005Dv-8y
 for qemu-devel@nongnu.org; Fri, 08 May 2020 05:05:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40996
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWywb-0003AR-3w
 for qemu-devel@nongnu.org; Fri, 08 May 2020 05:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588928720;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxhB6feDrmhyITxsph0+/4GAy6px+wez2Q8CjJsaRSE=;
 b=JnS8qcGYK6He3AMZ0tygxuRnmt1peicwkSp01QsLoW/8A3fDVxhWg1nKKkpeuzwus29ydy
 AZFIpcsDrGJsxnOusrjJJlAP/yunbbUZEHDlA5ZhZCEs7o0fiXXG251RJQ641dDZvlcD4e
 8i6mojCvpEHuLog9uu39EvEFdnjfHLc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-s1jPLhlVPb67yt6xHPH35Q-1; Fri, 08 May 2020 05:05:15 -0400
X-MC-Unique: s1jPLhlVPb67yt6xHPH35Q-1
Received: by mail-wm1-f71.google.com with SMTP id j5so4876278wmi.4
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 02:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SxhB6feDrmhyITxsph0+/4GAy6px+wez2Q8CjJsaRSE=;
 b=eoSJX2e8lqpFVKkDXtaAGSR98BrSMoo4k3csKmZ1qMLP46atcRRteu4Gkctm2BhA5h
 sTlIGfsPUcEEaE8ip+tLDYfGWBqrHnYgJl3Lf763+dsW3QW8XsXGUs0LU4ZQ97A4XhfB
 kmaqcGJytgM1cqJG9dFZzYwJ5XsFtzRj8ce2uWshnZrdUkEPM0317qUtUV2kaITWyNVN
 WEj9bMWpB5d5gvoV5qFkLJcyvKK0YwaUUi51Bji+Ubg1llETE7dn20mzr/G2bZLrAElg
 UVyA2r6VIWR76sKlgrMtRoCrv7uxbMaOg07Vet8D0IHvcI3k27N6s6ul/DCZr0rpuIvr
 iWVA==
X-Gm-Message-State: AGi0PuYIM8DbzwKZ5i09WSWojXYjtKIKvWDsvPCTRTiUkmS2LBYSedmf
 2RPFwltaDOmELDD7c1vVT+m46lOXI0tuz8o+EIAVzY/5MkRUHxurDFND2lMEc9TYqKIEt4zzl9C
 sWcf7Rm2jOp4GQvs=
X-Received: by 2002:a05:600c:d8:: with SMTP id
 u24mr8127238wmm.19.1588928713548; 
 Fri, 08 May 2020 02:05:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypKcd0XlTJ2i/MBxGo6mR/GNBCO0vqrLD30opZ97A1ckZFHAj3ugObA1P5t5cGVGsDErpv2Olw==
X-Received: by 2002:a05:600c:d8:: with SMTP id
 u24mr8127212wmm.19.1588928713359; 
 Fri, 08 May 2020 02:05:13 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id a81sm5432144wmh.7.2020.05.08.02.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 02:05:12 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 09/10] exec: Update coding style to make checkpatch.pl
 happy
In-Reply-To: <20200507173958.25894-10-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 7 May 2020 19:39:57
 +0200")
References: <20200507173958.25894-1-philmd@redhat.com>
 <20200507173958.25894-10-philmd@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 08 May 2020 11:05:11 +0200
Message-ID: <87pnbeer08.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=quintela@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: quintela@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> We will move this code in the next commit. Clean it up
> first to avoid checkpatch.pl errors.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


