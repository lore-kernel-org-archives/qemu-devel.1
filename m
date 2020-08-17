Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA5CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C7B20729
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/s9PD13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C7B20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gH9-0003tr-Fw
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k7gGI-0002jw-30
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56577
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k7gGG-000609-Df
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597675039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MAMwAvvPV1op6Mgn7xllFjl6VlguVKoB8umGZ5y8VN8=;
 b=Y/s9PD13O/Z3jcP6O31bQSONM7CG3UQtM3hwacIehGmNrjvtF3Ey9LYSqPZVDCSOZX4RfV
 anBdnEaDEhoUyMkGexRFyRbMd1oo0C3amrVMVJm4qwedQv1OzDmcXNhQxZfLDpDEEZUbiU
 ExcWTTwJ4beNaAaI0Y2s85UWIkHR/Kg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-_sO6nA9iN7K-r3F96HBo5g-1; Mon, 17 Aug 2020 10:37:16 -0400
X-MC-Unique: _sO6nA9iN7K-r3F96HBo5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2576B81F000;
 Mon, 17 Aug 2020 14:37:15 +0000 (UTC)
Received: from gondolin (ovpn-112-230.ams2.redhat.com [10.36.112.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8218C784BB;
 Mon, 17 Aug 2020 14:37:07 +0000 (UTC)
Date: Mon, 17 Aug 2020 16:37:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: virtio-vsock requires 'disable-legacy=on' in QEMU 5.1
Message-ID: <20200817163704.33590236.cohuck@redhat.com>
In-Reply-To: <20200817131128.lgxn3pyzuzly4edp@steredhat>
References: <CAGxU2F7pVNWtJG2BM2bk9qtJ_UHgDw4kjVqRmL-=yme7VX83Vg@mail.gmail.com>
 <20200813112820.62ffd63e.cohuck@redhat.com>
 <20200813102430.vjnc56anqjaxn4tw@steredhat.lan>
 <20200813123737.25ba11d2.cohuck@redhat.com>
 <20200813120415.s5we6mihe6fywm4a@steredhat.lan>
 <20200817122746.0b786372.cohuck@redhat.com>
 <20200817131128.lgxn3pyzuzly4edp@steredhat>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 00:24:04
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Qinghua Cheng <qcheng@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Aug 2020 15:11:28 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> On Mon, Aug 17, 2020 at 12:27:46PM +0200, Cornelia Huck wrote:

> > Speaking of tests: do you have a quick way to test vhost-vsock at hand?
> > Maybe I should add it to my manual repertoire...
> >   
> 
> Sure, maybe the quickest way is to use ncat. Starting from version 7.80,
> it supports AF_VSOCK sockets:
> 
>     host$ ./qemu-system-x86_64 ... -device vhost-vsock-pci,guest-cid=5
> 
>     host$ ncat --vsock -l 1234
> 
>     # vsock address is <cid, port>, cid=2 is used always to reach the host
>     guest$ ncat --vsock 2 1234
> 
> Other tests that I usually run are:
> - iperf-vsock: https://github.com/stefano-garzarella/iperf-vsock
> - vsock test suite in the Linux kernel (tools/testing/vsock)
> 
> Let me know if you want more details on these :-)

Thanks, simply doing some smoke tests with ncat should be enough :)


