Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4B4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 483BC20737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEqNbE9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483BC20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrMIm-0005cw-DA
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 10:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jrMIC-0005CT-82
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:03:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54917
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jrMI9-0002T0-Mc
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593785028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDUlctDVRYseK62Y7Vsmjo4FnU9Xx/FySZzX+/fNYY8=;
 b=CEqNbE9gQQBrVihA1ydoG7G0sk+/Z3zMIylkpcftDFeGERLxd9zIs0kw5bZhn2/n27+15P
 lwh/s0t7TO7t+DfyFA9Ybc4I7SEMzuywGjCoWiHbnOA0Z+EqNMvWypA6JpZZr8glk8fGXF
 2aN7/PW6ahNaqoiihPwfkFjr7DAAlUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-65CS4xhpNoCJCWrRasmi9g-1; Fri, 03 Jul 2020 10:03:44 -0400
X-MC-Unique: 65CS4xhpNoCJCWrRasmi9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97C96186A206;
 Fri,  3 Jul 2020 14:03:42 +0000 (UTC)
Received: from gondolin (ovpn-113-54.ams2.redhat.com [10.36.113.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 361FC6AD0C;
 Fri,  3 Jul 2020 14:03:35 +0000 (UTC)
Date: Fri, 3 Jul 2020 16:03:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 0/2] two atomic_cmpxchg() related fixes
Message-ID: <20200703160332.78301244.cohuck@redhat.com>
In-Reply-To: <20200703153711.3aa18ac7.pasic@linux.ibm.com>
References: <20200616045035.51641-1-pasic@linux.ibm.com>
 <20200701140106.004a3da2.cohuck@redhat.com>
 <3674a552-fdf3-ffad-a729-efcb730adf1c@de.ibm.com>
 <20200703153711.3aa18ac7.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Jul 2020 15:37:11 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 1 Jul 2020 14:06:11 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > 
> > 
> > On 01.07.20 14:01, Cornelia Huck wrote:  
> > > On Tue, 16 Jun 2020 06:50:33 +0200
> > > Halil Pasic <pasic@linux.ibm.com> wrote:
> > >   
> > >> The story short: compiler can generate code that does two
> > >> distinct fetches of *ind_addr for old and _old. If that happens we can
> > >> not figure out if we had the desired xchg or not.
> > >>
> > >> Halil Pasic (2):
> > >>   virtio-ccw: fix virtio_set_ind_atomic
> > >>   s390x/pci: fix set_ind_atomic
> > >>
> > >>  hw/s390x/s390-pci-bus.c | 16 +++++++++-------
> > >>  hw/s390x/virtio-ccw.c   | 18 ++++++++++--------
> > >>  2 files changed, 19 insertions(+), 15 deletions(-)
> > >>
> > >>
> > >> base-commit: 7d3660e79830a069f1848bb4fa1cdf8f666424fb  
> > > 
> > > Have we managed to reach any kind of agreement on this? (A v2?)
> > > 
> > > We can still get in fixes post-softfreeze, of course.  
> > 
> > Unless Halil has a v2 ready, 
> > I think the current patch is fine as is as a fix. I would suggest
> > to go with that and we can then do more beautification later when
> > necessary.
> > 
> >   
> 
> I think we were waiting for Paolo to chime in regarding the barrier().
> The thing I could beautify is using atomic_read(), but frankly I'm not
> sure about it, especially considering multi-proccess. My understanding of
> volatile is better than my understanding of atomic_read(). On the other
> hand, same multi-process question can be asked about atomic_cmpxchg()
> and __atomic_compare_exchange_n()...

We can just improve the code on top later. Having something that
works now beats something not yet developed that might be nicer :)

(But yes, it also might be good to look at non-s390 examples of this
pattern and check if something can be done in a more central place.)


