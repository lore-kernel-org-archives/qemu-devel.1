Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49F9C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF89B20775
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLevW/xz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF89B20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0NB9-0005Xx-20
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 06:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0NAb-00057T-SW
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:49:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21218
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0NAZ-0004Ku-QS
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595933354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DmT1eI01BzeIIMsat94yL5ZlTrQNy/w8csJXnhioZjk=;
 b=cLevW/xzLi87DWB9ebdU8pCs8oJPMKro+hK5DbXxxPeetqA0As47rPpK4sLyxWylv7OVGb
 ODcTCMkQ5yc3CysXgB64npElSqxCYZFJ5rbAh4LujPiBReUs7Xx/D1Cm8EoQle3sHOYiFg
 Fk3WeW7LBk23qNy/IC8fz/c8+S89dy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-ZzZV_khqNK-cJj7nTf0Xeg-1; Tue, 28 Jul 2020 06:49:05 -0400
X-MC-Unique: ZzZV_khqNK-cJj7nTf0Xeg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1784E107ACCA;
 Tue, 28 Jul 2020 10:49:04 +0000 (UTC)
Received: from gondolin (ovpn-113-21.ams2.redhat.com [10.36.113.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 212CC712C2;
 Tue, 28 Jul 2020 10:48:52 +0000 (UTC)
Date: Tue, 28 Jul 2020 12:48:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC v2 2/3] libvhost-user: handle endianness as mandated by
 the spec
Message-ID: <20200728124850.7c15eade.cohuck@redhat.com>
In-Reply-To: <20200721184456.1305ca0b.pasic@linux.ibm.com>
References: <20200717092929.19453-1-mhartmay@linux.ibm.com>
 <20200717092929.19453-3-mhartmay@linux.ibm.com>
 <20200721093942-mutt-send-email-mst@kernel.org>
 <20200721184456.1305ca0b.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 06:02:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 18:44:56 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Tue, 21 Jul 2020 09:40:10 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, Jul 17, 2020 at 11:29:28AM +0200, Marc Hartmayer wrote:  
> > > Since virtio existed even before it got standardized, the virtio
> > > standard defines the following types of virtio devices:
> > > 
> > >  + legacy device (pre-virtio 1.0)
> > >  + non-legacy or VIRTIO 1.0 device
> > >  + transitional device (which can act both as legacy and non-legacy)
> > > 
> > > Virtio 1.0 defines the fields of the virtqueues as little endian,
> > > while legacy uses guest's native endian [1]. Currently libvhost-user
> > > does not handle virtio endianness at all, i.e. it works only if the
> > > native endianness matches with whatever is actually needed. That means
> > > things break spectacularly on big-endian targets. Let us handle virtio
> > > endianness for non-legacy as required by the virtio specification
> > > [1]. We will fence non-legacy virtio devices with the upcoming patch.
> > > 
> > > [1] https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-210003
> > > 
> > > Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> > > 
> > > ---
> > > Note: As we don't support legacy virtio devices    
> > 
> > Who's "we" in this sentence? vhost user supports legacy generally ...  
> 
> In that sentence "we" is the library "libvhost-user". I would like
> to avoid s390x being an oddball regarding this. Marc's previous
> version made an attempt at correct endianness handling for legacy
> and non-legacy. That spawned a discussion on how we don't want
> legacy devices in this context. This series makes what seemed to be the
> consensus reached in that discussion explicit: namely that libvhost-user
> does not support legacy-virtio.

Can someone please clarify what libvhost-user actually supports?

virtio-fs is clearly non-legacy only, but in the changelog I also see a
mention of scsi, and that one probably does support legacy?

Can we make a distinction along the lines of:
- if we are non-legacy, we support any endianness;
- if we are legacy, we support little endian host/guest only?


