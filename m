Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A35BC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383D521835
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMZE/b4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383D521835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTSk8-00084z-8D
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTSeN-0008A3-Mi
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jTSaO-0003sS-Ca
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:59:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26875
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jTSaN-0003sB-TD
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588089350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wOf0Jpr0ee2zbxzrKU+r+1XY2I+WCAD4IqhLIIVAlj0=;
 b=JMZE/b4wenVJp4zt2YfYJDzC+xijT62S0sWD3qumpqRzOXKN6pQU/vc5aAot/wHNalGjnm
 AO81ijEPPuyigCWnurGTZUvubivb8U6oHmXOkD2Agt/2dt4ksBmPAAGnaE1C8yTisQR/7F
 QD8cgM+vBGybPvQiXI9atDwQwQ9NldE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-ktoE_tihOICukJUued77QQ-1; Tue, 28 Apr 2020 11:55:48 -0400
X-MC-Unique: ktoE_tihOICukJUued77QQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD7D4873092;
 Tue, 28 Apr 2020 15:55:47 +0000 (UTC)
Received: from work-vm (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC8FA61374;
 Tue, 28 Apr 2020 15:55:43 +0000 (UTC)
Date: Tue, 28 Apr 2020 16:55:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [Qemu-devel] Should memory hotplug work with vhost-user backends?
Message-ID: <20200428155541.GI2794@work-vm>
References: <CAFubqFuvE9oz-N2c7Tw70sdvVDsfO7LmHD3bbRabLUpw6z5KWg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFubqFuvE9oz-N2c7Tw70sdvVDsfO7LmHD3bbRabLUpw6z5KWg@mail.gmail.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Raphael Norwitz (raphael.s.norwitz@gmail.com) wrote:
> > > I've briefly looked through the libvhost-user code and the hot-add pa=
th
> > > looks safe enough to me (or at least no more broken than the regular
> > > vhost-user memory hot-add path).
> > >
> > > Can you elaborate a little more about why memory hot-add is unsafe wi=
th
> > > vhost-user device backends built with libvhost-user, as opposed to th=
ose
> > > using the raw vhost-user protocol semantics?
> >
> > The libvhost-user problem is that the library is mostly designed for a
> > single-threaded event loop that handles all virtqueue and vhost-user
> > protocol activity.
> >
> > As soon as virtqueues are handled by dedicated threads there are race
> > conditions between the virtqueue threads and the vhost-user protocol
> > thread.
> >
> > A virtqueue thread may or may not have an up-to-date view of memory
> > translation.  This can result in it missing memory that is currently
> > being hotplugged and continuing to access memory that has been removed.
> >
>=20
> I agree - this is definitely seems like a problem if memory is being remo=
ved,
> but I don=E2=80=99t see how a virtqueue thread may have an outdated view =
of memory
> in the hot-add case.

In the vhost-user client it gets a bit tricky because the setmemtable
command doesn't give differences - it gives a whole mapping table; so
the way libvhost-user does it is to perform a whole new set of mappings.
While the qemu and kernel side doesn't see any change, the mappings do
change in the client.  This probably needs a protocol improvement.

> libvhost-user now supports the REPLY_ACK feature, so that on hot-add qemu
> will wait for a response from the backend, confirming the new memory was
> successfully mapped in, before returning from vhost_user_set_mem_table().=
 If
> the new memory is mapped in by the backend before the ram is exposed to t=
he
> guest, how could a virtqueue thread receive operations on missing memory?

Yeh, I think use of that new memory isn't that bad.

Dave

> > Dave might have additional comments.
> >
> > Stefan
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


