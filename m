Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E3BC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021FF23A1E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZCMtcVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021FF23A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKcJ9-0006a3-0d
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 03:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kKcF4-0003dW-VH
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:57:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kKcEz-000425-Um
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600757848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q99VPgV8vXmQ4qrSDr09hOonSD3fsQ1DdpkynigjR5U=;
 b=VZCMtcVdpohLb/VYaJRZQPsKPHF2EVAQ/QGqzFR59a95BUJ8g39nhJuiyYP5Gkf0mumTrK
 zoCMlE7btn4GrhlzXinv8MvbfMPpyM8jSjKGzkquxaFoAhqx+ealW7Fdqu0RuLcJZ30qH/
 Kz/dK1z9v/UoX3Ic0XQH7ARv0GOD0rw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-d_Wtj7oJNy6zQOstXwjxbg-1; Tue, 22 Sep 2020 02:57:24 -0400
X-MC-Unique: d_Wtj7oJNy6zQOstXwjxbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93C671074654;
 Tue, 22 Sep 2020 06:57:23 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-3.ams2.redhat.com
 [10.36.112.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CAE727BDC;
 Tue, 22 Sep 2020 06:57:18 +0000 (UTC)
Subject: Re: [PATCH] hw/arm/virt: use pflash image real size when mapping
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?B?aGFpYmluemhhbmco5byg5rW35paMKQ==?= <haibinzhang@tencent.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
References: <790EEEF3-0799-4507-BF30-DA85440E766F@tencent.com>
 <52eb89e8-3602-2a2a-df9e-66130bce4070@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <db1e1feb-aef0-e8c4-429b-61586106edec@redhat.com>
Date: Tue, 22 Sep 2020 08:57:17 +0200
MIME-Version: 1.0
In-Reply-To: <52eb89e8-3602-2a2a-df9e-66130bce4070@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Leif Lindholm <leif@nuviainc.com>, Ard Biesheuvel <Ard.Biesheuvel@arm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/18/20 15:41, Philippe Mathieu-Daudé wrote:
> Cc'ing firmware experts.
> 
> On 9/18/20 2:26 PM, haibinzhang(寮犳捣鏂�) wrote:
>> Default size of arm-virt pflash image is 64MB which
>> will cost extra 128MB(64MBx2) memory per qemu process
>> and 12.5GB for 100 qemu processes. Host memory is
>> precious and it is valuable to reduce pflash image size.
>> For compatibility arm-virt uses real size when mapping.
> 
> Flash#0 is a device because eventually its model will handle
> sector/block protection, so firmware can do CapsuleUpdate
> (updating itself). Meanwhile you could treat flash#0 as a pure
> ROM device... But this wouldn't be the 'arm-virt' machine anymore.
> 
>>
>> Signed-off-by: Haibin Zhang <haibinzhang@tencent.com>
>> ---
>>  hw/arm/virt.c | 22 ++++++++++++++++++++--
>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index acf9bfbece..3545e12865 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -50,6 +50,7 @@
>>  #include "sysemu/sysemu.h"
>>  #include "sysemu/tpm.h"
>>  #include "sysemu/kvm.h"
>> +#include "sysemu/block-backend.h"
>>  #include "hw/loader.h"
>>  #include "exec/address-spaces.h"
>>  #include "qemu/bitops.h"
>> @@ -1001,10 +1002,27 @@ static void virt_flash_map(VirtMachineState *vms,
>>       */
>>      hwaddr flashsize = vms->memmap[VIRT_FLASH].size / 2;
>>      hwaddr flashbase = vms->memmap[VIRT_FLASH].base;
>> +    int64_t realsize;
>> +    BlockBackend *blk;
>>
>> -    virt_flash_map1(vms->flash[0], flashbase, flashsize,
>> +    realsize = flashsize;
>> +    blk = pflash_cfi01_get_blk(vms->flash[0]);
>> +    if (blk) {
>> +        realsize = blk_getlength(blk);
>> +        realsize = realsize < flashsize ? realsize : flashsize;
>> +    }
> 
> Stefan recently posted "nvdimm: read-only file support" which
> might be a better way to achieve what you want:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg741137.html
> 
>> +
>> +    virt_flash_map1(vms->flash[0], flashbase, realsize,
>>                      secure_sysmem);
>> -    virt_flash_map1(vms->flash[1], flashbase + flashsize, flashsize,
>> +
>> +    realsize = flashsize;
>> +    blk = pflash_cfi01_get_blk(vms->flash[1]);
>> +    if (blk) {
>> +        realsize = blk_getlength(blk);
>> +        realsize = realsize < flashsize ? realsize : flashsize;
>> +    }
>> +
>> +    virt_flash_map1(vms->flash[1], flashbase + flashsize, realsize,
>>                      sysmem);
>>  }
>>
>> --
>> 2.23.0
>>
> 

We've been here before.

  [Qemu-devel] [RFC PATCH] hw/arm/virt: use variable size of flash device to save memory

  https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg06773.html
  http://mid.mail-archive.com/20190325125142.11628-1-zhengxiang9@huawei.com

I don't have anything to add.

Laszlo


