Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB437C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:14:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A47E21941
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLrgefKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A47E21941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJbU-00080i-AR
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kGJYj-0003jc-VE
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:12:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28610
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kGJYh-0008Px-Iv
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599732722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ma7q1simR2rynLoRew9FwTp/KAFJ6ksUqQ5XP2CSOq0=;
 b=XLrgefKIQTablJDmXWefPMfYPUfVQ6TbE6ZixFwRV/IMJiigsBACStn8CBdh7C/BHuDYtV
 pSvVdaJhtM8Vi3dPrwEivs/Tq+rROlY2CFIZAXVZZ2wyzFGsqo+F8Fdw1k22nBZM4wNqOh
 21bndo+V+9IOxIOhLtv2N32PWGjMSws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-uJvZyDXzOhudDSsKvdVMnw-1; Thu, 10 Sep 2020 06:11:51 -0400
X-MC-Unique: uJvZyDXzOhudDSsKvdVMnw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FF94189E60A
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 10:11:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 819BE702E7;
 Thu, 10 Sep 2020 10:11:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 93D64113865F; Thu, 10 Sep 2020 09:44:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Meson can't recover from deletion of generated QAPI file(s)
References: <87pn6vw2he.fsf@dusky.pond.sub.org>
 <233ad355-3803-fb42-a27d-164a3c6a5e7e@redhat.com>
Date: Thu, 10 Sep 2020 09:44:54 +0200
In-Reply-To: <233ad355-3803-fb42-a27d-164a3c6a5e7e@redhat.com> (Paolo
 Bonzini's message of "Wed, 9 Sep 2020 16:34:22 +0200")
Message-ID: <87k0x2qdmx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 00:49:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 09/09/20 14:37, Markus Armbruster wrote:
>> Watch this:
>> 
>>     $ rm qapi/qapi-types-error.h 
>>     $ make
>>     Generating qemu-version.h with a meson_exe.py custom command
>>     Compiling C object qom/libqom.fa.p/object_interfaces.c.o
>>     In file included from ../qom/object_interfaces.c:4:
>>     /work/armbru/qemu/include/qapi/error.h:275:10: fatal error: qapi/qapi-types-error.h: No such file or directory
>>       275 | #include "qapi/qapi-types-error.h"
>>           |          ^~~~~~~~~~~~~~~~~~~~~~~~~
>>     compilation terminated.
>>     make: *** [Makefile.ninja:348: qom/libqom.fa.p/object_interfaces.c.o] Error 1
>> 
>> To recover, I have to run qapi-gen.py manually and exactly right, or
>> blow away the build tree and start over.
>> 
>> The old build system did what a build system should: it remade the files
>> that are missing or out of date.
>> 
>> I'm still too clueless about Meson to debug this, but I hope I can learn
>> from watching you fix it.
>
> Unfortunately you won't learn much about Meson, you would learn that 
> Make is messy but you don't need that.  You can also learn a little bit 
> about the new design of the QEMU build system though, so I'll explain 
> and not just send a patch.

Appreciated!

> The bad news this tells you about the build system is that, when 
> debugging an issue, you have to figure out if it's a bug in Meson,
> in the meson.build files, or in ninja2make.  Of course the second
> is the common case, but you never know especially now that there are
> more people using ninja2make in anger.
>
> Generating Makefile.ninja gets finicky because ninja (while it has other
> things I don't like) is a little more expressive than Make as far as
> simple build rules are concerned, therefore it doesn't need the stamp
> file trick.  So while we there may be one or two more bugs like this one
> down the road, ninja2make should not be an issue as soon as its teething
> problems are solved.

A Make replacement must address its issues to be credible.

Make's traditional inability to directly express "rule updates multiple
files" and "rule may or may not actually change its target(s)" has
always been an issue.  Countless Make users have had to learn the stamp
file work-around, and how to cope with its drawbacks.  I distinctly
remember grappling with it back in the 90s.

> (As an aside: the GNU Make 4.3 "grouped targets" feature can sometimes
> eliminate stamp files, but it would not help here.  The stamp file has
> another feature, namely the custom command can decide not to touch
> its outputs if they won't change.  This avoid more rebuilds.

This is *essential* when generating headers.  Without it, touching any
QAPI module or any part of the QAPI generator recompiles pretty much
everything.

>                                                               Grouped
> targets don't have a way to do with that).

Yes.  Also, TIL grouped targets :)

> The good news is that there's an easy(ish) way to do this.  The build 
> system is quite "linear" in how it works, so the first step should be to 
> look at build.ninja and see what the rules are like.  Here you'd see
> something like:
>
>   build long list of files: CUSTOM_COMMAND actual prerequisites
>    COMMAND = ...
>    description = Generating$ shared$ QAPI$ source$ files
>
> Your twenty-plus-years-of-writing-Makefiles spidey sense will tingle, as 
> you can figure out that this is not going to be trivial to convert to 
> Makefiles.  If you open Makefile.ninja you see the familiar stamp file
> trick:
>
>   long list of files: CUSTOM_COMMAND@57579de3eef.stamp; @:
>   CUSTOM_COMMAND@57579de3eef.stamp: actual prerequisites
> 	$(ninja-command-restat)
>
> and that's where the bug is.  If you delete one of the output files, Make
> only runs ":" and does not rebuild it.  One solution is to add:
>
>   ifneq (long list of files, $(wildcard long list of files))
>   .PHONY: CUSTOM_COMMAND@57579de3eef.stamp
>   endif
>
> This way, if any of the prerequites is missing (not just older than the 
> stamp file), the rule for CUSTOM_COMMAND@57579de3eef.stamp will always 
> be executed.

Neat trick!

Now I remember the old Makefiles actually didn't recover all by
themselves either, because they didn't use this trick.  Manual recovery
was "easy", though: remove the stamp file.

I ran into the "can't recover from deletion of generated QAPI file(s)"
issue when I updated a silly script of mine that helps me diff them.  To
force regeneration, the script removes them (relying on ccache to keep
compilation time in check).  Pre-Meson, it removed the stamp files.  I
didn't see any in meson.build, so I dropped their removal, nothing
worked, and I got quite confused.

> This is fairly simple to do:
>
> diff --git a/scripts/ninjatool.py b/scripts/ninjatool.py
> index 627a1cab45..6f0e35c727 100755
> --- a/scripts/ninjatool.py
> +++ b/scripts/ninjatool.py
> @@ -908,6 +908,9 @@ class Ninja2Make(NinjaParserEventsWithVars):
>              else:
>                  stamp = '%s@%s.stamp' % (rule, sha1_text(targets)[0:11])
>              self.print('%s: %s; @:' % (targets, stamp))
> +            self.print('ifneq (%s, $(wildcard %s))' % (targets, targets))
> +            self.print('.PHONY: %s' % (stamp, ))
> +            self.print('endif')
>              self.print('%s: %s | %s; ${ninja-command-restat}' % (stamp, inputs, orderonly))
>              self.rule_targets[rule].append(stamp)
>              self.stamp_targets[rule].append(stamp)
>
> To avoid this whole class of issues we could just use ninja to build QEMU
> (Make would launch it, so there would still be no user-facing changes).
> ninja2make's main strength was that it supported incremental conversion,
> but right now all of the binaries are built by Meson therefore it's not
> really *necessary* anymore.  Dropping ninja2make removes a relatively
> expensive part of the build as well as a nontrivial amount of code.

Makes sense to me.

> Another advantage would be that ninja tracks command lines and automatically
> rebuilds things if the command line has changed.  This is quite hard and
> expensive to do with Make so ninja2make does not even try, but it has bitten
> Philippe.
>
> Of course, the main disadvantage is that it adds another dependency.

Yes.  Drop in the bucket?

We already depend on ninja-the-language, we just feed it to ninja2make
instead of ninja.

> I will send the above patch formally soonish, but I wouldn't mind if somebody
> else helped merging it.

Thank you very much for taking the time to explain!


