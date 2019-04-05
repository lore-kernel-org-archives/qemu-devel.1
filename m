Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8844C282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 17:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99553206C0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 17:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99553206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44727 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCSL3-0006hg-MS
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 13:09:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hCSKE-0006Nj-5A
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 13:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1hCSKC-0002Hm-QO
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 13:08:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1hCSJl-0001BY-Py
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 13:08:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so8864425wrn.6
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 10:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
	:message-id:mime-version;
	bh=h2UA9Yb2cV6n17uspy5nTZw5GOspJJMclHKO8KQDQc0=;
	b=T5KRtgIYFjFNuKxLkgdjnHWlwNKc0IVCmwtZrVY57xNc+ivf4Nd1O0e/M/bExhnPOB
	SVClNQ0c0JXOa08KKf0c3N5dhcoUJK8VJAXQfHJJGQTRBP8RzZYt9iv45ogiyC6PVgve
	l4xgpgsilz0etaPD37DD+dRsgOiz78Uf1znv7eLMf19QRapihGf6kUFZXdPrGX+7WORy
	99H/kLUzi03kF2BeRmZf7NLwawqE4UWWtKmShvOq8rziKqLjoNv57Wgth37faAMQivAY
	3KSl4LMUCDygHvQwpKA5+54+lopLd8BWnDmwIr//uqHsyfD80o1U01tYVM5nKJ+piVij
	ycNw==
X-Gm-Message-State: APjAAAV34vF9VA6xv2lcsYn1MB6z//SN0M5W3uiUGQPaGM2CGHKJYUFW
	k90lFK6dodzETJHlrou0BZQe6A==
X-Google-Smtp-Source: APXvYqynAx3NM4VYT94Ooft5yh5Mr+TtInKTFSS7khrccuSrrVRZC/4EZQBKWhD/o3AvVzHHFUZKNw==
X-Received: by 2002:a5d:400c:: with SMTP id n12mr8891796wrp.31.1554483604634; 
	Fri, 05 Apr 2019 10:00:04 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
	[213.175.37.10]) by smtp.gmail.com with ESMTPSA id
	y9sm38039197wrn.18.2019.04.05.10.00.03
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 10:00:03 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>
In-Reply-To: <20190405150659.GC20411@rkaganb.sw.ru>
References: <20190329141832.22882-1-vkuznets@redhat.com>
	<20190329141832.22882-5-vkuznets@redhat.com>
	<20190405150659.GC20411@rkaganb.sw.ru>
Date: Fri, 05 Apr 2019 19:00:02 +0200
Message-ID: <87pnq0ie0d.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 4/8] i386/kvm: implement 'hv-all'
 pass-through mode
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405170002.teH20kgc7i37kFuvvam_wA8gdW3jElihQ1tW7jPQDEA@z>

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Fri, Mar 29, 2019 at 03:18:28PM +0100, Vitaly Kuznetsov wrote:
>> In many case we just want to give Windows guests all currently supported
>> Hyper-V enlightenments and that's where this new mode may come handy. We
>> pass through what was returned by KVM_GET_SUPPORTED_HV_CPUID.
>
> The only one out of those "many cases" I can think of is when you've
> developed a new hyperv feature in the kernel and you want to test it
> with a version of QEMU that's not aware of it.  Are there any others?
>

I can recall the following case I had: benchmark Windows guest
performance with different kernels like try to get the best number. As
these kernels were supporting different set of hv-* enlightenments I had
to do non-trivial work to figure out what's supported and adjust QEMU
command line accordingly.

Would've been much easier with 'hv-all'

>> 
>> hv_cpuid_check_and_set() is modified to also set cpu->hyperv_* flags as
>> we may want to check them later (and we actually do for hv_runtime,
>> hv_synic,...).
>> 
>> 'hv-all' is a development only feature, a migration blocker is added to
>> prevent issues while migrating between hosts with different feature sets.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  docs/hyperv.txt   |  10 ++++
>>  target/i386/cpu.c |   1 +
>>  target/i386/cpu.h |   1 +
>>  target/i386/kvm.c | 148 +++++++++++++++++++++++++++++++++++++---------
>>  4 files changed, 132 insertions(+), 28 deletions(-)
>> 
>> diff --git a/docs/hyperv.txt b/docs/hyperv.txt
>> index 397f2517b8..d1299aba81 100644
>> --- a/docs/hyperv.txt
>> +++ b/docs/hyperv.txt
>> @@ -174,6 +174,16 @@ without the feature to find out if enabling it is beneficial.
>>  Requires: hv-vapic
>>  
>>  
>> +4. Development features
>> +========================
>> +In some cases (e.g. during development) it may make sense to use QEMU in
>> +'pass-through' mode and give Windows guests all enlightenments currently
>> +supported by KVM. This pass-through mode is enabled by "hv-all" CPU flag.
>> +Note: enabling this flag effectively prevents migration as supported features
>> +may differ between target and destination.
>
> I find 'hv-passthrough' a more adequate name for this.

Sure, will adjust.

>
>> +Note: "hv-all" doesn't include 'hv-evmcs', it needs to be enabled explicitly.
>
> This is extremely confusing, when some features are more equal than
> others.  I think it'd make more sense instead to support filtering out
> some features, like in "hv-passthrough,hv-evmcs=off".

hv-evmcs is probably the only enlightenment which is not an obvious
'win': when enabled, some features (e.g. posted interrupts) are getting
disabled. But as 'hv-all' is now a developer-only feature I see no
problem with enabling evmcs too.

-- 
Vitaly

