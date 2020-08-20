Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C403C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 10:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259F320658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 10:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBzmeCYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259F320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8htb-0008GQ-DW
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 06:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k8hsb-0007WI-R0; Thu, 20 Aug 2020 06:33:09 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:36678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k8hsa-00042O-3k; Thu, 20 Aug 2020 06:33:09 -0400
Received: by mail-qk1-x744.google.com with SMTP id g26so1082147qka.3;
 Thu, 20 Aug 2020 03:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uT+IKsVCCIMVpU9OQNErRnIPuQgMN38KV2o5ZIXb4j8=;
 b=jBzmeCYZ8ecweZeleIcgTXNwp0IHGuhAUQFDeUmk6k/uFiyZHQtIlwrkblPvTr6DIa
 9FZRV8m8f4UI3DwoyZVpcmHHTr+wnDO28Sur+xdxSQTwMuPJlhGbBVAs1jZT0L4hV8lG
 TFXciclGEEwea6z0nw4Vl5Q4mEV1XYeONwWLTCvQkw+02avMp5QGSzgqN1zFiWJ1P1NK
 u79QdcSDKfyuICazK8i0IVRnfd4j8SlHt2nCtKWV6sbsAg0rQBAKm76is+LP+/IcHwFS
 4g8R39Ih9nBXKJq6edu3IiXRpZfnJwoM/UOLdntCaZaZ8kzjFotM0w1vkaVbjwU6WSFi
 XU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uT+IKsVCCIMVpU9OQNErRnIPuQgMN38KV2o5ZIXb4j8=;
 b=XsEGRmI/n46rBDFWsuazqx9HtqV9iiyp5PxHDdA0hXD2FoGb0jGUzLGFgKRNHKqkSq
 DOcZguIpIo2MfYPnPouyZs0DZi8CGpdcOCdkV1C2MUlXWTYm0nVRogaFQG/vLWlHz7Jk
 0vC0R6AXoI7sCkydb79QsC3qlUkk9mW8DA9MakQP2mtVNbxs/wDn3dJqMk1X8WoJyYE3
 j3/eMS374cQDm+X/uIZaP0U4tZHdz9Of1nVnWWKSrhaglDbh8zAi33inc/wL277qIUU+
 Jv5gzZrkOI5mHGajgpchK1Ez2lARiPIQlhVuk6jMT9Bqv4ObQQL2xwuDrtlQrg1z0KfP
 1Dmg==
X-Gm-Message-State: AOAM533FaL8IluYaLmfNBR3vM8mPAX24ES6kNbedCZkWf4zlKa/DLlSr
 5+dcEdrSHD8g35BnrrGKUrY=
X-Google-Smtp-Source: ABdhPJxEpeYnwp10BtShCK5HPSTGAQBsl1iWWMNKxMWlhQDtvUdNOevR5HMtpEroUB29L5KaYM/uag==
X-Received: by 2002:a37:9d0d:: with SMTP id g13mr1969979qke.165.1597919585939; 
 Thu, 20 Aug 2020 03:33:05 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c7:c152:6ea6:a44d:671e:88f?
 ([2804:431:c7c7:c152:6ea6:a44d:671e:88f])
 by smtp.gmail.com with ESMTPSA id u39sm2794414qtc.54.2020.08.20.03.33.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 03:33:05 -0700 (PDT)
Subject: Re: [PATCH 02/10] numa: introduce
 MachineClass::forbid_asymmetrical_numa
To: David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200814205424.543857-1-danielhb413@gmail.com>
 <20200814205424.543857-3-danielhb413@gmail.com>
 <20200820011726.GF271315@yekko.fritz.box>
 <20200820021128.GC642093@habkost.net>
 <20200820041504.GN271315@yekko.fritz.box>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <6086c921-9eb5-5bc6-7af3-b914f13f1f2f@gmail.com>
Date: Thu, 20 Aug 2020 07:33:00 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820041504.GN271315@yekko.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x744.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: qemu-ppc@nongnu.org, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/20/20 1:15 AM, David Gibson wrote:
> On Wed, Aug 19, 2020 at 10:11:28PM -0400, Eduardo Habkost wrote:
>> On Thu, Aug 20, 2020 at 11:17:26AM +1000, David Gibson wrote:
>>> On Fri, Aug 14, 2020 at 05:54:16PM -0300, Daniel Henrique Barboza wrote:
>>>> The pSeries machine does not support asymmetrical NUMA
>>>> configurations.
>>>
>>> This seems a bit oddly specific to have as a global machine class
>>> property.
>>>
>>> Would it make more sense for machines with specific NUMA constraints
>>> to just verify those during their initialization?
>>
>> This would be much simpler.  However, I like the idea of
>> representing machine-specific configuration validation rules as
>> data that can eventually be exported to management software.
> 
> Ah, ok, so basically the usual tradeoff between flexibility and
> advertisability.



To provide context, what I did here was inspired by this commit:

commit 0533ef5f2089f4f12a0ec5c8035e5e15ba0b5556
Author: Tao Xu <tao3.xu@intel.com>
Date:   Thu Sep 5 16:32:38 2019 +0800

     numa: Introduce MachineClass::auto_enable_numa for implicit NUMA node


In this commit, exclusive NUMA code from spapr.c was taken and put it
into numa.c, with a flag being set in spapr machine_init.


Thanks,


DHB


> 
> So, in that case, I guess the question is whether we envisage "no
> assymmetry" as a constraint common enough that it's worth creating an
> advertisable rule or not.  If we only ever have one user, then we
> haven't really done any better than hard coding the constraint in the
> manageent software.
> 
> Of course to complicate matters, in the longer term we're looking at
> removing that constraint from pseries - but doing so will be dependent
> on the guest kernel understanding a new format for the NUMA
> information in the device tree.  So qemu alone won't have enough
> information to tell if such a configuration is possible or not.
> 
>> (CCing John Snow, who had spent some time thinking about
>> configuration validation recently.)
>>
>>
>>>>
>>>> CC: Eduardo Habkost <ehabkost@redhat.com>
>>>> CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>>>> ---
>>>>   hw/core/numa.c      | 7 +++++++
>>>>   hw/ppc/spapr.c      | 1 +
>>>>   include/hw/boards.h | 1 +
>>>>   3 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/hw/core/numa.c b/hw/core/numa.c
>>>> index d1a94a14f8..1e81233c1d 100644
>>>> --- a/hw/core/numa.c
>>>> +++ b/hw/core/numa.c
>>>> @@ -547,6 +547,7 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
>>>>    */
>>>>   static void validate_numa_distance(MachineState *ms)
>>>>   {
>>>> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>>>>       int src, dst;
>>>>       bool is_asymmetrical = false;
>>>>       int nb_numa_nodes = ms->numa_state->num_nodes;
>>>> @@ -575,6 +576,12 @@ static void validate_numa_distance(MachineState *ms)
>>>>       }
>>>>   
>>>>       if (is_asymmetrical) {
>>>> +        if (mc->forbid_asymmetrical_numa) {
>>>> +            error_report("This machine type does not support "
>>>> +                         "asymmetrical numa distances.");
>>>> +            exit(EXIT_FAILURE);
>>>> +        }
>>>> +
>>>>           for (src = 0; src < nb_numa_nodes; src++) {
>>>>               for (dst = 0; dst < nb_numa_nodes; dst++) {
>>>>                   if (src != dst && numa_info[src].distance[dst] == 0) {
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index dd2fa4826b..3b16edaf4c 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -4512,6 +4512,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>>>        */
>>>>       mc->numa_mem_align_shift = 28;
>>>>       mc->auto_enable_numa = true;
>>>> +    mc->forbid_asymmetrical_numa = true;
>>>>   
>>>>       smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
>>>>       smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
>>>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>>>> index bc5b82ad20..dc6cdd1c53 100644
>>>> --- a/include/hw/boards.h
>>>> +++ b/include/hw/boards.h
>>>> @@ -215,6 +215,7 @@ struct MachineClass {
>>>>       bool nvdimm_supported;
>>>>       bool numa_mem_supported;
>>>>       bool auto_enable_numa;
>>>> +    bool forbid_asymmetrical_numa;
>>>>       const char *default_ram_id;
>>>>   
>>>>       HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
>>>
>>
>>
>>
> 

