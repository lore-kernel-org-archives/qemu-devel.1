Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6689DC388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 19:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C512E206D8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 19:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3iJUGG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C512E206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcDAV-00072r-Qp
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 14:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kcD8h-0005fK-V4
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 14:47:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kcD8f-0001xZ-FM
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 14:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604951260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SP03MbaQjLSCHBSLuF/xfRQVOPSgpOLou6jE0S3hBjY=;
 b=M3iJUGG8Xov6c/OnGWumlRxsq6NSoNczsBypbKEdf0ICB1uNgpD9P1mDL47hV79NLMsuLJ
 GOTNSo9Nbg60AW9mZvcX5CnspvOLt7hXvlsCGzekAP8S7FxkPubmNdb4Knw5LRveT+aNfa
 eTBJ/9eR9fTsWFXA2KXaAQg/uOZv7RA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-yte1DuVSMHq-Lb18S5OOKw-1; Mon, 09 Nov 2020 14:47:39 -0500
X-MC-Unique: yte1DuVSMHq-Lb18S5OOKw-1
Received: by mail-wr1-f70.google.com with SMTP id x16so4709844wrg.7
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 11:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SP03MbaQjLSCHBSLuF/xfRQVOPSgpOLou6jE0S3hBjY=;
 b=it+YFng3v98Ua0CT7c/CvxzGw3A7j+Xg/10wvYQ3xFmRejfOtQyLh9jpvLUc1OkjpA
 awBd2rFZqXSxzroxmMjUGopwuiEHcL3nQNncCd16M1nm5NvttrWzoq0Gu0ylSFi7WzmJ
 VWsp7LJszp6htmp3QV+AmuI6V4dwKzF45skodF5CpQIUkwt+6XRO6UeaIMFQkqVOW8LC
 HpJoavX8hMUkVYIvk4YJqlR4hE0+utCIfzLfE+LMND9KKhTjeq2aZL27qkXKpQCnJz1w
 QlmYsXwOZ+LvqCGpdvnxyzUzsTOkeVoH1zXQEgyBJatRz2lO2hI/IHkFcWpD6nJAIr0l
 XOIg==
X-Gm-Message-State: AOAM532lNXHxlSgQE1c8OvnLTkzGnpGnGCCZk95WEo0cSyTJxi+EFKyD
 pm+DEl2KkzpFXwmERLxubDjHkcs+cjZXAMghC4RZofMe1nnUQh/X/S+XIdVFgjgPIw+5yWTC4ik
 UvLj4d0jtSO7+Oac=
X-Received: by 2002:a5d:4104:: with SMTP id l4mr19336261wrp.276.1604951257615; 
 Mon, 09 Nov 2020 11:47:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxH7E1hJ3qB4mgJfKgc2HFziDSPgoEvT/wabH8UUjaZz94P8yaQsaDn/9hHC1SwShWDAnAOKQ==
X-Received: by 2002:a5d:4104:: with SMTP id l4mr19336245wrp.276.1604951257399; 
 Mon, 09 Nov 2020 11:47:37 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id y185sm464884wmb.29.2020.11.09.11.47.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 11:47:36 -0800 (PST)
Subject: Re: [PATCH v2 5/6] qemu-option: move help handling to
 get_opt_name_value
To: Markus Armbruster <armbru@redhat.com>
References: <20201109133931.979563-1-pbonzini@redhat.com>
 <20201109133931.979563-6-pbonzini@redhat.com>
 <87lffa2uao.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c4b0281b-977d-031a-eac1-a47e7780805a@redhat.com>
Date: Mon, 9 Nov 2020 20:47:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87lffa2uao.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/20 20:40, Markus Armbruster wrote:
>>
>> +        p = get_opt_name_value(p, firstname, help_wanted, &option, &value);
>> +        if (help_wanted && *help_wanted) {
>> +            return false;
> 
> Doesn't this leak @option and @value?  Remember, [2]
> get_opt_name_value() always sets *name and *value.

Yes, it does. :(

>>           if (help_wanted) {
>>               qemu_opts_print_help(list, true);
>> -            error_free(err);
>>           } else {
>>               error_report_err(err);
>>           }
> I think we could pass &help_wanted unconditionally, then ignore the
> value of help_wanted if opts_accepts_any().
> 

Unfortunately not, because callers rely on "help" being added to the 
options for !opts_accepts_any.  opts_do_parse however does:

> +        if (help_wanted && *help_wanted) {
> +            return false;
> +        }

You made the same remark on the previous version, but unfortunately I 
couldn't make it actually produce simpler code.

Paolo


