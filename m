Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ADDC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFFFC2064B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eX32PXrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFFC2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvdsM-0007WO-1L
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 05:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jvdrh-0006xM-6m
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:38:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26136
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jvdre-0005SF-Eu
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594805889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/6BbWMPTOUOHAr4XvA1A1gk/qjW4H8USIgYOndpwLeg=;
 b=eX32PXrLdtfBY5ujKL4Jc66nLv1tiPlWWxIpdHOuR1/r+f0EpUBiIn6W20fYbELMg7otdB
 FpOpwE6QqeaNKpFx+iRso9nFqQw7o9yKuZNxwrVLwcPXjpozBbid2yxyBN5RXKnG2K7UYT
 0OgaEAeHtwF0b04HjyhhqDAvqEHtUZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-38_CCw9hNh6yJD1CxT31ZA-1; Wed, 15 Jul 2020 05:38:07 -0400
X-MC-Unique: 38_CCw9hNh6yJD1CxT31ZA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C35119067E0;
 Wed, 15 Jul 2020 09:38:06 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 824646FDD1;
 Wed, 15 Jul 2020 09:37:57 +0000 (UTC)
Date: Wed, 15 Jul 2020 11:37:54 +0200
From: Andrew Jones <drjones@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 3/4] hw/arm/virt-acpi-build: Only expose flash on older
 machine types
Message-ID: <20200715093754.v376uobabdis7ykg@kamzik.brq.redhat.com>
References: <20200629140938.17566-1-drjones@redhat.com>
 <20200629140938.17566-4-drjones@redhat.com>
 <20200713104907.335bf762@redhat.com>
 <20200714055109.owrlob6m53notzh3@kamzik.brq.redhat.com>
 <20200714045537-mutt-send-email-mst@kernel.org>
 <20200714092325.5klaeqelu46mhg76@kamzik.brq.redhat.com>
 <20200714164141.1ce6b122@redhat.com>
 <20200715063648.rigcdnaxveened6u@kamzik.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200715063648.rigcdnaxveened6u@kamzik.brq.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:07:28
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
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 lersek@redhat.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, ard.biesheuvel@arm.com, philmd@redhat.com,
 eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 15, 2020 at 08:36:48AM +0200, Andrew Jones wrote:
> On Tue, Jul 14, 2020 at 04:41:41PM +0200, Igor Mammedov wrote:
> > 
> > In this particular case I'd drop versioning.
> >
> 
> So it sounds to me like we have some flexibility in our versioned machine
> maintenance. We can choose to forgo the usual compat code when the risk is
> deemed low enough. And, if somebody screams, we can always fix it later.
> I can live with that. I'll go ahead and respin without the versioning.
>

Actually this patch was already merged

  2c1fb4d5c011 hw/arm/virt-acpi-build: Only expose flash on older machine types

and I don't see much value in posting a patch to remove the compat code.

Regarding the result of this discussion, my take is that unless the
policy is to always or to never use versioning, then I think we should
have guidelines documented which we can follow. Would one of the ACPI
maintainers like to submit a document with the reasoning for when and
when not to use versioning? And also for what's expected of the
commit message justification when versioning is necessary?

Thanks,
drew


