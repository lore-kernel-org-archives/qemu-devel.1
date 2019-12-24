Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6FBC2D0CF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 07:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA792071A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 07:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYMZCPBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA792071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijeoe-0001Kc-O0
	for qemu-devel@archiver.kernel.org; Tue, 24 Dec 2019 02:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ijenW-0000J5-37
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 02:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ijenV-0002p8-1d
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 02:40:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60521
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ijenU-0002oq-Tj
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 02:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577173204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4NknF9ba4R5CHHAR6Mw5Q57fD8rHs5SRd5mZFYdoNU=;
 b=HYMZCPBTVC2dSohoT1835E/nmiiq7uYKCCQZj7GlnRpS4CLwYxykbuqBLxV0uKBYvs4OWi
 92rTW12i1IkPMlUCSC1cnmb6a7lsqO34FmiC2IMN0ptwdkxCyQUytU2ZpKdPPXe18mMaNm
 vTfoWV95sqenKzxwJajbjWIp77ThywM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-ayroffloNl-pgEI11xxYSw-1; Tue, 24 Dec 2019 02:40:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 934F7DB20;
 Tue, 24 Dec 2019 07:39:59 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2732160BE2;
 Tue, 24 Dec 2019 07:39:43 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v11 19/20] pc: Add support for virtio-iommu-pci
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-20-eric.auger@redhat.com>
 <20191210165032.GQ277340@myrica>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <336ecbf4-bcda-36a3-201f-d052da885ae2@redhat.com>
Date: Tue, 24 Dec 2019 08:39:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191210165032.GQ277340@myrica>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ayroffloNl-pgEI11xxYSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 armbru@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jean,

On 12/10/19 5:50 PM, Jean-Philippe Brucker wrote:
> On Fri, Nov 22, 2019 at 07:29:42PM +0100, Eric Auger wrote:
>> The virtio-iommu-pci is instantiated through the -device QEMU
>> option. However if instantiated it also requires an IORT ACPI table
>> to describe the ID mappings between the root complex and the iommu.
>>
>> This patch adds the generation of the IORT table if the
>> virtio-iommu-pci device is instantiated.
>>
>> We also declare the [0xfee00000 - 0xfeefffff] MSI reserved region
>> so that it gets bypassed by the IOMMU.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> It would be nice to factor the IORT code with arm, but this looks OK.
I factorized the iort table code generation. Not sure this will be used
eventually but well.

Thanks

Eric
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 


