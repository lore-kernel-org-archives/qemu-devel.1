Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68528C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 10:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D024920691
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 10:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D024920691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRCZj-0003UE-Rl
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 06:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1kRCXc-0002AC-GV; Sat, 10 Oct 2020 06:55:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60932 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1kRCXa-00028P-Iu; Sat, 10 Oct 2020 06:55:56 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 1ABBBCC9A2DAC52E3DCC;
 Sat, 10 Oct 2020 18:55:52 +0800 (CST)
Received: from [10.174.178.98] (10.174.178.98) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Sat, 10 Oct 2020 18:55:42 +0800
Subject: Re: [PATCH] target/i386/cpu: add return value verification and ignore
 Error objects
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 <qemu-devel@nongnu.org>
References: <20200904134529.1317-1-pannengyuan@huawei.com>
 <10efea6a-b3a8-3e37-47d1-640f5a9ef9c9@redhat.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <b2643f32-cdcd-cf87-68d7-ebfabcbf3ca6@huawei.com>
Date: Sat, 10 Oct 2020 18:55:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <10efea6a-b3a8-3e37-47d1-640f5a9ef9c9@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.98]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=pannengyuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 06:54:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.208,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org, Laurent
 Vivier <laurent@vivier.eu>, ehabkost@redhat.com, pbonzini@redhat.com,
 kuhn.chenqun@huawei.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping!

Maybe missed to queue?

On 2020/9/4 21:20, Philippe Mathieu-Daudé wrote:
> On 9/4/20 3:45 PM, Pan Nengyuan wrote:
>> 'err' is unnecessary in x86_cpu_class_check_missing_features(), we can change x86_cpu_expand_features()
>> to return true on success, false on failure, then pass NULL here to remove it.
>>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
>> ---
>>  target/i386/cpu.c | 15 +++++++--------
>>  1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 49d8958528..c3d3766133 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -4883,7 +4883,7 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
>>      }
>>  }
>>  
>> -static void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
>> +static bool x86_cpu_expand_features(X86CPU *cpu, Error **errp);
>>  static void x86_cpu_filter_features(X86CPU *cpu, bool verbose);
>>  
>>  /* Build a list with the name of all features on a feature word array */
>> @@ -4925,7 +4925,6 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
>>                                                   strList **missing_feats)
>>  {
>>      X86CPU *xc;
>> -    Error *err = NULL;
>>      strList **next = missing_feats;
>>  
>>      if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
>> @@ -4937,8 +4936,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
>>  
>>      xc = X86_CPU(object_new_with_class(OBJECT_CLASS(xcc)));
>>  
>> -    x86_cpu_expand_features(xc, &err);
>> -    if (err) {
>> +    if (!x86_cpu_expand_features(xc, NULL)) {
>>          /* Errors at x86_cpu_expand_features should never happen,
>>           * but in case it does, just report the model as not
>>           * runnable at all using the "type" property.
>> @@ -4947,7 +4945,6 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
>>          new->value = g_strdup("type");
>>          *next = new;
>>          next = &new->next;
>> -        error_free(err);
>>      }
>>  
>>      x86_cpu_filter_features(xc, false);
>> @@ -6426,7 +6423,7 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
>>  /* Expand CPU configuration data, based on configured features
>>   * and host/accelerator capabilities when appropriate.
>>   */
>> -static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>> +static bool x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>>  {
>>      CPUX86State *env = &cpu->env;
>>      FeatureWord w;
>> @@ -6436,14 +6433,14 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>>      for (l = plus_features; l; l = l->next) {
>>          const char *prop = l->data;
>>          if (!object_property_set_bool(OBJECT(cpu), prop, true, errp)) {
>> -            return;
>> +            return false;
>>          }
>>      }
>>  
>>      for (l = minus_features; l; l = l->next) {
>>          const char *prop = l->data;
>>          if (!object_property_set_bool(OBJECT(cpu), prop, false, errp)) {
>> -            return;
>> +            return false;
>>          }
>>      }
>>  
>> @@ -6540,6 +6537,8 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>>      if (env->cpuid_xlevel2 == UINT32_MAX) {
>>          env->cpuid_xlevel2 = env->cpuid_min_xlevel2;
>>      }
>> +
>> +    return true;
>>  }
>>  
>>  /*
>>
> 

