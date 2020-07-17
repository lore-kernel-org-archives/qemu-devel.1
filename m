Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EADC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9FB2076D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdQq/844"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9FB2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwQBw-0004BO-BX
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 09:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jwQBE-0003N4-0g
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:13:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55798
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jwQBB-0003Go-MI
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594991611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXwcbGKMFHCdAyAclL6lCr8olrFJ0fevSWaLt762OD0=;
 b=DdQq/844vL+gmKi2cXSOFZj/sClrcUezbTTyMA76eN1qV6VEkt6iDaSG+PMyoRIBn/BwCC
 AGJytol0qsIHsdb0UvDmXjcLmi2t0Vasq2brdP54KRTiRQ+1nP44D7iTHqNhytGqAVWwHR
 BVFmVIf87bV1svDp+LSJCLR5Gd5qLOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-zhN-HcPVPnS6uh2bd1_3CA-1; Fri, 17 Jul 2020 09:13:28 -0400
X-MC-Unique: zhN-HcPVPnS6uh2bd1_3CA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13425100A8E8;
 Fri, 17 Jul 2020 13:13:27 +0000 (UTC)
Received: from localhost (unknown [10.40.208.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC4CD710C8;
 Fri, 17 Jul 2020 13:13:23 +0000 (UTC)
Date: Fri, 17 Jul 2020 15:13:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [RFC 3/3] x68: acpi: trigger SMI before scanning for hotplugged
 CPUs
Message-ID: <20200717151321.27e2d849@redhat.com>
In-Reply-To: <515cc231-858a-a626-31a9-d74e1f6b4e38@redhat.com>
References: <20200710161704.309824-1-imammedo@redhat.com>
 <20200710161704.309824-4-imammedo@redhat.com>
 <515cc231-858a-a626-31a9-d74e1f6b4e38@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:27:47
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
Cc: boris.ostrovsky@oracle.com, liran.alon@oracle.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 14:28:29 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> (CC'ing Peter Krempa due to virsh setvcpu (singular) / setvcpus (plural)
> references)
> 
> On 07/10/20 18:17, Igor Mammedov wrote:
[...]

> (3) Just a thought: I wonder if we should reserve both ports (0xB2 and
> 0xB3 too). For now we don't have any use for the "data" port, but
> arguably it's part of the same register block.

we probably should, might be used for unplug part.

BTW any ideas how we'd like to procceed with unplug?

current flow looks like:

QEMU                       OSPM
unplug_req()
1)   =>SCI     --->
  -------------------------
2)                   handle_sci()
                         scan for events and send
                             Notify per removed CPU
                             clear rm_evt
  -------------------------
3)                   offline cpu
  -------------------------
4)                    call _EJ0 to unplug CPU
                         write into ej_evt
              <-------------
  -------------------------
5)  unplug cb
 

We probably should modify _EJ0 to send SMI instead of direct access
to cpuhp block, the question is how OSPM would tell FW which CPU it
ejects.
                      

[...]


