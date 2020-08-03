Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B7CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ECBA2067D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhgM/TKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECBA2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2Wkj-0005Rb-2T
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 05:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k2Wk8-0004z9-Ng
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:26:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27349
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k2Wk5-00065q-Eh
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596446807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oh+ywYm+wHmKEHr+sZxTJWbIQVVBiYGqmhQGXkgDK/o=;
 b=AhgM/TKQ9qYNbBdcSupaxeV4ZzpU1aEPDIhaOtLQ5+NWWqiPgBLZU2Pi7Pxv9ZcPzeZLlZ
 bMLlNMnvTpoxQ2z7cDdtEn+n6nBqHzde+2QpmXLcsFxv9fd8DLG/wSRGE3r/b3qZkjNTWr
 4AgJo4ZQK2Bng2LOpG3g8fk9DKw+zgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-lN9ZWlAqN1Sp2yM7-e50sA-1; Mon, 03 Aug 2020 05:26:39 -0400
X-MC-Unique: lN9ZWlAqN1Sp2yM7-e50sA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD47D18C63C0;
 Mon,  3 Aug 2020 09:26:38 +0000 (UTC)
Received: from gondolin (ovpn-112-197.ams2.redhat.com [10.36.112.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8312619C58;
 Mon,  3 Aug 2020 09:26:29 +0000 (UTC)
Date: Mon, 3 Aug 2020 11:26:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH 2/2] libvhost-user: handle endianness as mandated by the
 spec
Message-ID: <20200803112626.67f55526.cohuck@redhat.com>
In-Reply-To: <20200730140731.32912-3-mhartmay@linux.ibm.com>
References: <20200730140731.32912-1-mhartmay@linux.ibm.com>
 <20200730140731.32912-3-mhartmay@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:37:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jul 2020 16:07:31 +0200
Marc Hartmayer <mhartmay@linux.ibm.com> wrote:

> Since virtio existed even before it got standardized, the virtio
> standard defines the following types of virtio devices:
> 
>  + legacy device (pre-virtio 1.0)
>  + non-legacy or VIRTIO 1.0 device
>  + transitional device (which can act both as legacy and non-legacy)
> 
> Virtio 1.0 defines the fields of the virtqueues as little endian,
> while legacy uses guest's native endian [1]. Currently libvhost-user
> does not handle virtio endianness at all, i.e. it works only if the
> native endianness matches with whatever is actually needed. That means
> things break spectacularly on big-endian targets. Let us handle virtio
> endianness for non-legacy as required by the virtio specification
> [1]. 

Maybe add

"and fence legacy virtio, as there is no safe way to figure out the
needed endianness conversions for all cases."

> The fencing of legacy virtio devices is done in
> `vu_set_features_exec`.

Not that I disagree with fencing legacy virtio, but looking at some
vhost-user* drivers, I'm not sure everything will work as desired for
those (I might be missing something, though.)

- vhost-user-blk lists VERSION_1 in the supported features, but
  vhost-user-scsi doesn't... is there some inheritance going on that
  I'm missing?
- vhost-user-gpu-pci inherits from virtio-gpu-pci, so I guess it's fine
- vhost-user-input should also always have been virtio-1

So, has anybody been using vhost-user-scsi and can confirm that it
still works, or at least can be made to work?

> 
> [1] https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-210003
> 
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 77 +++++++++++++++------------
>  1 file changed, 43 insertions(+), 34 deletions(-)

The code change per se LGTM.


