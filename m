Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202A1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 05:31:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 391482225F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 05:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6HL86Cu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391482225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUkFQ-0000U3-5V
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 01:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUkE6-0008OA-2o
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 01:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUkE4-00040m-7R
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 01:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603171822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qgAmRfkWmJkmfMGLo1s9y5eXeYS3wclTOhKQRC+oUE=;
 b=I6HL86CuiPkOJ+dmj2YX/UQ7B8tm6Sgk2RnUZy8mIHw0NGMjyqyhEBs9ar1+JdE/+jwuu6
 f8bZISJiRCBkcuKA99pq2FrMC2EkD1AsWYSnusUAB0QON2FECCYurR+L5drd24sNuj5Puy
 w7Iw7gpxeSKa+ASuiTLYyDQI6C0PBsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-LeyoCm0qNZG64HhonvvPMw-1; Tue, 20 Oct 2020 01:30:18 -0400
X-MC-Unique: LeyoCm0qNZG64HhonvvPMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C033C107AFB6;
 Tue, 20 Oct 2020 05:30:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCA1E5C1C2;
 Tue, 20 Oct 2020 05:30:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3C9F11132A08; Tue, 20 Oct 2020 07:30:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH] hw/pci-host/grackle: Verify PIC link is properly set
References: <20201011190332.3189611-1-f4bug@amsat.org>
 <20201011223446.GA4787@yekko.fritz.box>
 <369509c1-2e90-13cf-8845-892e754516d1@amsat.org>
 <20201012065436.GB71119@yekko.fritz.box>
 <9f7e4847-801d-dcd3-b876-bf2d276251@eik.bme.hu>
 <6e587154-4bc5-c44c-0c85-b46e0dddd3aa@amsat.org>
 <87k0vm1wny.fsf@dusky.pond.sub.org>
 <24bcd4-fde2-22a2-d3f4-cd42d9ee13c6@eik.bme.hu>
 <87d01e48pa.fsf@dusky.pond.sub.org>
 <9968e60e-99fd-3777-62ca-57decb716886@ilande.co.uk>
Date: Tue, 20 Oct 2020 07:30:14 +0200
In-Reply-To: <9968e60e-99fd-3777-62ca-57decb716886@ilande.co.uk> (Mark
 Cave-Ayland's message of "Mon, 19 Oct 2020 15:38:28 +0100")
Message-ID: <877drl1n2x.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 BALATON Zoltan via <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> One thing I have thought about is being able to mark a link property
> as mandatory so if a value hasn't been set before realize then you

A non-null value, I presume.

> receive a fatal error. This would be for cases like this where 2
> internal devices are connected together without any formal interface,
> i.e. in cases where -device wouldn't work anyway.

Moves the check from code one step closer to data: from the realize
method to the object_property_add_link() call.

I like doing things in data, because data is easier to reason about than
code.

[...]


