Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92A8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9226B20775
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4hOuDHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9226B20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joj1h-0008QC-Ss
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 03:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1joj0u-0007Iz-IZ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 03:43:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34904
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1joj0t-0004lV-0b
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 03:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593157386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QraqlMF49D4ldfp2zZFjFcQ+GphvZwdByM6vjcSBTFc=;
 b=V4hOuDHTJr/Co1xhEoXVxcufn1HB6qNFMAncsRoTTmdVXvTbvn3VA/rGEsuuCdt2XOE+9Y
 ILpzNV2ZvSCOvCy8An4Xxz50TT8A9vkXPzfPCV0EVqAy44bmhoKub5FrjEkDztIAouIi7H
 Jw7HkLv34zg77GCkgoAaURH+ZkJqIPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-OGo3XNUnOO64MRhF1DBIIg-1; Fri, 26 Jun 2020 03:42:59 -0400
X-MC-Unique: OGo3XNUnOO64MRhF1DBIIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A8FC18585BD;
 Fri, 26 Jun 2020 07:42:58 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4BBB1002395;
 Fri, 26 Jun 2020 07:42:49 +0000 (UTC)
Subject: Re: [PATCH v5 2/5] virtio-iommu: Implement RESV_MEM probe request
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20200624132625.27453-1-eric.auger@redhat.com>
 <20200624132625.27453-3-eric.auger@redhat.com>
 <87zh8r1v6z.fsf@dusky.pond.sub.org>
 <CAFEAcA8OJ3_yA+o3FSJ1FOTpH73xbu_5YBGA5A5b8hOqEqvkiw@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <afdad70b-150e-17a3-a714-bdbbd6e534e1@redhat.com>
Date: Fri, 26 Jun 2020 09:42:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8OJ3_yA+o3FSJ1FOTpH73xbu_5YBGA5A5b8hOqEqvkiw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, bbhushan2@marvell.com,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 6/25/20 12:12 PM, Peter Maydell wrote:
> On Thu, 25 Jun 2020 at 08:06, Markus Armbruster <armbru@redhat.com> wrote:
>>     $ qemu-system-x86_64 -nodefaults -S -display none -device virtio-iommu-pci,len-reserved-regions=1,reserved-regions[0]=0xfee00000:0xfeefffff:99
>>     qemu-system-x86_64: -device virtio-iommu-pci,len-reserved-regions=1,reserved-regions[0]=0xfee00000:0xfeefffff:99: pc-i440fx-5.1 machine fails to create iommu-map device tree bindings
>>     Check you machine implements a hotplug handler for the virtio-iommu-pci device
>>     Check the guest is booted without FW or with -no-acpi
>>
>> By the way: s/Check you machine/Check your machine/.
> 
> Patch sent:
> https://patchew.org/QEMU/20200625100811.12690-1-peter.maydell@linaro.org/

Thank you for the typo fix.

Eric
> 
> thanks
> -- PMM
> 


