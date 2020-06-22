Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58481C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210E72073E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3hNTIWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210E72073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOfs-0008CL-Dm
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnOZq-0001Fl-8o; Mon, 22 Jun 2020 11:41:42 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnOZo-00041G-CS; Mon, 22 Jun 2020 11:41:41 -0400
Received: by mail-wm1-x343.google.com with SMTP id 17so43513wmo.1;
 Mon, 22 Jun 2020 08:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TF7KCQHZ19vd7eH8Vygxjp34TmrApPVh2V5fRml3vO8=;
 b=Q3hNTIWitQSIx8tsFOUYYwGfWtQ+cz8KU1UTqaY/E9aB9t8Yk90AIMjLicJrI1vZ58
 a5wj3gZ3LMhV9rqKEz+/tuYb7Ojpjbl4zW/fCp/hnEBxmrCv+vJBf4efXA/blWmvOp5j
 vWAM4XHX2Tc9Q+xjkMajWxLbZpAF+QKctclgOj8Y/aGAC/YBG6sqVT10+9E+FavqSghO
 doxaggcTVcXKBPmKFUcr3jn4FHcQ/MzhsVF1ZPEg8AUUZySA2G7qjKVvOBfcMS8XjY0Q
 8ewLYuvNxupM5RL5xpHCm4U4XtAd2UxdhwC+5UJ6TkJaODeG5qEASZAUt6Ca6jgg0N9l
 FBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TF7KCQHZ19vd7eH8Vygxjp34TmrApPVh2V5fRml3vO8=;
 b=XngDKozUKJ46pSEeVCG0udVF0Pc0k8tOGxkx6f9gMSHVkj591vLcOUFSAB6ZQN1Fus
 pYEwFJd6xVpq25sHi88k78VxP/DzM5N1MEMoP7cGj0XS1yjEu08IVj5dIrzwYmFAvfuo
 OZSjZXfD4nq65poNXqFPtf9u9zcmqWLAh6DIEMGyIs2rmBsXoR0m61fbGw4OjmalEPOz
 JdlUfPaa/KQCGJ1ufr7WnHXdXx61C1Lwy1/ghAK40xgSYrN4h5SZXawheoPovkRdA53+
 j5WQ/KBS7Qr/Ejb1cplM1KY8dwwKCLxYETLOXeGPP8dK63jfjuGkdDHmMR5tbRaWYhwc
 MsPA==
X-Gm-Message-State: AOAM533+gn/r1OQFp1pL5cxXqCSooDESQFVnSUAnfD0Ch3FqbENBW2eN
 jhAudU1vQaYXEPuRZ7tEpLk=
X-Google-Smtp-Source: ABdhPJwy3r1bptLL2u48LNrpySfEo1SSfmHtJ1ZNBX1OqSwPMoaktgqN+9GVixqqGhR/kl4ti2yOOw==
X-Received: by 2002:a1c:750e:: with SMTP id o14mr18714443wmc.86.1592840498342; 
 Mon, 22 Jun 2020 08:41:38 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id c2sm19044747wrv.47.2020.06.22.08.41.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 08:41:37 -0700 (PDT)
Subject: Re: [PATCH v4 1/8] hw/i2c/core: Add i2c_try_create_slave() and
 i2c_realize_and_unref()
To: Markus Armbruster <armbru@redhat.com>
References: <20200620225854.31160-1-f4bug@amsat.org>
 <20200620225854.31160-2-f4bug@amsat.org> <874kr36sg7.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e28de977-4e29-901f-58df-74095bcd2c91@amsat.org>
Date: Mon, 22 Jun 2020 17:41:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <874kr36sg7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 5:17 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Extract i2c_try_create_slave() and i2c_realize_and_unref()
>> from i2c_create_slave().
>> We can now set properties on a I2CSlave before it is realized.
>>
>> This is in line with the recent qdev/QOM changes merged
>> in commit 6675a653d2e.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/hw/i2c/i2c.h |  2 ++
>>  hw/i2c/core.c        | 18 ++++++++++++++++--
>>  2 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
>> index 4117211565..d6e3d85faf 100644
>> --- a/include/hw/i2c/i2c.h
>> +++ b/include/hw/i2c/i2c.h
>> @@ -80,6 +80,8 @@ int i2c_send(I2CBus *bus, uint8_t data);
>>  uint8_t i2c_recv(I2CBus *bus);
>>  
>>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr);
>> +DeviceState *i2c_try_create_slave(const char *name, uint8_t addr);
>> +bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp);
>>  
>>  /* lm832x.c */
>>  void lm832x_key_event(DeviceState *dev, int key, int state);
>> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
>> index 1aac457a2a..acf34a12d6 100644
>> --- a/hw/i2c/core.c
>> +++ b/hw/i2c/core.c
>> @@ -267,13 +267,27 @@ const VMStateDescription vmstate_i2c_slave = {
>>      }
>>  };
>>  
>> -DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
>> +DeviceState *i2c_try_create_slave(const char *name, uint8_t addr)
>>  {
>>      DeviceState *dev;
>>  
>>      dev = qdev_new(name);
>>      qdev_prop_set_uint8(dev, "address", addr);
>> -    qdev_realize_and_unref(dev, &bus->qbus, &error_fatal);
>> +    return dev;
>> +}
>> +
>> +bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp)
>> +{
>> +    return qdev_realize_and_unref(dev, &bus->qbus, errp);
>> +}
>> +
>> +DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
>> +{
>> +    DeviceState *dev;
>> +
>> +    dev = i2c_try_create_slave(name, addr);
>> +    i2c_realize_and_unref(dev, bus, &error_fatal);
>> +
>>      return dev;
>>  }
> 
> No objections, except I want to see actual users.

You weren't Cc'ed on the whole series.

User is patch #6/8 "hw/arm/aspeed: Describe each PCA9552 device":
https://www.mail-archive.com/qemu-devel@nongnu.org/msg714658.html

