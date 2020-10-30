Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B12C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B759206E3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHja2iVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B759206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRPs-0008W2-8v
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYROe-0007Fc-Dv
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:12:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYROc-0003r3-R1
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604052754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UM5f9Kvis6JZbzag/0+drIalW5ea3ncMMS7qOLfDzxE=;
 b=OHja2iVX6wvkFpPTp7w066QH8VGSKLYvP4CerhV9ldRaORurFCM+yb8GUTCJLN3yVHNXmO
 k2Gc7h4I7fOc0WJrusSlkwXYIfGeM4VVmRbwTduRtCJOhJ0tv9IHSaU8HcFqNtyYZc4j3g
 jmYGgU2LauoHF1S3mo0zWbw6OAklp9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-VMO7yFq0MGmCJ0_XQN58cw-1; Fri, 30 Oct 2020 06:12:32 -0400
X-MC-Unique: VMO7yFq0MGmCJ0_XQN58cw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE12C5708A;
 Fri, 30 Oct 2020 10:12:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BC52619C4;
 Fri, 30 Oct 2020 10:12:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C75E1113865F; Fri, 30 Oct 2020 11:12:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 00/11] sockets: Attempt to drain the abstract socket swamp
References: <20201029133833.3450220-1-armbru@redhat.com>
 <07eb80c1-6d56-2bd4-c8be-90a34167ae91@redhat.com>
Date: Fri, 30 Oct 2020 11:12:18 +0100
In-Reply-To: <07eb80c1-6d56-2bd4-c8be-90a34167ae91@redhat.com> (Paolo
 Bonzini's message of "Thu, 29 Oct 2020 19:06:19 +0100")
Message-ID: <87lffovx8d.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
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
Cc: kwolf@redhat.com, berrange@redhat.com, zxq_yx_007@163.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 29/10/20 14:38, Markus Armbruster wrote:
>> In my opinion, the Linux-specific abstract UNIX domain socket feature
>> introduced in 5.1 should have been rejected.  The feature is niche,
>> the interface clumsy, the implementation buggy and incomplete, and the
>> test coverage insufficient.  Review fail.
>> 
>> Fixing the parts we can still fix now is regrettably expensive.  If I
>> had the power to decide, I'd unceremoniously revert the feature,
>> compatibility to 5.1 be damned.  But I don't, so here we go.
>> 
>> I'm not sure this set of fixes is complete.  However, I already spent
>> too much time on this, so out it goes.  Lightly tested.
>> 
>> Regardless, I *will* make time for ripping the feature out if we
>> decide to do that.  Quick & easy way to avoid reviewing this series
>> *hint* *hint*.
>
> Apart from the nits pointed out in patch 7 (commit message) and 8 (code),
>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Thanks, and don't forget to fix the hole that your head has left in the
> wall.

Thanks for the review, and thanks for cheering my up!


