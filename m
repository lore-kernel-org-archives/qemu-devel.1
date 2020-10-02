Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BB2C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:32:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1579C20795
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcoXHR25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1579C20795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOOur-00070a-1C
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOOt0-0005wW-Kj
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:30:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kOOsx-0002dn-FU
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601659822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P0R+dDcKewz/RfI4pF+8L26Vm/BbkyD3KIQDYj2FuZ8=;
 b=PcoXHR25gZB5oV5llz+Nt7omLBfhntccu678CbnsTpONTq8Md4oGuAZQSmbVh5kX8ubmOk
 PbyQ5NUMsIEkrZ+vzQ6t0U2bn5YbruR1NPBgVQXKO2j9UaYWo8o8K2xOsnNh/eBzfF9qVK
 xrMMCto79BilkA88MvCvSyzzzlcTJ7w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-aU_ZHFokN-edQGlkm3z6og-1; Fri, 02 Oct 2020 13:30:20 -0400
X-MC-Unique: aU_ZHFokN-edQGlkm3z6og-1
Received: by mail-wm1-f70.google.com with SMTP id l26so645456wmg.7
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 10:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P0R+dDcKewz/RfI4pF+8L26Vm/BbkyD3KIQDYj2FuZ8=;
 b=VATTorKvSnSxTLOtlsc2DQmboupMf9Gm507OZL9FaNScaqN4L4tQh+p+PWJ7DUZleO
 DaOoOIkdsS6sP7+vV57aD0A5SD/WL4zkNElh3hhsa0zLQ3Nq0jn7l9WGscBOQiT1QDlA
 61JrlnWlAyo4EwfKEqcy88yw/uaHyET/+ZUddbUJpVFeJoNpFPtRf76nJe/vHnwPk2H2
 hAXyxCB3B1k4oaK40FJilXnPBZLTQdiysUYLfTHcRUt0OTwf7Qp36ZIdm6P3bgdXnF7U
 On0KKLDGML8/o2K8XnmxSDst0m6jZKkcy4Uc9N2ABKzgrSP2LDBG0JDEJaxx7g5J+c4j
 WCqQ==
X-Gm-Message-State: AOAM53093Ie11Nwm5KLkoAoguKoW0AD3FJoCd9hIbD2nbETw89UalLmn
 iiZTMaSuhoquMYVO5QAIXIF+5uc1ZEZydih7wZycEMrbQlftqeol9Mz34avlWWGK8VvwELJpSm2
 O71Gw9wZWHmSzcKA=
X-Received: by 2002:a1c:7c01:: with SMTP id x1mr3876199wmc.57.1601659819093;
 Fri, 02 Oct 2020 10:30:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBPE5gT4OpxC4Z+uKFMbpNK5KAA3HFoLZgwCrk8mqRpn+IvZo3B5A70EPbmmGXrwMm+qDDxg==
X-Received: by 2002:a1c:7c01:: with SMTP id x1mr3876182wmc.57.1601659818811;
 Fri, 02 Oct 2020 10:30:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:47e0:e742:75ba:b84d?
 ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id r14sm2573469wrn.56.2020.10.02.10.30.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 10:30:18 -0700 (PDT)
Subject: Re: [PULL v8 00/86] Misc QEMU patches for 2020-09-24
To: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200930195850.278104-1-pbonzini@redhat.com>
 <a0b8e23a-cccb-3c5d-dbf7-f489c0d95f93@redhat.com>
 <20201002162208.GB7303@habkost.net>
 <a793e75b-47f2-5120-24cd-c50a6a45d04b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1a98babe-f6b9-fa73-24ca-07ecbf395225@redhat.com>
Date: Fri, 2 Oct 2020 19:30:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a793e75b-47f2-5120-24cd-c50a6a45d04b@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/20 19:26, Michal Prívozník wrote:
> On 10/2/20 6:22 PM, Eduardo Habkost wrote:
>> On Fri, Oct 02, 2020 at 05:58:55PM +0200, Michal Prívozník wrote:
>>> On 9/30/20 9:58 PM, Paolo Bonzini wrote:
>>>>
>>>> Eduardo Habkost (10):
>>> <snip/>
>>>>         docs: Create docs/devel/qom.rst
>>>
>>> cd442a45db60a1a72fcf980c24bd1227f13f8a87 is the first bad commit
>>>
>>> Sorry for noticing this earlier, but is this known? The build starts
>>> failing
>>> for me after this commit:
>>>
>>> /usr/bin/sphinx-build -Dversion=5.1.50 -Drelease= -W
>>> -Ddepfile=docs/devel.d
>>> -Ddepfile_stamp=docs/devel.stamp -b html -d
>>> /home/zippy/work/qemu/qemu.git/build/docs/devel.p
>>> /home/zippy/work/qemu/qemu.git/docs/devel
>>> /home/zippy/work/qemu/qemu.git/build/docs/devel
>>> Running Sphinx v3.2.1
>>> building [mo]: targets for 0 po files that are out of date
>>> building [html]: targets for 20 source files that are out of date
>>> updating environment: [new config] 20 added, 0 changed, 0 removed
>>> reading sources... [100%] testing
>>>
>>>
>>>
>>>
>>> Warning, treated as error:
>>> /home/zippy/work/qemu/qemu.git/docs/../include/qom/object.h:747:Error in
>>> declarator
>>> If declarator-id with parameters (e.g., 'void f(int arg)'):
>>>    Invalid C declaration: Expected identifier in nested name. [error
>>> at 24]
>>>      object_initialize_child ( parent,  propname,  child,  type)
>>>      ------------------------^
>>> If parenthesis in noptr-declarator (e.g., 'void (*f(int arg))(double)'):
>>>    Error in declarator or parameters
>>>    Invalid C declaration: Expecting "(" in parameters. [error at 32]
>>>      object_initialize_child ( parent,  propname,  child,  type)
>>>      --------------------------------^
>>>
>>> make[1]: *** [Makefile.ninja:9898: docs/devel.stamp] Error 2
>>> make[1]: *** Deleting file 'docs/devel.stamp'
>>> make[1]: Leaving directory '/home/zippy/work/qemu/qemu.git/build'
>>> make: *** [GNUmakefile:11: all] Error 2
>>
>> I can't reproduce it using Sphinx v2.2.2.  I'm still trying to
>> understand what exactly the error means.
>>
> 
> Same here.
> 
>> I really wish we used virtualenv + requirements.txt to require a
>> specific version of Sphinx instead of wasting time dealing a wide
>> range of Sphinx versions.
>>
> 
> I already have a patch that I keep locally to build with v3:
> 
> diff --git a/docs/qemu-option-trace.rst.inc
> b/docs/qemu-option-trace.rst.inc
> index 7e09773a9c..ae83f6a1a8 100644
> --- a/docs/qemu-option-trace.rst.inc
> +++ b/docs/qemu-option-trace.rst.inc
> @@ -1,7 +1,7 @@
> 
>  Specify tracing options.
> 
> -.. option:: [enable=]PATTERN
> +.. option:: enable=PATTERN
> 
>    Immediately enable events matching *PATTERN*
>    (either event name or a globbing pattern).  This option is only
> 
> 
> That said, I'm not objecting to requiring v2 for now and switching to v3
> later.
> 
> 
> But interestingly, through trial and error I've came across this hack,
> which allows me to build again. I have no idea why it works:
> 
> diff --git i/include/qom/object.h w/include/qom/object.h
> index 27aaa67e63..59c729ebb7 100644
> --- i/include/qom/object.h
> +++ w/include/qom/object.h
> @@ -762,13 +762,14 @@ bool object_initialize_child_with_propsv(Object
> *parentobj,
>   *                                      child, sizeof(*child), type,
>   *                                      &error_abort, NULL)
>   */
> -#define object_initialize_child(parent, propname, child, type)          \
> -    object_initialize_child_internal((parent), (propname),              \
> -                                     (child), sizeof(*(child)), (type))
>  void object_initialize_child_internal(Object *parent, const char
> *propname,
>                                        void *child, size_t size,
>                                        const char *type);
> 
> +#define object_initialize_child(parent, propname, child, type)          \
> +    object_initialize_child_internal((parent), (propname),              \
> +                                     (child), sizeof(*(child)), (type))
> +

The error is due to kerneldoc treating the macro definition like a
function, so that makes sense.  If the docs look good (no reference to
object_initialize_child_internal) then the patch can be applied.

Paolo


