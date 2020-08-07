Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD59C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1242822CAE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hC1ETc2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1242822CAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3xxq-0001Gb-DB
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3xxD-0000qI-DL
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:42:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36191
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k3xxB-0005aW-Io
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596789736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FTVyNukig9LglrQp7DeT/KKAK6d3IX5PLERy/fWum4U=;
 b=hC1ETc2Rfmx1gaDa2knW9qmX576jNOCn/x2soG8WLRzzkqbwm4p/vQVaRz4+Lmg/5bHbh/
 esoBzTBwj8sHtG2Pzi4g64KdEuQA9xAOu/NR/ZDnI1Mq8MIdmjJTPBgZ330oGdOEvQeN22
 DyeC0R/v0O730FNWB3aTvBcwAg6sQDM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-1uAlRBsmMnCU2-yLgmDXog-1; Fri, 07 Aug 2020 04:42:14 -0400
X-MC-Unique: 1uAlRBsmMnCU2-yLgmDXog-1
Received: by mail-wr1-f72.google.com with SMTP id w7so465322wre.11
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 01:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=FTVyNukig9LglrQp7DeT/KKAK6d3IX5PLERy/fWum4U=;
 b=Evrnr/hyRWnWKoZWyMkyYGas8/WLpQBu788DD9cMOO8gelO2g8ByZ2kSZoaiTRSawh
 7VAWZQPkPNneNed8FXsGueLoy7M6giioHX69vsIgb9BnBTSzHc3tLvgQHO9Ru4zb2As2
 +N0YHywvGuE1alYApARZkf5gkknhsw6ye+rgyRLya1NuOtbCQq3av9oWhGqV3uS/GDBO
 C8u2UJirWyyeJa8u7OdaaRJjHFttpSRSTKFPENWoflpJfyGA7EvVou61bBneu70hIOA7
 WOfnDuCRM93beaqxj8dfcPqkijR6MWL1/rD0+VdPDcyAFI7Rv5vFOA7Goo7iVCKXt2Z7
 OH+w==
X-Gm-Message-State: AOAM53221a8QdwBqruPPujdMkouHwKNAiq5RilaZp1kbpxn6D1za9DW4
 YPz/xiiawZVv/4Qx9L19rplS+Bh8piLflXbZVI6B+WHEKOJDzrdwYBM2E1/PE+fNOjqeehhnKUe
 X/AhCOaYe+zU5L+w=
X-Received: by 2002:a5d:460c:: with SMTP id t12mr11559916wrq.334.1596789732779; 
 Fri, 07 Aug 2020 01:42:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOTWs65hywMpMMaTN+4qaNbAcVI6R7FEeHaVMFloEZIy2ZmbgG7rk411h5sDLbx49KXoNKEg==
X-Received: by 2002:a5d:460c:: with SMTP id t12mr11559898wrq.334.1596789732545; 
 Fri, 07 Aug 2020 01:42:12 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id k184sm9508736wme.1.2020.08.07.01.42.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 01:42:11 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <87364y28jp.fsf@dusky.pond.sub.org> <20200807082206.GC120942@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <a656d6e2-f3ff-4094-4d88-243175a6acb0@redhat.com>
Date: Fri, 7 Aug 2020 10:42:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200807082206.GC120942@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/20 10:22 AM, Daniel P. Berrangé wrote:
> On Fri, Aug 07, 2020 at 09:56:42AM +0200, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>>> This the more or less final version of the Meson conversion.  Due to
>>> the sheer size of the series you have been CCed only on the cover
>>> letter.
>>
>> Perfect timing: right before I drop off for two weeks of vacation.  I'm
>> excused!  *Maniacal laughter*
>>
>>> The series reaches the point where Makefile.target and unnest-vars
>>> can be removed, and all builds become non-recursive.  I have also
>>> converted parts of the testsuite, notably qtest since it is needed
>>> for fuzzing.  What's left for _after_ the merge is: 1) unit tests;
>>> 2) moving the rest of installation to meson (for which I have patches);
>>> 3) moving feature detection from configure to meson.
>>>
>>> Things I still haven't tested:
>>> - fuzzing
>>> - non-x86/Linux builds
>>> - static builds
>>> - Docker and VM builds
>>>
>>> Things I have checked:
>>> - x86 builds
>>> - modules
>>> - "make install"
>>> - internal slirp/dtc/capstone.
>>
>> Have you run it through our CI?
>>
>>> It should be more or less bisectable.  I have not tried building
>>> _all_ steps, but I have tried both before and after each major one.
>>>
>>> Build system rebuild rules seem to work reliably.
>>
>> Is it faster in common build scenarios?
>>
>>> After a week or quite intense rebasing, my impression is more or less
>>> the same as last December: Meson looks more daunting, but it is actually
>>> much nicer to work with.
>>
>> Not a particularly high bar to cross: our Makefiles are full of the kind
>> of black magic that keeps simple things simple (which is quite an
>> achievement; kudos!), and makes not-so-simple things really hard.
>>
>> I think it's now time to plan the end game, preferably without even more
>> weeks of intense rebasing.
>>
>> Do we have consensus to move forward with Meson?  If yes, I'd like to
>> propose to aim for merging as early as practical in the 5.2 cycle.
>> Rationale: rebasing build system changes on top of the Meson work is
>> probably easier than rebasing the Meson work, and avoids turning Paolo
>> into an overworked bottleneck.

Any merge request not changing buildsys (configure/Makefile), adding new
(or moving) .c files shouldn't be a problem.

I have that feeling that Meson will have less bottleneck problem than
our Perl scripts =)

>>
>> In more detail:
>>
>> 1. Pick a tentative deadline.
> 
> I'd suggest we need a bare minimum of half a development cycle to.
> So if we want it tin 5.2, we need to make a strong push now and over
> next month to review it and iron out any obvious blocking testing
> problems.
> 
>> 2. Cover the testing gaps and get as much review as we can until then.
>>    Fix defects as we go.
> 
> In terms of testing I'd suggest the minimium bar is likely the GitLab CI
> and Peter's merge scripts.
> 
> Anything beyond that is just nice to have.
> 
>> 3. If the known defects are expected to disrupt others too much, goto 1.
>>    Do not worry about unknown defects at this point.
>>
>> 4. Merge.
>>
>> 5. Deal with the fallout.
> 
> Yep, there's no substitute for getting it used for real by a wide
> range of people, which is why we we need leave ourselves at min
> 1/2 a dev cycle for this.

Just to clarify, does the "dev cycle" include the freeze window?

QEMU produces a release every 17 weeks, the dev cycle is usually 12
weeks then we have 4 (+1) weeks of stabilization for the release.

So the plan is to get this merged approximately 6 weeks after the
next release, right?

Regards,

Phil.

> 
> 
> Regards,
> Daniel
> 


