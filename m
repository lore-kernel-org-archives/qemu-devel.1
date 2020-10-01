Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C34FC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 10:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A239920838
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 10:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jg1866Hg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A239920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNvc3-00045u-Hr
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 06:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNvbQ-0003a6-55
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 06:14:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNvbN-0007Kh-Lt
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 06:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601547256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PEAe9srwxHXOzf70Gmcjq2LMH3oLoQhzs3Mf7awNs18=;
 b=Jg1866Hgpbx7fbeccUswkgEpOcnrpKBffMFw8kTFqnycn5pi3PE7GnaUiGxvZuCxh/eWv5
 e4+XhUpcuPuExm6FsUvztrS1YQFlrEouRTd45xX2UNvy5caQjc5orYsJW5KR/+qJvA1Sp8
 vDNz5urcgjXpmrJIs7lhKCJuP6JkUc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-Txe2j9A6PDeRkmSHcEI9JQ-1; Thu, 01 Oct 2020 06:14:13 -0400
X-MC-Unique: Txe2j9A6PDeRkmSHcEI9JQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8824D425DA;
 Thu,  1 Oct 2020 10:14:12 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-92.ams2.redhat.com [10.36.114.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C9E55578D;
 Thu,  1 Oct 2020 10:14:05 +0000 (UTC)
Date: Thu, 1 Oct 2020 12:14:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v7 06/13] qmp: Call monitor_set_cur() only in
 qmp_dispatch()
Message-ID: <20201001101403.GA6673@linux.fritz.box>
References: <20200909151149.490589-7-kwolf@redhat.com>
 <877dswo0mf.fsf@dusky.pond.sub.org>
 <20200925151304.GE5731@linux.fritz.box>
 <87ft72i0v8.fsf@dusky.pond.sub.org>
 <20200928143052.GH5451@linux.fritz.box>
 <87h7rfehtr.fsf@dusky.pond.sub.org>
 <20200930112903.GA9292@linux.fritz.box>
 <87o8ln9zl3.fsf@dusky.pond.sub.org>
 <20200930140051.GC9292@linux.fritz.box>
 <20200930172020.GE2783@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200930172020.GE2783@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-block@nongnu.org, marcandre.lureau@gmail.com,
 Markus Armbruster <armbru@redhat.com>, stefanha@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.09.2020 um 19:20 hat Dr. David Alan Gilbert geschrieben:
> * Kevin Wolf (kwolf@redhat.com) wrote:
> > Am 30.09.2020 um 15:14 hat Markus Armbruster geschrieben:
> > > Kevin Wolf <kwolf@redhat.com> writes:
> > > 
> > > > Am 30.09.2020 um 11:26 hat Markus Armbruster geschrieben:
> > > >> Kevin Wolf <kwolf@redhat.com> writes:
> > > >> 
> > > >> > Am 28.09.2020 um 13:42 hat Markus Armbruster geschrieben:
> > > >> >> Kevin Wolf <kwolf@redhat.com> writes:
> > > >> >> 
> > > >> >> > Am 14.09.2020 um 17:10 hat Markus Armbruster geschrieben:
> > > >> >> >> Kevin Wolf <kwolf@redhat.com> writes:
> > > [...]
> > > >> >> >> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > > >> >> >> > index 8469970c69..922fdb5541 100644
> > > >> >> >> > --- a/monitor/qmp.c
> > > >> >> >> > +++ b/monitor/qmp.c
> > > >> >> >> > @@ -135,16 +135,10 @@ static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp)
> > > >> >> >> >  
> > > >> >> >> >  static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
> > > >> >> >> >  {
> > > >> >> >> > -    Monitor *old_mon;
> > > >> >> >> >      QDict *rsp;
> > > >> >> >> >      QDict *error;
> > > >> >> >> >  
> > > >> >> >> > -    old_mon = monitor_set_cur(&mon->common);
> > > >> >> >> > -    assert(old_mon == NULL);
> > > >> >> >> > -
> > > >> >> >> > -    rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon));
> > > >> >> >> > -
> > > >> >> >> > -    monitor_set_cur(NULL);
> > > >> >> >> > +    rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon), &mon->common);
> > > >> >> >> 
> > > >> >> >> Long line.  Happy to wrap it in my tree.  A few more in PATCH 08-11.
> > > >> >> >
> > > >> >> > It's 79 characters. Should be fine even with your local deviation from
> > > >> >> > the coding style to require less than that for comments?
> > > >> >> 
> > > >> >> Let me rephrase my remark.
> > > >> >> 
> > > >> >> For me,
> > > >> >> 
> > > >> >>     rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon),
> > > >> >>                        &mon->common);
> > > >> >> 
> > > >> >> is significantly easier to read than
> > > >> >> 
> > > >> >>     rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon), &mon->common);
> > > >> >
> > > >> > I guess this is highly subjective. I find wrapped lines harder to read.
> > > >> > For answering subjective questions like this, we generally use the
> > > >> > coding style document.
> > > >> >
> > > >> > Anyway, I guess following an idiosyncratic coding style that is
> > > >> > different from every other subsystem in QEMU is possible (if
> > > >> > inconvenient) if I know what it is.
> > > >> 
> > > >> The applicable coding style document is PEP 8.
> > > >
> > > > I'll happily apply PEP 8 to Python code, but this is C. I don't think
> > > > PEP 8 applies very well to C code. (In fact, PEP 7 exists as a C style
> > > > guide, but we're not writing C code for the Python project here...)
> > > 
> > > I got confused (too much Python code review), my apologies.
> > > 
> > > >> > My problem is more that I don't know what the exact rules are. Can they
> > > >> > only be figured out experimentally by submitting patches and seeing
> > > >> > whether you like them or not?
> > > >> 
> > > >> PEP 8:
> > > >> 
> > > >>     A style guide is about consistency.  Consistency with this style
> > > >>     guide is important.  Consistency within a project is more important.
> > > >>     Consistency within one module or function is the most important.
> > > >> 
> > > >> In other words, you should make a reasonable effort to blend in.
> > > >
> > > > The project style guide for C is defined in CODING_STYLE.rst. Missing
> > > > consistency with it is what I'm complaining about.
> > > >
> > > > I also agree that consistency within one module or function is most
> > > > important, which is why I allow you to reformat my code. But I don't
> > > > think it means that local coding style rules shouldn't be documented,
> > > > especially if you can't just look at the code and see immediately how
> > > > it's supposed to be.
> > > >
> > > >> >> Would you mind me wrapping this line in my tree?
> > > >> >
> > > >> > I have no say in this subsystem and I take it that you want all code to
> > > >> > look as if you had written it yourself, so do as you wish.
> > > >> 
> > > >> I'm refusing the bait.
> > > >> 
> > > >> > But I understand that I'll have to respin anyway, so if you could
> > > >> > explain what you're after, I might be able to apply the rules for the
> > > >> > next version of the series.
> > > >> 
> > > >> First, PEP 8 again:
> > > >> 
> > > >>     Limit all lines to a maximum of 79 characters.
> > > >> 
> > > >>     For flowing long blocks of text with fewer structural restrictions
> > > >>     (docstrings or comments), the line length should be limited to 72
> > > >>     characters.
> > > >
> > > > Ok, that's finally clear limits at least.
> > > >
> > > > Any other rules from PEP 8 that you want to see applied to C code?
> > > 
> > > PEP 8 does not apply to C.
> > > 
> > > > Would you mind documenting this somewhere?
> > > >
> > > >> Second, an argument we two had on this list, during review of a prior
> > > >> version of this patch series, talking about C:
> > > >> 
> > > >>     Legibility.  Humans tend to have trouble following long lines with
> > > >>     their eyes (I sure do).  Typographic manuals suggest to limit
> > > >>     columns to roughly 60 characters for exactly that reason[*].
> > > >> 
> > > >>     Code is special.  It's typically indented, and long identifiers push
> > > >>     it further to the right, function arguments in particular.  We
> > > >>     compromised at 80 columns.
> > > >> 
> > > >>     [...]
> > > >> 
> > > >>     [*] https://en.wikipedia.org/wiki/Column_(typography)#Typographic_style
> > > >> 
> > > >> The width of the line not counting indentation matters for legibility.
> > > >> 
> > > >> The line I flagged as long is 75 characters wide not counting
> > > >> indentation.  That's needlessly hard to read for me.
> > > >> 
> > > >> PEP 8's line length limit is a *limit*, not a sacred right to push right
> > > >> to the limit.
> > > >> 
> > > >> Since I get to read this code a lot, I've taken care to avoid illegibly
> > > >> wide lines, and I've guided contributors to blend in.
> > > >
> > > > As I said, I don't mind the exact number much. I do mind predictability,
> > > > though. (And ideally also consistency across the project because
> > > > otherwise I need to change my editor settings for individual files.)
> > > >
> > > > So if you don't like 79 columns, give me any other number. But
> > > > please, do give me something specific I can work with. "illegibly wide"
> > > > is not something I can work with because it's highly subjective.
> > > 
> > > Taste is subjective.
> > > 
> > > We can always make CODING_STYLE.rst more detailed.  I view that as a
> > > last resort when we waste too much time arguing.
> > > 
> > > Back to line length.
> > > 
> > > CODING_STYLE.rst sets a *limit*.
> > > 
> > > Going over the limit violates CODING_STYLE.rst.  There are (rare) cases
> > > where that is justified.
> > > 
> > > CODING_STYLE.rst neither demands nor prohibits breaking lines before the
> > > limit is reached.
> > > 
> > > Until CODING_STYLE.rst prohibits breaking lines unless they exceed the
> > > limit, I will continue to ask for breaking lines when that makes the
> > > code easier to read and more consistent with the code around it, for
> > > code I maintain, and admittedly in my opinion.
> > > 
> > > These requests appear to irk you a great deal.  I don't understand, but
> > > I'm sorry about it all the same.  By arguing about it repeatedly, you've
> > > irked some back.  Brought it on myself, I guess.  However, if that's
> > > what it takes to keep the code I maintain legible and consistent, I'll
> > > pay the price.
> > 
> > I conclude that I'll never be able to submit code that passes your
> > review in the first attempt because I don't know the specific criteria
> > (and you don't seem to know them either before you see the patch).
> > 
> > Fine, I'll live with it. It's just one of the things that makes working
> > in your subsystems more frustrating than in others.
> 
> Hmm,
>   IMHO the thing here is that there's two different things here:
> 
>    a) A CODING_STYLE limit - and personally I use every last character
> of that when appropriate
>    b) For this particular case, Markus is saying he prefers the wrap
> there.
> 
> I don't think I see (b) as incompatible as a preference, but lets be
> sensible; if it's something you want to change in merge that seems
> reasonable, if it's something that you ask to change in a respin that's
> kind of reasonable, just don't hold up a big patch series for an
> argument over something that's legal in the coding style and isn't
> particularly offensive!

I'll just change this one in the next version. Changing a single
well-known instance not a big problem. It's just unfortunate that there
are "A few more in PATCH 08-11" and I don't know how to identify them.

So Markus will have to comment again in the next version (as he did in
other places in previous versions of this series) and potentially modify
my patches while applying to match his taste. The latter is something I
try hard to avoid as a maintainer, but I admit this means compromising
instead of perfectionism. And the former is just a bit tiring when with
every version of a series you get additional comments about style
preferences.

Kevin


