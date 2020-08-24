Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9630C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 08:58:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 702752087D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 08:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXOgT+lB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702752087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA8Ir-0005Ck-Ig
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 04:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kA8IK-0004mG-7n
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 04:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kA8IH-00071b-FM
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 04:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598259451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AlH3sev1eaSlLwiARCIZaMt4DFNOqgGG6m0BR2RzBHU=;
 b=bXOgT+lB55lCjL9LvG4KcREcJXHvhGl7cNolfZ/946Oy0sTpLnFe/jNjLwqV0IDmFMpbQs
 TAsVmt32cbzmWxtUjGOBHLj6I7zwlAuR4fw5aIIJEP0abo+Bbh1X2BERCjgxKqrD8kaxVy
 C8SSdl+u8hksMcobpNVJwK+m7uDA8XE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-IYlgezzpNEGNDw0gpKLfVQ-1; Mon, 24 Aug 2020 04:57:13 -0400
X-MC-Unique: IYlgezzpNEGNDw0gpKLfVQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D92581F012;
 Mon, 24 Aug 2020 08:57:12 +0000 (UTC)
Received: from work-vm (ovpn-114-59.ams2.redhat.com [10.36.114.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2544680920;
 Mon, 24 Aug 2020 08:57:09 +0000 (UTC)
Date: Mon, 24 Aug 2020 09:57:07 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zheng Chuan <zhengchuan@huawei.com>
Subject: Re: [PATCH v3 05/10] migration/dirtyrate: Record hash results for
 each sampled page
Message-ID: <20200824085707.GA2645@work-vm>
References: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
 <1597634433-18809-6-git-send-email-zhengchuan@huawei.com>
 <20200820173009.GM2664@work-vm>
 <20200820175149.GA244434@redhat.com>
 <20200820175512.GQ2664@work-vm>
 <95894cf7-ba09-9862-357a-1073a192e934@huawei.com>
 <20200821123014.GK348677@redhat.com>
 <20200821123910.GC2655@work-vm>
 <cf76fa9f-1395-3b0c-2ef1-b02f8fb552c1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <cf76fa9f-1395-3b0c-2ef1-b02f8fb552c1@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 04:38:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 zhang.zhanghailiang@huawei.com, quintela@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Zheng Chuan (zhengchuan@huawei.com) wrote:
> 
> 
> On 2020/8/21 20:39, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrangé (berrange@redhat.com) wrote:
> >> On Fri, Aug 21, 2020 at 08:22:06PM +0800, Zheng Chuan wrote:
> >>>
> >>>
> >>> On 2020/8/21 1:55, Dr. David Alan Gilbert wrote:
> >>>> * Daniel P. BerrangÃ© (berrange@redhat.com) wrote:
> >>>>> On Thu, Aug 20, 2020 at 06:30:09PM +0100, Dr. David Alan Gilbert wrote:
> >>>>>> * Chuan Zheng (zhengchuan@huawei.com) wrote:
> >>>>>>> Record hash results for each sampled page.
> >>>>>>>
> >>>>>>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> >>>>>>> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> >>>>>>> ---
> >>>>>>>  migration/dirtyrate.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >>>>>>>  migration/dirtyrate.h |   7 +++
> >>>>>>>  2 files changed, 151 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> >>>>>>> index c4304ef..62b6f69 100644
> >>>>>>> --- a/migration/dirtyrate.c
> >>>>>>> +++ b/migration/dirtyrate.c
> >>>>>>> @@ -25,6 +25,7 @@
> >>>>>>>  #include "dirtyrate.h"
> >>>>>>>  
> >>>>>>>  CalculatingDirtyRateState CalculatingState = CAL_DIRTY_RATE_INIT;
> >>>>>>> +static unsigned long int qcrypto_hash_len = QCRYPTO_HASH_LEN;
> >>>>>>
> >>>>>> Why do we need this static rather than just using the QCRYPTO_HASH_LEN ?
> >>>>>> It's never going to change is it?
> >>>>>> (and anyway it's just a MD5 len?)
> >>>>>
> >>>>> I wouldn't want to bet on that given that this is use of MD5. We might
> >>>>> claim this isn't security critical, but surprises happen, and we will
> >>>>> certainly be dinged on security audits for introducing new use of MD5
> >>>>> no matter what.
> >>>>>
> >>>>> If a cryptographic hash is required, then sha256 should be the choice
> >>>>> for any new code that doesn't have back compat requirements.
> >>>>>
> >>>>> If a cryptographic hash is not required then how about crc32 
> >>>>
> >>>> It doesn't need to be cryptographic; is crc32 the fastest reasonable hash for use
> >>>> in large areas?
> >>>>
> >>>> Dave
> >>>>
> >>>>> IOW, it doesn't make a whole lot of sense to say we need a cryptographic
> >>>>> hash, but then pick the most insecure one.
> >>>>>
> >>>>> sha256 is slower than md5, but it is conceivable that in future we might
> >>>>> gain support for something like Blake2b which is similar security level
> >>>>> to SHA3, while being faster than MD5.
> >>>>>
> >>>>> Overall I'm pretty unethusiastic about use of MD5 being introduced and
> >>>>> worse, being hardcoded as the only option.
> >>>>>
> >>>>> Regards,
> >>>>> Daniel
> >>>>> -- 
> >>>>> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> >>>>> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> >>>>> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> >>>
> >>> Hi, Daniel, Dave.
> >>>
> >>> I do compare MD5 and SHA256 with vm memory of 128G under mempress of 100G.
> >>>
> >>> 1. Calculation speed
> >>> 1） MD5 takes about 500ms to sample and hash all pages by record_ramblock_hash_info().
> >>> 2)  SHA256 takes about 750ms to sample all pages by record_ramblock_hash_info().
> >>>
> >>> 2. CPU Consumption
> >>> 1)  MD5 may have instant rise up to 48% for dirtyrate thread
> >>> 2)  SHA256 may have instant rise up to 75% for dirtyrate thread
> >>>
> >>> 3. Memory Consumption
> >>> SHA256 may need twice memory than MD5 due to its HASH_LEN.
> >>>
> >>> I am trying to consider if crc32 is more faster and takes less memory and is more safer than MD5?
> >>
> >> No, crc32 is absolutely *weaker* than MD5. It is NOT a cryptographic
> >> hash so does not try to guarantee collision resistance. It only has
> >> 2^32 possible outputs.
> >>
> >> MD5 does try to guarantee collision resistance, but MD5 is considered
> >> broken these days, so a malicious attacker can cause collisions if they
> >> are motivated enough.
> >>
> >> IOW if you need collision resistance that SHA256 should be used.
> > 
> > There's no need to guard against malicious behaviour here - this is just
> > a stat to guide migration.
> > If CRC32 is likely to be faster than md5 I suspect it's enough.
> > 
> > Dave
> > 
> Hi，Dave, Daniel.
> 
> I did test by crc32，it is much faster than MD5 and SHA256:)
> 
> As for 128G vm it takes only about 50ms to sample and hash all pages by record_ramblock_hash_info().
> And the dirtyrate calculation is still good enough:)
> ++++++++++++++++++++++++++++++++++++++++++
> |                      |    dirtyrate    |
> ++++++++++++++++++++++++++++++++++++++++++
> | no mempress          |     4MB/s       |
> ------------------------------------------
> | mempress 4096 1024   |    1248MB/s     |
> ++++++++++++++++++++++++++++++++++++++++++
> | mempress 4096 4096   |    4060MB/s     |
> ++++++++++++++++++++++++++++++++++++++++++
> 
> I will take crc32 in PatchV4, is that OK from the perspective of safety?

Yes, it's fine since it's only a heuristic anyway.

Dave

> In my opinion, it should be safe.
> The crc32 is only for compare and the recorder will be free after calculation is over.
> The output is just dirtyrate for user to guide migration.
> 
> What's more, i consider increase DIRTYRATE_DEFAULT_SAMPLE_PAGES from 256 to 512
> which may takes about 75ms to sample and hash all pages by record_ramblock_hash_info().
> 
> >>
> >> Regards,
> >> Daniel
> >> -- 
> >> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> >> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> >> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


