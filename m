Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C204C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB1A20809
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PALqLT6T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB1A20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0of4-000275-42
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 12:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k0odU-0008Q2-Qf
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:08:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33095
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k0odT-0001jQ-34
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596038933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=78E3fGZ7St2u5uOPvZ7eGWxD+MGNH7LaE2HDTwkBAhU=;
 b=PALqLT6T2TcJa6IayYpef4gS0Ens5iOj+ktkWUw3HLR1gm/ruMu+QaP1KwjJZCP/pFGJlM
 9DPWmH9AJg8U/MnL3Tsj0OeeDEtnPDPAk2trr3UKsOGamXpMBz5/ZWwnrMxNmaANF/5OMr
 pXYUhrkxmFwAS5YFfQ/cbwQ2Z4iXd/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-n6NZHoE1N2yW5Fvl3Syb1Q-1; Wed, 29 Jul 2020 12:08:52 -0400
X-MC-Unique: n6NZHoE1N2yW5Fvl3Syb1Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1524179EC3;
 Wed, 29 Jul 2020 16:08:51 +0000 (UTC)
Received: from localhost (ovpn-120-33.rdu2.redhat.com [10.10.120.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD5B76842F;
 Wed, 29 Jul 2020 16:08:50 +0000 (UTC)
Date: Wed, 29 Jul 2020 12:08:49 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: sysbus_create_simple Vs qdev_create
Message-ID: <20200729160849.GW225270@habkost.net>
References: <87r1t6hc0f.fsf@dusky.pond.sub.org>
 <20200720155955.GV1274972@habkost.net>
 <87v9ihbe6u.fsf@dusky.pond.sub.org>
 <50e31ece-215c-a632-e5a2-86ae7ab3abab@redhat.com>
 <87lfj4f6nz.fsf@dusky.pond.sub.org>
 <759959d1-f320-734a-ac5e-a60db6b1bc23@redhat.com>
 <20200728224733.GP225270@habkost.net>
 <422d7879-3fdc-d38e-259f-2477b9d3c169@redhat.com>
 <20200729143241.GS225270@habkost.net>
 <78767e1f-4124-cb6e-ead6-25fd415027c7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <78767e1f-4124-cb6e-ead6-25fd415027c7@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:27:47
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pratik Parvati <pratikp@vayavyalabs.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 29, 2020 at 06:01:31PM +0200, Paolo Bonzini wrote:
> On 29/07/20 16:32, Eduardo Habkost wrote:
> > On Wed, Jul 29, 2020 at 11:54:35AM +0200, Paolo Bonzini wrote:
> >> On 29/07/20 00:47, Eduardo Habkost wrote:
> > [...]
> >>> Do we really need need QOM children to be accessible using the QOM
> >>> property API?
> >>>
> >>> Using the same code for both user-configurable properties and for
> >>> the list of children of a QOM object might have saved some time
> >>> years ago, but I'm not sure this is still a necessary or useful
> >>> abstraction.
> >>
> >> The main thing we get from it is that the QOM paths treat children and
> >> links the same, and links are properties.  To be honest it's not a
> >> feature that is very much developed, so perhaps we can remove it but we
> >> need to evaluate the impact of losing it.
> > 
> > Are link properties usable by -device/device_add/-object/object-add?
> 
> Not sure exactly what you mean, but there is DEFINE_PROP_LINK and it's
> used to link devices to objects.  Is it ever used with an actual path
> rather than just the id of something in /objects?  Probably not.

I mean: are link properties settable from the command line or
QMP, as an argument to -device/device_add/-object/object-add?

-- 
Eduardo


