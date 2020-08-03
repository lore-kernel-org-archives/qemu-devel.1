Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE1DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A062068F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1oPwvyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A062068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2V2m-0000zx-EE
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 03:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k2V2D-0000ZF-8b
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 03:37:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53959
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k2V2A-0006s9-51
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 03:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596440241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ro11TNE79MJIGWTNAhNLYSSZEM+K7TBk79v4qcez4P4=;
 b=c1oPwvycJV5tMC3YDPoxnGhTFEk2oPnKXW3/2WnRfzIrZpG6FK5dHGAgsy7QVbE/N/CTRP
 3Yn/otHvrhhnZtuPxMls3kacre12O90sqGD2VvDpF3CPJqqxZHL/BIlndaWPIu2o3FkXVr
 yF56FfjOHsT5iU0cEtZ6/gaZLldymr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-O1JgFjy9NYuguWI0Yo_8Hg-1; Mon, 03 Aug 2020 03:37:17 -0400
X-MC-Unique: O1JgFjy9NYuguWI0Yo_8Hg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57594101C8A5;
 Mon,  3 Aug 2020 07:37:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 357587852C;
 Mon,  3 Aug 2020 07:37:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1308211AB5; Mon,  3 Aug 2020 09:37:14 +0200 (CEST)
Date: Mon, 3 Aug 2020 09:37:14 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Michael Brown <mcb30@ipxe.org>
Subject: Re: [ipxe-devel] https booting
Message-ID: <20200803073714.aeqffoct2l66ahrz@sirius.home.kraxel.org>
References: <20200722120827.dq72uabrk26nllra@sirius.home.kraxel.org>
 <20200722122347.GF2324845@redhat.com>
 <20200722135538.wvblddvskp5j4wik@sirius.home.kraxel.org>
 <20200722141318.GJ2324845@redhat.com>
 <411ac2fb-1f3e-28f0-5c9a-6ff0806cfbf7@ipxe.org>
MIME-Version: 1.0
In-Reply-To: <411ac2fb-1f3e-28f0-5c9a-6ff0806cfbf7@ipxe.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:56:11
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
Cc: ipxe-devel@lists.ipxe.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 24, 2020 at 05:19:38PM +0100, Michael Brown wrote:
> On 22/07/2020 15:13, Daniel P. Berrangé wrote:
> > We could easily define etc/ipxe/https/{ciphers,cacerts} paths in a
> > different format if better suited for iPXE. Libvirt can set the right
> > path depending on whether its booting a VM with EDK2 vs legacy BIOS
> 
> The most useful for iPXE would probably be to expose the fw_cfg mechanism as
> a URI scheme.  This would give a general mechanism allowing for use cases
> such as running a script provided by the host via e.g.
> 
>   chain fw_cfg:///opt/org.example/script.ipxe

Looks useful.
(coreboot folks might want add cbfs: support).

> The ${crosscert} setting could then be pointed at a base URL within the
> fw_cfg space, e.g.
> 
>   #define CROSSCERT "fw_cfg:///etc/ipxe/crosscert/auto"
> 
> This would then work in the same way under either BIOS or UEFI (or other
> custom firmware), would provide a feature with applicability broader than
> just obtaining certificates, and would avoid any potential problems from
> allocating enough RAM to parse every root certificate from iPXE's fixed
> 512kB internal heap.

Well, it isn't that easy.

fw_cfg isn't designed for a large number of files, and right now there
is a hard limit of (IIRC) 32 entries.  While adding an entry or two
isn't that much of a problem, adding all *.der files (228 right now)
hosted @ http://ca.ipxe.org/auto/ individually certainly is.

So, we'll have to pass a certificate bundle as single file and have ipxe
pick the certificate it needs from it.

take care,
  Gerd


