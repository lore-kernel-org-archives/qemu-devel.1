Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC94BC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 20:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97BB12063A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 20:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3XvoZAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97BB12063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWQdP-0005ZH-RS
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 16:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jWQcB-0004pW-OE
 for qemu-devel@nongnu.org; Wed, 06 May 2020 16:25:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43409
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jWQc9-0003mE-Ew
 for qemu-devel@nongnu.org; Wed, 06 May 2020 16:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588796756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/K4bXF0WOpdm14ByzD3NR4oLhT117bmL8GkyJqxJAXo=;
 b=Y3XvoZAKhOQ1JHQc5gBwRzhd4m4ksJdK+bNcCbXFWBbISLkbQu2qK8P9qwrC2q/j0dAVXi
 9y84c/EBOLsfOv73ldB65LXQz8GbqSPqyWnn5JV2BOtmZSdN5CNKnPG3ReSLwTDGVC/AZ2
 PtwNe5BylYJrX6i5I8c9If23qOK9isI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-arQ3SnG9PQejTKizAg-3Pw-1; Wed, 06 May 2020 16:25:46 -0400
X-MC-Unique: arQ3SnG9PQejTKizAg-3Pw-1
Received: by mail-wr1-f71.google.com with SMTP id e5so1899249wrs.23
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 13:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=edUuwFI9D0pStLV5uuIILbcmJQZgHW0O1swcyaE3mzo=;
 b=HEWhJ44UI/6I3J8shNfLzIPG6cqy0w9cvGbu/+EW2n9xfPM7E+v5yaDfTuv1cHZFu+
 8Gl+k9iQC+Ivo5nHtWj7a9DV4fLKFlGsljOSTLKI26O0/8cJAUfYUpaFdwjSYD8uyNbm
 nAqrYljgAAY2nbRi8+xlpCxYnVJL3B0VnjMqUUKfi4jR1bqGEG/MWGdAmk+F9TAmSK3w
 Z4kfE1wnh6PLCHd8FLlY+H3rT6VKZ6WEYsqQ2TlDoprZhrNO+wuG9sQ1XfBIs4MGBHKH
 uiN23K7gVsDPxWCpr3+Fn/J2IuZ7HZsNMn1M2ChOpQEIn1wlQCevmxeUh3MIqtbkcKBb
 NssQ==
X-Gm-Message-State: AGi0Pua+Sz5aIRwGlPrauj6BCvFALKBZSH4eWlpXHF8ir12dTOzj1++J
 m+i7pAL4B7+V9SdY2O9IRKWsuuw44l94RTKtPNjZvD3v3GK/2nQmehdQhSyrfeRWYsYrOVNCOLv
 drLA5aBoF+4y3bXU=
X-Received: by 2002:adf:cd92:: with SMTP id q18mr11911022wrj.237.1588796744842; 
 Wed, 06 May 2020 13:25:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypLr5mIzOctWGAL44hzABFWBlJedhhmvj1Vvwl+8wJ2ivTbFytNvLxDP4zUeTtIqhFS6heuVnA==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr11911002wrj.237.1588796744645; 
 Wed, 06 May 2020 13:25:44 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id 1sm4679753wmi.0.2020.05.06.13.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 13:25:44 -0700 (PDT)
Date: Wed, 6 May 2020 16:25:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH v25 00/10] Add ARMv8 RAS virtualization support in QEMU
Message-ID: <20200506162439-mutt-send-email-mst@kernel.org>
References: <20200410114639.32844-1-gengdongjiu@huawei.com>
 <CAFEAcA9oNuDf=bdSSE8mZWrB23+FegD5NeSAmu8dGWhB=adBQg@mail.gmail.com>
 <da3cbdfd-a75d-c87f-3ece-616278aa64d5@huawei.com>
MIME-Version: 1.0
In-Reply-To: <da3cbdfd-a75d-c87f-3ece-616278aa64d5@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:50:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, kvm-devel <kvm@vger.kernel.org>,
 Igor Mammedov <imammedo@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zheng Xiang <zhengxiang9@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 06, 2020 at 07:42:19PM +0800, gengdongjiu wrote:
> On 2020/4/17 21:32, Peter Maydell wrote:
> > On Fri, 10 Apr 2020 at 12:46, Dongjiu Geng <gengdongjiu@huawei.com> wro=
te:
> >>
> >> In the ARMv8 platform, the CPU error types includes synchronous extern=
al abort(SEA)
> >> and SError Interrupt (SEI). If exception happens in guest, host does n=
ot know the detailed
> >> information of guest, so it is expected that guest can do the recovery=
. For example, if an
> >> exception happens in a guest user-space application, host does not kno=
w which application
> >> encounters errors, only guest knows it.
> >>
> >> For the ARMv8 SEA/SEI, KVM or host kernel delivers SIGBUS to notify us=
erspace.
> >> After user space gets the notification, it will record the CPER into g=
uest GHES
> >> buffer and inject an exception or IRQ to guest.
> >>
> >> In the current implementation, if the type of SIGBUS is BUS_MCEERR_AR,=
 we will
> >> treat it as a synchronous exception, and notify guest with ARMv8 SEA
> >> notification type after recording CPER into guest.
> >=20
> > Hi. I left a comment on patch 1. The other 3 patches unreviewed
> > are 5, 6 and 8, which are all ACPI core code, so that's for
> > MST, Igor or Shannon to review.
> >=20
> > Once those have been reviewed, please ping me if you want this
> > to go via target-arm.next.
>=20
> Hi Peter,
>    Igor have reviewed all ACPI core code. whether you can apply this seri=
es to target-arm.next I can make another patches to solve your comments on =
patch1 and another APCI comment.
> Thanks very much in advance.

Given it all starts with patch 1, it's probably easier to address the
comment and repost.


> >=20
> > thanks
> > -- PMM
> >=20
> > .
> >=20


