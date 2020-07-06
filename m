Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B842C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0BF20724
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqAhUZoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0BF20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsMYE-0001R9-B1
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 04:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsMML-000662-3S
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:20:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsMMJ-000545-Bw
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:20:16 -0400
Received: by mail-wr1-x444.google.com with SMTP id o11so39835202wrv.9
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 01:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oPviQ+LIWGrd/yJvMZKPPFt1O+v7N7YSCrqZW1qvupw=;
 b=nqAhUZoHKtcH8+JTjMw9DvyU2KCcMBXr33sTsYlgoLsYRchsNhWlobHPjN6xacxBdR
 /7nO90UQ+1LY6nFoGK7uOCbZJv/tIvadGVicDMReuxy3hhyRBuSsXm4DJ/QbOJQ+vwau
 UpC38BTvLIhzFZeoLZjsvva1yMmrV6Fpkwo30Uzy2XGClZ9lN5mglAfhTIxmT+1S6Op6
 gTfByH6T5ZilI6aOuGQflWhGp24qRD1MwQUrjY/GnBz4yOqswU94hA8nOkyaa5ymS3cU
 O/x0UwRTN2nVLomayA9WeBuGdN4z5szSBDMxXRZIjbrj264Ms5F/cten2BtOEp7j1TRh
 fHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oPviQ+LIWGrd/yJvMZKPPFt1O+v7N7YSCrqZW1qvupw=;
 b=uM1m9rs4xS5ag7PUJhNmL3y4XBsbH0ZxcJ2LwCD5BPcT9YiHkPUnBEBJLBF+ZmjxV5
 1fkxWXFwK+N/N7kAwbA34jKxGpXp/bIcb+9Un5yYcVV6LkBKXjVQSA5kkXE7R7f6pa4R
 dCPyHPBUP9sPl7Elj6ZIs5S6djusRARO2FpThl0P6xToW+1gZgVaoNrpOItGpWjC4/mA
 54P7SGWs9UPnQZGAe9hZxvH+rYbXdjKAcc4p9DakJVsimbcHjdc+u0pTn508wnHThHxg
 EJIBQzUqtuz8o+tvpdQU1urfAf0sMrPIytO8tul30BVcRtDJnuDcfIn4irqBbbZlf21p
 R0ZA==
X-Gm-Message-State: AOAM530XoEVRjMeHMHqG9pCZ8WstD2/AW6dSnt6efQaD08nQ6txikTKY
 kQst+qnYP+wS/b15/CG2k1w=
X-Google-Smtp-Source: ABdhPJxqlqkFu3NaAPX4oF/vhN+9Gr5aDnHDCX2/Pm6tPo1voU+ZpCcbMUBOquGIdgGovtafLshPow==
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr48542327wrp.96.1594023613840; 
 Mon, 06 Jul 2020 01:20:13 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id t141sm2643612wmt.26.2020.07.06.01.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 01:20:13 -0700 (PDT)
Subject: Re: [PATCH v2] hw/core/qdev: Increase qdev_realize() kindness
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200705221430.30207-1-f4bug@amsat.org>
 <87fta5glw8.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f9e07dfc-868d-b5d6-ff62-24bdb882ccc4@amsat.org>
Date: Mon, 6 Jul 2020 10:20:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87fta5glw8.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/6/20 9:09 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Since commit 510ef98dca5, qdev_realize() aborts if bus-less
>> device is realized on a bus. Be kind with the developer by
>> displaying a hint about what is wrong.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> v2: Use errp (bonzini suggestion)
>>
>> Paolo, I was tempted to check errp is really &error_abort else
>> it is an error! :P
>>
>>     } else if (DEVICE_GET_CLASS(dev)->bus_type) {
>>         error_setg(errp, "%s: Unexpected bus '%s' for bus-less device '%s'",
>>                    __func__, DEVICE_GET_CLASS(dev)->bus_type,
>>                    object_get_typename(OBJECT(dev)));
>>         assert(errp == &error_abort); // <--------------
> 
> Don't!
> 
> Functions taking an Error **errp parameter to report errors should never
> examine the argument.
> 
> The Error API is for separating concerns.  The callee's concern is
> detecting errors and failing cleanly.  *Handling* the errors is the
> caller's concern.
> 
> To simplify common handling patterns, we provide convenience arguments
> &error_abort, &error_fatal, and NULL.  Their use is exclusively the
> caller's concern.
> 
> Examining the argument undermines the separation of concerns.
> 
>>         return false;
>>     }
>> ---
>>  hw/core/qdev.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index 2131c7f951..9d1530c39d 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -392,8 +392,11 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
>>  
>>      if (bus) {
>>          qdev_set_parent_bus(dev, bus);
>> -    } else {
>> -        assert(!DEVICE_GET_CLASS(dev)->bus_type);
>> +    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
>> +        error_setg(errp, "%s: Unexpected bus '%s' for bus-less device '%s'",
>> +                   __func__, DEVICE_GET_CLASS(dev)->bus_type,
>> +                   object_get_typename(OBJECT(dev)));
>> +        return false;
>>      }
>>  
>>      object_property_set_bool(OBJECT(dev), true, "realized", &err);
> 
> Scratch __func__.  error_setg() records __FILE__, __LINE__ and __func__,
> and error_handle_fatal() prints them.

Correct :/

> 
> Always, always, always test your error messages.  If they are impossible
> to test, mock up the error.  If mocking up is too much trouble, then
> reporting the error nicely is, too.
> 
> That said, this one matters to me only insofar as it sets a bad example.
> I don't actually care how impossible error messages come out :)

It might seems "impossible" to you because you only work with mainstream
QEMU.
There are plenty of forks trying to keep up with mainstream. Their code
is not mergeable in mainstream for various reasons (usually code not in
good shape, using deprecated APIs). These are mostly hobbyist trying
different boards / hardware / whatever.

You cleaned mainstream incorrect qdev/qom bus/parenting code before
merging your qdev/qom cleanup in commit 6675a653d2 ("Merge
remotes/armbru/tags/pull-qom-2020-06-15") but you didn't clean all the
forks. Now various forks simply abort, and it seems quite hard for a
developer not following mainstream activity on a daily basis to figure
out which change broke is fork.

As of today:
$ git log --oneline --since="3 weeks ago"|wc -l
776
And in 2 days we'll probably pass the 1k.

I hope you now understand the motivation of this patch. I failed at
properly describing it, mostly because I have a limited hobbyist time
where I try to address as much issues as I can.

I'll respin with improved commit description, and __func__ removed.

Regards,

Phil.

