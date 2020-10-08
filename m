Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AE0C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433B32184D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipMGY9Ee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433B32184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQXog-00062b-85
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 11:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQXo4-0005VL-4H
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQXo2-0007DM-0B
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602170768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=99xBdsFzLnpezC00puA7Rz00CaDWjiQv6M8aitIa+dU=;
 b=ipMGY9EeCe/5PLWpjTgVlwR64oKTfNs2MzT1wQMeUhcfFvN4M4jU4MjCMgsHDTNnGHmie1
 Peoh98h7e4uF/niB1sFhZAU23AWd9JIDjkT5GnoIUgtMc+HlZI9H5qzofz7CPZLy5OU3pp
 PinJvtpG9OLP41KgA3TqNLdoMK3ohHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-jdS8miWPOGKQJi9ZVNjC5A-1; Thu, 08 Oct 2020 11:26:06 -0400
X-MC-Unique: jdS8miWPOGKQJi9ZVNjC5A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C81F15708C;
 Thu,  8 Oct 2020 15:25:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74A4C55760;
 Thu,  8 Oct 2020 15:25:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD8B411329C1; Thu,  8 Oct 2020 17:25:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 1/4] keyval: Parse help options
References: <20201007164903.282198-1-kwolf@redhat.com>
 <20201007164903.282198-2-kwolf@redhat.com>
 <609ce08c-35d5-ca85-ac15-bdbc56c28465@redhat.com>
 <20201008084531.GC4672@linux.fritz.box>
Date: Thu, 08 Oct 2020 17:25:57 +0200
In-Reply-To: <20201008084531.GC4672@linux.fritz.box> (Kevin Wolf's message of
 "Thu, 8 Oct 2020 10:45:31 +0200")
Message-ID: <87wo00viwq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 07.10.2020 um 19:29 hat Eric Blake geschrieben:
>> On 10/7/20 11:49 AM, Kevin Wolf wrote:
>> > This adds a special meaning for 'help' and '?' as options to the keyval
>> > parser. Instead of being an error (because of a missing value) or a
>> > value for an implied key, they now request help, which is a new boolean
>> > ouput of the parser in addition to the QDict.
>> 
>> output
>> 
>> > 
>> > A new parameter 'p_help' is added to keyval_parse() that contains on
>> > return whether help was requested. If NULL is passed, requesting help
>> > results in an error and all other cases work like before.
>> > 
>> > Turning previous error cases into help is a compatible extension. The
>> > behaviour potentially changes for implied keys: They could previously
>> > get 'help' as their value, which is now interpreted as requesting help.
>> > 
>> > This is not a problem in practice because 'help' and '?' are not a valid
>> > values for the implied key of any option parsed with keyval_parse():
>> > 
>> > * audiodev: union Audiodev, implied key "driver" is enum AudiodevDriver,
>> >   "help" and "?" are not among its values
>> > 
>> > * display: union DisplayOptions, implied key "type" is enum
>> >   DisplayType, "help" and "?" are not among its values
>> > 
>> > * blockdev: union BlockdevOptions, implied key "driver is enum
>> >   BlockdevDriver, "help" and "?" are not among its values
>> > 
>> > * export: union BlockExport, implied key "type" is enum BlockExportType,
>> >   "help" and "?" are not among its values
>> > 
>> > * monitor: struct MonitorOptions, implied key "mode"is enum MonitorMode,
>> 
>> missing space
>> 
>> >   "help" and "?" are not among its values
>> > 
>> > * nbd-server: struct NbdServerOptions, no implied key.
>> 
>> Including the audit is nice (and thanks to Markus for helping derive the
>> list).
>> 
>> > 
>> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> > ---
>> 
>> > +++ b/util/keyval.c
>> > @@ -14,7 +14,7 @@
>> >   * KEY=VALUE,... syntax:
>> >   *
>> >   *   key-vals     = [ key-val { ',' key-val } [ ',' ] ]
>> > - *   key-val      = key '=' val
>> > + *   key-val      = 'help' | key '=' val
>> 
>> Maybe: = 'help' | '?' | key = '=' val
>> 
>> >   *   key          = key-fragment { '.' key-fragment }
>> >   *   key-fragment = / [^=,.]* /
>> >   *   val          = { / [^,]* / | ',,' }
>> > @@ -73,10 +73,14 @@
>> >   *
>> >   * Additional syntax for use with an implied key:
>> >   *
>> > - *   key-vals-ik  = val-no-key [ ',' key-vals ]
>> > + *   key-vals-ik  = 'help' | val-no-key [ ',' key-vals ]
>> 
>> and again for '?' here.
>
> Ah, true, I should mention '?', too.

Let's use a non-terminal

    help = 'help' | '?'
    key-val = key '=' val | help

>> Actually, this should probably be:
>> 
>> key-vals-ik  = 'help' [ ',' key-vals ]
>>              | '?' [ ',' key-vals ]
>>              | val-no-key [ ',' key-vals ]
>
> I noticed that the grammar was wrong even before my patch (because
> making use of the implied key is optional), but the right fix wasn't
> obvious to me, so I decided to just leave that part as it is.

The grammar leaves a small, but important unsaid, or rather said only in
the accompanying prose.

 * Additional syntax for use with an implied key:
 *
 *   key-vals-ik  = val-no-key [ ',' key-vals ]
 *   val-no-key   = / [^=,]* /

tries to express that with an implied key, the grammar changes from

     S = key-vals

to

     S = key-vals | key-vals-ik

See, "additional syntax".  Felt clear enough to me when I wrote it.  It
is not.

> Even your version is wrong because it's valid to a value with implied
> key and help at the same time.
>
> Thinking a bit more about it, I feel it should simply be something like:
>
>     key-vals-ik = val-no-key [ ',' key-vals ] | key-vals
>
> And then key-vals automatically covers the help case.

Unfortunately, this simple grammar is ambigious: "help" can be parsed
both as

    "help" -> help -> key-val -> key-vals -> key-vals-ik

and

    "help" -> val-no-key -> key-vals-ik

Ham-fisted fix:

    val-no-key = / [^-,]* / - 'help'

I'm not a fan of the exception operator.  Better ideas?

I'll have a closer look at the actual patch next.

>> >   *   val-no-key   = / [^=,]* /
>> 
>> This is now slightly inaccurate, but I don't know how to concisely
>> express the regex [^=,]* but not '?' or 'help', and the prose covers the
>> ambiguity.
>> 
>> 
>> > @@ -410,6 +442,14 @@ QDict *keyval_parse(const char *params, const char *implied_key,
>> >          implied_key = NULL;
>> >      }
>> >  
>> > +    if (p_help) {
>> > +        *p_help = help;
>> > +    } else if (help) {
>> > +        error_setg(errp, "Help is not available for this option");
>> > +        qobject_unref(qdict);
>> > +        return NULL;
>> > +    }
>> 
>> This part is a definite improvement over v2.
>> 
>> I'm assuming Markus can help touch up the comments and spelling errors, so:
>> 
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> I assumed that as a qsd series this would go through my own tree anyway,
> so if all of you agree that you don't want to see the corrected version
> on the list, I can fix them while applying the series.

The series spans "Command line option argument parsing" (this patch),
"QOM" (next two), and qsd (final one).  I'm fine with you taking it
through your tree.

Just noticed: you neglected to cc: the QOM maintainers.  Recommend to
give them a heads-up.


