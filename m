Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5604C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 18:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7348D20720
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 18:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtyzEsXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7348D20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9BgC-00042R-N5
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 14:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k9Bfb-0003Jy-HB
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 14:21:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40602
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k9BfZ-0008Rr-VU
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 14:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598034101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9iVBIrZhGuf8FWz07+EXr1m8HzsRSNy3xHKgbUJLIBU=;
 b=WtyzEsXkDo9clom1wEt0e4AEXFSiDQO3yG9KJjGnrPfBPtPEAZtbXYnA24ezxAI67iCf5I
 ceSoj0T5CIjVVJJYlZN8ielFHjfHtIxuZ5G0A8QEZRRKQ9CODv8xlykGtRrP2P6bArCtbK
 1BEuU8wtK2JuhoFjksDgzTfxC9PQW1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-4ahjCOWpN42VoolToMIG-w-1; Fri, 21 Aug 2020 14:21:39 -0400
X-MC-Unique: 4ahjCOWpN42VoolToMIG-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D71C281CAFD;
 Fri, 21 Aug 2020 18:21:36 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB2C65C1D0;
 Fri, 21 Aug 2020 18:21:27 +0000 (UTC)
Date: Fri, 21 Aug 2020 14:21:27 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: Suspicious QOM types without instance/class size
Message-ID: <20200821182127.GM642093@habkost.net>
References: <20200820215529.GH642093@habkost.net>
 <b60d899c-228f-5b75-ba16-beecb90b8b08@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b60d899c-228f-5b75-ba16-beecb90b8b08@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Cameron Esfahani <dirty@apple.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 11:40:12AM +0200, David Hildenbrand wrote:
> On 20.08.20 23:55, Eduardo Habkost wrote:
> > While trying to convert TypeInfo declarations to the new
> > OBJECT_DECLARE* macros, I've stumbled on a few suspicious cases
> > where instance_size or class_size is not set, despite having type
> > checker macros that use a specific type.
> > 
> > The ones with "WARNING" are abstract types (maybe not serious if
> > subclasses set the appropriate sizes).  The ones with "ERROR"
> > don't seem to be abstract types.
[...]
> > ERROR: hw/s390x/virtio-ccw.c:1237:1: class_size should be set to sizeof(VirtioCcwBusClass)?
> 
> The parent of TYPE_VIRTIO_CCW_BUS is TYPE_VIRTIO_BUS.
> 
> typedef struct VirtioBusClass VirtioCcwBusClass;
> 
> So I guess the sizes match? Anyhow, setting doesn't hurt.

Thanks for checking.  Yeah, the sizes match today.

It's a good idea to set it, just in case a real VirtioCcwBusClass
struct gets created one day.

-- 
Eduardo


