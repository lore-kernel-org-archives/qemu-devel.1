Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D98C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B37B321881
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LK/fsz+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37B321881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i55YH-0005X1-Nz
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 05:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1i55XR-00057y-9j
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1i55XP-0001BQ-VM
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:55:49 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:33198)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1i55XP-0001B7-RN
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:55:47 -0400
Received: by mail-qk1-x743.google.com with SMTP id x134so5054664qkb.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 02:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=h60LkbzgpfeQiBs19fnCdMry5+XDm06AI3f9+O3c3bU=;
 b=LK/fsz+4t7xG31JxEK4ZmfEUIwCk2s9/kkTixQphKhAM72jVgyO+AaJRYQmxc6+uCm
 ym2gnh9nbiF7CHLtpfoOpPDuqskcjfMhB5Xa331nieuWeZBOsOyuMH+Kf/zJ3C055Jq5
 wLPf39IvNQIB8Ii8Jey+OtVVeOzBUOeC0l7ifpmP90mM9R0qwTrT2ltC2NiV+1fyffb/
 HPYu2D99gw4w1VSiMKWMNPiTCucRbzGECmZoxMOepjIyrUdtJ05E+rWFd44yuDTG2nvX
 /VuMi021+ewFOVqPEFO8024pGGhuA6dWLg4aq7TsF1QyFbYtTFNfIEltusTNolyvy97S
 eoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=h60LkbzgpfeQiBs19fnCdMry5+XDm06AI3f9+O3c3bU=;
 b=sEJboLrlcSSxDAt/X0oLG9MQ/y8vlVdjLtVs4Hjol1olPtdhLtHAseMYUgAjLf4+LK
 6DOZPHCzL4nS7a6TXn9u/4CSNGYTs4Y4Z8CnMG7ishL6vBzRRcne7pKynwAgEjN5VobG
 d11Slj37aJsfSTbvjqWZNfLASJUnyIuZQdRoMlZ/+qQpZzEW0lKlUDnAPUZ0a3dAjG4y
 ylb5VQ2mIteY0GIkF/vIeHf3e7guwTZOmsSIFTpNTXZICXAB/4NAL53ITCKMlNb3h615
 pg1VaDAJn/G0A6hcpJ/6bsXifayrFB0gli3UXrN3rmfp4BSdiXFBxhyObCVVXKx7FTkf
 Xh5w==
X-Gm-Message-State: APjAAAVcy7U4bsj7hcSiVGg4WYdFfJPSRXNZSrbWZbBJKB2nZ+e/8HOm
 MTsS1FYdTiFybjiAnZIzUu4=
X-Google-Smtp-Source: APXvYqwIYY+f49eWjqGYV48JqMopT5P2/wm3/+4ZSS6FiRqllTVLs6VSRaaGj3k8/T98b3IMsqvYFw==
X-Received: by 2002:a05:620a:4a:: with SMTP id
 t10mr2923674qkt.168.1567504547153; 
 Tue, 03 Sep 2019 02:55:47 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c6:9589:1351:c7eb:87b:c9d5?
 ([2804:431:c7c6:9589:1351:c7eb:87b:c9d5])
 by smtp.gmail.com with ESMTPSA id e2sm7742320qkg.38.2019.09.03.02.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2019 02:55:46 -0700 (PDT)
To: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>
References: <20190807142114.17569-1-danielhb413@gmail.com>
 <20190807142114.17569-3-danielhb413@gmail.com>
 <a3b0480c-da0e-d182-335d-77568efb8121@redhat.com>
 <20190903092253.GB4582@localhost.localdomain>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <eeb3a0ff-2b95-2285-10e1-ae9bd2c4ba0e@gmail.com>
Date: Tue, 3 Sep 2019 06:55:44 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903092253.GB4582@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
Subject: Re: [Qemu-devel] [PATCH v5 2/4] block.c: adding bdrv_delete_file
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/3/19 6:22 AM, Kevin Wolf wrote:
> Am 29.08.2019 um 04:07 hat John Snow geschrieben:
>>
>> On 8/7/19 10:21 AM, Daniel Henrique Barboza wrote:
>>> Using the new 'bdrv_co_delete_file' interface, bdrv_delete_file
>>> can be used in a way similar of the existing bdrv_create_file to
>>> to clean up a created file.
>>>
>>> The logic is also similar to what is already done in bdrv_create_file:
>>> a qemu_coroutine is created if needed, a specialized function
>>> bdrv_delete_co_entry is used to call the bdrv_co_delete_file
>>> co-routine of the driver, if the driver implements it.
>>>
>>> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
>>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>>> ---
>>>   block.c               | 77 +++++++++++++++++++++++++++++++++++++++++++
>>>   include/block/block.h |  1 +
>>>   2 files changed, 78 insertions(+)
>>>
>>> diff --git a/block.c b/block.c
>>> index cbd8da5f3b..1e20250627 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -547,6 +547,83 @@ int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp)
>>>       return ret;
>>>   }
>>>   
>>> +typedef struct DeleteCo {
>>> +    BlockDriver *drv;
>>> +    BlockDriverState *bs;
>>> +    int ret;
>>> +    Error *err;
>>> +} DeleteCo;
>>> +
>>> +static void coroutine_fn bdrv_delete_co_entry(void *opaque)
>>> +{
>>> +    Error *local_err = NULL;
>>> +    DeleteCo *dco = opaque;
>>> +
>>> +    assert(dco->bs);
>>> +
>>> +    dco->ret = dco->drv->bdrv_co_delete_file(dco->bs, &local_err);
>>> +    error_propagate(&dco->err, local_err);
>>> +}
>>> +
>>> +int bdrv_delete_file(const char *filename, Error **errp)
>>> +{
>>> +    BlockDriver *drv = bdrv_find_protocol(filename, true, NULL);
>>> +    BlockDriverState *bs = bdrv_open(filename, NULL, NULL,
>>> +                                     BDRV_O_RDWR | BDRV_O_PROTOCOL, NULL);
>>> +    DeleteCo dco = {
>>> +        .drv = drv,
>>> +        .bs = bs,
>>> +        .ret = NOT_DONE,
>>> +        .err = NULL,
>>> +    };
>>> +    Coroutine *co;
>>> +    int ret;
>>> +
>>> +    if (!drv) {
>>> +        error_setg(errp, "File '%s' has unknown format", filename);
>>> +        ret = -ENOENT;
>>> +        goto out;
>>> +    }
>>> +
>> I was going to say that ENOENT is a weird error here, but I see it used
>> for !drv a few other places in block.c too, alongside EINVAL and
>> ENOMEDIUM. ENOMEDIUM loks like the most popular.
>>
>>> +    if (!drv->bdrv_co_delete_file) {
>>> +        error_setg(errp, "Driver '%s' does not support image delete",
>>> +                   drv->format_name);
>>> +        ret = -ENOTSUP;
>>> +        goto out;
>>> +    }
>>> +
>>> +    if (!bs) {
>>> +        error_setg(errp, "Could not open image '%s' for erasing",
>>> +                   filename);
>>> +        ret = 1;
>> Please keep all errors negative (or at least consistent within a function).
>>
>>
>> I'm also wondering if we want a version of delete that doesn't try to
>> open a file directly -- i.e. a version that exists like this:
>>
>> bdrv_co_delete_file(BlockDriverState *bs, Error **errp);
>>
>> That simply dispatches based on bs->drv to the correct routine.
>>
>> Then, you are free to have bdrv_delete_file handle the open (and let the
>> opening figure out what driver it needs), and just hand off the bds to
>> bdrv_co_delete_file.
>>
>> I'm not the authority for block.c, though, so maaaybe I'm giving you bad
>> advice here. Kevin's away on PTO for a bit and gave you advice most
>> recently, so I might try to gently ask him for more feedback next week.
> Yes, this was definitely the idea I had in mind when I suggested that
> bdrv_co_delete_file() should take a BDS.
>
> And I think the callers that want to call this function (for failures
> during image creation) all already have a BDS pointer, so nobody will
> actually need the additional open.
>
> const char *filename only works for the local filesystem (and even then
> I think not for all filenames) and some URLs, so this is not what we
> want to have in a public interface to identify an image file.

Hmpf, I understood your idead wrong in the v4 review and ended up
changing the co_routine (bdrv_co_delete_file) to use the BlockDriverState
instead of the public interface bdrv_delete_file that will be called 
inside crypto.c.

I'll respin it again with this change. Thanks for clarifying!



>
> Kevin


