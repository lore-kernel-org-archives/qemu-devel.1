Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11137C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C511020866
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5XDWbxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C511020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBh81-0007gr-36
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jBh70-0006Ut-RJ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jBh6x-0005Dm-3I
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:48:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32346
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jBh6w-00059w-UL
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 11:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583855281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=llDx5f/9wcs3vbiatzh0myHKONfdDXiTM5J6AYYnUJM=;
 b=D5XDWbxT6PT56bDcEECsoR+xQBsxUUEjcZX99ITtBBCwjPkCH/o3u/25BWm9aQ3BJZHTdK
 w1yRc2AAdUTReyFPQKaK7gN/chylNpG6oGF9TNrrLdtVK8CYGTDOClzY0D8ivMKiw/fQ3H
 g4+ujhzdRrx4vFtQqVzs/zQOtpT86K8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-aRqdc__hM86O2bD4Qkxjvg-1; Tue, 10 Mar 2020 11:47:58 -0400
X-MC-Unique: aRqdc__hM86O2bD4Qkxjvg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F164800D50;
 Tue, 10 Mar 2020 15:47:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D3F75D9C5;
 Tue, 10 Mar 2020 15:47:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C2C9511386A6; Tue, 10 Mar 2020 16:47:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v8 02/10] scripts: add coccinelle script to use auto
 propagated errp
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-3-vsementsov@virtuozzo.com>
 <87lfo997hs.fsf@dusky.pond.sub.org>
 <e5b19cf6-f206-a0ed-27cc-173c3a137ef2@virtuozzo.com>
Date: Tue, 10 Mar 2020 16:47:47 +0100
In-Reply-To: <e5b19cf6-f206-a0ed-27cc-173c3a137ef2@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 10 Mar 2020 10:44:22 +0300")
Message-ID: <87lfo8nrdo.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 09.03.2020 12:56, Markus Armbruster wrote:
>> Suggest
>>
>>      scripts: Coccinelle script to use auto-propagated errp
>>
>> or
>>
>>      scripts: Coccinelle script to use ERRP_AUTO_PROPAGATE()
>>
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>
>>> Script adds ERRP_AUTO_PROPAGATE macro invocation where appropriate and
>>> does corresponding changes in code (look for details in
>>> include/qapi/error.h)
>>>
>>> Usage example:
>>> spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>>   --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff \
>>>   blockdev-nbd.c qemu-nbd.c {block/nbd*,nbd/*,include/block/nbd*}.[hc]
>>
>> Suggest FILES... instead of a specific set of files.
>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>
>>> Cc: Eric Blake <eblake@redhat.com>
>>> Cc: Kevin Wolf <kwolf@redhat.com>
>>> Cc: Max Reitz <mreitz@redhat.com>
>>> Cc: Greg Kurz <groug@kaod.org>
>>> Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
>>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>>> Cc: Anthony Perard <anthony.perard@citrix.com>
>>> Cc: Paul Durrant <paul@xen.org>
>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>>> Cc: Laszlo Ersek <lersek@redhat.com>
>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>> Cc: Stefan Berger <stefanb@linux.ibm.com>
>>> Cc: Markus Armbruster <armbru@redhat.com>
>>> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
>>> Cc: qemu-block@nongnu.org
>>> Cc: qemu-devel@nongnu.org
>>> Cc: xen-devel@lists.xenproject.org
>>>
>>>   include/qapi/error.h                          |   3 +
>>>   scripts/coccinelle/auto-propagated-errp.cocci | 231 +++++++++++++++++=
+
>>>   2 files changed, 234 insertions(+)
>>>   create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci
>>>
>>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>>> index bb9bcf02fb..fbfc6f1c0b 100644
>>> --- a/include/qapi/error.h
>>> +++ b/include/qapi/error.h
>>> @@ -211,6 +211,9 @@
>>>    *         }
>>>    *         ...
>>>    *     }
>>> + *
>>> + * For mass conversion use script
>>
>> mass-conversion (we're not converting mass, we're converting en masse)
>>
>>> + *   scripts/coccinelle/auto-propagated-errp.cocci
>>>    */
>>>     #ifndef ERROR_H
>>> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/co=
ccinelle/auto-propagated-errp.cocci
>>> new file mode 100644
>>> index 0000000000..bff274bd6d
>>> --- /dev/null
>>> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
>>
>> Preface to my review of this script: may aim isn't to make it
>> bullet-proof.  I want to (1) make it good enough (explained in a
>> jiffie), and (2) automatically identify the spots where it still isn't
>> obviously safe for manual review.
>>
>> The latter may involve additional scripting.  That's okay.
>>
>> The script is good enough when the number of possibly unsafe spots is
>> low enough for careful manual review.
>>
>> When I ask for improvements that, in your opinion, go beyond "good
>> enough", please push back.  I'm sure we can work it out together.
>>
>>> @@ -0,0 +1,231 @@
>>> +// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
>>> +//
>>> +// Copyright (c) 2020 Virtuozzo International GmbH.
>>> +//
>>> +// This program is free software; you can redistribute it and/or modif=
y
>>> +// it under the terms of the GNU General Public License as published b=
y
>>> +// the Free Software Foundation; either version 2 of the License, or
>>> +// (at your option) any later version.
>>> +//
>>> +// This program is distributed in the hope that it will be useful,
>>> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> +// GNU General Public License for more details.
>>> +//
>>> +// You should have received a copy of the GNU General Public License
>>> +// along with this program.  If not, see <http://www.gnu.org/licenses/=
>.
>>> +//
>>> +// Usage example:
>>> +// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>> +//  --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff =
\
>>> +//  --max-width 80 blockdev-nbd.c qemu-nbd.c \
>>
>> You have --max-width 80 here, but not in the commit message.  Default
>> seems to be 78.  Any particular reason to change it to 80?
>
> Hmm. As I remember, without this parameter, reindenting doesn't work corr=
ectly.
> So, I'm OK with "--max-width 78", but I doubt that it will work without a=
 parameter.
> Still, may be I'm wrong, we can check it.

If you can point to an example where --max-width helps, keep it, and
update the commit message to match.  Else, drop it.

>>
>>> +//  {block/nbd*,nbd/*,include/block/nbd*}.[hc]
>>> +
>>> +// Switch unusual (Error **) parameter names to errp
>>
>> Let's drop the parenthesis around Error **
>>
>>> +// (this is necessary to use ERRP_AUTO_PROPAGATE).
>>
>> Perhaps ERRP_AUTO_PROPAGATE() should be ERRP_AUTO_PROPAGATE(errp) to
>> make the fact we're messing with @errp more obvious.  Too late; I
>> shouldn't rock the boat that much now.
>>
>>> +//
>>> +// Disable optional_qualifier to skip functions with "Error *const *er=
rp"
>>> +// parameter.
>>> +//
>>> +// Skip functions with "assert(_errp && *_errp)" statement, as they ha=
ve
>>> +// non generic semantics and may have unusual Error ** argument name f=
or purpose
>>
>> non-generic
>>
>> for a purpose
>>
>> Wrap comment lines around column 70, please.  It's easier to read.
>>
>> Maybe
>>
>>     // Skip functions with "assert(_errp && *_errp)" statement, because =
that
>>     // signals unusual semantics, and the parameter name may well serve =
a
>>     // purpose.
>
> Sounds good.
>
>>
>>> +// (like nbd_iter_channel_error()).
>>> +//
>>> +// Skip util/error.c to not touch, for example, error_propagate and
>>> +// error_propagate_prepend().
>>
>> error_propagate()
>>
>> I much appreciate your meticulous explanation of what you skip and why.
>>
>>> +@ depends on !(file in "util/error.c") disable optional_qualifier@
>>> +identifier fn;
>>> +identifier _errp !=3D errp;
>>> +@@
>>> +
>>> + fn(...,
>>> +-   Error **_errp
>>> ++   Error **errp
>>> +    ,...)
>>> + {
>>> +(
>>> +     ... when !=3D assert(_errp && *_errp)
>>> +&
>>> +     <...
>>> +-    _errp
>>> ++    errp
>>> +     ...>
>>> +)
>>> + }
>>
>> This rule is required to make the actual transformations (below) work
>> even for parameters with names other than @errp.  I believe it's not
>> used in this series.  In fact, I can't see a use for it in the entire
>> tree right now.  Okay anyway.
>>
>>> +
>>> +// Add invocation of ERRP_AUTO_PROPAGATE to errp-functions where neces=
sary
>>> +//
>>> +// Note, that without "when any" final "..." may not want to mach some=
thing
>>
>> s/final "..." may not mach/the final "..." does not match/
>>
>>> +// matched by previous pattern, i.e. the rule will not match double
>>> +// error_prepend in control flow like in vfio_set_irq_signaling().
>>
>> Can't say I fully understand Coccinelle there.  I figure you came to
>> this knowledge the hard way.
>
> It's follows from smpl grammar document:
>
> "Implicitly, =E2=80=9C...=E2=80=9D matches the shortest path between some=
thing that matches the pattern before the dots (or the beginning of the fun=
ction, if there is nothing before the dots) and something that matches the =
pattern after the dots (or the end of the function, if there is nothing aft=
er the dots)."
> ...
> "_when any_ removes the aforementioned constraint that =E2=80=9C...=E2=80=
=9D matches the shortest path"

Let me think that through.

The pattern with the cases other than error_prepend() omitted:

     fn(..., Error **errp, ...)
     {
    +   ERRP_AUTO_PROPAGATE();
        ...  when !=3D ERRP_AUTO_PROPAGATE();
        error_prepend(errp, ...);
        ... when any
     }

Tail of vfio_set_irq_signaling():

        name =3D index_to_str(vbasedev, index);
        if (name) {
            error_prepend(errp, "%s-%d: ", name, subindex);
        } else {
            error_prepend(errp, "index %d-%d: ", index, subindex);
        }
        error_prepend(errp,
                      "Failed to %s %s eventfd signaling for interrupt ",
                      fd < 0 ? "tear down" : "set up", action_to_str(action=
));
        return ret;
    }

The pattern's first ... matches a "shortest" path to an error_prepend(),
where "shortest" means "does not cross an error_prepend().  Its when
clause makes us ignore functions that already use ERRP_AUTO_PROPAGATE().

There are two such "shortest" paths, one to the first error_prepend() in
vfio_set_irq_signaling(), and one to the second.  Neither path to the
third one is not "shortest": they both cross one of the other two
error_prepend().

The pattern' s second ... matches a path from a matched error_prepend()
to the end of the function.  There are two paths.  Both cross the third
error_prepend().  You need "when any" to make the pattern match anyway.

Alright, I think I got it.  But now I'm paranoid about ... elsewhere.
For instance, here's rule1 with error_propagate_prepend() omitted:

    // Match scenarios with propagation of local error to errp.
    @rule1 disable optional_qualifier exists@
    identifier fn, local_err;
    symbol errp;
    @@

     fn(..., Error **errp, ...)
     {
         ...
         Error *local_err =3D NULL;
         ...
         error_propagate(errp, local_err);
         ...
     }

The second and third ... won't match anything containing
error_propagate().  What if a function has multiple error_propagate() on
all paths?  Like this one:

    extern foo(int, Error **);
    extern bar(int, Error **);

    void frob(Error **errp)
    {
        Error *local_err =3D NULL;
        int arg;

        foo(arg, errp);
        bar(arg, &local_err);
        error_propagate(errp, local_err);
        bar(arg + 1, &local_err);
        error_propagate(errp, local_err);
    }

This is actually a variation of error.h's "Receive and accumulate
multiple errors (first one wins)" code snippet.

The Coccinelle script transforms it like this:

     void frob(Error **errp)
     {
    +    ERRP_AUTO_PROPAGATE();
         Error *local_err =3D NULL;
         int arg;

The rule that adds ERRP_AUTO_PROPAGATE() matches (it has ... when any),
but rule1 does not, and we therefore don't convert any of the
error_propagate().

The result isn't wrong, just useless.

Is this the worst case?

Possible improvement to the ERRP_AUTO_PROPAGATE() rule: don't use
"... when any" in the error_propagate() case, only in the other cases.
Would that help?

I think this is the only other rule with "..." matching control flow.

>>
>>> +//
>>> +// Note, "exists" says that we want apply rule even if it matches not =
on
>>> +// all possible control flows (otherwise, it will not match standard p=
attern
>>> +// when error_propagate() call is in if branch).
>>
>> Learned something new.  Example: kvm_set_kvm_shadow_mem().
>>
>> Spelling it "exists disable optional_qualifier" would avoid giving
>> readers the idea we're disabling "exists", but Coccinelle doesn't let
>> us.  Oh well.
>>
>>> +@ disable optional_qualifier exists@
>>> +identifier fn, local_err, errp;
>>
>> I believe this causes
>>
>>      warning: line 98: errp, previously declared as a metavariable, is u=
sed as an identifier
>>      warning: line 104: errp, previously declared as a metavariable, is =
used as an identifier
>>      warning: line 106: errp, previously declared as a metavariable, is =
used as an identifier
>>      warning: line 131: errp, previously declared as a metavariable, is =
used as an identifier
>>      warning: line 192: errp, previously declared as a metavariable, is =
used as an identifier
>>      warning: line 195: errp, previously declared as a metavariable, is =
used as an identifier
>>      warning: line 228: errp, previously declared as a metavariable, is =
used as an identifier
>>
>> Making @errp symbol instead of identifier should fix this.
>
> Hmm, I didn't see these warnings.. But yes, it should be symbol.
>
>>
>>> +@@
>>> +
>>> + fn(..., Error **errp, ...)
>>> + {
>>> ++   ERRP_AUTO_PROPAGATE();
>>> +    ...  when !=3D ERRP_AUTO_PROPAGATE();
>>> +(
>>> +    error_append_hint(errp, ...);
>>> +|
>>> +    error_prepend(errp, ...);
>>> +|
>>> +    error_vprepend(errp, ...);
>>> +|
>>> +    Error *local_err =3D NULL;
>>> +    ...
>>> +(
>>> +    error_propagate_prepend(errp, local_err, ...);
>>> +|
>>> +    error_propagate(errp, local_err);
>>> +)
>>> +)
>>> +    ... when any
>>> + }
>>> +
>>> +
>>> +// Match scenarios with propagation of local error to errp.
>>> +@rule1 disable optional_qualifier exists@
>>> +identifier fn, local_err;
>>> +symbol errp;
>>> +@@
>>> +
>>> + fn(..., Error **errp, ...)
>>> + {
>>> +     ...
>>> +     Error *local_err =3D NULL;
>>> +     ...
>>> +(
>>> +    error_propagate_prepend(errp, local_err, ...);
>>> +|
>>> +    error_propagate(errp, local_err);
>>> +)
>>
>> Indentation off by one.
>>
>>> +     ...
>>> + }
>>> +
>>> +// Convert special case with goto in separate.
>>
>> s/in separate/separately/
>>
>>> +// We can probably merge this into the following hunk with help of ( |=
 )
>>> +// operator, but it significantly reduce performance on block.c parsin=
g (or it
>>
>> s/reduce/reduces/
>>
>>> +// hangs, I don't know)
>>
>> Sounds like you tried to merge this into the following hunk, but then
>> spatch took so long on block.c that you killed it.  Correct?
>
> Yes.

I'd say something like "I tried merging this into the following rule the
obvious way, but it made Coccinelle hang on block.c."

>>
>>> +//
>>> +// Note interesting thing: if we don't do it here, and try to fixup "o=
ut: }"
>>> +// things later after all transformations (the rule will be the same, =
just
>>> +// without error_propagate() call), coccinelle fails to match this "ou=
t: }".
>>
>> Weird, but not worth further investigation.
>
> It partially match to the idea which I saw somewhere in coccinelle docume=
ntation,
> that coccinelle converts correct C code to correct C code. "out: }" is an=
 example
> of incorrect, impossible code flow, and coccinelle can't work with it... =
But it's
> just a thought.
>
>>
>>> +@@
>>> +identifier rule1.fn, rule1.local_err, out;
>>> +symbol errp;
>>> +@@
>>> +
>>> + fn(...)
>>> + {
>>> +     <...
>>> +-    goto out;
>>> ++    return;
>>> +     ...>
>>> +- out:
>>> +-    error_propagate(errp, local_err);
>>
>> You neglect to match error_propagate_prepend().  Okay, because (1) that
>> pattern doesn't occur in the tree right now, and (2) if it gets added,
>> gcc will complain.
>
> No, because it should not removed. error_propagate_prepend should be conv=
erted
> to prepend, not removed. So, corresponding gotos should not be removed as=
 well.

You're right.

>>
>>> + }
>>> +
>>> +// Convert most of local_err related staff.
>>
>> s/staff/stuff/
>>
>>> +//
>>> +// Note, that we update everything related to matched by rule1 functio=
n name
>>> +// and local_err name. We may match something not related to the patte=
rn
>>> +// matched by rule1. For example, local_err may be defined with the sa=
me name
>>> +// in different blocks inside one function, and in one block follow th=
e
>>> +// propagation pattern and in other block doesn't. Or we may have seve=
ral
>>> +// functions with the same name (for different configurations).
>>
>> Context: rule1 matches functions that have all three of
>>
>> * an Error **errp parameter
>>
>> * an Error *local_err =3D NULL variable declaration
>>
>> * an error_propagate(errp, local_err) or error_propagate_prepend(errp,
>>    local_err, ...) expression, where @errp is the parameter and
>>    @local_err is the variable.
>>
>> If I understand you correctly, you're pointing out two potential issues:
>>
>> 1. This rule can match functions rule1 does not match if there is
>> another function with the same name that rule1 does match.
>>
>> 2. This rule matches in the entire function matched by rule1, even when
>> parts of that function use a different @errp or @local_err.
>>
>> I figure these apply to all rules with identifier rule1.fn, not just
>> this one.  Correct?
>
> Yes.

Thanks!

>>
>> Regarding 1.  There must be a better way to chain rules together, but I
>> don't know it.
>>  Can we make Coccinelle at least warn us when it converts
>> multiple functions with the same name?  What about this:
>>
>>     @initialize:python@
>>     @@
>>     fnprev =3D {}
>>
>>     def pr(fn, p):
>>         print("### %s:%s: %s()" % (p[0].file, p[0].line, fn))
>>
>>     @r@
>>     identifier rule1.fn;
>>     position p;
>>     @@
>>      fn(...)@p
>>      {
>>          ...
>>      }
>>     @script:python@
>>         fn << rule1.fn;
>>         p << r.p;
>>     @@
>>     if fn not in fnprev:
>>         fnprev[fn] =3D p
>>     else:
>>         if fnprev[fn]:
>
> hmm, the condition can't be false
>
>>             pr(fn, fnprev[fn])
>>             fnprev[fn] =3D None
>>         pr(fn, p)
>
> and we'll miss next duplication..

The idea is

    first instance of fn:
        fn not in fnprev
        fnprev[fn] =3D position of instance
        don't print
    second instance:
        fnprev[fn] is the position of the first instance
        print first two instances
    subsequent instances: fnprev[fn] is None
        print this instance

I might have screwed up the coding, of course :)

> But I like the idea.
>
>>
>> For each function @fn matched by rule1, fncnt[fn] is an upper limit of
>> the number of functions with the same name we touch.  If it's more than
>> one, we print.
>>
>> Reports about a dozen function names for the whole tree in my testing.
>> Inspecting the changes to them manually is feasible.  None of them are
>> in files touched by this series.
>>
>> The line printed for the first match is pretty useless for me: it points
>> to a Coccinelle temporary file *shrug*.
>>
>> Regarding 2.  Shadowing @errp or @local_err would be in bad taste, and I
>> sure hope we don't do that.  Multiple @local_err variables... hmm.
>> Perhaps we could again concoct some script rules to lead us to spots to
>> check manually.  See below for my attempt.
>>
>> What's the worst that could happen if we blindly converted such code?
>> The answer to that question tells us how hard to work on finding and
>> checking these guys.
>>
>>> +//
>>> +// Note also that errp-cleaning functions
>>> +//   error_free_errp
>>> +//   error_report_errp
>>> +//   error_reportf_errp
>>> +//   warn_report_errp
>>> +//   warn_reportf_errp
>>> +// are not yet implemented. They must call corresponding Error* - free=
ing
>>> +// function and then set *errp to NULL, to avoid further propagation t=
o
>>> +// original errp (consider ERRP_AUTO_PROPAGATE in use).
>>> +// For example, error_free_errp may look like this:
>>> +//
>>> +//    void error_free_errp(Error **errp)
>>> +//    {
>>> +//        error_free(*errp);
>>> +//        *errp =3D NULL;
>>> +//    }
>>> +@ exists@
>>> +identifier rule1.fn, rule1.local_err;
>>> +expression list args;
>>> +symbol errp;
>>> +@@
>>> +
>>> + fn(...)
>>> + {
>>> +     <...
>>> +(
>>
>> Each of the following patterns applies anywhere in the function.
>>
>> First pattern: delete @local_err
>>
>>> +-    Error *local_err =3D NULL;
>>
>> Common case: occurs just once, not nested.  Anything else is suspicious.
>>
>> Both can be detected in the resulting patches with a bit of AWK
>> wizardry:
>>
>>      $ git-diff -U0 master..review-error-v8 | awk '/^@@ / { ctx =3D $5; =
for (i =3D 6; i <=3D NF; i++) ctx =3D ctx " " $i; if (ctx !=3D octx) { octx=
 =3D ctx; n =3D 0 } } /^- *Error *\* *[A-Za-z0-9_]+ *=3D *NULL;/ { if (inde=
x($0, "E") > 6) print "nested\n    " ctx; if (n) print "more than one\n    =
" ctx; n++ }'
>>      nested
>>          static void xen_block_drive_destroy(XenBlockDrive *drive, Error=
 **errp)
>>      nested
>>          static void xen_block_device_destroy(XenBackendInstance *backen=
d,
>>      nested
>>          static void xen_block_device_destroy(XenBackendInstance *backen=
d,
>>      more than one
>>          static void xen_block_device_destroy(XenBackendInstance *backen=
d,
>>
>> Oh.
>>
>> xen_block_drive_destroy() nests its Error *local_err in a conditional.
>>
>> xen_block_device_destroy() has multiple Error *local_err.
>>
>> In both cases, manual review is required to ensure the conversion is
>> okay.  I believe it is.
>>
>> Note that the AWK script relies on diff showing the function name in @@
>> lines, which doesn't always work due to our coding style.
>>
>> For the whole tree, I get some 30 spots.  Feasible.
>>
>>> +|
>>
>> Second pattern: clear @errp after freeing it
>>
>>> +
>>> +// Convert error clearing functions
>>
>> Suggest: Ensure @local_err is cleared on free
>>
>>> +(
>>> +-    error_free(local_err);
>>> ++    error_free_errp(errp);
>>> +|
>>> +-    error_report_err(local_err);
>>> ++    error_report_errp(errp);
>>> +|
>>> +-    error_reportf_err(local_err, args);
>>> ++    error_reportf_errp(errp, args);
>>> +|
>>> +-    warn_report_err(local_err);
>>> ++    warn_report_errp(errp);
>>> +|
>>> +-    warn_reportf_err(local_err, args);
>>> ++    warn_reportf_errp(errp, args);
>>> +)
>>
>> As you mention above, these guys don't exist, yet.  Builds anyway,
>> because this part of the rule is not used in this patch series.  You
>> don't want to omit it, because then the script becomes unsafe to use.
>>
>> We could also open-code:
>>
>>     // Convert error clearing functions
>>     (
>>     -    error_free(local_err);
>>     +    error_free(*errp);
>>     +    *errp =3D NULL;
>>     |
>>     ... and so forth ...
>>     )
>>
>> Matter of taste.  Whatever is easier to explain in the comments.  Since
>> you already wrote one...
>
> I just feel that using helper functions is safer way..
>
>>
>> We talked about extending this series slightly so these guys are used.
>> I may still look into that.
>>
>>> +?-    local_err =3D NULL;
>>> +
>>
>> The new helpers clear @local_err.  Assignment now redundant, delete.
>> Okay.
>>
>>> +|
>>
>> Third and fourth pattern: delete error_propagate()
>>
>>> +-    error_propagate_prepend(errp, local_err, args);
>>> ++    error_prepend(errp, args);
>>> +|
>>> +-    error_propagate(errp, local_err);
>>> +|
>>
>> Fifth pattern: use @errp directly
>>
>>> +-    &local_err
>>> ++    errp
>>> +)
>>> +     ...>
>>> + }
>>> +
>>> +// Convert remaining local_err usage. It should be different kinds of =
error
>>> +// checking in if operators. We can't merge this into previous hunk, a=
s this
>>
>> In if conditionals, I suppose.  It's the case for this patch.  If I
>> apply the script to the whole tree, the rule gets also applied in other
>> contexts.  The sentence might mislead as much as it helps.  Keep it or
>> delete it?
>
> Maybe, just be more honest: "It should be ..., but it may be any other pa=
ttern, be careful"

"Need to be careful" means "needs careful manual review", which I
believe is not feasible; see "Preface to my review of this script"
above.

But do we really need to be careful here?

This rule should apply only where we added ERRP_AUTO_PROPAGATE().

Except when rule chaining via function name fails us, but we plan to
detect that and review manually, so let's ignore this issue here.

Thanks to ERRP_AUTO_PROPAGATE(), @errp is not null.  Enabling
replacement of @local_err by @errp is its whole point.

What exactly do we need to be careful about?

>
>>
>>> +// conflicts with other substitutions in it (at least with "- local_er=
r =3D NULL").
>>> +@@
>>> +identifier rule1.fn, rule1.local_err;
>>> +symbol errp;
>>> +@@
>>> +
>>> + fn(...)
>>> + {
>>> +     <...
>>> +-    local_err
>>> ++    *errp
>>> +     ...>
>>> + }
>>> +
>>> +// Always use the same patter for checking error
>>
>> s/patter/pattern/
>>
>>> +@@
>>> +identifier rule1.fn;
>>> +symbol errp;
>>> +@@
>>> +
>>> + fn(...)
>>> + {
>>> +     <...
>>> +-    *errp !=3D NULL
>>> ++    *errp
>>> +     ...>
>>> + }
>>


