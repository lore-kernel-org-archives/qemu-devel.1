Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81768C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 19:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9F5206D8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 19:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4WkJsOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9F5206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcCet-0002tV-LD
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 14:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kcCde-0002Od-Pi
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 14:15:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kcCda-0006EW-N0
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 14:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604949332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/vI45HVmAM57QYcyLMt6ZKpceb/rsCkcvZo/llAgk7c=;
 b=i4WkJsOymebAraDvVWtcm9I5ozPHDSgWd26BMek9helTSmP/PgHq8UV94xhRTIHe1G6rKs
 TthJFpHGywI2c7bgHH8RDLCmNCjWsNSciRj6sPROsH9tuMa1uwYBbREUDzgFVOonSXBTQp
 4gI9PujglxkjCQfwJ4EeFeSMNL0rTFg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-9QJv-iLrOhyu9SvDLzegug-1; Mon, 09 Nov 2020 14:15:30 -0500
X-MC-Unique: 9QJv-iLrOhyu9SvDLzegug-1
Received: by mail-wr1-f72.google.com with SMTP id b6so4674335wrn.17
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 11:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/vI45HVmAM57QYcyLMt6ZKpceb/rsCkcvZo/llAgk7c=;
 b=RjvfGc3Gqri9SXEQXt5U9glbPWj5RN0NvF1tmJaY9n7EGL9V/a9BUz5GzBeDArdds7
 +U445p2SU2VZgWskRDIp0r//BkQA3DtGIw2KhqnPXTv0AosVkdXqzXI7k4yREspVv1Eo
 O2z4+W1f76UJg+MqovolnAD/Bt5o83MjBxc+IlKMIXQGslNTXvmdX2cCzFdo6gc9yI5n
 yPwH7DR3n5GXOgf+4CzQfTKwDy1nPu3IvWUpd6hOBF2VuNPQJSqlL145EA6HdPN++sGl
 4ZOj2PCR7GqZZd1re0BKoeaQcASYS/xn0vV9hDgtmxG7CYqF5OH+T0i+SiWCEkSH65Z/
 TN/Q==
X-Gm-Message-State: AOAM533LnV9PGQrFO9JY6FpGIYCswAIKtZdfxyHhfv4CekRX8pjqsaob
 +MxHs7zhbLwxbrh5odaxWA/mjg48OkBl3f1FJgt/fIbxcE7XylKNpIGh0C9e76cVHF3P14qS6zu
 lTc7uymk0i/EU/LA=
X-Received: by 2002:a1c:1f08:: with SMTP id f8mr733684wmf.30.1604949329130;
 Mon, 09 Nov 2020 11:15:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3BH9He0r9TwdzodHoVXHcirmhNDYu47d1PnnoItXQH25WG0TryfF/Jc6eyBJHyc4GemQF0A==
X-Received: by 2002:a1c:1f08:: with SMTP id f8mr733664wmf.30.1604949328894;
 Mon, 09 Nov 2020 11:15:28 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id b14sm14148785wrx.35.2020.11.09.11.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 11:15:28 -0800 (PST)
Subject: Re: [PATCH-for-5.2 v3] configure: Check vhost-user is available for
 vhost-user-blk-server
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Thomas Huth <thuth@redhat.com>
References: <20201109140730.2600017-1-philmd@redhat.com>
 <50725a6d-f2b4-bf46-4f36-a4e7bf7f89fa@redhat.com>
 <CAP+75-XXvG+CzqRRsbYE20O=tLR5jZVEgSAKDg-5Y7GW5r-4cg@mail.gmail.com>
 <11346f41-40eb-f8e0-7405-558de89513d7@redhat.com>
 <b6c81bd3-7b18-0610-09e8-a68db4f7f734@redhat.com>
Message-ID: <ee20cf39-3574-d81e-a75d-d611b75edd94@redhat.com>
Date: Mon, 9 Nov 2020 20:15:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <b6c81bd3-7b18-0610-09e8-a68db4f7f734@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/9/20 7:52 PM, Philippe Mathieu-Daudé wrote:
> On 11/9/20 7:44 PM, Thomas Huth wrote:
>> On 09/11/2020 19.41, Philippe Mathieu-Daudé wrote:
>>> On Mon, Nov 9, 2020 at 6:22 PM Thomas Huth <thuth@redhat.com> wrote:
>>>> On 09/11/2020 15.07, Philippe Mathieu-Daudé wrote:
>>>>> Check vhost-user is available when building vhost-user-blk-server.
>>>>>
>>>>> This fixes:
>>>>>
>>>>>  $ ../configure \
>>>>>       --disable-vhost-user --enable-vhost-user-blk-server && \
>>>>>    make qemu-nbd
>>>>>  ...
>>>>>  [505/505] Linking target qemu-nbd
>>>>>  FAILED: qemu-nbd
>>>>>  cc  -o qemu-nbd qemu-nbd.p/qemu-nbd.c.o -Wl,--as-needed -Wl,--no-undefined -pie -Wl,--whole-archive libblockdev.fa libblock.fa libcrypto.fa libauthz.fa libqom.fa libio.fa -Wl,--no-whole-archive -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -m64 -fstack-protector-strong -Wl,--start-group libqemuutil.a libblockdev.fa libblock.fa libcrypto.fa libauthz.fa libqom.fa libio.fa @block.syms -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lgio-2.0 -lgobject-2.0 -lglib-2.0 -pthread -lgnutls -lutil -lm -lgthread-2.0 -lglib-2.0 -lbz2 -lgthread-2.0 -lglib-2.0 -lssh -lrbd -lrados -lcurl -lxml2 -lzstd -lacl -lgfapi -lglusterfs -lgfrpc -lgfxdr -luuid -laio /usr/lib64/libz.so -L/usr/lib64/iscsi -liscsi -lnettle -lgnutls -lpam -Wl,--end-group
>>>>>  /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_process_vq':
>>>>>  block/export/vhost-user-blk-server.c:203: undefined reference to `vu_get_queue'
>>>>>  /usr/bin/ld: block/export/vhost-user-blk-server.c:208: undefined reference to `vu_queue_pop'
>>>>>  /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_queue_set_started':
>>>>>  block/export/vhost-user-blk-server.c:228: undefined reference to `vu_get_queue'
>>>>>  /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_req_complete':
>>>>>  block/export/vhost-user-blk-server.c:55: undefined reference to `vu_queue_push'
>>>>>  /usr/bin/ld: block/export/vhost-user-blk-server.c:56: undefined reference to `vu_queue_notify'
>>>>>  /usr/bin/ld: libblockdev.fa(block_export_vhost-user-blk-server.c.o): in function `vu_blk_queue_set_started':
>>>>>  block/export/vhost-user-blk-server.c:229: undefined reference to `vu_set_queue_handler'
>>>>>  /usr/bin/ld: libqemuutil.a(util_vhost-user-server.c.o): in function `vu_client_trip':
>>>>>  util/vhost-user-server.c:176: undefined reference to `vu_dispatch'
>>>>>  /usr/bin/ld: util/vhost-user-server.c:180: undefined reference to `vu_deinit'
>>>>>  /usr/bin/ld: libqemuutil.a(util_vhost-user-server.c.o): in function `vu_accept':
>>>>>  util/vhost-user-server.c:291: undefined reference to `vu_init'
>>>>>  collect2: error: ld returned 1 exit status
>>>>>  ninja: build stopped: subcommand failed.
>>>>>  make: *** [Makefile:171: run-ninja] Error 1
>>>>>
>>>>> Now we get:
>>>>>
>>>>>  $ ../configure \
>>>>>       --disable-vhost-user --enable-vhost-user-blk-server && \
>>>>>  ERROR: --enable-vhost-user-blk-server requires --enable-vhost-user
>>>>>
>>>>> Fixes: bc15e44cb21 ("configure: introduce --enable-vhost-user-blk-server")
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>> ---
>>>>> Since v1:
>>>>> - Addressed Thomas review comments
>>>>> https://lists.gnu.org/archive/html/qemu-devel/2020-11/msg02188.html
>>>>> ---
>>>>>  configure | 4 ++++
>>>>>  1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/configure b/configure
>>>>> index 805f7791503..3124be82da1 100755
>>>>> --- a/configure
>>>>> +++ b/configure
>>>>> @@ -2375,6 +2375,10 @@ test "$vhost_user_fs" = "" && vhost_user_fs=$vhost_user
>>>>>  if test "$vhost_user_fs" = "yes" && test "$vhost_user" = "no"; then
>>>>>    error_exit "--enable-vhost-user-fs requires --enable-vhost-user"
>>>>>  fi
>>>>> +test "$vhost_user_blk_server" = "" && vhost_user_blk_server=$vhost_user
>>>>> +if test "$vhost_user_blk_server" = "yes" && test "$vhost_user" = "no"; then
>>>>> +  error_exit "--enable-vhost-user-blk-server requires --enable-vhost-user"
>>>>> +fi
>>>>
>>>> A little bit later in this file, we've got :
>>>>
>>>> # libvhost-user is Linux-only
>>>> test "$vhost_user_blk_server" = "" && vhost_user_blk_server=$linux
>>>> if test "$vhost_user_blk_server" = "yes" && test "$linux" = "no"; then
>>>>   error_exit "--enable-vhost-user-blk-server is only available on Linux"
>>>> fi
>>>>
>>>> I think it would be better to add the new code there instead.
>>>> Also maybe better do something like:
>>>>
>>>> test "$vhost_user_blk_server" = "" && test "$vhost_user" = "yes" \
>>>>  &&  vhost_user_blk_server=$linux
>>>>
>>>> instead?
>>>
>>> I understood this option is similar to the other vhost-user related ones
>>> and should be treated the same way.
>>
>> But the second check does not make much sense anymore after your change,
>> since "$vhost_user_blk_server" is certainly not empty anymore. So the two
>> checks IMHO have to be combined.
> 
> Ah now I see it... You are right, thanks for the review :)

So we are back to v2:
https://lists.gnu.org/archive/html/qemu-devel/2020-11/msg02333.html


