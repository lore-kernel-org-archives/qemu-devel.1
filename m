Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7660BC433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 08:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD332071A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 08:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEl4Que1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD332071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwLMA-0005ny-0R
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 04:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwLLQ-0005BX-OH
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 04:03:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48722
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwLLP-0005I9-8n
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 04:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594973026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=9LILVtctDAHk9jVvgwRNm0TAzAIATXan+1Em9XHy4O4=;
 b=YEl4Que14Uy08Kl1hsEzNzeHJZ/vM0bT/1AC8PsrA/n9w3D3et0D2uTdcjtBJfaOS56+bT
 YgGwc7v/KyXRS5jqSKIk893MNCMsBWYdu7t5dd4VN6FAc5GwMGCuG96kkHwK6pdld/j44o
 FDUhCLbZGCExpGidKzktFP4X/QQ7AGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-cuEvj8ApMjuDFqPjfD8B7Q-1; Fri, 17 Jul 2020 04:03:42 -0400
X-MC-Unique: cuEvj8ApMjuDFqPjfD8B7Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AD3980BCA8;
 Fri, 17 Jul 2020 08:03:40 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D83919724;
 Fri, 17 Jul 2020 08:03:36 +0000 (UTC)
Subject: Re: [PATCH v5 10/11] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Havard Skinnemoen <hskinnemoen@google.com>
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-11-hskinnemoen@google.com>
 <109d52ed-65bf-0fcc-98f1-47b7a6671d0b@kaod.org>
 <CAFQmdRZcygskP3iwss01-Jz67yjAP_JENXjWM2Bp8U=DRzxR0Q@mail.gmail.com>
 <875zaq78xq.fsf@dusky.pond.sub.org>
 <19733456-a672-595d-e721-e0ef26d7f665@amsat.org>
 <87v9iq2hkv.fsf@dusky.pond.sub.org>
 <e87663cf-7cb2-ca6c-a751-e5c1cebc5440@amsat.org>
 <87pn8xywz2.fsf@dusky.pond.sub.org>
 <b3bc658f-a865-8e6b-c904-01c7724e89cc@amsat.org>
 <CAFQmdRa9FiP6yX=XDrJy5KpjifQyVkQiY6DXtSoJSvfoq7Vm6w@mail.gmail.com>
 <CAFQmdRac6tsZafN3PsnLhPA_Ny032ZAjOFuXkmYvJ-ubjcpPPw@mail.gmail.com>
 <5345d70f-3041-ed13-12e9-9a8e3d803805@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <416d5243-dc8e-37c6-197f-96dec1c9f5cc@redhat.com>
Date: Fri, 17 Jul 2020 10:03:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5345d70f-3041-ed13-12e9-9a8e3d803805@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, CS20 KFTing <kfting@nuvoton.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/07/2020 09.48, Philippe Mathieu-Daudé wrote:
> +Thomas

> On 7/16/20 10:56 PM, Havard Skinnemoen wrote:
>> On Wed, Jul 15, 2020 at 1:54 PM Havard Skinnemoen
>> <hskinnemoen@google.com> wrote:
>>>
>>> On Wed, Jul 15, 2020 at 3:57 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>
>>>> On 7/15/20 11:00 AM, Markus Armbruster wrote:
>>>>> Now my point.  Why first make up user configuration, then use that to
>>>>> create a BlockBackend, when you could just go ahead and create the
>>>>> BlockBackend?
>>>>
>>>> CLI issue mostly.
>>>>
>>>> We can solve it similarly to the recent "sdcard: Do not allow invalid SD
>>>> card sizes" patch:
>>>>
>>>>  if (!dinfo) {
>>>>      error_setg(errp, "Missing SPI flash drive");
>>>>      error_append_hint(errp, "You can use a dummy drive using:\n");
>>>>      error_append_hint(errp, "-drive if=mtd,driver=null-co,"
>>>>                              "read-ones=on,size=64M\n);
>>>>      return;
>>>>  }
>>>>
>>>> having npcm7xx_connect_flash() taking an Error* argument,
>>>> and MachineClass::init() call it with &error_fatal.
>>>
>>> Erroring out if the user specifies a configuration that can't possibly
>>> boot sounds good to me. Better than trying to come up with defaults
>>> that are still not going to result in a bootable system.
>>>
>>> For testing recovery paths, I think it makes sense to explicitly
>>> specify a null device as you suggest.
>>
>> Hmm, one problem. qom-test fails with
>>
>> qemu-system-aarch64: Missing SPI flash drive
>> You can add a dummy drive using:
>> -drive if=mtd,driver=null-co,read-zeroes=on,size=32M
>> Broken pipe
>> /usr/local/google/home/hskinnemoen/qemu/for-upstream/tests/qtest/libqtest.c:166:
>> kill_qemu() tried to terminate QEMU process but encountered exit
>> status 1 (expected 0)
>> ERROR qom-test - too few tests run (expected 68, got 7)
>>
>> So it looks like we might need a different solution to this, unless we
>> want to make generic tests more machine-aware...

I didn't follow the other mails in this thread, but what we usually do
in such a case: Add a "if (qtest_enabled())" check to the device or the
machine to ignore the error if it is running in qtest mode.

 Thomas


