Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B00C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64143206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/+L6CGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64143206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnT0-0000Jf-Hd
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDnPT-0004cy-96; Thu, 03 Sep 2020 07:28:07 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:36236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDnPR-0008NR-BW; Thu, 03 Sep 2020 07:28:06 -0400
Received: by mail-qt1-x842.google.com with SMTP id n10so1589761qtv.3;
 Thu, 03 Sep 2020 04:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9ekIUoYeHzoslT4Dhtfeg/PWay7LeWwFREJahHpoRvE=;
 b=L/+L6CGk7mxm9J7cczGfx1hLhReGWTBLjrt286V4vXiOQE7yZn/PM/wZEsKH3qJJDJ
 JEoWO1ed776bfKZf0w3P0S3RvQn8JZmfQTOEmiFHPz0YgjA0Z9s0dUMpXqihkLMCY6m0
 leA0bUiI4jQUtgTSCwdnWkNUGIBFfrSYsOxJPvxFCV88dDkZiXWoEUfEEo3127YCf+pp
 eELGNNrekX5NIZ8qxyqrVwGLlX5YLR9XFKKPVTsSfnuUeEfhvz6zMAZxZwMJAOZMSqTE
 AGPvC/2j8IV/dCiQG9QT22FZymWEJio8+ywfwoVZSM7lVA2Ak7d+lKowA11wSam8mf1O
 7i0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9ekIUoYeHzoslT4Dhtfeg/PWay7LeWwFREJahHpoRvE=;
 b=JlVHBHmwaim2b8tfA7xzW7sQKjRghVVpR21O6gtRPLc/OdcGaDV1XmfjLkHTVVxGyz
 MovDRNLS8DLU/SHU5HmLzp0EwrHzek6OP6y1ua97K3S9Ix0h4FsvaxQ3zuznpIFth0gW
 ILnJ7Nxq86mSP5zVG75W3z0AWVCk/ThvsrTXG9tqLPvl+c62+K8i/eEK1B1qz59nDw5Y
 5ggAjsWRG/nljOc5YShLTllEezJMVb/tmY66bgFxnYMtJda+J81PqfGQxk5tGQCqBqEq
 5b2/3SndFh+Try8x+ovf0LtqCvncExc6qSHUAQOPrEa1frH+9n/wSOIVUzn68aPjzkMF
 xaWg==
X-Gm-Message-State: AOAM530dUc0uT+9qiTB0QHP+ZYY5YWDpuMjzPhv8CqeF79oTDUvd8ND4
 bm7C8PkPRYy6wSlYN1ZWkbmr270Engs=
X-Google-Smtp-Source: ABdhPJyu/wHnpYUVoyfx2welbhG+6EQaz7he5zVnHZBjwGweFIYZ2+79XNi8R8BLm4lU50zGvUzBEQ==
X-Received: by 2002:aed:2c63:: with SMTP id f90mr2919675qtd.262.1599132483277; 
 Thu, 03 Sep 2020 04:28:03 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca?
 ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id s192sm387864qke.50.2020.09.03.04.28.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 04:28:02 -0700 (PDT)
Subject: Re: [PATCH v2 3/7] spapr: introduce
 SpaprMachineClass::numa_assoc_array
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200901125645.118026-1-danielhb413@gmail.com>
 <20200901125645.118026-4-danielhb413@gmail.com>
 <20200903015148.GK1897@yekko.fritz.box>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <d493d0d8-7104-40a4-a957-156b6cd1d5b6@gmail.com>
Date: Thu, 3 Sep 2020 08:28:00 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903015148.GK1897@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x842.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-2.403,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/2/20 10:51 PM, David Gibson wrote:
> On Tue, Sep 01, 2020 at 09:56:41AM -0300, Daniel Henrique Barboza wrote:
>> The next step to centralize all NUMA/associativity handling in
>> the spapr machine is to create a 'one stop place' for all
>> things ibm,associativity.
>>
>> This patch introduces numa_assoc_array, a 2 dimensional array
>> that will store all ibm,associativity arrays of all NUMA nodes.
>> This array is initialized in a new spapr_numa_associativity_init()
>> function, called in spapr_machine_init(). It is being initialized
>> with the same values used in other ibm,associativity properties
>> around spapr files (i.e. all zeros, last value is node_id).
>> The idea is to remove all hardcoded definitions and FDT writes
>> of ibm,associativity arrays, doing instead a call to the new
>> helper spapr_numa_write_associativity_dt() helper, that will
>> be able to write the DT with the correct values.
>>
>> We'll start small, handling the trivial cases first. The
>> remaining instances of ibm,associativity will be handled
>> next.
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> 
> The idea is great, but there's one small but significant problem here:
> 
>> +void spapr_numa_associativity_init(MachineState *machine)
>> +{
>> +    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
>> +    int nb_numa_nodes = machine->numa_state->num_nodes;
>> +    int i;
>> +
>> +    /*
>> +     * For all associativity arrays: first position is the size,
>> +     * position MAX_DISTANCE_REF_POINTS is always the numa_id,
>> +     * represented by the index 'i'.
>> +     *
>> +     * This will break on sparse NUMA setups, when/if QEMU starts
>> +     * to support it, because there will be no more guarantee that
>> +     * 'i' will be a valid node_id set by the user.
>> +     */
>> +    for (i = 0; i < nb_numa_nodes; i++) {
>> +        smc->numa_assoc_array[i][0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS);
>> +        smc->numa_assoc_array[i][MAX_DISTANCE_REF_POINTS] = cpu_to_be32(i);
> 
> This initialization is called on a machine *instance*, which means it
> should treat the machine class as read-only.  i.e. the
> numa_assoc_array should be in the SpaprMachineState, rather than the
> class.
> 
> I mean, we'd get away with it in practice, since there's only ever
> likely to be a single machine instance, but still we should correct
> this.

Got it. I'll move it to SpaprMachineState. This will also spare a handful of lines
everywhere else since I was instantiating the class just to manipulate the matrix
(and now, in hindsight, I figured that this was a warning about the weirdness
of what I was doing).


Thanks,


DHB

> 

