Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DF1C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E809B22251
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYxbE8qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E809B22251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG1Bs-00037v-Pm
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 10:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kG1B5-00021X-7U
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kG1B1-0005qC-Qp
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599662062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fiBidSHD2teJynrkll/l1LbbOlaPccU17167FOmb+8M=;
 b=PYxbE8qwO1en/7wV5gIw2Zr2zVyorxhyaJkqoArnUoHx5zBptFW9brsvVsELHUrrAEtI8/
 e3c1jTdHFKIPoSfbDXpblfWB6BaCv3Je2aVokkMosmNj6AydIzgbK3+HxBVL5W/CKWe4MM
 6JRlVCYSIT68WqRqMMbFTAcEKmvHZCo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-sijGsB15O668edOLzZY-vA-1; Wed, 09 Sep 2020 10:34:20 -0400
X-MC-Unique: sijGsB15O668edOLzZY-vA-1
Received: by mail-ed1-f70.google.com with SMTP id r19so1089022edq.12
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 07:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fiBidSHD2teJynrkll/l1LbbOlaPccU17167FOmb+8M=;
 b=L83y79d3YAnmqbMY/c9Q++p1nqa2P1mROGEovhMePGQEDg2k/m/ZsHTKx6ss0LGsWk
 BVo/FwXlETEMx9/Uiip2WqitnEQdVA15p99rJureLxshy2ediIxpuDgqM8iWRkmagp3V
 TXwzrwA6AqPpoBYs+WXXNW8qX3UYj8mV9aCRzfk840G6zJBhoGImx6iBw3EBONCgNbhy
 eD9sMSHM6XhwzwZWWpP1wAjzOH3/hB6LL7xTMeLR1HFICglAOdcySCuU99vmEKMjBe/5
 FCOM+nd6xM7nrITHTeQwDCCB45hAqWBSKx0gPSQiRLEdHpvQMrVPGV/Cc6GB+lMV1NRL
 NaEA==
X-Gm-Message-State: AOAM531vs5+S7K1NrdPVsFgb1urCiFLxSuQ59Z1Td5LPxyAmFwKUgS8v
 O/EJMrV7dxawDMCtHcZODQlmbo0Pv9RNaQp5ZC0B5hGYyzYw7JyDnJCSis9KUMJYH6BHvuBD9+C
 Ig1tJsCeF0mvOG7w=
X-Received: by 2002:a17:906:a101:: with SMTP id
 t1mr3837177ejy.203.1599662058826; 
 Wed, 09 Sep 2020 07:34:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuKVnREGHqBAYFauMYubmYUS2uWYTQB+7GBxPPHigDueDF0TCBYIPEiSHOiRLscKY0A6rUXg==
X-Received: by 2002:a17:906:a101:: with SMTP id
 t1mr3837160ejy.203.1599662058497; 
 Wed, 09 Sep 2020 07:34:18 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id cw9sm2560874edb.13.2020.09.09.07.34.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 07:34:17 -0700 (PDT)
Subject: Re: Meson can't recover from deletion of generated QAPI file(s)
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <87pn6vw2he.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <233ad355-3803-fb42-a27d-164a3c6a5e7e@redhat.com>
Date: Wed, 9 Sep 2020 16:34:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87pn6vw2he.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 07:20:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/20 14:37, Markus Armbruster wrote:
> Watch this:
> 
>     $ rm qapi/qapi-types-error.h 
>     $ make
>     Generating qemu-version.h with a meson_exe.py custom command
>     Compiling C object qom/libqom.fa.p/object_interfaces.c.o
>     In file included from ../qom/object_interfaces.c:4:
>     /work/armbru/qemu/include/qapi/error.h:275:10: fatal error: qapi/qapi-types-error.h: No such file or directory
>       275 | #include "qapi/qapi-types-error.h"
>           |          ^~~~~~~~~~~~~~~~~~~~~~~~~
>     compilation terminated.
>     make: *** [Makefile.ninja:348: qom/libqom.fa.p/object_interfaces.c.o] Error 1
> 
> To recover, I have to run qapi-gen.py manually and exactly right, or
> blow away the build tree and start over.
> 
> The old build system did what a build system should: it remade the files
> that are missing or out of date.
> 
> I'm still too clueless about Meson to debug this, but I hope I can learn
> from watching you fix it.

Unfortunately you won't learn much about Meson, you would learn that 
Make is messy but you don't need that.  You can also learn a little bit 
about the new design of the QEMU build system though, so I'll explain 
and not just send a patch.

The bad news this tells you about the build system is that, when 
debugging an issue, you have to figure out if it's a bug in Meson,
in the meson.build files, or in ninja2make.  Of course the second
is the common case, but you never know especially now that there are
more people using ninja2make in anger.

Generating Makefile.ninja gets finicky because ninja (while it has other
things I don't like) is a little more expressive than Make as far as
simple build rules are concerned, therefore it doesn't need the stamp
file trick.  So while we there may be one or two more bugs like this one
down the road, ninja2make should not be an issue as soon as its teething
problems are solved.

(As an aside: the GNU Make 4.3 "grouped targets" feature can sometimes
eliminate stamp files, but it would not help here.  The stamp file has
another feature, namely the custom command can decide not to touch
its outputs if they won't change.  This avoid more rebuilds.  Grouped
targets don't have a way to do with that).

The good news is that there's an easy(ish) way to do this.  The build 
system is quite "linear" in how it works, so the first step should be to 
look at build.ninja and see what the rules are like.  Here you'd see
something like:

  build long list of files: CUSTOM_COMMAND actual prerequisites
   COMMAND = ...
   description = Generating$ shared$ QAPI$ source$ files

Your twenty-plus-years-of-writing-Makefiles spidey sense will tingle, as 
you can figure out that this is not going to be trivial to convert to 
Makefiles.  If you open Makefile.ninja you see the familiar stamp file
trick:

  long list of files: CUSTOM_COMMAND@57579de3eef.stamp; @:
  CUSTOM_COMMAND@57579de3eef.stamp: actual prerequisites
	$(ninja-command-restat)

and that's where the bug is.  If you delete one of the output files, Make
only runs ":" and does not rebuild it.  One solution is to add:

  ifneq (long list of files, $(wildcard long list of files))
  .PHONY: CUSTOM_COMMAND@57579de3eef.stamp
  endif

This way, if any of the prerequites is missing (not just older than the 
stamp file), the rule for CUSTOM_COMMAND@57579de3eef.stamp will always 
be executed.

This is fairly simple to do:

diff --git a/scripts/ninjatool.py b/scripts/ninjatool.py
index 627a1cab45..6f0e35c727 100755
--- a/scripts/ninjatool.py
+++ b/scripts/ninjatool.py
@@ -908,6 +908,9 @@ class Ninja2Make(NinjaParserEventsWithVars):
             else:
                 stamp = '%s@%s.stamp' % (rule, sha1_text(targets)[0:11])
             self.print('%s: %s; @:' % (targets, stamp))
+            self.print('ifneq (%s, $(wildcard %s))' % (targets, targets))
+            self.print('.PHONY: %s' % (stamp, ))
+            self.print('endif')
             self.print('%s: %s | %s; ${ninja-command-restat}' % (stamp, inputs, orderonly))
             self.rule_targets[rule].append(stamp)
             self.stamp_targets[rule].append(stamp)

To avoid this whole class of issues we could just use ninja to build QEMU
(Make would launch it, so there would still be no user-facing changes).
ninja2make's main strength was that it supported incremental conversion,
but right now all of the binaries are built by Meson therefore it's not
really *necessary* anymore.  Dropping ninja2make removes a relatively
expensive part of the build as well as a nontrivial amount of code.

Another advantage would be that ninja tracks command lines and automatically
rebuilds things if the command line has changed.  This is quite hard and
expensive to do with Make so ninja2make does not even try, but it has bitten
Philippe.

Of course, the main disadvantage is that it adds another dependency.

I will send the above patch formally soonish, but I wouldn't mind if somebody
else helped merging it.

Paolo


