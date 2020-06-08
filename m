Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190E0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE9F82072F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dN4wZ25g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9F82072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiGUD-0003cg-4B
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 08:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jiGSW-0001yO-HV
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 08:00:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38847
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jiGSV-0006hj-Hr
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 08:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591617654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Mzq1zS5opkSh8ZWWPbOAjwcXzqrFrc9v0qCnsGMipg=;
 b=dN4wZ25gSBSoZ2Xs/QH9XD2ngEgoTGFAYI/9U+8K2Tz6ddnZp5vvl4x2UtD60/i9rHilmL
 flDHfK7X1yquDlQHsO5FnjsxqTnuNAfd7DgDBPzDGUBOgIgbzWLSGAeqs8rRL6Gif4MTRz
 lbUoeiyrogyNFL1CuO87/JqAK4y0nVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-m2xmzFQAP6yUA7AesH7fRQ-1; Mon, 08 Jun 2020 08:00:52 -0400
X-MC-Unique: m2xmzFQAP6yUA7AesH7fRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0045107ACCA;
 Mon,  8 Jun 2020 12:00:51 +0000 (UTC)
Received: from localhost (unknown [10.40.208.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83E322B5BE;
 Mon,  8 Jun 2020 12:00:48 +0000 (UTC)
Date: Mon, 8 Jun 2020 14:00:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Subject: Re: [Question] Regarding PMU initialization within the QEMU for ARM
 VCPUs
Message-ID: <20200608140026.1eb49a8b@redhat.com>
In-Reply-To: <0c91f4bab5d24bb3a1e7ca36d1d57221@huawei.com>
References: <b2e401cd17fe49d792d09b31bd726e35@huawei.com>
 <20200603093745.dwfb55ny34az7rez@kamzik.brq.redhat.com>
 <20200605173116.55419a1e@redhat.com>
 <0c91f4bab5d24bb3a1e7ca36d1d57221@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 16:38:37 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > Sent: Friday, June 5, 2020 4:31 PM
> > To: Andrew Jones <drjones@redhat.com>
> > Cc: Salil Mehta <salil.mehta@huawei.com>; qemu-devel@nongnu.org;
> > qemu-arm@nongnu.org; Peter Maydell <peter.maydell@linaro.org>; mst@redhat.com
> > Subject: Re: [Question] Regarding PMU initialization within the QEMU for ARM
> > VCPUs
> > 
> > On Wed, 3 Jun 2020 11:37:45 +0200
> > Andrew Jones <drjones@redhat.com> wrote:
> >   
> > > On Mon, Jun 01, 2020 at 03:04:33PM +0000, Salil Mehta wrote:  
> > > > Hello,
> > > > I could see below within function fdt_add_pmu_nodes() part of
> > > > hw/arm/virt.c during virt machine initialization time:  
> > ...  
> > >  
> > > > Q4. This function  fdt_* looks to be wrongly named. The info
> > > >     being initialized here shall be used even when ACPI is
> > > >     being used. Initialization part and FDT info looked
> > > >     mixed up here if I am right?  
> > >
> > > Agreed. The function has the wrong name. mach-virt has many functions that
> > > mix the initialization and fdt building together, but those functions are
> > > named something like create_foo(). Patches welcome.  
> > that was where I gave up on cpu hotplug arm/virt the last time.  
> 
> Were you releasing the ARM objects as well? Or are you referring to some
> other problem?
I was talking about mix of FDT and device creation code.

> 
> > Ideally we should split out from create_foo() all firmware generation code
> > (fdt) and move it to virt_machine_done time + make sure that it could be
> > regenerated at reset time so guest would get updated FDT on reset.  
> 
> Agreed, just like ACPI part. That would be more cleaner. 
> 
> Thanks
> Salil.
> 
> 


