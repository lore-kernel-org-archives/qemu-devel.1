Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9C7C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9862084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLZN1XkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9862084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyxIa-0007n5-WB
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 07:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iyxHj-0007AN-LL
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:26:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iyxHh-0002fb-0q
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:26:30 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43544
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iyxHg-0002Yt-K6
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580819187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MszlNI7YNZV2jQRy7qH0Q4vUrqQZS2e1Cn9y39/Qy5g=;
 b=bLZN1XkL5XL07oCgVYtpaDAHn2VpsZ+tLQg5OKXptC451Jg2oaNWs9orAIMdWTQ1yjVcgC
 n7DpBPWCc6g0DFtNUReDZxkwbecm+SbpNhZ9SJx5dRdjCju/7wH1eLfIthRIwYemkamWVg
 SZTlaogHfnhYYaB3FzS+xb2WrjBQ8TU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-IKb5SNlgMcyyescI_bQdWw-1; Tue, 04 Feb 2020 07:26:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51FA51137846;
 Tue,  4 Feb 2020 12:26:21 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 06D4C86C4A;
 Tue,  4 Feb 2020 12:26:11 +0000 (UTC)
Subject: Re: [PATCH v13 03/10] virtio-iommu: Implement attach/detach command
To: Peter Xu <peterx@redhat.com>
References: <20200125171955.12825-1-eric.auger@redhat.com>
 <20200125171955.12825-4-eric.auger@redhat.com>
 <20200203134915.GA155875@xz-x1>
 <ce49f691-d944-2e5e-87a3-7e7c9651c2af@redhat.com>
 <20200203151917.GD155875@xz-x1>
 <5289913a-43fc-aaae-5b82-151922de93bf@redhat.com>
 <20200203181938.GE155875@xz-x1>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <75625c27-88da-c26b-7ee6-ab3f57b55906@redhat.com>
Date: Tue, 4 Feb 2020 13:26:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200203181938.GE155875@xz-x1>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: IKb5SNlgMcyyescI_bQdWw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 quintela@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 2/3/20 7:19 PM, Peter Xu wrote:
> On Mon, Feb 03, 2020 at 06:46:36PM +0100, Auger Eric wrote:
>> Hi Peter,
>>
>> On 2/3/20 4:19 PM, Peter Xu wrote:
>>> On Mon, Feb 03, 2020 at 03:59:00PM +0100, Auger Eric wrote:
>>>
>>> [...]
>>>
>>>>>> +static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *ep)
>>>>>> +{
>>>>>> +    QLIST_REMOVE(ep, next);
>>>>>> +    g_tree_unref(ep->domain->mappings);
>>>>>
>>>>> Here domain->mapping is unreferenced for each endpoint, while at [1]
>>>>> below you only reference the domain->mappings if it's the first
>>>>> endpoint.  Is that problematic?
>>>> in [1] I take a ref to the domain->mappings if it is *not* the 1st
>>>> endpoint. This aims at deleting the mappings gtree when the last EP is
>>>> detached from the domain.
>>>>
>>>> This fixes the issue reported by Jean in:
>>>> https://patchwork.kernel.org/patch/11258267/#23046313
>>>
>>> Ah OK. :)
>>>
>>> However this is tricky.  How about do explicit g_tree_destroy() in
>>> virtio_iommu_detach() when it's the last endpoint?  I see that you
>>> have:
>>>
>>>     /*
>>>      * when the last EP is detached, simply remove the domain for
>>>      * the domain list and destroy it. Note its mappings were already
>>>      * freed by the ref count mechanism. Next operation involving
>>>      * the same domain id will re-create one domain object.
>>>      */
>>>     if (QLIST_EMPTY(&domain->endpoint_list)) {
>>>         g_tree_remove(s->domains, GUINT_TO_POINTER(domain->id));
>>>     }
>>>
>>> Then it becomes:
>>>
>>>     if (QLIST_EMPTY(&domain->endpoint_list)) {
>>>         g_tree_destroy(domain->mappings);
>>>         g_tree_remove(s->domains, GUINT_TO_POINTER(domain->id));
>>>     }
>>>
>>> And also remove the trick in attach() so you take the domain ref
>>> unconditionally.  Would that work?
>> Yes I think so. On the other hand this ref counting mechanism is also
>> made for that purpose of destroying objects without being forced to
>> explicitly call the destroy function.
> 
> IMHO that's two different things.  g_tree_destroy() should be the same
> as g_tree_unref() here when the tree is empty.  It's really a matter
> of easy reading of code:
> 
> void
> g_tree_destroy (GTree *tree)
> {
>   g_return_if_fail (tree != NULL);
> 
>   g_tree_remove_all (tree);
>   g_tree_unref (tree);
> }
> 
> What we really changed here is to allow the ref/unref to be clearly
> paired, i.e., for each EP it'll ref once and unref once.  The prvious
> solution has the trick in that the 1st EP don't ref, the latter EPs
> ref, and when the domain quits it doesn't unref to match the first
> ref.  It's error prone to me.  Then, if we can do it in the paired way
> easily, I don't see why not...

OK. I will respin according to your suggestion.

Thanks

Eric
> 
> Thanks,
> 


