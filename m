Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64C3C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C1D20738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCsSfHdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C1D20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juznL-0005QX-0E
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1juzmc-0004oR-Np
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:50:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59485
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1juzmY-0005Xa-PC
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594651813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zp9LsfYPQAMv+9SlA3KJ1wQWKbi5KT3lbHhMH8UYjyU=;
 b=WCsSfHdrAiiJAnQ9XmWB417X2DYs+0PjEaLyAu++AzCCElY4fQxZQm0MIyVYufH5UGGutD
 7IuGgA5O3NrFJ7xT2Ls2coCfIUk4Kvjp4/hzpZs5reLStRbqXAe9+O+TCiCJCt2sN5wmR7
 JwJfxuoISRvO1YBsEG8gIE5ZHzUccrY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-vsL8vPgeOw-axPdgYd-5Pw-1; Mon, 13 Jul 2020 10:50:09 -0400
X-MC-Unique: vsL8vPgeOw-axPdgYd-5Pw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56236107BEF7;
 Mon, 13 Jul 2020 14:50:08 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-183.ams2.redhat.com
 [10.36.114.183])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5F2879231;
 Mon, 13 Jul 2020 14:50:01 +0000 (UTC)
Subject: Re: [PULL 3/5] softmmu/vl: Let -fw_cfg option take a 'gen_id' argument
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200704163927.28188-1-philmd@redhat.com>
 <20200704163927.28188-4-philmd@redhat.com>
 <CAFEAcA8v2rEC0T_=D1Bat9DQJ=YS57fRUDDQyFdxJsEB=OEPMw@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <17fd7aea-cc7e-c17a-5748-88dd0d106317@redhat.com>
Date: Mon, 13 Jul 2020 16:50:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8v2rEC0T_=D1Bat9DQJ=YS57fRUDDQyFdxJsEB=OEPMw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:20:22
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/13/20 15:13, Peter Maydell wrote:
> On Sat, 4 Jul 2020 at 17:41, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> The 'gen_id' argument refers to a QOM object able to produce
>> data consumable by the fw_cfg device. The producer object must
>> implement the FW_CFG_DATA_GENERATOR interface.
>>
>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> Message-Id: <20200623172726.21040-4-philmd@redhat.com>
> 
> Coverity points out (CID 1430396) an issue with the error handling
> in this patch:
> 
> 
>> @@ -2052,6 +2056,15 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>>      if (nonempty_str(str)) {
>>          size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
>>          buf = g_memdup(str, size);
>> +    } else if (nonempty_str(gen_id)) {
>> +        Error *local_err = NULL;
> 
> We set local_err to NULL here...
> 
>> +
>> +        fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp);
> 
> ...but we don't pass it to the function here...

Ugh, I should have noticed that in review. I'm sorry.

Laszlo

> 
>> +        if (local_err) {
> 
> ...so this condition is always false and the body of the if is dead code.
> 
>> +            error_propagate(errp, local_err);
>> +            return -1;
>> +        }
>> +        return 0;
>>      } else {
>>          GError *err = NULL;
>>          if (!g_file_get_contents(file, &buf, &size, &err)) {
> 
> thanks
> -- PMM
> 


