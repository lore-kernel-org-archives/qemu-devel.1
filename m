Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6748C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA712078D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbHK2GE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA712078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jih0U-0006tq-OB
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jigz6-0005Zb-Dk
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:20:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33675
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jigz5-0007Yo-J1
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591719558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xIjfaioqmBdVChcuQCpcGGXIjUXo4w4gXfPUySK3fk8=;
 b=QbHK2GE1gnIkXL59cGoVG247P1nlPgbSf8iSUBY3HWGsWzPYuDKJ9UFNtdcfdptfZfnWFd
 2Y8v35rLMEov8y8a4K9l2CyaVsL8Rg+XTT/oPvdCiWfSI3xhHtqWPCJcMrR/hwnvwvtrlI
 CMTvNmZJNluRZcYS/FTPbjN4ZGkO980=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-FOFoOAkGP-mJYruZWnJrDw-1; Tue, 09 Jun 2020 12:19:08 -0400
X-MC-Unique: FOFoOAkGP-mJYruZWnJrDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08210107AFB2;
 Tue,  9 Jun 2020 16:18:56 +0000 (UTC)
Received: from localhost (ovpn-113-3.phx2.redhat.com [10.3.113.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E37958FF9A;
 Tue,  9 Jun 2020 16:18:14 +0000 (UTC)
Date: Tue, 9 Jun 2020 12:18:14 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 00/20] virtio-mem: Paravirtualized memory hot(un)plug
Message-ID: <20200609161814.GJ2366737@habkost.net>
References: <20200603144914.41645-1-david@redhat.com>
 <20200609091034-mutt-send-email-mst@kernel.org>
 <08385823-d98f-fd9d-aa9d-bc1bd6747c29@redhat.com>
 <20200609115814-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609115814-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 01:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 teawater <teawaterz@linux.alibaba.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Richard Henderson <rth@twiddle.net>, Eric Farman <farman@linux.ibm.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Janosch Frank <frankja@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 09, 2020 at 11:59:04AM -0400, Michael S. Tsirkin wrote:
> On Tue, Jun 09, 2020 at 03:26:08PM +0200, David Hildenbrand wrote:
> > On 09.06.20 15:11, Michael S. Tsirkin wrote:
> > > On Wed, Jun 03, 2020 at 04:48:54PM +0200, David Hildenbrand wrote:
> > >> This is the very basic, initial version of virtio-mem. More info on
> > >> virtio-mem in general can be found in the Linux kernel driver v2 posting
> > >> [1] and in patch #10. The latest Linux driver v4 can be found at [2].
> > >>
> > >> This series is based on [3]:
> > >>     "[PATCH v1] pc: Support coldplugging of virtio-pmem-pci devices on all
> > >>      buses"
> > >>
> > >> The patches can be found at:
> > >>     https://github.com/davidhildenbrand/qemu.git virtio-mem-v3
> > > 
> > > So given we tweaked the config space a bit, this needs a respin.
> > 
> > Yeah, the virtio-mem-v4 branch already contains a fixed-up version. Will
> > send during the next days.
> 
> BTW. People don't normally capitalize the letter after ":".
> So a better subject is
>   virtio-mem: paravirtualized memory hot(un)plug

I'm not sure that's still the rule:

[qemu/(49ee115552...)]$ git log --oneline v4.0.0.. | egrep ': [A-Z]' | wc -l
5261
[qemu/(49ee115552...)]$ git log --oneline v4.0.0.. | egrep ': [a-z]' | wc -l
2921

-- 
Eduardo


