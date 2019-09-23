Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C35C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868E720673
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868E720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCO3L-0006mz-Iy
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 09:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCO00-0003q9-Gx
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCNzz-000457-2N
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:03:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60286)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCNzy-00044z-QF
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:03:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 12396356DC;
 Mon, 23 Sep 2019 13:03:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC50060C63;
 Mon, 23 Sep 2019 13:03:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 36574113864E; Mon, 23 Sep 2019 15:03:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [Qemu-devel] [PATCH] vl.c: Report unknown machines correctly
References: <20190915202011.30459-1-palmer@sifive.com>
Date: Mon, 23 Sep 2019 15:03:24 +0200
In-Reply-To: <20190915202011.30459-1-palmer@sifive.com> (Palmer Dabbelt's
 message of "Sun, 15 Sep 2019 13:20:11 -0700")
Message-ID: <8736gnnp0j.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 23 Sep 2019 13:03:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Palmer Dabbelt <palmer@sifive.com> writes:

> I was recently typing in a QEMU command line, and ended up with
> something like
>
>     qemu-system-riscv64 -machine virt ... -M 8G
>
> which is, in retrospect, obviously incorrect: there is no "8G" machine.
> I should have typed something like
>
>     qemu-system-riscv64 -machine virt ... -m 8G
>
> but since QEMU was giving me the excessively unhelpful error message
>
>     qemu-system-riscv64: -machine virt: unsupported machine type
>     Use -machine help to list supported machines
>
> I had to spend a few minutes scratching my head to figure out what was
> going on.  For some reason I felt like I'd done that before, so I
> figured I'd take a whack at fixing the problem this time.  It turns out
> the error reporting for non-existant machines is just wrong: the invalid
> machine is detected after we've lost the argument pointer, so it just
> prints out the first instance of "-machine" instead of the one we're
> actually looking for.
>
> I've fixed this by just printing out "-machine $NAME" directly, but I
> feel like there's a better way to do this.  Specifically, my issue is
> that it always prints out "-machine" instead of "-M" -- that's actually
> a regression for users just passing a single invalid machine via "-M",
> which I assume is the more common case.
>
> I'm not sure how to do this right, though, and my flight is boarding so
> I figured I'd send this out as a way to ask the question.  I didn't have
> time to run the test suite or figure out how to add a test for this, as
> I'm assuming there's a better way to do it.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  vl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/vl.c b/vl.c
> index 630f5c5e9c..821a5d91c8 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2487,7 +2487,7 @@ static MachineClass *machine_parse(const char *name, GSList *machines)
>  
>      mc = find_machine(name, machines);
>      if (!mc) {
> -        error_report("unsupported machine type");
> +        error_printf("-machine %s: unsupported machine type\n", name);
>          error_printf("Use -machine help to list supported machines\n");
>          exit(1);
>      }

This is an instance of QemuOpts features undermining each other.

error_report() uses the "current location".  A few judiciously placed
loc_FOO() ensure many error_report() just work.  For instance, anything
within main()'s two loops over argv[] has the current location point to
the current option or argument.

= QemuOpts feature #1: capture option location =

A struct QemuOpts stores a complex option for later use.  Since many
such later uses call error_report(), it captures the option's location,
so you can make the current location point to it again.  It's even
automatic with qemu_opts_foreach().

= QemuOpts feature #2: option merging =

You can request multiple options to be merged[*] by putting .merge_lists
= true into the QemuOptsList.  qemu_machine_opts does.  -machine a=b
-machine x=y gets merged into -machine a=b,x=y.

= The two feature don't want to play with each other =

With option merging, we can have any number of *actual* option
locations, but QemuOpts can capture just one, so we arbitrarily capture
the first one.  In your example, that's "-machine virt", which is
misleading, because the offending location is actually "-M 8G".

By the time we realized the features don't play with each other, we were
too deeply invested into both features to say "either feature is fine,
but we can't have both".

To make them play, we'd have to capture locations at the struct QemuOpt
level instead.  Looks like an awful lot of work just to make a few error
messages less confusing.  Makes me sad, because I do value decent error
messages.



[*] Multiple options with the same ID.  A detail that isn't relevant
here, I think.  Can explain if you're curious.

