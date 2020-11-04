Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF859C388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C16DF223AB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Byn0VWDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16DF223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaH4L-0004lX-Nm
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:35:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaH3W-0004Kq-9O
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:34:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaH3U-0002WO-MC
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604489659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yzEND02fp4ozBAHieOqrD3zBUZ7ps2/LMOEBWQ45jUw=;
 b=Byn0VWDxV35goEEbL0L9PHA+UnKjc1h4D1Vd/HH1d/1XfrlWsfsP1pNc7LaNs4E/ah191g
 ff3pB2zLVnyVGOgjwzZXMt2TEUAxn3pwmw0fbIpfm/v3CK6R9xKEsA4LHtNVomolMZWpYl
 JzD9EU8z8g4L38zwQWq5nZZ5v+tQQn4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-93B91AKoOdagdnnL4UcxPw-1; Wed, 04 Nov 2020 06:34:18 -0500
X-MC-Unique: 93B91AKoOdagdnnL4UcxPw-1
Received: by mail-wr1-f69.google.com with SMTP id q15so9133896wrw.8
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 03:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yzEND02fp4ozBAHieOqrD3zBUZ7ps2/LMOEBWQ45jUw=;
 b=BvXj1tmJcYJ5eo0R0yP+uZ2JW9hnYD+tILiCsTFST/rZdnz+sj823hzRPOEAsy0W8I
 aXjki7T5yTQr/EqN9KvDB5PFt0GHcIWbso/6frQowLG+15TAMcCm4m4/kcTZPRp1tcCu
 tgdp9i8r5FIhAmKfU0d0Uu8llWjU/XH19pyyjV/+Y+oGytk8XQPWYnHYBe9vUQJ0K/ZT
 gNd+6Fgw4B/ZKLfb9y4fLpcVxr5IbAEXgR4WhIMcrVkaLlIfcmJ83gi/8ZuSYccQvVQi
 HOUNXP8XKexs46HqO3dImmLZsapJcCwhdoV2p6jnHyT6vTfMRg7WkvHhwJVZOW3oY2sS
 8R4A==
X-Gm-Message-State: AOAM53115vT+9z4ywD4IvQpsEboqUpcpHB3WJ3rbr87NzFpdcT8Acviu
 7E7yc9kAyABu93WJLX+H/CiisovKyL6ipnqq0YdEQnPK88HqJ/gj44jFeFYSvUuCmvTAa56ZJU5
 oPEa7k7TzLjtmUIk=
X-Received: by 2002:adf:ce12:: with SMTP id p18mr31499749wrn.52.1604489657139; 
 Wed, 04 Nov 2020 03:34:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSqP31bpe5KQUpTv/mBjRSIxW+/5PRdZXTbVQfpXLIkdCBlG+eFDK0QjrWYPNlRcfjcHFp7A==
X-Received: by 2002:adf:ce12:: with SMTP id p18mr31499738wrn.52.1604489656988; 
 Wed, 04 Nov 2020 03:34:16 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id v67sm1832776wma.17.2020.11.04.03.34.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 03:34:16 -0800 (PST)
Subject: Re: [PATCH v2] qapi, qemu-options: make all parsing visitors parse
 boolean options the same
To: Markus Armbruster <armbru@redhat.com>
References: <20201103161339.447118-1-pbonzini@redhat.com>
 <87h7q51smo.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4d4e833b-829d-3a94-98ed-e22180ca372f@redhat.com>
Date: Wed, 4 Nov 2020 12:34:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87h7q51smo.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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

On 04/11/20 08:35, Markus Armbruster wrote:
>> +               "boolean (on/off, yes/no, true/false, y/n)");
> Recommend to have the error message only mention the preferred form.  I
> like the laconic "'on' or 'off'".  It's really all the user needs to
> know.
> 

I went for "boolean (on/off) value".

> 
> Avoiding the full_name() on success isn't hard:
> 
>        if (!qapi_bool_parse(name, str, obj, NULL)) {
>            error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>                       full_name(qiv, name), "'on' or 'off'");
>            return false;
>        }
>        return true;

Can't refuse.

>>
>>      case QEMU_OPT_BOOL:
>> -        return parse_option_bool(opt->name, opt->str, &opt->value.boolean,
>> -                                 errp);
>> +        return qapi_bool_parse(opt->name, opt->str, &opt->value.boolean, errp);
> 
> Please break the line the same way as before.

Why? It's not even 80 characters.

Paolo


