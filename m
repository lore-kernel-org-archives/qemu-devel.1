Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE95FCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 14:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A222087E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 14:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUoMczlL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A222087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPSEL-0001uS-2a
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 10:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iPSCX-00006w-BS
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 10:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iPS8r-00047j-Rt
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 10:06:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52511
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iPS8r-00047b-O6
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 10:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572357997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sEBGXjTaxukdq83mRizQInab2bBgIDPPas2PkYHDYSM=;
 b=YUoMczlLT6cjfsd2+usYMAq3ULBQ/HvwQ4xHH3N+PXb9m66rEFsuPDaNihdLNMloHR5vd2
 sSxGP+MSkqV/PCcYiNLvO6wr1c/AL2O7shQQ1rGJiwhqHyn6E4km1XPWAv0xWoSOnCZElr
 1cWSoHIcwCLkQFc+dDFsZlpySp41498=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-AhGBrXzJOl6rOJ-B_nHvSA-1; Tue, 29 Oct 2019 10:06:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADCB85EC;
 Tue, 29 Oct 2019 14:06:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F15D210027B5;
 Tue, 29 Oct 2019 14:05:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6284D11385C9; Tue, 29 Oct 2019 15:05:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH v7 05/11] qapi: add unplug primary event
References: <20191029114905.6856-1-jfreimann@redhat.com>
 <20191029114905.6856-6-jfreimann@redhat.com>
 <87mudjpvgl.fsf@dusky.pond.sub.org>
 <20191029134637.nvdbj3dn7rna2olq@jenstp.localdomain>
Date: Tue, 29 Oct 2019 15:05:35 +0100
In-Reply-To: <20191029134637.nvdbj3dn7rna2olq@jenstp.localdomain> (Jens
 Freimann's message of "Tue, 29 Oct 2019 14:46:37 +0100")
Message-ID: <87eeyvode8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: AhGBrXzJOl6rOJ-B_nHvSA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: berrange@redhat.com, ehabkost@redhat.com, quintela@redhat.com,
 aadam@redhat.com, jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, alex.williamson@redhat.com, laine@redhat.com,
 pbonzini@redhat.com, ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jens Freimann <jfreimann@redhat.com> writes:

> On Tue, Oct 29, 2019 at 01:50:02PM +0100, Markus Armbruster wrote:
>>Jens Freimann <jfreimann@redhat.com> writes:
>>
>>> This event is emitted when we sent a request to unplug a
>>
>>Uh, "we sent a requestion [...] from the Guest OS"...  do you mean "we
>>received"?
>
> No, we sent a pci hotplug event to the guest by "pushing" the pcie attent=
ion
> button. So, it's QEMU requesting the unplug.

So if it's QEMU who does the sending, then saying "we sent [...] from
the Guest OS does not compute for me.  Do you mean "sent to"?

[...]


