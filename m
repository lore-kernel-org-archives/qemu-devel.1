Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E779C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D6D206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D6D206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIqnR-0007sO-UU
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 06:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kIqmc-0007F9-J2; Thu, 17 Sep 2020 06:04:54 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:56825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kIqmZ-0002fI-Jb; Thu, 17 Sep 2020 06:04:54 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.109])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 810C36295DC8;
 Thu, 17 Sep 2020 12:04:40 +0200 (CEST)
Received: from kaod.org (37.59.142.99) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 17 Sep
 2020 12:04:39 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003e5756229-0a38-4cd4-8cf3-c2b624cbf389,
 CCC0D77BD3F1F8C36E09B026C91493862201CFF2) smtp.auth=groug@kaod.org
Date: Thu, 17 Sep 2020 12:04:37 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 14/15] spapr: Simplify error handling in
 spapr_memory_plug()
Message-ID: <20200917120437.6ab60ca4@bahia.lan>
In-Reply-To: <87lfh8g8dy.fsf@dusky.pond.sub.org>
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-15-groug@kaod.org>
 <11f0dcb7-7923-0164-df69-4911b3293663@virtuozzo.com>
 <20200915134340.0cc3f9eb@bahia.lan>
 <20200917011525.GI5258@yekko.fritz.box>
 <87lfh8g8dy.fsf@dusky.pond.sub.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: f4f423c2-6b55-4b2e-9437-26b7a4bdd5f3
X-Ovh-Tracer-Id: 3798786289686845859
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrtdeggddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveetffehjeffffegtefhfeegkeegleethedtgeelueejuedugefggfdtlefhkeffnecuffhomhgrihhnpehruhdrnhhlnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 06:04:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Thu, 17 Sep 2020 09:38:49 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> David Gibson <david@gibson.dropbear.id.au> writes:
> 
> > On Tue, Sep 15, 2020 at 01:43:40PM +0200, Greg Kurz wrote:
> >> On Tue, 15 Sep 2020 13:58:53 +0300
> >> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> >> 
> >> > 14.09.2020 15:35, Greg Kurz wrote:
> >> > > As recommended in "qapi/error.h", add a bool return value to
> >> > > spapr_add_lmbs() and spapr_add_nvdimm(), and use them instead
> >> > > of local_err in spapr_memory_plug().
> >> > > 
> >> > > Since object_property_get_uint() only returns 0 on failure, use
> >> > > that as well.
> >> > 
> >> > Why are you sure? Can't the property be 0 itself?
> >> > 
> >> 
> >> Hmmm... I've based this assumption on the header:
> >> 
> >>  * Returns: the value of the property, converted to an unsigned integer, or 0
> >>  * an error occurs (including when the property value is not an integer).
> >> 
> >> but looking at the implementation, I don't see any check that
> >> a property cannot be 0 indeed...
> >
> > Yeah, indeed I'm pretty sure it can.
> 
> Correct.
> 
> Corollary: you can't use to return value to check for failure, except
> when you know the property cannot be zero (you commonly don't).
> 
> The function predates our (rather late) realization that returning a
> recognizable error value in addition to setting an error leads to more
> readable code.  Today, we'd perhaps do it the way you describe below.
> 
> >> It's a bit misleading to mention this in the header though. I
> >> understand that the function should return something, which
> >> should have a some explicitly assigned value to avoid compilers
> >> or static analyzers to yell, but the written contract should be
> >> that the value is _undefined_ IMHO.
> >
> > Hrm... I think the description could be clearer, but returning 0
> > explicitly on the failure case has some benefits too.  If 0 is a
> > reasonable default for when the property isn't present (which is a
> > plausibly common case) then it means you can just get a value and
> > ignore errors.
> 
> Matter of taste.
> 
> There's no shortage of _undefined_ in C...
> 

Yeah and each compiler has its take as how to handle that.

FWIW see section 3.1 of this bachelor thesis on the topic:

https://www.cs.ru.nl/bachelors-theses/2017/Matthias_Vogelaar___4372913___Defining_the_Undefined_in_C.pdf

> >> In its present form, the only way to know if the property is
> >> valid is to pass a non-NULL errp actually. I'd rather even see
> >> that in the contract, and an assert() in the code.
> >
> > Maybe... see above.
> 
> If you think the contract could be improved, please post a patch.
> 

The contract of object_property_get_enum() which is the next function
in object.h explicitly says that the result is undefined, even if
the implementation returns 0. So I was thinking of doing the same
for object_property_get_uint().

> What assertion do you have in mind?  If it's adding assert(errp) to
> object_property_get_uint(), I'll object.  Functions should not place
> additional restrictions on @errp arguments without a compelling reason.
> 

I had such an assertion in mind but if you think this restriction is
abusive, I take your word :)

> >> An alternative would be to convert it to have a bool return
> >> value and get the actual uint result with a pointer argument.
> >
> > I don't think this is a good idea.  Returning success/failure as the
> > return value is a good rule of thumb because it reduces the amount of
> > checking of out-of-band information you need to do.  If you move to
> > returning the actual value you're trying to get out of band in this
> > sense, it kind of defeats that purpose.
> >
> > I think this one is a case where it is reasonable to make it required
> > to explicitly check the error value.
> 
> If almost all calls assign the value to a variable, like
> 
>     val = object_property_get_uint(obj, name, &err);
>     if (err) {
>         error_propagate(errp, err)
>         ... bail out ...
>     }
>     ... use val ...
> 
> then the alternative Greg proposed is easier on the eyes:
> 
>     if (!object_property_get_uint(obj, name, &val, errp)) {
>         ... bail out ...
>     }
>     ... use val ...
> 

That's what I had in mind.

> It isn't for calls that use the value without storing it in a variable
> first.
> 

$ git grep object_property_get_uint -- :^{include,qom/object.c} | wc -l
60

Manual inspecting the output of

$ git grep -W object_property_get_uint -- :^{include,qom/object.c}
...

seems to be showing that most users simply ignore errors (ie. pass NULL
as 3rd argument). Then some users pass &error_abort and only a few
pass a &err or errp.

Assuming that users know what they're doing, I guess my proposal
wouldn't bring much to the code base in the end... I'm not even
sure now that it's worth changing the contract.

Cheers,

--
Greg

> >> > > Also call ERRP_GUARD() to be able to check the status of void
> >> > > function pc_dimm_plug() with *errp.
> >> 
> >> I'm now hesitating to either check *errp for object_property_get_uint()
> >> too or simply drop this patch...
> 


