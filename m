Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A660C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B5E02173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tp5IblZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5E02173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8ojU-0006Q6-HF
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 12:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j8oik-0005Xz-Li
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j8oij-0001EA-MH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:19:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32211
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j8oij-0001E3-Ih
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583169549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dEkXo+2BXLBr8aZk0V9sXzDzdnBglqN/XDpR/EhPQM0=;
 b=Tp5IblZrH5FDgejYv64efdZm3fcOUttgclNNoOxt4qyV3EpCnpSXuoQHqcTa2jWwvmkisA
 cW1iWYVNZaraRgp37mfztjisKNejQCp2ZQ/sx5EdVLvgQ9tj1YaW4LnOj3hAiQ0Gs49ptC
 RbmBPlDWkhiqC7Fnf5dYphUVibp/WUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-a9IxbPTvPSGcoQPrktJ1Dw-1; Mon, 02 Mar 2020 12:19:05 -0500
X-MC-Unique: a9IxbPTvPSGcoQPrktJ1Dw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58F7618B9FC1;
 Mon,  2 Mar 2020 17:19:04 +0000 (UTC)
Received: from localhost (ovpn-126-231.rdu2.redhat.com [10.10.126.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B32D45D9C9;
 Mon,  2 Mar 2020 17:19:02 +0000 (UTC)
Date: Mon, 2 Mar 2020 12:19:01 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v3 2/4] target/i386: Remove monitor from some CPU models
Message-ID: <20200302171901.GI4440@habkost.net>
References: <20200212081328.7385-1-tao3.xu@intel.com>
 <20200212081328.7385-3-tao3.xu@intel.com>
 <20200228213909.GA481504@habkost.net>
 <06a6cd99-7d11-7eee-c337-c71e756fc53f@intel.com>
MIME-Version: 1.0
In-Reply-To: <06a6cd99-7d11-7eee-c337-c71e756fc53f@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 02, 2020 at 07:47:28PM +0800, Tao Xu wrote:
> On 2/29/2020 5:39 AM, Eduardo Habkost wrote:
> > On Wed, Feb 12, 2020 at 04:13:26PM +0800, Tao Xu wrote:
> > > Add new version of Snowridge, Denverton, Opteron_G3, EPYC, and Dhyana
> > > CPU model to uremove MONITOR/MWAIT featre.
> > >=20
> > > After QEMU/KVM use "-overcommit cpu-pm=3Don" to expose MONITOR/MWAIT
> > > (commit id 6f131f13e68d648a8e4f083c667ab1acd88ce4cd), the MONITOR/MWA=
IT
> > > feature in these CPU model is unused.
> > >=20
> > > Signed-off-by: Tao Xu <tao3.xu@intel.com>
> >=20
> > What exactly is the problem you are trying to fix?
> >=20
> > No CPU model will ever have monitor=3Don set by default with KVM,
> > because kvm_default_props has a monitor=3Doff element.
> >=20
>=20
> Maybe it is not a fix. For example, when we boot a guest with Denverton
> cpu model, guest cannot detect MONITOR/MWAIT and boot with no warning,
> because of "monitor=3Doff" by default. The MONITOR/MWAIT feature in these=
 CPU
> model is unused,but no harm. I am wondering if we should remove it from
> existing CPU models.

As monitor=3Doff is on kvm_default_props, changing the CPU model
table will only affect other accelerators (e.g. TCG, where
MONITOR/MWAIT support is advertised as supported).

We shouldn't be dictating policy for other accelerators just
because KVM doesn't support it.  Removing the feature on
kvm_default_props is sufficient.

--=20
Eduardo


