Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2F7C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 09:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCEB215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 09:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcVlaCFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCEB215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQRtr-0002y9-40
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 05:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQRt0-0002Ty-Va
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 05:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQRsz-0002b0-78
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 05:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602148011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uQNMdaUtjX13w9cxK+I7Ae30HTnIm5bG2zdgJsiIMZI=;
 b=EcVlaCFa2Xm1gFUOgjciWCUBL3msqEtGdrfBgjIsCWP+ZRNJBhOMKVq67NCs0iuMRhd41q
 Vzpdenx/txlRpB7l7oVKqt9bagu6cnYzWt3SlxHYVx9EgeGQ5BvMwpJrpkZwY2JyY3GhwK
 anVaz+t5GytJFKufJ3SWTDsv1fFsYco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-RG6hptN_ORCK3qe3B3S4gA-1; Thu, 08 Oct 2020 05:06:40 -0400
X-MC-Unique: RG6hptN_ORCK3qe3B3S4gA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C34010BBEC2
 for <qemu-devel@nongnu.org>; Thu,  8 Oct 2020 09:06:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6574B50B44;
 Thu,  8 Oct 2020 09:06:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A5F0911329C1; Thu,  8 Oct 2020 11:06:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 34/36] qapi/visit.py: assert tag_member contains a
 QAPISchemaEnumType
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-35-jsnow@redhat.com>
 <87mu0yb40j.fsf@dusky.pond.sub.org>
 <e986d234-293e-a663-a9f5-74831af43c3e@redhat.com>
Date: Thu, 08 Oct 2020 11:06:37 +0200
In-Reply-To: <e986d234-293e-a663-a9f5-74831af43c3e@redhat.com> (John Snow's
 message of "Wed, 7 Oct 2020 12:40:29 -0400")
Message-ID: <87zh4x13z6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 10/7/20 8:43 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> This is true by design, but not presently able to be expressed in the
>>> type system. An assertion helps mypy understand our constraints.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>   scripts/qapi/visit.py | 12 +++++++-----
>>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
>>> index 14f30c228b7..4f11fd325b8 100644
>>> --- a/scripts/qapi/visit.py
>>> +++ b/scripts/qapi/visit.py
>>> @@ -22,7 +22,7 @@
>>>       mcgen,
>>>   )
>>>   from .gen import QAPISchemaModularCVisitor, ifcontext
>>> -from .schema import QAPISchemaObjectType
>>> +from .schema import QAPISchemaEnumType, QAPISchemaObjectType
>>>     
>>>   def gen_visit_decl(name, scalar=False):
>>> @@ -84,15 +84,17 @@ def gen_visit_object_members(name, base, members, variants):
>>>           ret += gen_endif(memb.ifcond)
>>>         if variants:
>>> +        tag_member = variants.tag_member
>>> +        assert isinstance(tag_member.type, QAPISchemaEnumType)
>> I'm curious: do you need the local variable to make the assertion
>> stick?
>> 
>
> No, but it only sticks to the binding and not the
> data. i.e. assertions to downcast work on the *name*.

Would it stick to variants.tag_member, too?

I'm asking to learn, not to find a reason to make you change your patch.

> (This comes up somewhere in the schema.py patches where I make a
> change that looks completely pointless, but it makes mypy happy.)
>
> I could have left it alone. I just saw a lot of repeated multi-dots
> and habitually created a temporary local for the purpose.

Matter of taste.  Long chains of dots make the code hard to read because
they are so long.  Temporary variable make it hard to read because you
have to remember what they mean.  Tradeoff.  I come up with cases I find
hard to decide all too often.

In case the local variable isn't needed for mypy: when you throw in
something that isn't needed for the patch's stated purpose, it's best to
mention it in the commit message, because not mentioning it is a review
comment magnet :)

Put yourself in the reviewers shoes.  Your lovingly crafted commit
message puts him into a positive mood.  He nods along while reading your
obvious patch at a good pace.  And then he runs smack into the
unexpected unrelated part, and stops: oh, what's going on here?  Back up
some and read more slowly to make sure I understand.

>>> +
>>>           ret += mcgen('''
>>>       switch (obj->%(c_name)s) {
>>>   ''',
>>> -                     c_name=c_name(variants.tag_member.name))
>>> +                     c_name=c_name(tag_member.name))
>>>             for var in variants.variants:
>>> -            case_str = c_enum_const(variants.tag_member.type.name,
>>> -                                    var.name,
>>> -                                    variants.tag_member.type.prefix)
>>> +            case_str = c_enum_const(tag_member.type.name, var.name,
>>> +                                    tag_member.type.prefix)
>>>               ret += gen_if(var.ifcond)
>>>               if var.type.name == 'q_empty':
>>>                   # valid variant and nothing to do


