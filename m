Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874C3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4978D206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 10:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8CZb7EV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4978D206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZXSq-0002FZ-GK
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 06:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jZXRc-0000xI-CN
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:19:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57505
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jZXRX-0003oQ-5T
 for qemu-devel@nongnu.org; Fri, 15 May 2020 06:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589537987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PMdj3LbWPHy5RZNzGbB8v2dJn+w2xsNtqytsLpv7AHE=;
 b=d8CZb7EVckHw48QYzQWlbxQZc8XXoVvhT/nQFpXc9rnj+5yDTdDY2clyv1ETZvxDV9MHAQ
 jqHbgWSDC7Xw779b8gDfc9oNqVS+UBsquiOhEdmHoo1YmWv0QotvI1KkjOc6Bob9n7Saji
 ndb1V1lLqOCxnU3ar88yYdl+Da+jfOw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-QBRE3m0uPMGtzpgM_SMbvg-1; Fri, 15 May 2020 06:19:46 -0400
X-MC-Unique: QBRE3m0uPMGtzpgM_SMbvg-1
Received: by mail-wm1-f72.google.com with SMTP id n66so963294wme.4
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 03:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PMdj3LbWPHy5RZNzGbB8v2dJn+w2xsNtqytsLpv7AHE=;
 b=HhCEEiPWfQjnWQCmLUj64aWA89gQbkcVTcboR/0IW99RAnSqC1d3bOm7OyDo2GoyHl
 s4UL1JLKgW2B8HRHakKNAuHrod0VJIYoDAGGjFD9P9X3XQoWVpCYBLeAXljW7R2ri7hr
 rZyYSnQ6nXX5RwhDWYhQVhpczkV3L7rFPnE3lXrhouIyH6q+Ts0eRFGIedUf6XzCj1So
 +TbmD2HWF16+cTsaz/+LZtpvpwk/zbXKycpF6xQjBZ9JjZOib0EF8K3WBNsHtzm+RUnj
 PzRA6N8mzX8oTXpGIehnuTEJyWj4ciiu6jUcOifwAkcPeUUsOoNO/kyeDXEQA6W/+Oql
 YSPw==
X-Gm-Message-State: AOAM531D4ESdjpCkeE8+2UfHp+aDmbMG/YGoQaa7nbX+m4FE/y4Int+Y
 lLXs9wlhrMzDOAEmNiZgaDdd2zkKs4mLZ5W1DiNm7Pu/T7rh66p19BWPaX9yUzPUklQUkHyU7Wh
 IGYhp0jmgqMIk0ME=
X-Received: by 2002:a1c:1f16:: with SMTP id f22mr3197440wmf.46.1589537985050; 
 Fri, 15 May 2020 03:19:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwK7L+zii0hhGbtXOTGgO4kyfTPg/GrxhNUsfNqUpx1TUHl+S70sAAfbFfXjR2PGFGIr0jqKA==
X-Received: by 2002:a1c:1f16:: with SMTP id f22mr3197404wmf.46.1589537984630; 
 Fri, 15 May 2020 03:19:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:60bb:f5bd:83ff:ec47?
 ([2001:b07:6468:f312:60bb:f5bd:83ff:ec47])
 by smtp.gmail.com with ESMTPSA id t4sm3427522wri.54.2020.05.15.03.19.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 03:19:44 -0700 (PDT)
Subject: Re: proposal: deprecate -readconfig/-writeconfig
To: Markus Armbruster <armbru@redhat.com>
References: <7599153e-89a2-9a86-16ad-4a3c6a107b18@redhat.com>
 <20200514085622.GB1280939@redhat.com>
 <1287b3b8-9fd0-04d5-1dd2-66b695dace5d@redhat.com>
 <877dxdspyk.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <70499ef0-83a2-b7f2-f69c-fbb3760cf27d@redhat.com>
Date: Fri, 15 May 2020 12:19:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <877dxdspyk.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/05/20 07:54, Markus Armbruster wrote:
>> I don't see QemuOpts going away anytime soon, but I do see more QMP/QAPI
>> and less command line in the future as far as management tools are
>> concerned.  QemuOpts and HMP will remain for direct usage, for the
>> foreseeable future.
> 
> I'd prefer not to have two separate configuration infrastructures.

We already have two, since the introduction of preconfig state.  The
question is more how to unify the code that implements them, than how to
reduce them to one.

For example, I can imagine (and have even discussed informally with John
Snow) a patch series that starts by adding a new preconfig command:

{ 'execute': 'set-argv', 'arguments': { 'argv': [ '-m', '2048'] } }

and progressively adds more preconfig commands until Libvirt can
reasonably configure a VM without set-argv.

An example implementation would be to special case chardev-add,
object-add etc. to stash their arguments in a QAPI struct in preconfig
mode, and the same for -chardev and -object.  Then the big ugly setup
code in main() would walk these structs instead of QemuOpts.  Bingo: you
have a QAPI-representable machine config.  It may not be the nicest one
(see the problems you raised in the past about chardev-add not using the
latest and greatest QAPI features) but I would love to see a proof of
concept for this.

Thanks,

Paolo


