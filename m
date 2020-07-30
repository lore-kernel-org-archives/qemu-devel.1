Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9F5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 04:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8056822B42
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 04:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RN8IvsX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8056822B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k10Mf-0000O1-O8
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 00:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k10Ld-0008Mg-G3
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 00:39:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41090
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k10Lb-0001xt-Bh
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 00:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596083954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=yd8RWLUCummTAyQk1bVAoIqP6FIo20pTj7mM8w3mOXk=;
 b=RN8IvsX22RqttItVdiEhBsTiPCoJxsw6g4uGZO348dBF0oQhcs2n15QB8ExbRlMav6it4s
 Xlt0JrIj5S7Et71Sm8RtAbWK+m6nFoHp6hrzQD9WyJk6ZhlcJ88S8P8r6OgnmNIuxnFaqV
 kckhQhmPkFT8+cOXYGr2p/SI2Qg4RjQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-74UOS8RFPOG988u6e2mVow-1; Thu, 30 Jul 2020 00:39:10 -0400
X-MC-Unique: 74UOS8RFPOG988u6e2mVow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35A231902EA0;
 Thu, 30 Jul 2020 04:39:09 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-85.ams2.redhat.com [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BD401001B2C;
 Thu, 30 Jul 2020 04:39:07 +0000 (UTC)
Subject: Re: [PATCH for-5.2 0/6] Continue booting in case the first device is
 not bootable
To: Viktor Mihajlovski <mihajlov@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200728183734.7838-1-thuth@redhat.com>
 <5c860673-9c0c-79fe-2804-4864856257f5@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d0b44e40-f800-8471-1a3e-c3ba1eca61a7@redhat.com>
Date: Thu, 30 Jul 2020 06:39:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5c860673-9c0c-79fe-2804-4864856257f5@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 22:19:00
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/07/2020 13.42, Viktor Mihajlovski wrote:
> 
> 
> On 7/28/20 8:37 PM, Thomas Huth wrote:
>> If the user did not specify a "bootindex" property, the s390-ccw bios
>> tries to find a bootable device on its own. Unfortunately, it alwasy
>> stops at the very first device that it can find, no matter whether it's
>> bootable or not. That causes some weird behavior, for example while
>>
>>   qemu-system-s390x -hda bootable.qcow2
>>
>> boots perfectly fine, the bios refuses to work if you just specify
>> a virtio-scsi controller in front of it:
>>
>>   qemu-system-s390x -device virtio-scsi -hda bootable.qcow2
>>
>> Since this is quite uncomfortable and confusing for the users, and
>> all major firmwares on other architectures correctly boot in such
>> cases, too, let's also try to teach the s390-ccw bios how to boot
>> in such cases.
>>
>> For this, we have to get rid of the various panic()s and IPL_assert()
>> statements at the "low-level" function and let the main code handle
>> the decision instead whether a boot from a device should fail or not,
>> so that the main code can continue searching in case it wants to.
>>
> 
> Looking at it from an architectural perspective: If an IPL Information
> Block specifying the boot device has been set and can be retrieved using
> Diagnose 308 it has to be respected, even if the device doesn't contain
> a bootable program. The boot has to fail in this case.
> 
> I had not the bandwidth to follow all code paths, but I gather that this
> is still the case with the series.

Right. Just to be sure, I just double-checked with:

... -device virtio-blk,drive=baddrive,bootindex=1 \
    -device virtio-blk,drive=gooddrive

and indeed, the s390-ccw bios only checks the "baddrive" here and
refuses to boot.

> So one can argue that these changes
> are taking care of an undefined situation (real hardware will always
> have the IPIB set).
> 
> As long as the architecture is not violated, I can live with the
> proposed changes.

Thanks!

> I however would like to point out that this only
> covers a corner case (no -boot or -device ..,bootindex specified).

Sure. We™ should/could maybe also add some more documentation to

 https://www.qemu.org/docs/master/system/target-s390x.html

to make it more clear to the "unexperienced" qemu-system-s390x users
that "bootindex" is the preferred / architected way of booting there.

> Please don't create the impression that this patches will lead to the
> same behavior as on other platforms.
Ok, I'll try to state that more clearly in the cover letter of v2.

 Thomas


