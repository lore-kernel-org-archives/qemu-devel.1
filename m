Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7697C3F2CD
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 18:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F59246BE
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 18:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjaJVVic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F59246BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8SwM-0003yJ-Oa
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 13:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j8SvF-0002yz-97
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 13:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j8SvD-0004R3-SY
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 13:02:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25620
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j8SvD-0004Qq-JI
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 13:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583085754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LlzD60oAKSC1pVP/MvadAVwk3d13Ai9e2kxegP32/bs=;
 b=TjaJVVicQl6YeGr4lNlZkBoIqJ1N+mmlgR/JpCEsZ1B5LeHa02wK+UzH0XeGNtQ9CC4kHQ
 jKAB4r4O9OYU5rWgMbyzsD9y4jSw02QAzLwRdZ8l3if4uOVD+McphN2wj9XgIhs82wy90k
 KQKTyQEIMmq050v4C9dIjpTwZU5TauQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-XsF9UwFTN1y11C579abZhg-1; Sun, 01 Mar 2020 13:02:31 -0500
X-MC-Unique: XsF9UwFTN1y11C579abZhg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A90C68017CC;
 Sun,  1 Mar 2020 18:02:29 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9297D48;
 Sun,  1 Mar 2020 18:02:27 +0000 (UTC)
Subject: Re: [PATCH v2 5/6] hw/arm/virt: kvm: Check the chosen gic version is
 supported by the host
To: Richard Henderson <richard.henderson@linaro.org>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org
References: <20200301104040.15186-1-eric.auger@redhat.com>
 <20200301104040.15186-6-eric.auger@redhat.com>
 <30b6269e-e22f-347c-8e42-5af964bd14b7@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <165d40a0-8308-d4d2-e935-a7caf633462c@redhat.com>
Date: Sun, 1 Mar 2020 19:02:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <30b6269e-e22f-347c-8e42-5af964bd14b7@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: maz@kernel.org, drjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,
On 3/1/20 6:56 PM, Richard Henderson wrote:
> On 3/1/20 2:40 AM, Eric Auger wrote:
>> +        /* Check chosen version is effectively supported by the host */
>> +        if (vms->gic_version == VIRT_GIC_VERSION_2 &&
>> +               !(probe_bitmap & KVM_ARM_VGIC_V2)) {
>> +                error_report("host does not support in-kernel GICv2 emulation");
>> +                exit(1);
>> +        } else if (vms->gic_version == VIRT_GIC_VERSION_3 &&
>> +               !(probe_bitmap & KVM_ARM_VGIC_V3)) {
>> +                error_report("host does not support in-kernel GICv3 emulation");
>> +                exit(1);
>> +        }
> 
> Indentation is wrong here.
OK
> 
>> +    case VIRT_GIC_VERSION_HOST:
>> +        error_report("gic-version=host requires KVM");
>> +        exit(1);
>> +    default: /* explicit V2/V3 are left untouched */
>> +        break;
>>      }
> 
> I'd prefer to just list V2 and V3 here explicitly, instead of the default.
> It'll be nicer with gic_version changed to an enum.
OK I will respin with those changes.

Thank you for the review!

Best Regards

Eric
> 
> With those changes,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 


