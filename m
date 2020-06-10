Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23829C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 11:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BB9204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 11:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUztCxzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BB9204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiz5N-0005ec-6t
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 07:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jiz3J-00046G-PO
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 07:37:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31713
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jiz3I-0006wP-7S
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 07:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591789070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7uNNal8+pm0GW3Bju4cwHR+lAGH9Kh3rV4tnWZvlDLk=;
 b=PUztCxzhWhlug0Br5tYK4bmYQHhvswVWZY8a7ymuDMDkgUIL8ImCZZVkuSV6O2U6LVjJMd
 XT4wRgxBEfUZn8rpp0WnMvo0k1HNeVgvrZCoh8rqHs05CBMMkcUrHJF1VCuqA7XGMjy2n9
 epsDAgv+JNqga5FMPabump7Rix31sxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-6DdRQvAFM-ibMZG_Wu7F5A-1; Wed, 10 Jun 2020 07:37:46 -0400
X-MC-Unique: 6DdRQvAFM-ibMZG_Wu7F5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 613E11005513;
 Wed, 10 Jun 2020 11:37:45 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-151.ams2.redhat.com [10.36.113.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5F2F5D9D5;
 Wed, 10 Jun 2020 11:37:43 +0000 (UTC)
Date: Wed, 10 Jun 2020 13:37:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Sam Eiderman <sameid@google.com>
Subject: Re: Clarification regarding new qemu-img convert --target-is-zero flag
Message-ID: <20200610113742.GC6947@linux.fritz.box>
References: <CAFr6bU=LjeW5_eGtwL38cher2TM52skohuANNXN9EpO+mA-z8Q@mail.gmail.com>
 <f93b4d9a-4963-74e9-4f52-f95a187f6055@virtuozzo.com>
 <CAFr6bU=tzuQNQSm4AAdYHanmTDx6fpK64OvXST2MZ5s8LqhGMA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFr6bU=tzuQNQSm4AAdYHanmTDx6fpK64OvXST2MZ5s8LqhGMA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 david.edmondson@oracle.com, Tony Zhang <tzz@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.06.2020 um 08:28 hat Sam Eiderman geschrieben:
> Hi,
> 
> My target format is a Persistent Disk on GCP.
> https://cloud.google.com/persistent-disk
> 
> And my use case is converting VMDKs to PDs so I'm just using qemu-img
> for the conversion (not using qemu as a hypervisor).
> 
> Luckily PDs are zeroed out when allocated but I was asking to
> understand the restrictions of qemu-img convert.
> 
> It could be useful for qemu-img convert to not zero out the disk, but
> do write allocated zeroes, I'm imagining cloud scenarios where instead
> of virtual disks the customer receives an attached physical SSD device
> that is not zeroed out beforehand (only encryption key changed, for
> privacy/security sake) so reads will return garbage.

But that's the default mode? Zeroing out the whole disk upfront is an
optimisation that we do if efficient zeroing is possible, but if we
can't, we just write explicit zeros where needed.

--target-is-zero means that you promise that the target is already
pre-zeroed so qemu-img can further optimise things. If you specify it
and the target doesn't contain zeros, but random data, you get garbage.

Kevin


