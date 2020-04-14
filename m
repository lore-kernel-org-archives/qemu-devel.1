Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C3BC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:12:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB87E2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAoEYGQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB87E2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOJUE-000851-Uy
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 07:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1jOJMs-0004pz-NC
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1jOJMr-0006Oo-JC
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:04:38 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:38500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1jOJMo-0006Ng-Tn; Tue, 14 Apr 2020 07:04:35 -0400
Received: by mail-qk1-x744.google.com with SMTP id o19so5376127qkk.5;
 Tue, 14 Apr 2020 04:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hOpfhn1iq4ThwlFw6hoeLeZjUUsRrxcxUybe1eAjqYw=;
 b=ZAoEYGQfBWa/aYr5Ohhy37KEkMsZVSu93q+jj37Gx6aXyu5e+1Z3ktvvHBF67soC74
 ACpF89SM2L7XMHEixVSffHVGzaXhDkYPlAv2ZlSG0C/DR/xJooy1vN8LOa9h8k+Phfrn
 E0e4EK/qNeyfa9ux9WLUcICA3ZOx7NV1ei4lFjDRiaG+wJR4LfcOtSG6fhEhe8hJLzvY
 Lb6GyhJhHq/5Fnc7VpL6WMn6ijOFxLS445/UyUafHyXJ/GV1E6YnQKhRhf8ZMp5iQ3sx
 D35bWLz/huWB1f0x7QOwxxhPsKN9F2l0/toVH2woZaaAF4mlyxPraxSytJyDfcEw6197
 RgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hOpfhn1iq4ThwlFw6hoeLeZjUUsRrxcxUybe1eAjqYw=;
 b=IFIxcTeB5/5EMs/FOS+LLisCLTWXlEtRFt2Q+3FjHVgjj9a5CFkiTVhsIt+0ynF4Qa
 nCR+TzWwXrlFU1AlO4mnMreEY3dT4UgvgZU1iPPBjtgQLy6e/2O0gph67oLSZwoOa6wC
 QTT5MdnfcrFVx1jDL4cnUwMUzDZz3Tws/oakyfratVot4ZHi483UmRtDSqF/mFn7kJMA
 BpnxCDxLoUSDkmMrGMOhMlLUai9z4Q09nz553ddJnmIi99AcIhhFWn0KPkCVn4FAV4Dn
 BCUkQhSToj18L1fLCUXvLeMClbjw+edhDAwvCZH/f5kfEnduPZNWsoDeUt4KzBFZKpLN
 iVwA==
X-Gm-Message-State: AGi0PuYdT7ziBa0okOOtYTrx/jcfZVnUn6yygglQ8CuorIiTXQAi0Frt
 oV03iaq1VhS4oDcjZ3StjrA=
X-Google-Smtp-Source: APiQypK1qL+o55EAmnHtgUQXxIIkEkPu37s+eHPniK4NKFh//tlJoy9axh/RFjFJZxKPbpK6RFAKbg==
X-Received: by 2002:a05:620a:670:: with SMTP id
 a16mr19659601qkh.467.1586862274175; 
 Tue, 14 Apr 2020 04:04:34 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c6:b6b7:222c:adc1:59c6:6fc1?
 ([2804:431:c7c6:b6b7:222c:adc1:59c6:6fc1])
 by smtp.gmail.com with ESMTPSA id j2sm10422054qth.57.2020.04.14.04.04.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 04:04:33 -0700 (PDT)
Subject: Re: [PATCH] spapr_nvdimm.c: make 'label-size' mandatory
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200413203628.31636-1-danielhb413@gmail.com>
 <20200414020117.GB48061@umbus.fritz.box>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <84c6f5c7-de31-84ef-e873-58b10af14bc0@gmail.com>
Date: Tue, 14 Apr 2020 08:04:29 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414020117.GB48061@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/13/20 11:01 PM, David Gibson wrote:
> CCing Xiao, Michael and Igor for generic NVDIMM perspective.
> 
> On Mon, Apr 13, 2020 at 05:36:28PM -0300, Daniel Henrique Barboza wrote:
>> The pseries machine does not support NVDIMM modules without label.
>> Attempting to do so, even if the overall block size is aligned with
>> 256MB, will seg fault the guest kernel during NVDIMM probe. This
>> can be avoided by forcing 'label-size' to always be present for
>> sPAPR NVDIMMs.
>>
>> The verification was put before the alignment check because the
>> presence of label-size affects the alignment calculation, so
>> it's not optimal to warn the user about an alignment error,
>> then about the lack of label-size, then about a new alignment
>> error when the user sets a label-size.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> 
> So, this would get the job done, but it seems a bit inelegant compared
> to having the device default to working settings.  I'm looking at how
> this interacts with the generic constraints on label-size.
> 
> The generic nvdimm code has a MIN_NAMESPACE_LABEL_SIZE of 128 kiB, and
> values of label-size less than that are rejected.  Except that if
> label-size is not set at all, it is left as 0.
> 
> Is that intended behaviour?  Do x86 (or whatever) NVDIMMs have a label
> of at least 128kiB, unless they have no label at all?  Or could we
> make the default label-size 128kiB generically?

My limited understanding on how NVDIMM works in x86 is that x86 NVDIMMs can
work with and without label, but the label has a minimum size of 128kiB.

The current NVDIMM init code always adds NVDIMM_LABEL_SIZE_PROP regardless
of user settings, as you can see in hw/mem/nvdimm.c, nvdimm_init(). I found
this out in my first attempt in this patch when doing


object_property_find(OBJECT(nvdimm), NVDIMM_LABEL_SIZE_PROP,
                      &error_abort) == 0) == NULL


inside spapr_nvdimm.c and finding out that this property is always present. This
means that the way to distinguish between label and label-less NVDIMMs is to
check label_size != 0, as we can see being done in hw/acpi/nvdimm.c. What I did
then was to use this same approach in spapr_nvdimm.c.




Thanks,


DHB


