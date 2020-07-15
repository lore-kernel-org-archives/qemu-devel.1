Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4897AC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B4D20657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOWsOJNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B4D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvh7C-0004Cd-0c
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jvh6c-0003bc-Ec
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:05:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37592
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jvh6Z-00043Z-Sz
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594818346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mwDRxRl+3IUgJSVH3++6rWrApTzCoDqL0Oof74/RdKo=;
 b=fOWsOJNMnVZcDnPDbTFMIxYdP2jm+AL2PpjrxJU58a8As4pSYRPZM5xSx4V9wUqTt/nIpD
 IINBkH+Bo428g7eSvzrNUxhu2E6UiFl2RoRsPgk7D8HUoQQs+sEZxqtPBWPcvDojFFS3WG
 2Ol+h8qquuTL6Ejy3mBaran3raw7Wbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-X_kl0fCHPGCIgJaURL_ZtA-1; Wed, 15 Jul 2020 09:05:44 -0400
X-MC-Unique: X_kl0fCHPGCIgJaURL_ZtA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AF2E107BEF5;
 Wed, 15 Jul 2020 13:05:43 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB75E78A50;
 Wed, 15 Jul 2020 13:05:33 +0000 (UTC)
Date: Wed, 15 Jul 2020 15:05:30 +0200
From: Andrew Jones <drjones@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH 3/4] hw/arm/virt-acpi-build: Only expose flash on older
 machine types
Message-ID: <20200715130530.gtgjyvxfol35i6lk@kamzik.brq.redhat.com>
References: <20200629140938.17566-1-drjones@redhat.com>
 <20200629140938.17566-4-drjones@redhat.com>
 <20200713104907.335bf762@redhat.com>
 <20200714055109.owrlob6m53notzh3@kamzik.brq.redhat.com>
 <20200714045537-mutt-send-email-mst@kernel.org>
 <20200714092325.5klaeqelu46mhg76@kamzik.brq.redhat.com>
 <20200714164141.1ce6b122@redhat.com>
 <20200715063648.rigcdnaxveened6u@kamzik.brq.redhat.com>
 <b1593635-54aa-fd8c-951d-c2ef648ec6c9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b1593635-54aa-fd8c-951d-c2ef648ec6c9@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, ard.biesheuvel@arm.com,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, eric.auger@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 15, 2020 at 02:26:19PM +0200, Laszlo Ersek wrote:
> Hi Drew,
> 
> On 07/15/20 08:36, Andrew Jones wrote:
> 
> > So it sounds to me like we have some flexibility in our versioned machine
> > maintenance. We can choose to forgo the usual compat code when the risk is
> > deemed low enough. And, if somebody screams, we can always fix it later.
> > I can live with that. I'll go ahead and respin without the versioning.
> 
> In that case, please don't simply remove the acpi_dsdt_add_flash() call
> from build_dsdt(), because then "git blame" won't be able to help later.
> Can you please replace the call with a comment instead, similar to the
> RTC comment from commit 67736a25f865 ("ARM: virt: Don't generate RTC
> ACPI device when using UEFI", 2016-01-15)?
>

In the end I won't be respinning, as this patch is already merged. And,
unless Igor twists my arm, then I don't plan to write another patch
that removes the compat code. If I did remove it, I'd put a comment
in there for git-blame to find. And, in the comment I'd write "Igor
said to remove this", because git-blame would otherwise blame me :-)

Thanks,
drew


