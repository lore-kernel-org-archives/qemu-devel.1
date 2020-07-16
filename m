Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBBBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03BB1207F9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOIJNiIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BB1207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvzrS-00048r-9y
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 05:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jvzq7-0002ik-PM
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:06:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42727
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jvzq4-0003tw-LV
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594890358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=fmEw6vR1iR52HLFWOPF05O7gq/GmMIwmBRJmu7mxTDw=;
 b=DOIJNiIooM5ADyO8C093NpexVy+ff4Mf2Wer4j+sC6RBE5/2bBckrliiSn6JaKCEefz2mv
 PvB8tVqvnLzqmyyRyhEpmscauiewIti1yxa2LpXerNDlU/mdwveMw+n6VjiLi5FFzLH/jI
 Clbc6sFRJKEXXIbqNsEL0yt0DuexU34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-cuKh2NHWPBys3ywSQl4Itg-1; Thu, 16 Jul 2020 05:05:57 -0400
X-MC-Unique: cuKh2NHWPBys3ywSQl4Itg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E78A8AF865;
 Thu, 16 Jul 2020 09:05:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-234.ams2.redhat.com [10.36.112.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A99F5C1C3;
 Thu, 16 Jul 2020 09:05:46 +0000 (UTC)
Subject: Re: [PATCH for-5.1 2/5] qom: Plug memory leak in "info qom-tree"
To: Li Qiang <liq3ea@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20200714160202.3121879-1-armbru@redhat.com>
 <20200714160202.3121879-3-armbru@redhat.com>
 <CAKXe6SJMJr03VgLGTdO8Xd1cYuDTBGUbe3PiKedvdtddmTsQ5g@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0f9a9a6c-a7f5-a995-c5df-7a55051cf2c3@redhat.com>
Date: Thu, 16 Jul 2020 11:05:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJMJr03VgLGTdO8Xd1cYuDTBGUbe3PiKedvdtddmTsQ5g@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 01:59:11
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/07/2020 17.19, Li Qiang wrote:
> Markus Armbruster <armbru@redhat.com> 于2020年7月15日周三 上午12:05写道：
>>
>> Commit e8c9e65816 "qom: Make "info qom-tree" show children sorted"
>> created a memory leak, because I didn't realize
>> object_get_canonical_path_component()'s value needs to be freed.
>>
>> Reproducer:
>>
>>     $ qemu-system-x86_64 -nodefaults -display none -S -monitor stdio
>>     QEMU 5.0.50 monitor - type 'help' for more information
>>     (qemu) info qom-tree
>>
>> This leaks some 4500 path components, 12-13 characters on average,
>> i.e. roughly 100kBytes depending on the allocator.  A couple of
>> hundred "info qom-tree" here, a couple of hundred there, and soon
>> enough we're talking about real memory.
>>
>> Plug the leak.
>>
>> Fixes: e8c9e65816f5dbfe18ad3b2be938d0d8192d459a
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Tested-by: Thomas Huth <thuth@redhat.com>


> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> 
> I have also send out this patch.
> I hope the maintainer will pick your patch.

Thanks a lot for your patch, too! Normally, I'd say "first come, first
serve" and suggest that we use your patch, but since Markus' patch
series has some more patches which would break due to the contextual
differences, I think it's slightly better this time to use Markus'
version of the patch.

 Regards,
  Thomas


