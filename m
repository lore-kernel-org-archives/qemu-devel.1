Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DBCC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 657F1205CB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SI6viH8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657F1205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAU7a-0006u3-LQ
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAU71-0006Tc-Mm
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:15:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31611
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAU6v-00072T-Ve
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598343316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o7a/9CQyjxcOh/vsG8MDabXnXe16st+Pdw+dA3VKx6c=;
 b=SI6viH8ENGOo/HtMSCjNk1/3JlXROTnzlsGrpAnsotJTzdPlUjxA11TRsRCLuoJn1sLpj9
 M1OG5qJQv9oUTQpng1p4sSxzNv28GXV4nZIMAheXPPV1jy8R5vIRhI+mOFv7jBCLWmYHA8
 WQy72dpBXnG390XI7xYbe2Vv4E9iQTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-4_qR10aaODKA4L4RAwx08g-1; Tue, 25 Aug 2020 04:15:12 -0400
X-MC-Unique: 4_qR10aaODKA4L4RAwx08g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98E5E1007B02;
 Tue, 25 Aug 2020 08:15:11 +0000 (UTC)
Received: from work-vm (ovpn-114-128.ams2.redhat.com [10.36.114.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 516AD1002D41;
 Tue, 25 Aug 2020 08:15:07 +0000 (UTC)
Date: Tue, 25 Aug 2020 09:15:04 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
 decode
Message-ID: <20200825081504.GA2646@work-vm>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <20200824184112.GB2688@work-vm>
 <f602852c-b6af-694e-3e32-47974722e144@amd.com>
MIME-Version: 1.0
In-Reply-To: <f602852c-b6af-694e-3e32-47974722e144@amd.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:36:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Babu Moger (babu.moger@amd.com) wrote:
> Hi Dave,
> 
> On 8/24/20 1:41 PM, Dr. David Alan Gilbert wrote:
> > * Babu Moger (babu.moger@amd.com) wrote:
> >> To support some of the complex topology, we introduced EPYC mode apicid decode.
> >> But, EPYC mode decode is running into problems. Also it can become quite a
> >> maintenance problem in the future. So, it was decided to remove that code and
> >> use the generic decode which works for majority of the topology. Most of the
> >> SPECed configuration would work just fine. With some non-SPECed user inputs,
> >> it will create some sub-optimal configuration.
> >> Here is the discussion thread.
> >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fqemu-devel%2Fc0bcc1a6-1d84-a6e7-e468-d5b437c1b254%40amd.com%2F&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C74d90724af9c4adcc75008d8485d4d16%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637338912853492167&amp;sdata=GTsMKcpeYXAA0CvpLTirPHKdNSdlJE3RuPjCtSyWtGQ%3D&amp;reserved=0
> >>
> >> This series removes all the EPYC mode specific apicid changes and use the generic
> >> apicid decode.
> > 
> > Hi Babu,
> >   This does simplify things a lot!
> > One worry, what happens about a live migration of a VM from an old qemu
> > that was using the node-id to a qemu with this new scheme?
> 
> The node_id which we introduced was only used internally. This wasn't
> exposed outside. I don't think live migration will be an issue.

Didn't it become part of the APIC ID visible to the guest?

Dave

-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


