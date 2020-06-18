Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D14C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 08:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92728208D5
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 08:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPMu4beg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92728208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlpUc-0005uc-RS
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 04:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jlpTv-0005KR-P7
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 04:01:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58867
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jlpTt-0004eY-Vm
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 04:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592467265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HuQIDvdNY2hZP3LQ1FVNQKHXXWwgVfXmUeGug9owRaM=;
 b=jPMu4begsm78xnytsPM7I9gDuoCv+ClFRCoQLhy0I5do3E5e3xjQEQ1OauhRciwQLkiz/X
 0KS8AN72WiD2ZesrueTerPKa3qaiTwP6tfCwttdxHFqCnXyXs2jzsiRZffNTV7oWI1YXNC
 LwylqglPTDM7nLr7CtLHMGTWytwmQAQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-0SM6kwkhOruvuRbQQG2Y8A-1; Thu, 18 Jun 2020 04:01:03 -0400
X-MC-Unique: 0SM6kwkhOruvuRbQQG2Y8A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1072108C311;
 Thu, 18 Jun 2020 08:01:01 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37A9F60BF3;
 Thu, 18 Jun 2020 08:00:57 +0000 (UTC)
Subject: Re: ovmf / PCI passthrough impaired due to very limiting PCI64
 aperture
To: Eduardo Habkost <ehabkost@redhat.com>,
 Guilherme Piccoli <gpiccoli@canonical.com>
References: <99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com>
 <20200616165043.24y2cp53axk7uggy@sirius.home.kraxel.org>
 <20200616165746.GH2788@work-vm>
 <CAHD1Q_zGu4Q63HjHx3aZKu3wh8NppuP6T4kgnUN3j=-ZDufVZA@mail.gmail.com>
 <b423f4a4-2552-bdc8-7c9f-41f200aef672@redhat.com>
 <20200617134652.GE2776@work-vm> <20200617154959.GZ2366737@habkost.net>
 <CAHD1Q_z7E79HwCeFEg8yQOUGsOZRQuhL-zc4RXJdubT3eYp+NA@mail.gmail.com>
 <20200617163308.GE2366737@habkost.net>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9710e2b4-7c56-df86-0c7c-6d2cb4ab95f4@redhat.com>
Date: Thu, 18 Jun 2020 10:00:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200617163308.GE2366737@habkost.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:32:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Pedro Principeza <pedro.principeza@canonical.com>,
 Dann Frazier <dann.frazier@canonical.com>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, fw@gpiccoli.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/17/20 18:33, Eduardo Habkost wrote:
> On Wed, Jun 17, 2020 at 12:57:52PM -0300, Guilherme Piccoli wrote:
>> Can't qemu reads the host physical bits and pass that as fw_cfg as
>> "real_host_physbits" or something like that?
>> OVMF could rely on that - if such property is available, we use it to
>> extend the PCI64 aperture.
> 
> Giving a exact "real host physbits" value would be too limiting
> if we still want to allow migration to smaller hosts.  But we can
> provide extra information on CPUID or fw_cfg, yes.
> 
> I will try to write down a proposal to extend the KVM CPUID leaf
> to provide extra information about MAXPHYADDR guarantees.

Thank you -- if this can be detected in the guest via CPUID, then I
prefer that to fw_cfg. We need to keep an eye on x-file-slots for fw_cfg.

Thanks
Laszlo


