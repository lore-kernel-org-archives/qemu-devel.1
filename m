Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5A0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 04:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F1B20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 04:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7dEXcBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F1B20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtkmo-0008Js-7t
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 00:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtklu-0007pp-6O
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 00:36:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60122
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtklr-00035J-Gb
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 00:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594355781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=iRs6YcnmO7n7P1tbKY2dMN9bFOjS+xA7Y/N71dp4BL8=;
 b=g7dEXcBEV4oOKY97quOBMOGtdaSHPv/DQRdMXcGf6+qEzomt9eXdxnzyjk0Dy1Ic7Gg0CX
 vIWGtFDOqvpznYbB4EWwQO4mv42/EgCpc3qGq0VCc6gLhTo63tJ13O7yJcpXLwjECFBXSo
 UbXHr1YPgnaCOKGVV8/CVDCvN4KiMl4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-s07HFQRaPlWVzZXRgwipFg-1; Fri, 10 Jul 2020 00:36:17 -0400
X-MC-Unique: s07HFQRaPlWVzZXRgwipFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C479100A61E;
 Fri, 10 Jul 2020 04:36:16 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-68.ams2.redhat.com [10.36.112.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76E3B7880F;
 Fri, 10 Jul 2020 04:36:12 +0000 (UTC)
Subject: Re: [PATCH 3/3] cpu-timers, icount: new modules
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200629093504.3228-1-cfontana@suse.de>
 <20200629093504.3228-4-cfontana@suse.de>
 <aa45a793-35b1-d3bd-18a8-4c52ad888029@redhat.com>
 <f89f249d-dbc4-779b-5b53-fc408461f072@suse.de>
 <ecf5f26b-ce86-3e13-5c5c-567919433acb@redhat.com>
 <e9dca3d1-f52d-13ce-2d7d-66958bc15765@suse.de>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <996dc455-548e-5964-9c87-f4abe5b63907@redhat.com>
Date: Fri, 10 Jul 2020 06:36:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e9dca3d1-f52d-13ce-2d7d-66958bc15765@suse.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:36:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/2020 20.38, Claudio Fontana wrote:
> On 7/8/20 5:05 PM, Paolo Bonzini wrote:
>> On 08/07/20 17:00, Claudio Fontana wrote:
>>>> Bisectable, 100% failure rate, etc. :(  Can you split the patch in
>>>> multiple parts, specifically separating any rename or introducing of
>>>> includes from the final file move?
>>> Hi Paolo,
>>>
>>> will take a look!
>>>
>>> Is this captured by some travis / cirrus-ci / anything I can easily see the result of?
>>>
>>>
>>
>> Nope, unfortunately we don't have an s390 CI.  But if you can get your
>> hands on one, just "./configure --target-list=s390x-softmmu && make &&
>> make check-block" will show it.
> 
> So this is tricky, but I am making some progress after getting my hands on one.
> Maybe if someone understands s390 keys better, I could be clued in.
> 
> In short this goes away if I again set icount to enabled for qtest,
> basically ensuring that --enable-tcg is there and then reenabling icount.
> 
> qtest was forcing icount and shift=0 by creating qemu options, in order to misuse its counter feature,
> instead of using a separate counter.
> 
> Removing that ugliness we end up with different behavior of save/load, because vmstate will now suddenly not contain icount-related values anymore.
> What I do not understand is why this causes a problem because save should just not store the icount state and load should just not load the icount state,
> and why we die on the load of s390 keys state (it works just fine for other architectures).

FYI, the s390 storage keys are just part of the RAM of the machine,
AFAIK they are in no way related to icount. To me it sounds like your
problem is that the migration stream got corrupted elsewhere and is now
just failing in the skey handler by accident.
Is there maybe an endianness bug around somewhere? s390x is one of the
last big endian hosts that is still around...

 Thomas


