Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE21C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60AB206A4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/ZbhBmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60AB206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaIFm-0003JJ-Iy
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 07:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaIEe-0002lC-Uv
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:49:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaIEb-0003vp-Mt
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:49:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604494192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yp+VgFBMh63J/vzPVsbplNMHH349Uhkj0fwdoF4CiaM=;
 b=E/ZbhBmxd6+003ikOzAyFAJ0RSX3N1O5g4lSu5zpTF4W6aVBcE/kUMxQjNQK8oaE2eduDB
 X2roB6KlS9Yvx1RKDPGzOGhd7wnhFNffJbQc936Bf9q0sC29+FSnpfoHj/mB17XOYOrR30
 lK8pCuFoDMXVKVvbfd8PjSSsgzXqoMg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-2AeyA-ZANXuYWlV1DyrXZQ-1; Wed, 04 Nov 2020 07:49:51 -0500
X-MC-Unique: 2AeyA-ZANXuYWlV1DyrXZQ-1
Received: by mail-ej1-f70.google.com with SMTP id gt7so3267371ejb.23
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 04:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Yp+VgFBMh63J/vzPVsbplNMHH349Uhkj0fwdoF4CiaM=;
 b=b5/A7mr82OJ+sgOiY7dJ+ZDqgn+7a+71huhoozP0Jl7ph9EH9nU2d2FkaQ/f0oWBIe
 aw38dSYg2SprGia7VONnCHKrByzMa+BT9LCnDHuYv5yG7jkoirkkk7ZxYUpBiGHuIzN4
 eorvn3NCmMvo3wZGT/+c6DzaLoY1ThkEmq/xuNnSgIky45EnwqO/5W8kd49ZZcClMA/d
 9G0Q1n+BvNV8x7FBrQS3J/eoNln/iw8qfOYM3pxwnFMRpjGGp+LSNlIHQXBjLOP07itv
 TYjSEjt6rlidAnP9gqe6kDI4UDTzQfRQp4ofCruIj7mnVu/aLrIKUgUg9b4Zwi+hOwKc
 QHZg==
X-Gm-Message-State: AOAM53109zkz8Sgu6GPE8hgTWa+P7knnvT9vjYDSL6TyaR9oTXbDKbtd
 WuzshYb2ZM2BWNgfWTX5NSkGp/AzyE7of9iGSHqkk/1E4gv7qcQjbHfvZolEfA9DcQpaJ4b3MRS
 STmY4d8F/kO0aFeU=
X-Received: by 2002:aa7:d64b:: with SMTP id v11mr26329570edr.253.1604494189275; 
 Wed, 04 Nov 2020 04:49:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUr2hNrM5c0//56202c6Zu87gO0B4XZJeVmH6lfKpFk03qFfeQF2D1s8sSP92LEDmN7nVwMg==
X-Received: by 2002:aa7:d64b:: with SMTP id v11mr26329555edr.253.1604494189022; 
 Wed, 04 Nov 2020 04:49:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id u14sm1031009edv.6.2020.11.04.04.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 04:49:48 -0800 (PST)
Subject: Re: [PATCH for-5.2 2/4] qemu-option: move help handling to
 get_opt_name_value
To: Markus Armbruster <armbru@redhat.com>
References: <20201103151452.416784-1-pbonzini@redhat.com>
 <20201103151452.416784-3-pbonzini@redhat.com>
 <87blgdz50o.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3eb241f5-955c-f0c1-a132-66de05ee2fec@redhat.com>
Date: Wed, 4 Nov 2020 13:49:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87blgdz50o.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 04/11/20 13:21, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> Right now, help options are parsed normally and then checked
>> specially in opt_validate---but only if coming from
>> qemu_opts_parse or qemu_opts_parse_noisily, not if coming
>> from qemu_opt_set.
>>
>> Instead, move the check from opt_validate to the common workhorses
>> of qemu_opts_parse and qemu_opts_parse_noisily, opts_do_parse and
>> get_opt_name_value.
>>
>> This will come in handy in a subsequent patch, which will
>> raise a warning for "-object memory-backend-ram,share"
>> ("flag" option with no =on/=off part) but not for
>> "-object memory-backend-ram,help".
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> I'm afraid this fails my smoke test:
> 
>      $ o=`sed -n '/HAS_ARG,/s/DEF("\([^"]*\)".*/\1/p' qemu-options.hx`
>      $ for i in $o; do echo "= $i"; upstream-qemu -$i help -version; done 2>&1 | egrep -v 'QEMU emulator|Copyright'
> 
> Many output differences.  False positives due to help printing lists in
> random order.  Arbitrarily picked true positive:
> 
>      $ upstream-qemu -msg help
>      msg options:
>        guest-name=<bool (on/off)> - Prepends guest name for error messages but only if -name guest is set otherwise option is ignored
> 
>        timestamp=<bool (on/off)>
>      $ echo $?
>      1
> 
> regresses to silent failure.

Hmm, indeed. :/  Fortunately the fix is simple:

diff --git a/util/qemu-option.c b/util/qemu-option.c
index fcd1119a5d..5a3c287611 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -947,10 +947,10 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList 
*list, const char *params,
      bool help_wanted = false;

      opts = opts_parse(list, params, permit_abbrev, false, 
&help_wanted, &err);
-    if (err) {
+    if (!opts) {
+        assert(!!err + !!help_wanted == 1);
          if (help_wanted) {
              qemu_opts_print_help(list, true);
-            error_free(err);
          } else {
              error_report_err(err);
          }


I've queued 1 and 3 since they were reviewed already and are fixes for 
tests.  I'll run these two through the whole CI and repost.

Paolo


