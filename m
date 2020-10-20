Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FAEC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1231420BED
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDEGhdng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1231420BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrfc-0000Z5-Tb
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kUrS4-0006FN-92
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kUrS2-0006vP-49
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603199594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vVZzARi07qgLmdx6A/Q8nbl2HnAOho4uuxEBCLeO4rU=;
 b=iDEGhdngrGb+G6zmkEcCFJRHXko4hhzvlfuvRKfqK/ROKcVF9QrrXHwt+PuxDrV+GNl+b4
 V5BZaAPdyPWPu+x/E2FxDOmOJOGim+Un6hd3hXYjvr29fKQAPgOtQLMM7l/FIHmB4v5gDK
 MwEP5NPSy6BqK14xUlLceiWGv9DLMJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-_jPjrPdBMcC8suFVXvpwJQ-1; Tue, 20 Oct 2020 09:13:12 -0400
X-MC-Unique: _jPjrPdBMcC8suFVXvpwJQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0892F8799EF;
 Tue, 20 Oct 2020 13:13:11 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-203.rdu2.redhat.com [10.10.115.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D859F60CCC;
 Tue, 20 Oct 2020 13:13:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 6DE81220307; Tue, 20 Oct 2020 09:13:03 -0400 (EDT)
Date: Tue, 20 Oct 2020 09:13:03 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: [Virtio-fs] [PATCH v3] virtiofsd: add container-friendly -o
 sandbox=chroot option
Message-ID: <20201020131303.GA380917@redhat.com>
References: <20201008085534.16070-1-stefanha@redhat.com>
 <CAJFHJrohwGOvZax=anXZdFeuTT+uZAJ89Hu9CohgnE-tJEKTiw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJFHJrohwGOvZax=anXZdFeuTT+uZAJ89Hu9CohgnE-tJEKTiw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: vromanso@redhat.com, qemu-devel@nongnu.org, mpatel@redhat.com,
 virtio-fs-list <virtio-fs@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, rmohr@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 19, 2020 at 06:43:41PM +0900, Chirantan Ekbote wrote:
> On Thu, Oct 8, 2020 at 5:55 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > virtiofsd cannot run in a container because CAP_SYS_ADMIN is required to
> > create namespaces.
> >
> 
> In crosvm we deal with this by also creating a user namespace, which
> then allows us to create the mount, net, and pid namespaces as well.
> Could that also work for virtiofsd?

I think one key question here is that who does the sandboxing. Is it
the contatiner runtime environment or virtiofsd itself. I think what
stefan is trying to do is that container runtime has done the sandboxing
so virtiofsd has not do it.

Having said that, if container runtime has setup things in such a
way that virtiofsd has CAP_SYS_ADMIN, is it desirable that virtiofsd
does pivot_root() instead of chroot()?

Thanks
Vivek


