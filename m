Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD6CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B991622CF8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPPVotjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B991622CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3FYA-0007Ib-PN
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 05:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3FX4-0006lB-3N
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:16:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30640
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3FX0-0003hJ-Fl
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596618977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PsEjecBTSLJ4ftcms3D8R+or2TN4CMjjwvtPDvMx4Hk=;
 b=TPPVotjbs6QTbioauViFIptUFOMcrnxzSpTxdh1ua+RoMABqlC9kwdjDPev41fe8+xVEF1
 j/RkjnYd0N71H0MLHsmaDdPGf+NlYRldhRnrurwc6L2CY2hCvQx6yBn+bBDVJQxCVao/wp
 C1fgkh/caMJ+Lseo5wxFgNutSmXGKss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-cbd4H_VAOvib9oWTveTLZw-1; Wed, 05 Aug 2020 05:16:15 -0400
X-MC-Unique: cbd4H_VAOvib9oWTveTLZw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAB4A19057A2;
 Wed,  5 Aug 2020 09:16:13 +0000 (UTC)
Received: from gondolin (ovpn-113-4.ams2.redhat.com [10.36.113.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 454925DA88;
 Wed,  5 Aug 2020 09:16:11 +0000 (UTC)
Date: Wed, 5 Aug 2020 11:16:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-5.2 2/6] pc-bios/s390-ccw: Move ipl-related code
 from main() into a separate function
Message-ID: <20200805111609.64107a1b.cohuck@redhat.com>
In-Reply-To: <6be1e380-4841-a5ea-f710-26988cdcc441@redhat.com>
References: <20200728183734.7838-1-thuth@redhat.com>
 <20200728183734.7838-3-thuth@redhat.com>
 <20200729104721.6f2b8162.cohuck@redhat.com>
 <6be1e380-4841-a5ea-f710-26988cdcc441@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 03:37:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jul 2020 13:05:08 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 29/07/2020 10.47, Cornelia Huck wrote:
> > On Tue, 28 Jul 2020 20:37:30 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> Let's move this part of the code into a separate function to be able
> >> to use it from multiple spots later.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  pc-bios/s390-ccw/main.c | 20 ++++++++++++--------
> >>  1 file changed, 12 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> >> index 146a50760b..9b64eb0c24 100644
> >> --- a/pc-bios/s390-ccw/main.c
> >> +++ b/pc-bios/s390-ccw/main.c
> >> @@ -223,14 +223,8 @@ static void virtio_setup(void)
> >>      }
> >>  }
> >>  
> >> -int main(void)
> >> +static void ipl_boot_device(void)
> >>  {
> >> -    sclp_setup();
> >> -    css_setup();
> >> -    boot_setup();
> >> -    find_boot_device();
> >> -    enable_subchannel(blk_schid);
> >> -
> >>      switch (cutype) {
> >>      case CU_TYPE_DASD_3990:
> >>      case CU_TYPE_DASD_2107:
> >> @@ -242,8 +236,18 @@ int main(void)
> >>          break;
> >>      default:
> >>          print_int("Attempting to boot from unexpected device type", cutype);
> >> -        panic("");
> >> +        panic("\nBoot failed.\n");  
> > 
> > Maybe "Boot failed: no supported device type"?  
> 
> The print_int right before already talks about "unexpected device type",
> so I think the simple "Boot failed" should be enough?

Yes, as long as we don't end up with other boot failures printing the
same messages.


