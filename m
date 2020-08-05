Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD34C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC99920792
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 09:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ut509OuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC99920792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Fbl-0004ex-Tm
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 05:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3FaR-0003JS-Ht
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:19:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54378
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3FaP-0003wY-Rm
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 05:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596619189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EpRzZ4Ta339Ht5fQqx98DteyzbCaSnpT3Xf70fqQbRY=;
 b=Ut509OuYDKT3mCfjUt1UdEcSwAm/ZALaPcjQZXsI3BWeXO1vyOI/lRWTBSVwvMDd9IBV4y
 COUIm3XDQLHno/18Dwf1zcJmEGRShzMnDweD4zRX4CTMZdcRMe7X6GP3UuNgikLP0AI5Fm
 ECzYEUxD6H1PdtE2drGxjka0lMXx68o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-N_4m5D2XM5C9CtuArl57eQ-1; Wed, 05 Aug 2020 05:19:47 -0400
X-MC-Unique: N_4m5D2XM5C9CtuArl57eQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FD36100AA22;
 Wed,  5 Aug 2020 09:19:46 +0000 (UTC)
Received: from gondolin (ovpn-113-4.ams2.redhat.com [10.36.113.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A9A969314;
 Wed,  5 Aug 2020 09:19:44 +0000 (UTC)
Date: Wed, 5 Aug 2020 11:19:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-5.2 3/6] pc-bios/s390-ccw: Move the inner logic of
 find_subch() to a separate function
Message-ID: <20200805111942.2a38b64e.cohuck@redhat.com>
In-Reply-To: <667365fe-b46b-f425-bf67-a6af2b4114fe@redhat.com>
References: <20200728183734.7838-1-thuth@redhat.com>
 <20200728183734.7838-4-thuth@redhat.com>
 <20200729105426.6d8a5a61.cohuck@redhat.com>
 <667365fe-b46b-f425-bf67-a6af2b4114fe@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:45:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jul 2020 13:13:17 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 29/07/2020 10.54, Cornelia Huck wrote:
> > On Tue, 28 Jul 2020 20:37:31 +0200
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> Move the code to a separate function to be able to re-use it from a
> >> different spot later.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  pc-bios/s390-ccw/main.c | 99 ++++++++++++++++++++++++-----------------
> >>  1 file changed, 57 insertions(+), 42 deletions(-)
> >>
> >> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> >> index 9b64eb0c24..9477313188 100644
> >> --- a/pc-bios/s390-ccw/main.c
> >> +++ b/pc-bios/s390-ccw/main.c
> >> @@ -51,6 +51,60 @@ unsigned int get_loadparm_index(void)
> >>      return atoui(loadparm_str);
> >>  }
> >>  
> >> +static int check_sch_no(int dev_no, int sch_no)  
> > 
> > check_subchannel()? You verify dev_no as well, if supplied.  
> 
> Ok.
> 
> >> +{
> >> +    bool is_virtio;
> >> +    Schib schib;
> >> +    int r;
> >> +
> >> +    blk_schid.sch_no = sch_no;
> >> +    r = stsch_err(blk_schid, &schib);
> >> +    if (r == 3 || r == -EIO) {
> >> +        return -EIO;  
> > 
> > -ENODEV? It means that you either have no devices, or an invalid
> > subchannel set.  
> 
> We don't have ENODEV in the s390-ccw bios... but I could introduce it, I
> guess :-)

I always forget that we have only a subset of error codes here :)

ENODEV looks like a reasonable value to have, though.


