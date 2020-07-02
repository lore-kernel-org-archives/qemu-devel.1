Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2986C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA04B20748
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdpyAeoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA04B20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqvrJ-0007rr-0i
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 05:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqvqi-0007K8-EP
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:49:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49746
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqvqg-00058L-Po
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593683382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tzS1XQ6aGuMhXuC6FmJkv76RbrQuflBDei181QZi6X4=;
 b=SdpyAeoL8//xcwi8G+pPyGbuCAspY1Mi8CkpZ02D5LBk+4hF/iG9eWg5SZ/eoIHtNDvMnZ
 fCeiD6MVM2O3Vo4PewCk9vNhGAVX+O3zpE2n11b+ZCCQIg17eT2HGtOAXms+nk9p+xvHTE
 4ttVzWQPB7OUGf80MVrdx9RPmRDTRxE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-0o_oqq6hN5GTpKsBMlFu8w-1; Thu, 02 Jul 2020 05:49:40 -0400
X-MC-Unique: 0o_oqq6hN5GTpKsBMlFu8w-1
Received: by mail-wm1-f72.google.com with SMTP id a21so27523090wmd.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 02:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tzS1XQ6aGuMhXuC6FmJkv76RbrQuflBDei181QZi6X4=;
 b=pCzbs8BxmrEk4rtzYbMf06+zzvhP+UoyGflinUAMOpAALk+46P6pyT/Yf1m5gOyZ6i
 bSuqHi1tFoKrSfvuOUMM7xnhz0FdwoeqKkavRiB8+Uvp77gNPN0NWsAowyBakOnCPzy3
 FhRKE+majDeX7yFDE9Vrvr7+wGkHflunR5ZvVdF53r694z423B4kzWFwAsI925+ceOTE
 UAHxuiTjUFBLyefha9U7CM70KH33X2Kr+JbnQSlTIqwgN2Mt+0R+GOVwLTy+YzL7+Mw/
 C6BaD4F77YB232BQOxepwEbmJzeWxxleM0tL0OCyDyJ7iTuM1rzT237QYPb0BscTcoq8
 Qdzw==
X-Gm-Message-State: AOAM5312lDUi/n1tthdunPNCJgCpWlnerdnGoUB6xlLUiviZBAsXs+tV
 7NTyM4LNghsMAjXjj+EON5hhwzONHKewxsiscSyzD9COEPKAi3IOIu33xgceymbx1fGYqM74L0L
 TbhOva5RUJRMm9Xk=
X-Received: by 2002:a7b:ce14:: with SMTP id m20mr33181431wmc.129.1593683379117; 
 Thu, 02 Jul 2020 02:49:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7p7UkG/39ioOaJXYrzI2vC9CNvuP2YFk5TzFkJHXTpDuhk7mcn4pEqalXAlskhRLbOH6MNQ==
X-Received: by 2002:a7b:ce14:: with SMTP id m20mr33181410wmc.129.1593683378834; 
 Thu, 02 Jul 2020 02:49:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2cad:376b:7d21:868e?
 ([2001:b07:6468:f312:2cad:376b:7d21:868e])
 by smtp.gmail.com with ESMTPSA id w2sm10588066wrs.77.2020.07.02.02.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 02:49:38 -0700 (PDT)
Subject: Re: [PATCH] target/i386: implement undocumented "smsw r32" behavior
To: Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200626104419.15504-2-pbonzini@redhat.com>
 <20200702093717.GD78555@SPB-NB-133.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e23b1841-adcd-6e94-bd1d-f372b89dfb81@redhat.com>
Date: Thu, 2 Jul 2020 11:49:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200702093717.GD78555@SPB-NB-133.local>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/20 11:37, Roman Bolshakov wrote:
> On Fri, Jun 26, 2020 at 06:44:19AM -0400, Paolo Bonzini wrote:
>> In 32-bit mode, the higher 16 bits of the destination
>> register are undefined.  In practice CR0[31:0] is stored,
>> just like in 64-bit mode, so just remove the "if" that
>> currently differentiates the behavior.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Hi Paolo,
> 
> It seems to be a follow-up to the kvm-unit-tests patch:
> https://patchwork.kernel.org/patch/11590445/

It would be if I had seen that patch! O:-)  I'll add the Reported-by of
course.

Paolo

> Could you please add:
> Reported-by: Roman Bolshakov <r.bolshakov@yadro.com>
> 
>> ---
>>  target/i386/translate.c | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/i386/translate.c b/target/i386/translate.c
>> index 4d808a6f93..60eac03498 100644
>> --- a/target/i386/translate.c
>> +++ b/target/i386/translate.c
>> @@ -7579,12 +7579,13 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
>>          CASE_MODRM_OP(4): /* smsw */
>>              gen_svm_check_intercept(s, pc_start, SVM_EXIT_READ_CR0);
>>              tcg_gen_ld_tl(s->T0, cpu_env, offsetof(CPUX86State, cr[0]));
>> -            if (CODE64(s)) {
>> -                mod = (modrm >> 6) & 3;
>> -                ot = (mod != 3 ? MO_16 : s->dflag);
>> -            } else {
>> -                ot = MO_16;
>> -            }
>> +            /*
>> +             * In 32-bit mode, the higher 16 bits of the destination
>> +             * register are undefined.  In practice CR0[31:0] is stored
>> +             * just like in 64-bit mode.
>> +             */
>> +            mod = (modrm >> 6) & 3;
>> +            ot = (mod != 3 ? MO_16 : s->dflag);
>>              gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
>>              break;
>>          case 0xee: /* rdpkru */
>> -- 
>> 2.26.2
>>
>>
> 
> Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
> 
> Regards,
> Roman
> 


