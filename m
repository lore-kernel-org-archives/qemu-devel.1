Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36144C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C9802087D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yd2UxImS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9802087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIsg5-0001Ky-Ml
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 08:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIsem-0000mb-Tg
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIsek-0001FQ-DG
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600344293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b1XolRKzlbW+YA7XTklFgOiVMrWPFGF9NnufPfnP2/I=;
 b=Yd2UxImSM7o25ucvLltqdQjpMlDJhaM73FW40bzLP9NArzMgmLwdmpKFpqdCki6n0vBK/1
 F0ngvz2zMiYz3GG0i6I/0+Q/WRANisdMaGDPCT/He3JMeWh2aMvWdmnLTpJv2sBE/IJVAc
 rJdD0zUw893cXrIdWXaP/fKOiZnzts0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-_DA1JaVSMwyyEVuunZ8_sw-1; Thu, 17 Sep 2020 08:04:46 -0400
X-MC-Unique: _DA1JaVSMwyyEVuunZ8_sw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C17631074645;
 Thu, 17 Sep 2020 12:04:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FAC97880F;
 Thu, 17 Sep 2020 12:04:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6C971113864A; Thu, 17 Sep 2020 14:04:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 14/15] spapr: Simplify error handling in
 spapr_memory_plug()
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-15-groug@kaod.org>
 <11f0dcb7-7923-0164-df69-4911b3293663@virtuozzo.com>
 <20200915134340.0cc3f9eb@bahia.lan>
 <20200917011525.GI5258@yekko.fritz.box>
 <87lfh8g8dy.fsf@dusky.pond.sub.org>
 <20200917120437.6ab60ca4@bahia.lan>
Date: Thu, 17 Sep 2020 14:04:41 +0200
In-Reply-To: <20200917120437.6ab60ca4@bahia.lan> (Greg Kurz's message of "Thu, 
 17 Sep 2020 12:04:37 +0200")
Message-ID: <87ft7g1uee.fsf@dusky.pond.sub.org>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz <groug@kaod.org> writes:

> On Thu, 17 Sep 2020 09:38:49 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> David Gibson <david@gibson.dropbear.id.au> writes:
>> 
>> > On Tue, Sep 15, 2020 at 01:43:40PM +0200, Greg Kurz wrote:
>> >> On Tue, 15 Sep 2020 13:58:53 +0300
>> >> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>> >> 
>> >> > 14.09.2020 15:35, Greg Kurz wrote:
>> >> > > As recommended in "qapi/error.h", add a bool return value to
>> >> > > spapr_add_lmbs() and spapr_add_nvdimm(), and use them instead
>> >> > > of local_err in spapr_memory_plug().
>> >> > > 
>> >> > > Since object_property_get_uint() only returns 0 on failure, use
>> >> > > that as well.
>> >> > 
>> >> > Why are you sure? Can't the property be 0 itself?
>> >> > 
>> >> 
>> >> Hmmm... I've based this assumption on the header:
>> >> 
>> >>  * Returns: the value of the property, converted to an unsigned integer, or 0
>> >>  * an error occurs (including when the property value is not an integer).
>> >> 
>> >> but looking at the implementation, I don't see any check that
>> >> a property cannot be 0 indeed...
>> >
>> > Yeah, indeed I'm pretty sure it can.
>> 
>> Correct.
>> 
>> Corollary: you can't use to return value to check for failure, except
>> when you know the property cannot be zero (you commonly don't).
>> 
>> The function predates our (rather late) realization that returning a
>> recognizable error value in addition to setting an error leads to more
>> readable code.  Today, we'd perhaps do it the way you describe below.
>> 
>> >> It's a bit misleading to mention this in the header though. I
>> >> understand that the function should return something, which
>> >> should have a some explicitly assigned value to avoid compilers
>> >> or static analyzers to yell, but the written contract should be
>> >> that the value is _undefined_ IMHO.
>> >
>> > Hrm... I think the description could be clearer, but returning 0
>> > explicitly on the failure case has some benefits too.  If 0 is a
>> > reasonable default for when the property isn't present (which is a
>> > plausibly common case) then it means you can just get a value and
>> > ignore errors.
>> 
>> Matter of taste.
>> 
>> There's no shortage of _undefined_ in C...
>> 
>
> Yeah and each compiler has its take as how to handle that.
>
> FWIW see section 3.1 of this bachelor thesis on the topic:
>
> https://www.cs.ru.nl/bachelors-theses/2017/Matthias_Vogelaar___4372913___Defining_the_Undefined_in_C.pdf
>
>> >> In its present form, the only way to know if the property is
>> >> valid is to pass a non-NULL errp actually. I'd rather even see
>> >> that in the contract, and an assert() in the code.
>> >
>> > Maybe... see above.
>> 
>> If you think the contract could be improved, please post a patch.
>> 
>
> The contract of object_property_get_enum() which is the next function
> in object.h explicitly says that the result is undefined, even if
> the implementation returns 0. So I was thinking of doing the same
> for object_property_get_uint().

Let's survey actual behavior of the object_property_get*():

                           return value
    function            on success  on error
    o_p_get()           true        false
    o_p_get_str()       non-null    null
    o_p_get_link()      anything    null
    o_p_get_bool()      anything    false
    o_p_get_int()       anything    -1
    o_p_get_uint()      anything    0
    o_p_get_enum()      enum value  0 or -1

object_property_get() and object_property_get_str() have a distinct
error value.  Yes, a QAPI str cannot be null.

object_property_get_enum() has *two* error values, and one of them can
also occur as success value.  This is daft.  I'll send a patch to always
return -1 on error.  Bonus: distinct error value.

object_property_get_link(), _bool(), _int(), and _uint() don't have a
distinct error value.

>> What assertion do you have in mind?  If it's adding assert(errp) to
>> object_property_get_uint(), I'll object.  Functions should not place
>> additional restrictions on @errp arguments without a compelling reason.
>> 
>
> I had such an assertion in mind but if you think this restriction is
> abusive, I take your word :)
>
>> >> An alternative would be to convert it to have a bool return
>> >> value and get the actual uint result with a pointer argument.
>> >
>> > I don't think this is a good idea.  Returning success/failure as the
>> > return value is a good rule of thumb because it reduces the amount of
>> > checking of out-of-band information you need to do.  If you move to
>> > returning the actual value you're trying to get out of band in this
>> > sense, it kind of defeats that purpose.
>> >
>> > I think this one is a case where it is reasonable to make it required
>> > to explicitly check the error value.
>> 
>> If almost all calls assign the value to a variable, like
>> 
>>     val = object_property_get_uint(obj, name, &err);
>>     if (err) {
>>         error_propagate(errp, err)
>>         ... bail out ...
>>     }
>>     ... use val ...
>> 
>> then the alternative Greg proposed is easier on the eyes:
>> 
>>     if (!object_property_get_uint(obj, name, &val, errp)) {
>>         ... bail out ...
>>     }
>>     ... use val ...
>> 
>
> That's what I had in mind.
>
>> It isn't for calls that use the value without storing it in a variable
>> first.
>> 
>
> $ git grep object_property_get_uint -- :^{include,qom/object.c} | wc -l
> 60
>
> Manual inspecting the output of
>
> $ git grep -W object_property_get_uint -- :^{include,qom/object.c}
> ...
>
> seems to be showing that most users simply ignore errors (ie. pass NULL
> as 3rd argument). Then some users pass &error_abort and only a few
> pass a &err or errp.
>
> Assuming that users know what they're doing, I guess my proposal
> wouldn't bring much to the code base in the end... I'm not even
> sure now that it's worth changing the contract.

We'd change

    val = object_property_get_uint(obj, name, &error_abort);

to

    object_property_get_uint(obj, name, &val, &error_abort);

which is not an improvement.

Most of the ones passing NULL should probably pass &error_abort
instead.  Doesn't change the argument.
    
> Cheers,
>
> --
> Greg
>
>> >> > > Also call ERRP_GUARD() to be able to check the status of void
>> >> > > function pc_dimm_plug() with *errp.
>> >> 
>> >> I'm now hesitating to either check *errp for object_property_get_uint()
>> >> too or simply drop this patch...
>> 


